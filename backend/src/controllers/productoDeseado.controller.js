import { prisma } from '../services/prisma.js';

// ─── POST /api/productos-deseados ───────────────────────────────────────────
// Body: { id_producto, id_usuario, precio_objetivo }
export async function crearProductoDeseado(req, res, next) {
  try {
    const { id_producto, id_usuario, precio_objetivo } = req.body;

    if (!id_producto || !id_usuario || precio_objetivo == null) {
      return res.status(400).json({ error: 'Faltan campos: id_producto, id_usuario, precio_objetivo' });
    }

    // Upsert: si ya existe el deseo para ese usuario+producto, actualiza el precio_objetivo
    const existing = await prisma.producto_Deseado.findFirst({
      where: { id_producto: Number(id_producto), id_usuario: Number(id_usuario) },
    });

    if (existing) {
      const updated = await prisma.producto_Deseado.update({
        where: { id: existing.id },
        data: { precio_objetivo: Number(precio_objetivo) },
      });
      return res.status(200).json(updated);
    }

    const deseado = await prisma.producto_Deseado.create({
      data: {
        id_producto: Number(id_producto),
        id_usuario: Number(id_usuario),
        precio_objetivo: Number(precio_objetivo),
      },
    });

    return res.status(201).json(deseado);
  } catch (err) {
    next(err);
  }
}

// ─── GET /api/productos-deseados?id_usuario=X ──────────────────────────────
export async function listarProductosDeseados(req, res, next) {
  try {
    const { id_usuario } = req.query;

    if (!id_usuario) {
      return res.status(400).json({ error: 'Se requiere id_usuario como query param' });
    }

    const deseados = await prisma.producto_Deseado.findMany({
      where: { id_usuario: Number(id_usuario) },
      include: {
        producto: {
          include: { precios: true, imagenes: true },
        },
        notificaciones: {
          orderBy: { fecha_notificado: 'desc' },
          take: 1, // solo la más reciente
        },
      },
      orderBy: { id: 'desc' },
    });

    return res.json(deseados);
  } catch (err) {
    next(err);
  }
}

// ─── DELETE /api/productos-deseados/:id ────────────────────────────────────
export async function eliminarProductoDeseado(req, res, next) {
  try {
    const id = Number(req.params.id);

    // Eliminar notificaciones relacionadas primero (FK constraint)
    await prisma.notificacion.deleteMany({ where: { id_producto_deseado: id } });
    await prisma.producto_Deseado.delete({ where: { id } });

    return res.status(204).send();
  } catch (err) {
    next(err);
  }
}

// ─── PUT /api/productos-deseados/:id ───────────────────────────────────────
// Actualiza precio_objetivo (y limpia notificaciones para reactivar la alerta)
export async function actualizarProductoDeseado(req, res, next) {
  try {
    const id = Number(req.params.id);
    const { precio_objetivo } = req.body;

    if (precio_objetivo == null) {
      return res.status(400).json({ error: 'Se requiere precio_objetivo' });
    }

    // Limpiar notificaciones anteriores para que el cron vuelva a evaluar
    await prisma.notificacion.deleteMany({ where: { id_producto_deseado: id } });

    const updated = await prisma.producto_Deseado.update({
      where: { id },
      data: { precio_objetivo: Number(precio_objetivo) },
    });

    return res.json(updated);
  } catch (err) {
    next(err);
  }
}