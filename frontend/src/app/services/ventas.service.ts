import { http } from './api';
import type { Venta } from './types';

export interface ConfirmarVentaItem {
  id_carrito: number;
  id_producto: number;
  precio: number;
}

export interface ConfirmarVentaRequest {
  id_usuario: number;
  id_metodo_pago: number;
  total: number;
  items: ConfirmarVentaItem[];
}

export const ventasService = {
  confirmar: (payload: ConfirmarVentaRequest) =>
    http.post<Venta>('/ventas/confirmar', payload),
};