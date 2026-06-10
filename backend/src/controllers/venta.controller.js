import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior:
// ❌ include 'metodoPago' → 'metodo_pago' (nombre de la relación en el schema).
// ❌ include 'ventas_x_producto' → 'venta_x_productos' (nombre en el schema).
// ❌ campo 'metodo_pago' en create/update → 'id_metodo_pago' (FK escalar del schema).
// ✅ Añadidos campos requeridos 'total' y 'fecha' en create.

export async function listVentas(req, res, next) {
  try {
    const where = {};
    if (req.query.id_usuario) where.id_usuario = Number(req.query.id_usuario);
    res.json(await prisma.venta.findMany({
      where,
      include: {
        usuario: true,
        metodo_pago: true,
        venta_x_productos: { include: { producto: true } },
      },
      orderBy: { fecha: 'desc' },
    }));
  } catch (err) { next(err); }
}

export async function getVenta(req, res, next) {
  try {
    const item = await prisma.venta.findUnique({
      where: { id: req.id },
      include: {
        usuario: true,
        metodo_pago: true,
        venta_x_productos: {
          include: {
            producto: true,
            chat: true,
            valoracion: true,
          },
        },
      },
    });
    if (!item) return res.status(404).json({ error: { message: 'Venta not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createVenta(req, res, next) {
  try {
    const { id_usuario, id_metodo_pago, total, fecha } = req.body;
    res.status(201).json(await prisma.venta.create({
      data: {
        id_usuario,
        id_metodo_pago,
        total,
        fecha: fecha ? new Date(fecha) : new Date(),
      },
    }));
  } catch (err) { next(err); }
}

export async function updateVenta(req, res, next) {
  try {
    const { id_usuario, id_metodo_pago, total, fecha } = req.body;
    res.json(await prisma.venta.update({
      where: { id: req.id },
      data: {
        ...(id_usuario     !== undefined && { id_usuario }),
        ...(id_metodo_pago !== undefined && { id_metodo_pago }),
        ...(total          !== undefined && { total }),
        ...(fecha          !== undefined && { fecha: new Date(fecha) }),
      },
    }));
  } catch (err) { next(err); }
}

export async function deleteVenta(req, res, next) {
  try {
    await prisma.venta.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
export async function confirmarVenta(req, res, next) {
  try {
    const { id_usuario, id_metodo_pago, total, items } = req.body;
 
    // Validación básica de campos requeridos
    if (!id_usuario || !id_metodo_pago || !total || !Array.isArray(items) || items.length === 0) {
      return res.status(400).json({
        error: { message: 'Faltan campos requeridos: id_usuario, id_metodo_pago, total, items[]' },
      });
    }
 
    // Verificar stock ANTES de abrir la transacción
    // Evita abrir una tx que sabemos que va a fallar
    const ids_producto = items.map((i) => Number(i.id_producto));
    const productos = await prisma.producto.findMany({
      where: { id: { in: ids_producto } },
      select: { id: true, nombre: true, cantidad: true },
    });
 
    const agotados = productos.filter((p) => p.cantidad <= 0);
    if (agotados.length > 0) {
      return res.status(409).json({
        error: {
          message: 'Uno o más productos no tienen stock disponible',
          productos_agotados: agotados.map((p) => ({ id: p.id, nombre: p.nombre })),
        },
      });
    }
 
    // Transacción atómica
    const venta = await prisma.$transaction(async (tx) => {
 
      // 1. Crear la venta
      const nuevaVenta = await tx.venta.create({
        data: {
          id_usuario: Number(id_usuario),
          id_metodo_pago: Number(id_metodo_pago),
          total: Number(total),
          fecha: new Date(),
        },
      });
 
      // 2. Crear venta_x_producto por cada item + descontar cantidad
      for (const item of items) {
        const id_producto = Number(item.id_producto);
        const precio      = Number(item.precio);
 
        // Crear registro de venta_x_producto
        await tx.venta_X_Producto.create({
          data: {
            id_venta:    nuevaVenta.id,
            id_producto,
            cantidad:    1,
            precio,
          },
        });
 
        // Descontar 1 unidad del stock
        await tx.producto.update({
          where: { id: id_producto },
          data:  { cantidad: { decrement: 1 } },
        });
      }
 
      // 3. Limpiar el carrito del usuario
      await tx.carrito.deleteMany({
        where: { id_usuario: Number(id_usuario) },
      });
 
      return nuevaVenta;
    });
 
    res.status(201).json(venta);
  } catch (err) { next(err); }
}
