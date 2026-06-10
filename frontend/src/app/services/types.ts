export interface Usuario {
  id: number;
  nombre: string;
  usuario: string;
  correo: string;
  id_pais: number;
  id_rol: number;
  id_metodo_pago_fav: number;
}

export interface Imagen_Producto {
  id: number;
  nombre: string;
  ruta: string;
  id_producto: number;
  id_tipo_imagen: number;
}

export interface Precio {
  id: number;
  precio: number;
  id_pais: number;
  id_producto: number;
  pais?: { id: number; nombre: string };  // incluido por el backend
}

export interface Producto {
  id: number;
  nombre: string;
  descripcion: string;
  cantidad: number;
  id_vendedor: number;
  id_categoria: number;
  id_pais: number;
  id_videojuego: number;
  imagenes?: Imagen_Producto[];
  precios?: Precio[];
}

export interface Categoria {
  id: number;
  nombre: string;
}

export interface Pais {
  id: number;
  nombre: string;
}

export interface Videojuego {
  id: number;
  nombre: string;
}

export interface MetodoPago {
  id: number;
  nombre: string;
  id_pais: number;
}

// Mantenido por compatibilidad — usar Imagen_Producto para nuevos usos
export interface ImagenProducto {
  id: number;
  id_producto: number;
  ruta: string;  // corregido: era "url", el schema usa "ruta"
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

 
export interface Notificacion {
  id: number;
  fecha_notificado: string;
  descripcion: string;
  id_producto_deseado: number;
}
 
export interface ProductoDeseado {
  id: number;
  precio_objetivo: number;
  id_producto: number;
  id_usuario: number;
  producto?: import('./types').Producto;
  notificaciones?: Notificacion[];
}
 
