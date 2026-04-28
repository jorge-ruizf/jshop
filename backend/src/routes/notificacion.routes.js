import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listNotificaciones, getNotificacion, createNotificacion, updateNotificacion, deleteNotificacion,
} from '../controllers/notificacion.controller.js';

const notificacionRouter = Router();

notificacionRouter.get('/', listNotificaciones);
notificacionRouter.get('/:id', parseId, getNotificacion);
// ✅ id_usuario / contenido eliminados — FK correcta es id_producto_deseado
// ✅ campo renombrado: contenido → descripcion
notificacionRouter.post('/', requireFields(['id_producto_deseado', 'descripcion']), createNotificacion);
notificacionRouter.put('/:id', parseId, updateNotificacion);
notificacionRouter.delete('/:id', parseId, deleteNotificacion);

export { notificacionRouter };
