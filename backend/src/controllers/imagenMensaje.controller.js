import { prisma } from '../services/prisma.js';

export async function listImagenesMensaje(req, res, next) {
  try {
    const where = {};
    if (req.query.id_mensaje) where.id_mensaje = Number(req.query.id_mensaje);
    res.json(await prisma.imagen_Mensaje.findMany({ where }));
  } catch (err) { next(err); }
}

export async function getImagenMensaje(req, res, next) {
  try {
    const item = await prisma.imagen_Mensaje.findUnique({
      where: { id: req.id },
      include: { mensaje: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Imagen_Mensaje not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createImagenMensaje(req, res, next) {
  try {
    const { id_mensaje, url } = req.body;
    res.status(201).json(await prisma.imagen_Mensaje.create({ data: { id_mensaje, url } }));
  } catch (err) { next(err); }
}

export async function updateImagenMensaje(req, res, next) {
  try {
    const { id_mensaje, url } = req.body;
    res.json(await prisma.imagen_Mensaje.update({
      where: { id: req.id },
      data: { id_mensaje, url },
    }));
  } catch (err) { next(err); }
}

export async function deleteImagenMensaje(req, res, next) {
  try {
    await prisma.imagen_Mensaje.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
