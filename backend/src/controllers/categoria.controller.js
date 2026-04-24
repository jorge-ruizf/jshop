import { prisma } from '../services/prisma.js';

export async function listCategorias(req, res, next) {
  try {
    res.json(await prisma.categoria.findMany());
  } catch (err) { next(err); }
}

export async function getCategoria(req, res, next) {
  try {
    const item = await prisma.categoria.findUnique({ where: { id: req.id } });
    if (!item) return res.status(404).json({ error: { message: 'Categoria not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createCategoria(req, res, next) {
  try {
    const { nombre } = req.body;
    res.status(201).json(await prisma.categoria.create({ data: { nombre } }));
  } catch (err) { next(err); }
}

export async function updateCategoria(req, res, next) {
  try {
    const { nombre } = req.body;
    res.json(await prisma.categoria.update({ where: { id: req.id }, data: { nombre } }));
  } catch (err) { next(err); }
}

export async function deleteCategoria(req, res, next) {
  try {
    await prisma.categoria.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
