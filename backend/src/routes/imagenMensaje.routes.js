import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listImagenesMensaje, getImagenMensaje, createImagenMensaje, updateImagenMensaje, deleteImagenMensaje,
} from '../controllers/imagenMensaje.controller.js';

const imagenMensajeRouter = Router();

imagenMensajeRouter.get('/', listImagenesMensaje);
imagenMensajeRouter.get('/:id', parseId, getImagenMensaje);
imagenMensajeRouter.post('/', requireFields(['id_mensaje', 'url']), createImagenMensaje);
imagenMensajeRouter.put('/:id', parseId, updateImagenMensaje);
imagenMensajeRouter.delete('/:id', parseId, deleteImagenMensaje);

export { imagenMensajeRouter };
