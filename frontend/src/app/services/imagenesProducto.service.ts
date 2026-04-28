import { http } from "./api";
import type { ImagenProducto } from "./types";

export const imagenesProductoService = {
  list: (signal?: AbortSignal) => http.get<ImagenProducto[]>("/imagenes-producto", signal),
  get: (id: number, signal?: AbortSignal) => http.get<ImagenProducto>(`/imagenes-producto/${id}`, signal),
  create: (data: Omit<ImagenProducto, "id">) =>
    http.post<ImagenProducto>("/imagenes-producto", data),
  update: (id: number, data: Partial<Omit<ImagenProducto, "id">>) =>
    http.put<ImagenProducto>(`/imagenes-producto/${id}`, data),
  remove: (id: number) => http.del<void>(`/imagenes-producto/${id}`),
};
