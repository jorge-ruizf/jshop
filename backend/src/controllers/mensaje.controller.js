import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior:
// ❌ orderBy 'enviado_en' → 'fecha' (el schema define el campo como 'fecha DateTime').
// ❌ include 'imagenes' eliminado — Mensaje NO tiene relación directa con Imagen_Mensaje
//    en el schema (Imagen_Mensaje apunta a Chat, no a Mensaje).
// ✅ Se añade 'fecha' al crear un mensaje.

export async function listMensajes(req, res, next) {
  try {
    const where = {};
    if (req.query.id_chat) where.id_chat = Number(req.query.id_chat);
    res.json(await prisma.mensaje.findMany({
      where,
      include: { usuario: true },
      orderBy: { fecha: 'asc' },
    }));
  } catch (err) { next(err); }
}

export async function getMensaje(req, res, next) {
  try {
    const item = await prisma.mensaje.findUnique({
      where: { id: req.id },
      include: { usuario: true, chat: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Mensaje not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createMensaje(req, res, next) {
  try {
    const { id_chat, id_usuario, contenido, fecha } = req.body;
    res.status(201).json(await prisma.mensaje.create({
      data: {
        id_chat,
        id_usuario,
        contenido,
        fecha: fecha ? new Date(fecha) : new Date(),
      },
    }));
  } catch (err) { next(err); }
}

export async function updateMensaje(req, res, next) {
  try {
    const { contenido } = req.body;
    res.json(await prisma.mensaje.update({
      where: { id: req.id },
      data: { contenido },
    }));
  } catch (err) { next(err); }
}

export async function deleteMensaje(req, res, next) {
  try {
    await prisma.mensaje.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
