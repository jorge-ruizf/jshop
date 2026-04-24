import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listProductos, getProducto, createProducto, updateProducto, deleteProducto,
} from '../controllers/producto.controller.js';

const productoRouter = Router();

productoRouter.get('/', listProductos);
productoRouter.get('/:id', parseId, getProducto);
productoRouter.post(
  '/',
  requireFields(['nombre', 'descripcion', 'id_vendedor', 'id_categoria', 'id_pais']),
  createProducto,
);
productoRouter.put('/:id', parseId, updateProducto);
productoRouter.delete('/:id', parseId, deleteProducto);

export { productoRouter };
