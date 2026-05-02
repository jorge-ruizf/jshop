import { useState } from "react";
import { useNavigate } from "react-router";
import { Card } from "../components/ui/card";
import { Button } from "../components/ui/button";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";
import { Separator } from "../components/ui/separator";
import { Mail, Lock } from "lucide-react";
import { useFetch } from "../hooks/useFetch";
import { productosService } from "../services";
import { AuthButtons } from "../components/auth/AuthButtons";

export function Login() {
  const navigate = useNavigate();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  // Pull live Producto catalog count from the backend as a small marketing
  // hint under the header. Errors are intentionally suppressed — auth UI
  // must always render even if the catalog endpoint is down.
  const {
    data: productos,
    loading: productosLoading,
    error: productosError,
  } = useFetch((signal) => productosService.list(signal), []);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log("Login attempt:", { email, password });
    navigate("/");
  };

  const handleSocialLogin = (provider: string) => {
    console.log(`Login with ${provider}`);
    navigate("/");
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-background to-muted/20 flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full">
        {/* Header */}
        <div className="text-center mb-8">
          <h1 className="mb-2">Iniciar Sesión</h1>
          <p className="text-muted-foreground">Accede a tu cuenta de GameStore Pro</p>
          {/* Live Producto count from backend */}
          <p className="mt-2 text-xs text-muted-foreground">
            {productosLoading
              ? "Cargando catálogo…"
              : productosError
              ? `Catálogo no disponible: ${productosError.message}`
              : `${productos?.length ?? 0} productos disponibles ahora mismo`}
          </p>
        </div>

        <Card className="p-6 md:p-8">
          {/* Social Login */}

          <div className="items-center justify-center">
            <AuthButtons />
          </div>
	

        </Card>
      </div>
    </div>
  );
}
