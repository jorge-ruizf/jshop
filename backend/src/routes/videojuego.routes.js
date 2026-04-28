import { Router } from 'express';
import { requireFields, parseId } from '../middlewares/validateBody.js';

import {
    listVideojuegos,
    getVideojuego,
    createVideojuego,
    updateVideojuego,
    deleteVideojuego,
} from '../controllers/videojuego.controller.js';

const videojuegoRouter = Router();

videojuegoRouter.get('/', listVideojuegos);
videojuegoRouter.get('/:id', parseId, getVideojuego);
videojuegoRouter.post('/', requireFields(['nombre']), createVideojuego);
videojuegoRouter.put('/:id', parseId, requireFields(['nombre']), updateVideojuego);
videojuegoRouter.delete('/:id', parseId, deleteVideojuego);

export { videojuegoRouter };