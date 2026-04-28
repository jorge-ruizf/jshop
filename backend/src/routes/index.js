import { Router } from 'express';

import { healthRouter } from './health.routes.js';
import { usuarioRouter } from './usuario.routes.js';
import { productoRouter } from './producto.routes.js';
import { categoriaRouter } from './categoria.routes.js';
import { paisRouter } from './pais.routes.js';
import { metodoPagoRouter } from './metodoPago.routes.js';
import { ventaRouter } from './venta.routes.js';
import { ventaProductoRouter } from './ventaProducto.routes.js';
import { carritoRouter } from './carrito.routes.js';
import { chatRouter } from './chat.routes.js';
import { mensajeRouter } from './mensaje.routes.js';
import { imagenMensajeRouter } from './imagenMensaje.routes.js';
import { imagenProductoRouter } from './imagenProducto.routes.js';
import { valoracionRouter } from './valoracion.routes.js';
import { notificacionRouter } from './notificacion.routes.js';
import { videojuegoRouter } from './videojuego.routes.js';

const apiRouter = Router();

// CORE
apiRouter.use('/health', healthRouter);
apiRouter.use('/usuarios', usuarioRouter);

// CATÁLOGO
apiRouter.use('/productos', productoRouter);
apiRouter.use('/categorias', categoriaRouter);
apiRouter.use('/paises', paisRouter);

// COMERCIO
apiRouter.use('/ventas', ventaRouter);
apiRouter.use('/ventas-productos', ventaProductoRouter);
apiRouter.use('/carrito', carritoRouter);

// SOCIAL / CHAT
apiRouter.use('/chats', chatRouter);
apiRouter.use('/mensajes', mensajeRouter);

// MEDIA
apiRouter.use('/imagenes-mensaje', imagenMensajeRouter);
apiRouter.use('/imagenes-producto', imagenProductoRouter);

// OTROS
apiRouter.use('/metodos-pago', metodoPagoRouter);
apiRouter.use('/valoraciones', valoracionRouter);
apiRouter.use('/notificaciones', notificacionRouter);

// VIDEOJUEGOS
apiRouter.use('/videojuegos', videojuegoRouter);


export { apiRouter };


apiRouter.get('/', (req, res) => {
  res.json({
    message: 'API JSHOP running',
    endpoints: [
      '/api/productos',
      '/api/categorias',
      '/api/usuarios',
      '/api/ventas',
    ],
  });
});
