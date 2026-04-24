import { prisma } from '../services/prisma.js';

export async function listImagenesProducto(req, res, next) {
  try {
    const where = {};
    if (req.query.id_producto) where.id_producto = Number(req.query.id_producto);
    res.json(await prisma.imagen_Producto.findMany({ where }));
  } catch (err) { next(err); }
}

export async function getImagenProducto(req, res, next) {
  try {
    const item = await prisma.imagen_Producto.findUnique({
      where: { id: req.id },
      include: { producto: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Imagen_Producto not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createImagenProducto(req, res, next) {
  try {
    const { id_producto, url } = req.body;
    res.status(201).json(await prisma.imagen_Producto.create({ data: { id_producto, url } }));
  } catch (err) { next(err); }
}

export async function updateImagenProducto(req, res, next) {
  try {
    const { id_producto, url } = req.body;
    res.json(await prisma.imagen_Producto.update({
      where: { id: req.id },
      data: { id_producto, url },
    }));
  } catch (err) { next(err); }
}

export async function deleteImagenProducto(req, res, next) {
  try {
    await prisma.imagen_Producto.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
