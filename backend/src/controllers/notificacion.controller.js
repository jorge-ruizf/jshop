import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior (reescritura completa):
// ❌ id_usuario eliminado — Notificacion NO tiene FK a Usuario en el schema.
// ❌ contenido → descripcion (el schema define el campo como 'descripcion Text').
// ❌ leida eliminado — campo no existe en el schema.
// ❌ creado_en → fecha_notificado (nombre del campo en el schema).
// ✅ FK correcta: id_producto_deseado → Producto_Deseado.
// ✅ include actualizado: producto_deseado (con usuario y producto anidados).
// ✅ Filtro de listado corregido a id_producto_deseado.

export async function listNotificaciones(req, res, next) {
  try {
    const where = {};
    if (req.query.id_producto_deseado) where.id_producto_deseado = Number(req.query.id_producto_deseado);
    res.json(await prisma.notificacion.findMany({
      where,
      include: {
        producto_deseado: { include: { producto: true, usuario: true } },
      },
      orderBy: { fecha_notificado: 'desc' },
    }));
  } catch (err) { next(err); }
}

export async function getNotificacion(req, res, next) {
  try {
    const item = await prisma.notificacion.findUnique({
      where: { id: req.id },
      include: {
        producto_deseado: { include: { producto: true, usuario: true } },
      },
    });
    if (!item) return res.status(404).json({ error: { message: 'Notificacion not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createNotificacion(req, res, next) {
  try {
    const { id_producto_deseado, descripcion, fecha_notificado } = req.body;
    res.status(201).json(await prisma.notificacion.create({
      data: {
        id_producto_deseado,
        descripcion,
        fecha_notificado: fecha_notificado ? new Date(fecha_notificado) : new Date(),
      },
    }));
  } catch (err) { next(err); }
}

export async function updateNotificacion(req, res, next) {
  try {
    const { descripcion, fecha_notificado } = req.body;
    res.json(await prisma.notificacion.update({
      where: { id: req.id },
      data: {
        ...(descripcion       !== undefined && { descripcion }),
        ...(fecha_notificado  !== undefined && { fecha_notificado: new Date(fecha_notificado) }),
      },
    }));
  } catch (err) { next(err); }
}

export async function deleteNotificacion(req, res, next) {
  try {
    await prisma.notificacion.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
