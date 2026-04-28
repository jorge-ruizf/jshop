import { http } from "./api";
import type { Videojuego } from "./types";

export const videojuegoService = {
  list: (signal?: AbortSignal) =>
      http.get<Videojuego[]>("/videojuegos", signal),

  get: (id: number, signal?: AbortSignal) =>
      http.get<Videojuego>(`/videojuegos/${id}`, signal),

  create: (data: Omit<Videojuego, "id">) =>
      http.post<Videojuego>("/videojuegos", data),

  update: (id: number, data: Partial<Omit<Videojuego, "id">>) =>
      http.put<Videojuego>(`/videojuegos/${id}`, data),

  remove: (id: number) =>
      http.del<void>(`/videojuegos/${id}`),
};