import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior (reescritura completa):
// ❌ id_usuario eliminado — Valoracion NO tiene FK a Usuario en el schema.
// ❌ id_producto eliminado — Valoracion NO tiene FK a Producto en el schema.
// ❌ puntuacion → puntaje (nombre del campo en el schema).
// ❌ comentario eliminado — campo no existe en el schema.
// ❌ creado_en → fecha (nombre del campo en el schema).
// ✅ FK correcta: id_venta_x_producto (@unique — 1 valoración por línea de venta).
// ✅ include actualizado: venta_x_producto (con producto y venta anidados).
// ✅ Filtro de listado corregido.

export async function listValoraciones(req, res, next) {
  try {
    const where = {};
    if (req.query.id_venta_x_producto) where.id_venta_x_producto = Number(req.query.id_venta_x_producto);
    res.json(await prisma.valoracion.findMany({
      where,
      include: {
        venta_x_producto: { include: { producto: true, venta: true } },
      },
      orderBy: { fecha: 'desc' },
    }));
  } catch (err) { next(err); }
}

export async function getValoracion(req, res, next) {
  try {
    const item = await prisma.valoracion.findUnique({
      where: { id: req.id },
      include: {
        venta_x_producto: { include: { producto: true, venta: true } },
      },
    });
    if (!item) return res.status(404).json({ error: { message: 'Valoracion not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createValoracion(req, res, next) {
  try {
    const { id_venta_x_producto, puntaje, fecha } = req.body;
    if (!Number.isInteger(puntaje) || puntaje < 1 || puntaje > 5) {
      return res.status(400).json({ error: { message: 'puntaje debe ser un entero entre 1 y 5' } });
    }
    res.status(201).json(await prisma.valoracion.create({
      data: {
        id_venta_x_producto,
        puntaje,
        fecha: fecha ? new Date(fecha) : new Date(),
      },
    }));
  } catch (err) { next(err); }
}

export async function updateValoracion(req, res, next) {
  try {
    const { puntaje, fecha } = req.body;
    if (puntaje !== undefined && (!Number.isInteger(puntaje) || puntaje < 1 || puntaje > 5)) {
      return res.status(400).json({ error: { message: 'puntaje debe ser un entero entre 1 y 5' } });
    }
    res.json(await prisma.valoracion.update({
      where: { id: req.id },
      data: {
        ...(puntaje !== undefined && { puntaje }),
        ...(fecha   !== undefined && { fecha: new Date(fecha) }),
      },
    }));
  } catch (err) { next(err); }
}

export async function deleteValoracion(req, res, next) {
  try {
    await prisma.valoracion.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
