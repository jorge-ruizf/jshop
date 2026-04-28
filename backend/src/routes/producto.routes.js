import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listProductos, getProducto, createProducto, updateProducto, deleteProducto,
} from '../controllers/producto.controller.js';

const productoRouter = Router();

productoRouter.get('/', listProductos);
productoRouter.get('/:id', parseId, getProducto);
// ✅ añadido id_videojuego (FK requerida en el schema — estaba ausente)
productoRouter.post(
  '/',
  requireFields(['nombre', 'descripcion', 'id_vendedor', 'id_pais', 'id_categoria', 'id_videojuego']),
  createProducto,
);
productoRouter.put('/:id', parseId, updateProducto);
productoRouter.delete('/:id', parseId, deleteProducto);

export { productoRouter };
