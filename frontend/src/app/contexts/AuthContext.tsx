import { createContext, useContext, ReactNode } from "react";
import { useAuthSync } from "../hooks/useAuthSync";
import type { Usuario } from "../services/types";

// ─── Tipos ────────────────────────────────────────────────────

interface AuthContextValue {
  usuario: Usuario | null;
  setUsuario: (usuario: Usuario | null) => void;
  loading: boolean;
  isAuthenticated: boolean;
}

// ─── Contexto ─────────────────────────────────────────────────

const AuthContext = createContext<AuthContextValue | null>(null);

// ─── Provider ─────────────────────────────────────────────────

export function AuthProvider({ children }: { children: ReactNode }) {
  const { usuario, setUsuario, loading } = useAuthSync();

  return (
    <AuthContext.Provider
      value={{
        usuario,
        setUsuario,
        loading,
        isAuthenticated: !!usuario,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

// ─── Hook ─────────────────────────────────────────────────────

export function useAuthContext(): AuthContextValue {
  const context = useContext(AuthContext);

  if (context === null) {
    throw new Error(
      "[useAuthContext] debe usarse dentro de <AuthProvider>."
    );
  }

  return context;
}