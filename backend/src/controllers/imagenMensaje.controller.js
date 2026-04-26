import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior:
// ❌ id_mensaje eliminado — Imagen_Mensaje NO tiene FK a Mensaje en el schema.
// ✅ FK correcta es id_chat → tbl_chat (con relación a Chat).
// ❌ campo url eliminado — schema tiene 'ruta' (VarChar 150) y 'fecha'.
// ✅ Añadidos: ruta, fecha, id_tipo_imagen.
// ✅ include actualizado: chat y tipo_imagen.

export async function listImagenesMensaje(req, res, next) {
  try {
    const where = {};
    if (req.query.id_chat) where.id_chat = Number(req.query.id_chat);
    res.json(await prisma.imagen_Mensaje.findMany({
      where,
      include: { tipo_imagen: true },
    }));
  } catch (err) { next(err); }
}

export async function getImagenMensaje(req, res, next) {
  try {
    const item = await prisma.imagen_Mensaje.findUnique({
      where: { id: req.id },
      include: { chat: true, tipo_imagen: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Imagen_Mensaje not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createImagenMensaje(req, res, next) {
  try {
    const { id_chat, id_tipo_imagen, ruta, fecha } = req.body;
    res.status(201).json(await prisma.imagen_Mensaje.create({
      data: {
        id_chat,
        id_tipo_imagen,
        ruta,
        fecha: fecha ? new Date(fecha) : new Date(),
      },
    }));
  } catch (err) { next(err); }
}

export async function updateImagenMensaje(req, res, next) {
  try {
    const { id_chat, id_tipo_imagen, ruta, fecha } = req.body;
    res.json(await prisma.imagen_Mensaje.update({
      where: { id: req.id },
      data: {
        ...(id_chat       !== undefined && { id_chat }),
        ...(id_tipo_imagen !== undefined && { id_tipo_imagen }),
        ...(ruta          !== undefined && { ruta }),
        ...(fecha         !== undefined && { fecha: new Date(fecha) }),
      },
    }));
  } catch (err) { next(err); }
}

export async function deleteImagenMensaje(req, res, next) {
  try {
    await prisma.imagen_Mensaje.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
