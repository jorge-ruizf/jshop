import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listMensajes, getMensaje, createMensaje, updateMensaje, deleteMensaje,
} from '../controllers/mensaje.controller.js';

const mensajeRouter = Router();

mensajeRouter.get('/', listMensajes);
mensajeRouter.get('/:id', parseId, getMensaje);
mensajeRouter.post('/', requireFields(['id_chat', 'id_usuario', 'contenido']), createMensaje);
mensajeRouter.put('/:id', parseId, updateMensaje);
mensajeRouter.delete('/:id', parseId, deleteMensaje);

export { mensajeRouter };
