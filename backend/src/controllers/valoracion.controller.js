import { prisma } from '../services/prisma.js';

export async function listValoraciones(req, res, next) {
  try {
    const where = {};
    if (req.query.id_producto) where.id_producto = Number(req.query.id_producto);
    if (req.query.id_usuario) where.id_usuario = Number(req.query.id_usuario);
    res.json(await prisma.valoracion.findMany({
      where,
      include: { usuario: true, producto: true },
      orderBy: { creado_en: 'desc' },
    }));
  } catch (err) { next(err); }
}

export async function getValoracion(req, res, next) {
  try {
    const item = await prisma.valoracion.findUnique({
      where: { id: req.id },
      include: { usuario: true, producto: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Valoracion not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createValoracion(req, res, next) {
  try {
    const { id_usuario, id_producto, puntuacion, comentario } = req.body;
    if (!Number.isInteger(puntuacion) || puntuacion < 1 || puntuacion > 5) {
      return res.status(400).json({ error: { message: 'puntuacion must be an integer between 1 and 5' } });
    }
    res.status(201).json(await prisma.valoracion.create({
      data: { id_usuario, id_producto, puntuacion, comentario },
    }));
  } catch (err) { next(err); }
}

export async function updateValoracion(req, res, next) {
  try {
    const { puntuacion, comentario } = req.body;
    if (puntuacion !== undefined && (!Number.isInteger(puntuacion) || puntuacion < 1 || puntuacion > 5)) {
      return res.status(400).json({ error: { message: 'puntuacion must be an integer between 1 and 5' } });
    }
    res.json(await prisma.valoracion.update({
      where: { id: req.id },
      data: { puntuacion, comentario },
    }));
  } catch (err) { next(err); }
}

export async function deleteValoracion(req, res, next) {
  try {
    await prisma.valoracion.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
