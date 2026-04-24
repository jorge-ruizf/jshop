import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listVentaProductos, getVentaProducto, createVentaProducto, updateVentaProducto, deleteVentaProducto,
} from '../controllers/ventaProducto.controller.js';

const ventaProductoRouter = Router();

ventaProductoRouter.get('/', listVentaProductos);
ventaProductoRouter.get('/:id', parseId, getVentaProducto);
ventaProductoRouter.post(
  '/',
  requireFields(['id_producto', 'id_venta', 'cantidad', 'precio']),
  createVentaProducto,
);
ventaProductoRouter.put('/:id', parseId, updateVentaProducto);
ventaProductoRouter.delete('/:id', parseId, deleteVentaProducto);

export { ventaProductoRouter };
