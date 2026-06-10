import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listVentas, getVenta, createVenta, updateVenta, deleteVenta,
  confirmarVenta,
} from '../controllers/venta.controller.js';

const ventaRouter = Router();

ventaRouter.get('/',      listVentas);
ventaRouter.get('/:id',   parseId, getVenta);
// ✅ metodo_pago → id_metodo_pago (FK escalar del schema)
// ✅ añadido total (campo requerido en el schema: total Decimal)
ventaRouter.post('/',     requireFields(['id_usuario', 'id_metodo_pago', 'total']), createVenta);
ventaRouter.put('/:id',   parseId, updateVenta);
ventaRouter.delete('/:id', parseId, deleteVenta);

// ✅ /confirmar va ANTES de /:id — Express no lo confunde con un id numérico
ventaRouter.post('/confirmar', requireFields(['id_usuario', 'id_metodo_pago', 'total', 'items']), confirmarVenta);

export { ventaRouter };