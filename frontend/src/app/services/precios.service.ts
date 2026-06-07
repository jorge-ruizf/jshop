import { http } from './api';
import type { Precio } from './types';

export interface PrecioInput {
  id_pais: number;
  precio: number;
}

export const preciosService = {
  listByProducto: (id_producto: number, signal?: AbortSignal) =>
    http.get<Precio[]>(`/precios?id_producto=${id_producto}`, signal),

  bulk: (id_producto: number, precios: PrecioInput[]) =>
    http.post<Precio[]>('/precios/bulk', { id_producto, precios }),

  remove: (id: number) =>
    http.del<void>(`/precios/${id}`),
};