import { http } from "./api";
import type { Pais } from "./types";

export const paisesService = {
  list: (signal?: AbortSignal) => http.get<Pais[]>("/paises", signal),
  get: (id: number, signal?: AbortSignal) => http.get<Pais>(`/paises/${id}`, signal),
  create: (data: Omit<Pais, "id">) => http.post<Pais>("/paises", data),
  update: (id: number, data: Partial<Omit<Pais, "id">>) =>
    http.put<Pais>(`/paises/${id}`, data),
  remove: (id: number) => http.del<void>(`/paises/${id}`),
};
