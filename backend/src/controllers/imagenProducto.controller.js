import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior:
// ❌ campo url eliminado — schema tiene 'nombre' (VarChar 100) y 'ruta' (VarChar 150).
// ✅ Añadido id_tipo_imagen (FK requerida según schema).
// ✅ include actualizado: producto + tipo_imagen.

export async function listImagenesProducto(req, res, next) {
  try {
    const where = {};
    if (req.query.id_producto) where.id_producto = Number(req.query.id_producto);
    res.json(await prisma.imagen_Producto.findMany({
      where,
      include: { tipo_imagen: true },
    }));
  } catch (err) { next(err); }
}

export async function getImagenProducto(req, res, next) {
  try {
    const item = await prisma.imagen_Producto.findUnique({
      where: { id: req.id },
      include: { producto: true, tipo_imagen: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Imagen_Producto not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createImagenProducto(req, res, next) {
  try {
    const { id_producto, id_tipo_imagen, nombre, ruta } = req.body;
    res.status(201).json(await prisma.imagen_Producto.create({
      data: { id_producto, id_tipo_imagen, nombre, ruta },
    }));
  } catch (err) { next(err); }
}

export async function updateImagenProducto(req, res, next) {
  try {
    const { id_producto, id_tipo_imagen, nombre, ruta } = req.body;
    res.json(await prisma.imagen_Producto.update({
      where: { id: req.id },
      data: {
        ...(id_producto    !== undefined && { id_producto }),
        ...(id_tipo_imagen !== undefined && { id_tipo_imagen }),
        ...(nombre         !== undefined && { nombre }),
        ...(ruta           !== undefined && { ruta }),
      },
    }));
  } catch (err) { next(err); }
}

export async function deleteImagenProducto(req, res, next) {
  try {
    await prisma.imagen_Producto.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
