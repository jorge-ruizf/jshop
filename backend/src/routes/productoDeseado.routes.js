import { Router } from 'express';
import {
  crearProductoDeseado,
  listarProductosDeseados,
  eliminarProductoDeseado,
  actualizarProductoDeseado,
} from '../controllers/productoDeseado.controller.js';

const productoDeseadoRouter = Router();

productoDeseadoRouter.get('/', listarProductosDeseados);       // GET  ?id_usuario=X
productoDeseadoRouter.post('/', crearProductoDeseado);         // POST
productoDeseadoRouter.put('/:id', actualizarProductoDeseado);  // PUT  /:id
productoDeseadoRouter.delete('/:id', eliminarProductoDeseado); // DEL  /:id

export { productoDeseadoRouter };