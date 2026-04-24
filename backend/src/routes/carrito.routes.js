import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listCarrito, getCarrito, createCarrito, updateCarrito, deleteCarrito,
} from '../controllers/carrito.controller.js';

const carritoRouter = Router();

carritoRouter.get('/', listCarrito);
carritoRouter.get('/:id', parseId, getCarrito);
carritoRouter.post('/', requireFields(['id_producto', 'id_usuario']), createCarrito);
carritoRouter.put('/:id', parseId, updateCarrito);
carritoRouter.delete('/:id', parseId, deleteCarrito);

export { carritoRouter };
