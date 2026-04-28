import { http } from "./api";
import type { Categoria } from "./types";

export const categoriasService = {
  list: (signal?: AbortSignal) => http.get<Categoria[]>("/categorias", signal),
  get: (id: number, signal?: AbortSignal) => http.get<Categoria>(`/categorias/${id}`, signal),
  create: (data: Omit<Categoria, "id">) => http.post<Categoria>("/categorias", data),
  update: (id: number, data: Partial<Omit<Categoria, "id">>) =>
    http.put<Categoria>(`/categorias/${id}`, data),
  remove: (id: number) => http.del<void>(`/categorias/${id}`),
};
