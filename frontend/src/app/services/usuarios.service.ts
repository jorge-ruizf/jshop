import { http } from "./api";
import type { Usuario } from "./types";

export const usuariosService = {
  list: () => http.get<Usuario[]>("/usuarios"),
  get: (id: number) => http.get<Usuario>(`/usuarios/${id}`),
  create: (data: Omit<Usuario, "id">) => http.post<Usuario>("/usuarios", data),
  update: (id: number, data: Partial<Omit<Usuario, "id">>) =>
    http.put<Usuario>(`/usuarios/${id}`, data),
  remove: (id: number) => http.del<void>(`/usuarios/${id}`),
};
