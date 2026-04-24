import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listVentas, getVenta, createVenta, updateVenta, deleteVenta,
} from '../controllers/venta.controller.js';

const ventaRouter = Router();

ventaRouter.get('/', listVentas);
ventaRouter.get('/:id', parseId, getVenta);
ventaRouter.post('/', requireFields(['id_usuario', 'metodo_pago']), createVenta);
ventaRouter.put('/:id', parseId, updateVenta);
ventaRouter.delete('/:id', parseId, deleteVenta);

export { ventaRouter };
