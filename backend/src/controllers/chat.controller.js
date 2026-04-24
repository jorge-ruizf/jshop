import { prisma } from '../services/prisma.js';

export async function listChats(req, res, next) {
  try {
    res.json(await prisma.chat.findMany({
      include: { usuario_a: true, usuario_b: true },
    }));
  } catch (err) { next(err); }
}

export async function getChat(req, res, next) {
  try {
    const item = await prisma.chat.findUnique({
      where: { id: req.id },
      include: {
        usuario_a: true,
        usuario_b: true,
        mensajes: { orderBy: { enviado_en: 'asc' }, include: { imagenes: true } },
      },
    });
    if (!item) return res.status(404).json({ error: { message: 'Chat not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createChat(req, res, next) {
  try {
    const { id_usuario_a, id_usuario_b } = req.body;
    res.status(201).json(await prisma.chat.create({ data: { id_usuario_a, id_usuario_b } }));
  } catch (err) { next(err); }
}

export async function updateChat(req, res, next) {
  try {
    const { id_usuario_a, id_usuario_b } = req.body;
    res.json(await prisma.chat.update({
      where: { id: req.id },
      data: { id_usuario_a, id_usuario_b },
    }));
  } catch (err) { next(err); }
}

export async function deleteChat(req, res, next) {
  try {
    await prisma.chat.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
