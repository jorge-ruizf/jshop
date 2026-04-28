import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listImagenesMensaje, getImagenMensaje, createImagenMensaje, updateImagenMensaje, deleteImagenMensaje,
} from '../controllers/imagenMensaje.controller.js';

const imagenMensajeRouter = Router();

imagenMensajeRouter.get('/', listImagenesMensaje);
imagenMensajeRouter.get('/:id', parseId, getImagenMensaje);
// ✅ id_mensaje / url eliminados
// ✅ FK correcta es id_chat; campo renombrado url → ruta; id_tipo_imagen es requerido
imagenMensajeRouter.post('/', requireFields(['id_chat', 'id_tipo_imagen', 'ruta']), createImagenMensaje);
imagenMensajeRouter.put('/:id', parseId, updateImagenMensaje);
imagenMensajeRouter.delete('/:id', parseId, deleteImagenMensaje);

export { imagenMensajeRouter };
