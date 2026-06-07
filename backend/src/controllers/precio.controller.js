import { prisma } from '../services/prisma.js';

export async function listPrecios(req, res, next) {
  try {
    const where = {};
    if (req.query.id_producto) where.id_producto = Number(req.query.id_producto);
    if (req.query.id_pais)     where.id_pais     = Number(req.query.id_pais);
    res.json(await prisma.precio.findMany({ where, include: { pais: true } }));
  } catch (err) { next(err); }
}

export async function createPrecio(req, res, next) {
  try {
    const { precio, id_pais, id_producto } = req.body;
    res.status(201).json(
      await prisma.precio.create({ data: { precio, id_pais, id_producto } })
    );
  } catch (err) { next(err); }
}

export async function bulkUpsertPrecios(req, res, next) {
  try {
    const { id_producto, precios } = req.body;
    if (!id_producto || !Array.isArray(precios)) {
      return res.status(400).json({
        error: { message: 'id_producto y precios[] son requeridos' },
      });
    }

    const upserted = await Promise.all(
      precios.map(async ({ id_pais, precio: valor }) => {
        const existing = await prisma.precio.findFirst({
          where: {
            id_producto: Number(id_producto),
            id_pais: Number(id_pais),
          },
        });
        if (existing) {
          return prisma.precio.update({
            where: { id: existing.id },
            data: { precio: Number(valor) },
          });
        }
        return prisma.precio.create({
          data: {
            id_producto: Number(id_producto),
            id_pais: Number(id_pais),
            precio: Number(valor),
          },
        });
      })
    );

    res.status(201).json(upserted);
  } catch (err) { next(err); }
}

export async function deletePrecio(req, res, next) {
  try {
    await prisma.precio.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}