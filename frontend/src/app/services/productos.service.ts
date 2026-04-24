import { http } from "./api";
import type { Producto } from "./types";

export const productosService = {
  list: () => http.get<Producto[]>("/productos"),
  get: (id: number) => http.get<Producto>(`/productos/${id}`),
  create: (data: Omit<Producto, "id">) => http.post<Producto>("/productos", data),
  update: (id: number, data: Partial<Omit<Producto, "id">>) =>
    http.put<Producto>(`/productos/${id}`, data),
  remove: (id: number) => http.del<void>(`/productos/${id}`),
};
