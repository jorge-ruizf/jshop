import { prisma } from '../services/prisma.js';

export async function listMetodosPago(req, res, next) {
  try {
    res.json(await prisma.metodo_Pago.findMany());
  } catch (err) { next(err); }
}

export async function getMetodoPago(req, res, next) {
  try {
    const item = await prisma.metodo_Pago.findUnique({ where: { id: req.id } });
    if (!item) return res.status(404).json({ error: { message: 'Metodo_Pago not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createMetodoPago(req, res, next) {
  try {
    const { nombre } = req.body;
    res.status(201).json(await prisma.metodo_Pago.create({ data: { nombre } }));
  } catch (err) { next(err); }
}

export async function updateMetodoPago(req, res, next) {
  try {
    const { nombre } = req.body;
    res.json(await prisma.metodo_Pago.update({ where: { id: req.id }, data: { nombre } }));
  } catch (err) { next(err); }
}

export async function deleteMetodoPago(req, res, next) {
  try {
    await prisma.metodo_Pago.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
