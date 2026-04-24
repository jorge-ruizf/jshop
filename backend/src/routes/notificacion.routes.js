import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listNotificaciones, getNotificacion, createNotificacion, updateNotificacion, deleteNotificacion,
} from '../controllers/notificacion.controller.js';

const notificacionRouter = Router();

notificacionRouter.get('/', listNotificaciones);
notificacionRouter.get('/:id', parseId, getNotificacion);
notificacionRouter.post('/', requireFields(['id_usuario', 'contenido']), createNotificacion);
notificacionRouter.put('/:id', parseId, updateNotificacion);
notificacionRouter.delete('/:id', parseId, deleteNotificacion);

export { notificacionRouter };
