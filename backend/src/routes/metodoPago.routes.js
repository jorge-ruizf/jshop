import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listMetodosPago, getMetodoPago, createMetodoPago, updateMetodoPago, deleteMetodoPago,
} from '../controllers/metodoPago.controller.js';

const metodoPagoRouter = Router();

metodoPagoRouter.get('/', listMetodosPago);
metodoPagoRouter.get('/:id', parseId, getMetodoPago);
// ✅ añadido id_pais (FK requerida en el schema — estaba ausente)
metodoPagoRouter.post('/', requireFields(['nombre', 'id_pais']), createMetodoPago);
metodoPagoRouter.put('/:id', parseId, requireFields(['nombre']), updateMetodoPago);
metodoPagoRouter.delete('/:id', parseId, deleteMetodoPago);

export { metodoPagoRouter };
