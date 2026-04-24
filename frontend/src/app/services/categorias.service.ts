import { http } from "./api";
import type { Categoria } from "./types";

export const categoriasService = {
  list: () => http.get<Categoria[]>("/categorias"),
  get: (id: number) => http.get<Categoria>(`/categorias/${id}`),
  create: (data: Omit<Categoria, "id">) => http.post<Categoria>("/categorias", data),
  update: (id: number, data: Partial<Omit<Categoria, "id">>) =>
    http.put<Categoria>(`/categorias/${id}`, data),
  remove: (id: number) => http.del<void>(`/categorias/${id}`),
};
