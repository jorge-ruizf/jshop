import { prisma } from '../services/prisma.js';

export async function listVentas(req, res, next) {
  try {
    res.json(await prisma.venta.findMany({
      include: { usuario: true, metodoPago: true, ventas_x_producto: true },
    }));
  } catch (err) { next(err); }
}

export async function getVenta(req, res, next) {
  try {
    const item = await prisma.venta.findUnique({
      where: { id: req.id },
      include: { usuario: true, metodoPago: true, ventas_x_producto: { include: { producto: true } } },
    });
    if (!item) return res.status(404).json({ error: { message: 'Venta not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createVenta(req, res, next) {
  try {
    const { id_usuario, metodo_pago } = req.body;
    const created = await prisma.venta.create({ data: { id_usuario, metodo_pago } });
    res.status(201).json(created);
  } catch (err) { next(err); }
}

export async function updateVenta(req, res, next) {
  try {
    const { id_usuario, metodo_pago } = req.body;
    const updated = await prisma.venta.update({
      where: { id: req.id },
      data: { id_usuario, metodo_pago },
    });
    res.json(updated);
  } catch (err) { next(err); }
}

export async function deleteVenta(req, res, next) {
  try {
    await prisma.venta.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
