import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listCategorias, getCategoria, createCategoria, updateCategoria, deleteCategoria,
} from '../controllers/categoria.controller.js';

const categoriaRouter = Router();

categoriaRouter.get('/', listCategorias);
categoriaRouter.get('/:id', parseId, getCategoria);
categoriaRouter.post('/', requireFields(['nombre']), createCategoria);
categoriaRouter.put('/:id', parseId, requireFields(['nombre']), updateCategoria);
categoriaRouter.delete('/:id', parseId, deleteCategoria);

export { categoriaRouter };
