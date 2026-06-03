import { http } from './api';
import type { CarritoItem } from './types';

export const carritoService = {

  getByUsuario: (id_usuario: number) =>
    http.get<CarritoItem[]>(`/carrito?id_usuario=${id_usuario}`),

  add: (id_producto: number, id_usuario: number) =>
    http.post<CarritoItem>('/carrito', { id_producto, id_usuario }),

  remove: (id: number) =>
    http.del<void>(`/carrito/${id}`),

};