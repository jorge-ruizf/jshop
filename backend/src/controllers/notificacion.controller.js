import { prisma } from '../services/prisma.js';

export async function listNotificaciones(req, res, next) {
  try {
    const where = {};
    if (req.query.id_usuario) where.id_usuario = Number(req.query.id_usuario);
    if (req.query.leida !== undefined) where.leida = req.query.leida === 'true';
    res.json(await prisma.notificacion.findMany({
      where,
      orderBy: { creado_en: 'desc' },
    }));
  } catch (err) { next(err); }
}

export async function getNotificacion(req, res, next) {
  try {
    const item = await prisma.notificacion.findUnique({
      where: { id: req.id },
      include: { usuario: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Notificacion not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createNotificacion(req, res, next) {
  try {
    const { id_usuario, contenido, leida } = req.body;
    res.status(201).json(await prisma.notificacion.create({
      data: { id_usuario, contenido, leida: leida ?? false },
    }));
  } catch (err) { next(err); }
}

export async function updateNotificacion(req, res, next) {
  try {
    const { contenido, leida } = req.body;
    res.json(await prisma.notificacion.update({
      where: { id: req.id },
      data: { contenido, leida },
    }));
  } catch (err) { next(err); }
}

export async function deleteNotificacion(req, res, next) {
  try {
    await prisma.notificacion.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
