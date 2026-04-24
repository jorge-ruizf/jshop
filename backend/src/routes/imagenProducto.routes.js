import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listImagenesProducto, getImagenProducto, createImagenProducto, updateImagenProducto, deleteImagenProducto,
} from '../controllers/imagenProducto.controller.js';

const imagenProductoRouter = Router();

imagenProductoRouter.get('/', listImagenesProducto);
imagenProductoRouter.get('/:id', parseId, getImagenProducto);
imagenProductoRouter.post('/', requireFields(['id_producto', 'url']), createImagenProducto);
imagenProductoRouter.put('/:id', parseId, updateImagenProducto);
imagenProductoRouter.delete('/:id', parseId, deleteImagenProducto);

export { imagenProductoRouter };
