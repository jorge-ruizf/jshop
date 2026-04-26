import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior:
// ✅ Nombre del modelo en Prisma client: venta_X_Producto (correcto, sin cambios).
// ✅ include ampliado: chat y valoracion (relaciones 1-a-1 inversas del schema).
// ✅ Filtros de listado añadidos por id_venta e id_producto.

export async function listVentaProductos(req, res, next) {
  try {
    const where = {};
    if (req.query.id_venta)    where.id_venta    = Number(req.query.id_venta);
    if (req.query.id_producto) where.id_producto = Number(req.query.id_producto);
    res.json(await prisma.venta_X_Producto.findMany({
      where,
      include: {
        producto: true,
        venta: true,
        chat: true,
        valoracion: true,
      },
    }));
  } catch (err) { next(err); }
}

export async function getVentaProducto(req, res, next) {
  try {
    const item = await prisma.venta_X_Producto.findUnique({
      where: { id: req.id },
      include: {
        producto: true,
        venta: { include: { usuario: true, metodo_pago: true } },
        chat: { include: { mensajes: true } },
        valoracion: true,
      },
    });
    if (!item) return res.status(404).json({ error: { message: 'Venta_X_Producto not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createVentaProducto(req, res, next) {
  try {
    const { id_producto, id_venta, cantidad, precio } = req.body;
    res.status(201).json(await prisma.venta_X_Producto.create({
      data: { id_producto, id_venta, cantidad, precio },
    }));
  } catch (err) { next(err); }
}

export async function updateVentaProducto(req, res, next) {
  try {
    const { id_producto, id_venta, cantidad, precio } = req.body;
    res.json(await prisma.venta_X_Producto.update({
      where: { id: req.id },
      data: {
        ...(id_producto !== undefined && { id_producto }),
        ...(id_venta    !== undefined && { id_venta }),
        ...(cantidad    !== undefined && { cantidad }),
        ...(precio      !== undefined && { precio }),
      },
    }));
  } catch (err) { next(err); }
}

export async function deleteVentaProducto(req, res, next) {
  try {
    await prisma.venta_X_Producto.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
