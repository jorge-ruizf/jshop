// Shared resource types matching the backend Prisma schema.
// Keep in sync with backend/prisma/schema.prisma.

export interface Usuario {
  id: number;
  nombre: string;
  usuario: string;
  correo: string;
  id_pais: number;
  id_rol: number;
  id_metodo_pago_fav: number;
}

export interface Producto {
  id: number;
  nombre: string;
  descripcion: string;
  id_vendedor: number;
  id_categoria: number;
  id_pais: number;
}

export interface Categoria {
  id: number;
  nombre: string;
}

export interface Pais {
  id: number;
  nombre: string;
}

export interface MetodoPago {
  id: number;
  nombre: string;
}

export interface Venta {
  id: number;
  id_usuario: number;
  metodo_pago: number;
}

export interface VentaXProducto {
  id: number;
  id_producto: number;
  id_venta: number;
  cantidad: number;
  precio: number;
}

export interface CarritoItem {
  id: number;
  id_producto: number;
  id_usuario: number;
}
