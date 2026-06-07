import { Router } from 'express';
import { parseId, requireFields } from '../middlewares/validateBody.js';
import {
  listPrecios,
  createPrecio,
  bulkUpsertPrecios,
  deletePrecio,
} from '../controllers/precio.controller.js';

const precioRouter = Router();

precioRouter.get('/', listPrecios);
precioRouter.post('/', requireFields(['precio', 'id_pais', 'id_producto']), createPrecio);
precioRouter.post('/bulk', bulkUpsertPrecios);
precioRouter.delete('/:id', parseId, deletePrecio);

export { precioRouter };