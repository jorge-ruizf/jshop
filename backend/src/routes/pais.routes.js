import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listPaises, getPais, createPais, updatePais, deletePais,
} from '../controllers/pais.controller.js';

const paisRouter = Router();

paisRouter.get('/', listPaises);
paisRouter.get('/:id', parseId, getPais);
paisRouter.post('/', requireFields(['nombre']), createPais);
paisRouter.put('/:id', parseId, requireFields(['nombre']), updatePais);
paisRouter.delete('/:id', parseId, deletePais);

export { paisRouter };
