import { Link, Outlet, useLocation, useNavigate } from "react-router";
import { ShoppingCart, User, Home, Shield, Pencil, LogOut } from "lucide-react";
import { Button } from "./ui/button";
import { HoverCard, HoverCardContent, HoverCardTrigger } from "./ui/hover-card";
import { Input } from "./ui/input";
import { Label } from "./ui/label";
import { Separator } from "./ui/separator";
import { useState, useEffect } from "react";
import { useStore } from "../data/store-context";
import { useFetch } from "../hooks/useFetch";
import {productosService, paisesService, Usuario, usuariosService} from "../services";
import {useAuthSync} from "../hooks/useAuthSync";

export function Layout() {
  const location = useLocation();
  const navigate = useNavigate();
  const store = useStore();
  // Backend-driven count of available Productos (used as cart badge placeholder
  // until the cart entity is wired). Loading/errors are handled silently here
  // so they never block the chrome from rendering.
  const {data: productos} = useFetch(() => productosService.list(), []);
  const cartItemsCount = productos?.length ?? 0;

  // Backend-driven country list for the user-profile preferred-country
  // dropdown. Replaces the mock `store.getActiveCountries()`. Backend Pais
  // only stores { id, nombre }, so flag/currency are not displayed here.
  const {
    data: backendPaises,
    loading: paisesLoading,
    error: paisesError,
  } = useFetch(() => paisesService.list(), []);

  const { usuario, setUsuario } = useAuthSync();

  const [userProfile, setUserProfile] = useState({
    name: "",
    preferredCountry: "",
  });

  useEffect(() => {
    if (usuario) {
      setUserProfile((prev) => ({
        ...prev,
        name: usuario.nombre || usuario.usuario || usuario.correo,
      }));
    }
  }, [usuario]);

  const [editMode, setEditMode] = useState({
    name: false,
    discord: false,
  });

  const isActive = (path: string) => location.pathname === path;

  const handleLogout = () => {
    navigate("/login");
  };

  const toggleEditMode = (field: "name" | "discord") => {
    setEditMode({...editMode, [field]: !editMode[field]});
  };

  const handleSaveName = async () => {
    if (!usuario) return;
    if (userProfile.name === usuario.nombre) return;

    try {
      await usuariosService.update(usuario.id, {
        nombre: userProfile.name,
      });

      // 🔥 sync sin recargar
      setUsuario((prev) => prev && {
        ...prev,
        nombre: userProfile.name,
      });

    } catch (err) {
      console.error(err);
    }
  };

  return (
      <div className="min-h-screen flex flex-col">
        {/* Header */}
        <header className="bg-white border-b border-border sticky top-0 z-50">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex items-center justify-between h-16">
              <Link to="/" className="flex items-center gap-2">
                <div
                    className="w-10 h-10 bg-gradient-to-br from-primary to-secondary rounded-lg flex items-center justify-center">
                  <Home className="w-6 h-6 text-white"/>
                </div>
                <span className="text-xl tracking-tight">GameStore Pro</span>
              </Link>

              {/* Navigation */}
              <nav className="hidden md:flex items-center gap-6">
                <Link
                    to="/"
                    className={`transition-colors ${
                        isActive("/")
                            ? "text-primary"
                            : "text-foreground hover:text-primary"
                    }`}
                >
                  Tienda
                </Link>
                <Link
                    to="/admin"
                    className={`transition-colors flex items-center gap-1 ${
                        isActive("/admin")
                            ? "text-primary"
                            : "text-foreground hover:text-primary"
                    }`}
                >
                  <Shield className="w-4 h-4"/>
                  Admin
                </Link>
              </nav>

              {/* Actions */}
              <div className="flex items-center gap-3">
                <Link to="/checkout">
                  <Button variant="ghost" size="icon" className="relative">
                    <ShoppingCart className="w-5 h-5"/>
                    {cartItemsCount > 0 && (
                        <span
                            className="absolute -top-1 -right-1 bg-accent text-white text-xs w-5 h-5 rounded-full flex items-center justify-center">
                      {cartItemsCount}
                    </span>
                    )}
                  </Button>
                </Link>

                <HoverCard openDelay={200} closeDelay={200}>
                  <HoverCardTrigger>
                    <button
                        className="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors hover:bg-accent hover:text-accent-foreground h-9 w-9 outline-none focus-visible:ring-2 focus-visible:ring-ring">
                      <User className="w-5 h-5"/>
                    </button>
                  </HoverCardTrigger>
                  <HoverCardContent className="w-80" align="end">
                    <div className="space-y-4">
                      <div>
                        <h3 className="mb-1">Perfil de Usuario</h3>
                        <p className="text-sm text-muted-foreground">
                          Gestiona tu informaci&oacute;n personal
                        </p>
                      </div>

                      <Separator/>

                      {/* Name */}
                      <div className="space-y-2">
                        <div className="flex items-center justify-between">
                          <Label htmlFor="name" className="text-sm">Nombre</Label>
                          <Button variant="ghost" size="icon" className="h-6 w-6"
                                  onClick={() => toggleEditMode("name")}>
                            <Pencil className="h-3 w-3"/>
                          </Button>
                        </div>
                        {editMode.name ? (
                            <Input
                                id="name"
                                value={userProfile.name}
                                onChange={(e) => setUserProfile({...userProfile, name: e.target.value})}
                                onBlur={async () => {
                                  toggleEditMode("name");
                                  await handleSaveName();
                                }}
                                autoFocus
                                className="h-8"
                            />
                        ) : (
                            <p className="text-sm">{userProfile.name}</p>
                        )}
                      </div>

                      {/* Country */}
                      <div className="space-y-2">
                        <Label htmlFor="country" className="text-sm">Moneda Preferida</Label>
                        <select
                            id="country"
                            value={userProfile.preferredCountry}
                            onChange={(e) => setUserProfile({...userProfile, preferredCountry: e.target.value})}
                            disabled={paisesLoading || !!paisesError}
                            className="flex h-8 w-full items-center justify-between rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
                        >
                          {paisesLoading && <option value="">Cargando países…</option>}
                          {paisesError && <option value="">Error: {paisesError.message}</option>}
                          {!paisesLoading && !paisesError && (!backendPaises || backendPaises.length === 0) && (
                              <option value="">Sin países configurados</option>
                          )}
                          {!paisesLoading && !paisesError && backendPaises?.map((country) => (
                              <option key={country.id} value={String(country.id)}>
                                {country.nombre}
                              </option>
                          ))}
                        </select>
                      </div>

                      <Separator/>

                      <Button
                          variant="outline"
                          className="w-full justify-start text-destructive hover:text-destructive hover:bg-destructive/10"
                          onClick={handleLogout}
                      >
                        <LogOut className="w-4 h-4 mr-2"/>
                        Cerrar Sesi&oacute;n
                      </Button>
                    </div>
                  </HoverCardContent>
                </HoverCard>
              </div>
            </div>
          </div>
        </header>

        {/* Main Content */}
        <main className="flex-1">
          <Outlet/>
        </main>

        {/* Footer */}
        <footer className="bg-muted border-t border-border mt-auto">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
            <p className="text-center text-sm text-muted-foreground">
              &copy; 2026 GameStore Pro. Todos los derechos reservados.
            </p>
          </div>
        </footer>
      </div>
  );
}

