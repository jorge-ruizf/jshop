import { prisma } from '../services/prisma.js';

export async function listVentaProductos(req, res, next) {
  try {
    res.json(await prisma.venta_x_Producto.findMany({
      include: { producto: true, venta: true },
    }));
  } catch (err) { next(err); }
}

export async function getVentaProducto(req, res, next) {
  try {
    const item = await prisma.venta_x_Producto.findUnique({
      where: { id: req.id },
      include: { producto: true, venta: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Venta_x_Producto not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createVentaProducto(req, res, next) {
  try {
    const { id_producto, id_venta, cantidad, precio } = req.body;
    const created = await prisma.venta_x_Producto.create({
      data: { id_producto, id_venta, cantidad, precio },
    });
    res.status(201).json(created);
  } catch (err) { next(err); }
}

export async function updateVentaProducto(req, res, next) {
  try {
    const { id_producto, id_venta, cantidad, precio } = req.body;
    const updated = await prisma.venta_x_Producto.update({
      where: { id: req.id },
      data: { id_producto, id_venta, cantidad, precio },
    });
    res.json(updated);
  } catch (err) { next(err); }
}

export async function deleteVentaProducto(req, res, next) {
  try {
    await prisma.venta_x_Producto.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
