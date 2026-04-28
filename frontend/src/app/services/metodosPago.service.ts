import { http } from "./api";
import type { MetodoPago } from "./types";

export const metodosPagoService = {
  list: (signal?: AbortSignal) => http.get<MetodoPago[]>("/metodos-pago", signal),
  get: (id: number, signal?: AbortSignal) => http.get<MetodoPago>(`/metodos-pago/${id}`, signal),
  create: (data: Omit<MetodoPago, "id">) => http.post<MetodoPago>("/metodos-pago", data),
  update: (id: number, data: Partial<Omit<MetodoPago, "id">>) =>
    http.put<MetodoPago>(`/metodos-pago/${id}`, data),
  remove: (id: number) => http.del<void>(`/metodos-pago/${id}`),
};
