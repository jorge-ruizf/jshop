import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior:
// ❌ include 'metodoPago' → 'metodo_pago' (nombre de la relación en el schema).
// ❌ include 'ventas_x_producto' → 'venta_x_productos' (nombre en el schema).
// ❌ campo 'metodo_pago' en create/update → 'id_metodo_pago' (FK escalar del schema).
// ✅ Añadidos campos requeridos 'total' y 'fecha' en create.

export async function listVentas(req, res, next) {
  try {
    const where = {};
    if (req.query.id_usuario) where.id_usuario = Number(req.query.id_usuario);
    res.json(await prisma.venta.findMany({
      where,
      include: {
        usuario: true,
        metodo_pago: true,
        venta_x_productos: { include: { producto: true } },
      },
      orderBy: { fecha: 'desc' },
    }));
  } catch (err) { next(err); }
}

export async function getVenta(req, res, next) {
  try {
    const item = await prisma.venta.findUnique({
      where: { id: req.id },
      include: {
        usuario: true,
        metodo_pago: true,
        venta_x_productos: {
          include: {
            producto: true,
            chat: true,
            valoracion: true,
          },
        },
      },
    });
    if (!item) return res.status(404).json({ error: { message: 'Venta not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createVenta(req, res, next) {
  try {
    const { id_usuario, id_metodo_pago, total, fecha } = req.body;
    res.status(201).json(await prisma.venta.create({
      data: {
        id_usuario,
        id_metodo_pago,
        total,
        fecha: fecha ? new Date(fecha) : new Date(),
      },
    }));
  } catch (err) { next(err); }
}

export async function updateVenta(req, res, next) {
  try {
    const { id_usuario, id_metodo_pago, total, fecha } = req.body;
    res.json(await prisma.venta.update({
      where: { id: req.id },
      data: {
        ...(id_usuario     !== undefined && { id_usuario }),
        ...(id_metodo_pago !== undefined && { id_metodo_pago }),
        ...(total          !== undefined && { total }),
        ...(fecha          !== undefined && { fecha: new Date(fecha) }),
      },
    }));
  } catch (err) { next(err); }
}

export async function deleteVenta(req, res, next) {
  try {
    await prisma.venta.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
