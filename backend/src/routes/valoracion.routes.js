import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listValoraciones, getValoracion, createValoracion, updateValoracion, deleteValoracion,
} from '../controllers/valoracion.controller.js';

const valoracionRouter = Router();

valoracionRouter.get('/', listValoraciones);
valoracionRouter.get('/:id', parseId, getValoracion);
// ✅ id_usuario / id_producto / puntuacion eliminados
// ✅ FK correcta: id_venta_x_producto; campo renombrado: puntuacion → puntaje
valoracionRouter.post('/', requireFields(['id_venta_x_producto', 'puntaje']), createValoracion);
valoracionRouter.put('/:id', parseId, updateValoracion);
valoracionRouter.delete('/:id', parseId, deleteValoracion);

export { valoracionRouter };
