import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior:
// ❌ usuario_a / usuario_b eliminados — Chat NO tiene usuarios directos en el schema.
// ✅ Chat pertenece a una Venta_X_Producto (relación 1-a-1, @unique).
// ✅ include actualizado: venta_x_producto, mensajes, imagenes_mensaje.
// ✅ orderBy mensajes por 'fecha' (el schema no tiene 'enviado_en').
// ✅ createChat recibe id_venta_x_producto + fecha.

export async function listChats(req, res, next) {
  try {
    res.json(await prisma.chat.findMany({
      include: {
        venta_x_producto: { include: { producto: true, venta: true } },
        mensajes: { orderBy: { fecha: 'asc' } },
      },
    }));
  } catch (err) { next(err); }
}

export async function getChat(req, res, next) {
  try {
    const item = await prisma.chat.findUnique({
      where: { id: req.id },
      include: {
        venta_x_producto: { include: { producto: true, venta: true } },
        mensajes: {
          orderBy: { fecha: 'asc' },
          include: { usuario: true },
        },
        imagenes_mensaje: { include: { tipo_imagen: true } },
      },
    });
    if (!item) return res.status(404).json({ error: { message: 'Chat not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createChat(req, res, next) {
  try {
    const { id_venta_x_producto, fecha } = req.body;
    res.status(201).json(await prisma.chat.create({
      data: {
        id_venta_x_producto,
        fecha: fecha ? new Date(fecha) : new Date(),
      },
      include: { venta_x_producto: true },
    }));
  } catch (err) { next(err); }
}

// Update solo permite cambiar la fecha; el vínculo con venta_x_producto es inmutable.
export async function updateChat(req, res, next) {
  try {
    const { fecha } = req.body;
    res.json(await prisma.chat.update({
      where: { id: req.id },
      data: { fecha: new Date(fecha) },
    }));
  } catch (err) { next(err); }
}

export async function deleteChat(req, res, next) {
  try {
    await prisma.chat.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
