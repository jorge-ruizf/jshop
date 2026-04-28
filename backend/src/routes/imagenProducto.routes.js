import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listImagenesProducto, getImagenProducto, createImagenProducto, updateImagenProducto, deleteImagenProducto,
} from '../controllers/imagenProducto.controller.js';

const imagenProductoRouter = Router();

imagenProductoRouter.get('/', listImagenesProducto);
imagenProductoRouter.get('/:id', parseId, getImagenProducto);
// ✅ url eliminado → ruta; añadidos nombre e id_tipo_imagen (requeridos en schema)
imagenProductoRouter.post('/', requireFields(['id_producto', 'id_tipo_imagen', 'nombre', 'ruta']), createImagenProducto);
imagenProductoRouter.put('/:id', parseId, updateImagenProducto);
imagenProductoRouter.delete('/:id', parseId, deleteImagenProducto);

export { imagenProductoRouter };
