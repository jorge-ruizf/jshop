import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listChats, getChat, createChat, updateChat, deleteChat,
} from '../controllers/chat.controller.js';

const chatRouter = Router();

chatRouter.get('/', listChats);
chatRouter.get('/:id', parseId, getChat);
// ✅ id_usuario_a / id_usuario_b eliminados — Chat pertenece a Venta_X_Producto, no a usuarios
chatRouter.post('/', requireFields(['id_venta_x_producto']), createChat);
chatRouter.put('/:id', parseId, updateChat);
chatRouter.delete('/:id', parseId, deleteChat);

export { chatRouter };
