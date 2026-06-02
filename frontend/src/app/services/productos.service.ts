import { http } from "./api";
import type { Producto } from "./types";

export const productosService = {
  list: (signal?: AbortSignal) => http.get<Producto[]>("/productos", signal),
  get: (id: number, signal?: AbortSignal) => http.get<Producto>(`/productos/${id}`, signal),
  create: (data: Omit<Producto, "id">) => http.post<Producto>("/productos", data),
  update: (id: number, data: Partial<Omit<Producto, "id">>) =>
    http.put<Producto>(`/productos/${id}`, data),
  remove: (id: number) => http.del<void>(`/productos/${id}`),
  uploadImage: async (id: number, url: string): Promise<{ path: string }> => {
    const res = await fetch(`/api/productos/${id}/imagen`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ url }),
    });
    if (!res.ok) throw new Error('Error al guardar la imagen');
    return res.json();
  },
};

