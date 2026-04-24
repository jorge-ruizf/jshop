import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';
import {
  listChats, getChat, createChat, updateChat, deleteChat,
} from '../controllers/chat.controller.js';

const chatRouter = Router();

chatRouter.get('/', listChats);
chatRouter.get('/:id', parseId, getChat);
chatRouter.post('/', requireFields(['id_usuario_a', 'id_usuario_b']), createChat);
chatRouter.put('/:id', parseId, updateChat);
chatRouter.delete('/:id', parseId, deleteChat);

export { chatRouter };
