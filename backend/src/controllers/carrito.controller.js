import { prisma } from '../services/prisma.js';

export async function listCarrito(req, res, next) {
  try {
    const where = {};
    if (req.query.id_usuario) where.id_usuario = Number(req.query.id_usuario);
    res.json(await prisma.carrito.findMany({
      where,
      include: { producto: true, usuario: true },
    }));
  } catch (err) { next(err); }
}

export async function getCarrito(req, res, next) {
  try {
    const item = await prisma.carrito.findUnique({
      where: { id: req.id },
      include: { producto: true, usuario: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Carrito item not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createCarrito(req, res, next) {
  try {
    const { id_producto, id_usuario } = req.body;
    res.status(201).json(await prisma.carrito.create({ data: { id_producto, id_usuario } }));
  } catch (err) { next(err); }
}

export async function updateCarrito(req, res, next) {
  try {
    const { id_producto, id_usuario } = req.body;
    res.json(await prisma.carrito.update({
      where: { id: req.id },
      data: { id_producto, id_usuario },
    }));
  } catch (err) { next(err); }
}

export async function deleteCarrito(req, res, next) {
  try {
    await prisma.carrito.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
