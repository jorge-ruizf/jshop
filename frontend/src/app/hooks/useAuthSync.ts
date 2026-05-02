import { useEffect, useState } from "react";
import { supabase } from "../services/supabaseClient";
import { usuariosService } from "../services/usuarios.service";
import type { Usuario } from "../services/types";

export function useAuthSync() {
  const [usuario, setUsuario] = useState<Usuario | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const sync = async () => {
      const { data } = await supabase.auth.getUser();
      const user = data.user;

      if (!user) {
        setLoading(false);
        return;
      }

      const email = user.email!;
      const fullName = user.user_metadata?.full_name || "";

      const existing = await usuariosService.getByEmail(email);

      console.log("Frontend=> existing:", existing);

      if (existing) {
        setUsuario(existing);
      } else {
        const username = email.split("@")[0];

        const nuevo = await usuariosService.create({
          nombre: fullName,
          usuario: username,
          correo: email,
          id_pais: 1,
          id_rol: 1,
          id_metodo_pago_fav: 1,
        });

        setUsuario(nuevo);
      }


      setLoading(false);
    };

    sync();

    // 🔄 escuchar cambios de sesión
    const { data: listener } = supabase.auth.onAuthStateChange(() => {
      sync();
    });

    return () => listener.subscription.unsubscribe();
  }, []);

  return { usuario, setUsuario, loading };
}