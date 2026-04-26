import { http } from "./api";
import type { MetodoPago } from "./types";

export const metodosPagoService = {
  list: () => http.get<MetodoPago[]>("/metodos-pago"),
  get: (id: number) => http.get<MetodoPago>(`/metodos-pago/${id}`),
  create: (data: Omit<MetodoPago, "id">) => http.post<MetodoPago>("/metodos-pago", data),
  update: (id: number, data: Partial<Omit<MetodoPago, "id">>) =>
    http.put<MetodoPago>(`/metodos-pago/${id}`, data),
  remove: (id: number) => http.del<void>(`/metodos-pago/${id}`),
};
