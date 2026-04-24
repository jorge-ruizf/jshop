import { http } from "./api";
import type { Pais } from "./types";

export const paisesService = {
  list: () => http.get<Pais[]>("/paises"),
  get: (id: number) => http.get<Pais>(`/paises/${id}`),
  create: (data: Omit<Pais, "id">) => http.post<Pais>("/paises", data),
  update: (id: number, data: Partial<Omit<Pais, "id">>) =>
    http.put<Pais>(`/paises/${id}`, data),
  remove: (id: number) => http.del<void>(`/paises/${id}`),
};
