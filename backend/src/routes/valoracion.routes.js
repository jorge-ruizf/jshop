import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listValoraciones, getValoracion, createValoracion, updateValoracion, deleteValoracion,
} from '../controllers/valoracion.controller.js';

const valoracionRouter = Router();

valoracionRouter.get('/', listValoraciones);
valoracionRouter.get('/:id', parseId, getValoracion);
valoracionRouter.post(
  '/',
  requireFields(['id_usuario', 'id_producto', 'puntuacion']),
  createValoracion,
);
valoracionRouter.put('/:id', parseId, updateValoracion);
valoracionRouter.delete('/:id', parseId, deleteValoracion);

export { valoracionRouter };
