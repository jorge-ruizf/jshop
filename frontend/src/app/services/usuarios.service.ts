import { http } from "./api";
import type { Usuario } from "./types";

// @ts-ignore
// @ts-ignore
export const usuariosService = {
  list: (signal?: AbortSignal) => http.get<Usuario[]>("/usuarios", signal),

  get: (id: number, signal?: AbortSignal) =>
      http.get<Usuario>(`/usuarios/${id}`, signal),

  create: (data: Omit<Usuario, "id">) =>
      http.post<Usuario>("/usuarios", data),

  update: (id: number, data: Partial<Omit<Usuario, "id">>) =>
      http.put<Usuario>(`/usuarios/${id}`, data),

  remove: (id: number) =>
      http.del<void>(`/usuarios/${id}`),

  getByEmail: (correo: string, signal?: AbortSignal) =>
      http.get<Usuario | null>(`/usuarios/by-email`, {
        // @ts-ignore
        params: { correo },
        signal,
      }),
};