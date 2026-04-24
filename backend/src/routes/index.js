import { Router } from 'express';
import { healthRouter } from './health.routes.js';
import { usuarioRouter } from './usuario.routes.js';
import { productoRouter } from './producto.routes.js';
import { categoriaRouter } from './categoria.routes.js';
import { paisRouter } from './pais.routes.js';
import { ventaRouter } from './venta.routes.js';
import { ventaProductoRouter } from './ventaProducto.routes.js';
import { carritoRouter } from './carrito.routes.js';

const apiRouter = Router();

apiRouter.use('/health', healthRouter);
apiRouter.use('/usuarios', usuarioRouter);
apiRouter.use('/productos', productoRouter);
apiRouter.use('/categorias', categoriaRouter);
apiRouter.use('/paises', paisRouter);
apiRouter.use('/ventas', ventaRouter);
apiRouter.use('/ventas-productos', ventaProductoRouter);
apiRouter.use('/carrito', carritoRouter);

export { apiRouter };
