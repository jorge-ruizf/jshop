import { http } from './api';
import type { ProductoDeseado } from './types';

export const productosDeseadosService = {
  /** Listar todas las alertas de un usuario */
  listar: (id_usuario: number): Promise<ProductoDeseado[]> =>
    http.get(`/productos-deseados?id_usuario=${id_usuario}`),

  /** Crear o actualizar alerta (el backend hace upsert) */
  crear: (data: {
    id_producto: number;
    id_usuario: number;
    precio_objetivo: number;
  }): Promise<ProductoDeseado> =>
    http.post('/productos-deseados', data),

  /** Editar precio objetivo (reactiva la alerta si ya fue disparada) */
  actualizar: (id: number, precio_objetivo: number): Promise<ProductoDeseado> =>
    http.put(`/productos-deseados/${id}`, { precio_objetivo }),

  /** Eliminar alerta */
  eliminar: (id: number): Promise<void> =>
    http.del(`/productos-deseados/${id}`),
};