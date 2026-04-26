import { prisma } from '../services/prisma.js';

// Sin cambios estructurales. Se añade include en getById para mayor contexto.

export async function listPaises(req, res, next) {
  try {
    res.json(await prisma.pais.findMany());
  } catch (err) { next(err); }
}

export async function getPais(req, res, next) {
  try {
    const item = await prisma.pais.findUnique({
      where: { id: req.id },
      include: { metodos_pago: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Pais not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createPais(req, res, next) {
  try {
    const { nombre } = req.body;
    res.status(201).json(await prisma.pais.create({ data: { nombre } }));
  } catch (err) { next(err); }
}

export async function updatePais(req, res, next) {
  try {
    const { nombre } = req.body;
    res.json(await prisma.pais.update({ where: { id: req.id }, data: { nombre } }));
  } catch (err) { next(err); }
}

export async function deletePais(req, res, next) {
  try {
    await prisma.pais.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
