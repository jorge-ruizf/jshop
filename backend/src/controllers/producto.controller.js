import { prisma } from '../services/prisma.js';

export async function listProductos(req, res, next) {
  try {
    res.json(await prisma.producto.findMany());
  } catch (err) { next(err); }
}

export async function getProducto(req, res, next) {
  try {
    const item = await prisma.producto.findUnique({ where: { id: req.id } });
    if (!item) return res.status(404).json({ error: { message: 'Producto not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createProducto(req, res, next) {
  try {
    const { nombre, descripcion, id_vendedor, id_categoria, id_pais } = req.body;
    const created = await prisma.producto.create({
      data: { nombre, descripcion, id_vendedor, id_categoria, id_pais },
    });
    res.status(201).json(created);
  } catch (err) { next(err); }
}

export async function updateProducto(req, res, next) {
  try {
    const { nombre, descripcion, id_vendedor, id_categoria, id_pais } = req.body;
    const updated = await prisma.producto.update({
      where: { id: req.id },
      data: { nombre, descripcion, id_vendedor, id_categoria, id_pais },
    });
    res.json(updated);
  } catch (err) { next(err); }
}

export async function deleteProducto(req, res, next) {
  try {
    await prisma.producto.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
