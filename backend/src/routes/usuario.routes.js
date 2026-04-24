import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listUsuarios, getUsuario, createUsuario, updateUsuario, deleteUsuario,
} from '../controllers/usuario.controller.js';

const usuarioRouter = Router();

usuarioRouter.get('/', listUsuarios);
usuarioRouter.get('/:id', parseId, getUsuario);
usuarioRouter.post(
  '/',
  requireFields(['nombre', 'usuario', 'correo', 'id_pais', 'id_rol', 'id_metodo_pago_fav']),
  createUsuario,
);
usuarioRouter.put('/:id', parseId, updateUsuario);
usuarioRouter.delete('/:id', parseId, deleteUsuario);

export { usuarioRouter };
