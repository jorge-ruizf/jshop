import { Router } from 'express';
import { healthRouter } from './health.routes.js';
import { usuarioRouter } from './usuario.routes.js';
import { productoRouter } from './producto.routes.js';
import { categoriaRouter } from './categoria.routes.js';
import { paisRouter } from './pais.routes.js';

const apiRouter = Router();

apiRouter.use('/health', healthRouter);
apiRouter.use('/usuarios', usuarioRouter);
apiRouter.use('/productos', productoRouter);
apiRouter.use('/categorias', categoriaRouter);
apiRouter.use('/paises', paisRouter);

export { apiRouter };
