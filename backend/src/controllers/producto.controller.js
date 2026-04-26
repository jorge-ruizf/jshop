import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior:
// ✅ Añadido id_videojuego (FK requerida en el schema).
// ✅ include completo: vendedor, pais, categoria, videojuego, imagenes, precios.
// ✅ create/update incluyen todos los campos requeridos del schema.

export async function listProductos(req, res, next) {
  try {
    const where = {};
    if (req.query.id_categoria)  where.id_categoria  = Number(req.query.id_categoria);
    if (req.query.id_videojuego) where.id_videojuego = Number(req.query.id_videojuego);
    if (req.query.id_vendedor)   where.id_vendedor   = Number(req.query.id_vendedor);
    res.json(await prisma.producto.findMany({
      where,
      include: {
        vendedor: true,
        categoria: true,
        videojuego: true,
        pais: true,
        imagenes: { include: { tipo_imagen: true } },
        precios: { include: { pais: true } },
      },
    }));
  } catch (err) { next(err); }
}

export async function getProducto(req, res, next) {
  try {
    const item = await prisma.producto.findUnique({
      where: { id: req.id },
      include: {
        vendedor: true,
        categoria: true,
        videojuego: true,
        pais: true,
        imagenes: { include: { tipo_imagen: true } },
        precios: { include: { pais: true } },
      },
    });
    if (!item) return res.status(404).json({ error: { message: 'Producto not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createProducto(req, res, next) {
  try {
    const { nombre, descripcion, id_vendedor, id_pais, id_categoria, id_videojuego } = req.body;
    res.status(201).json(await prisma.producto.create({
      data: { nombre, descripcion, id_vendedor, id_pais, id_categoria, id_videojuego },
    }));
  } catch (err) { next(err); }
}

export async function updateProducto(req, res, next) {
  try {
    const { nombre, descripcion, id_vendedor, id_pais, id_categoria, id_videojuego } = req.body;
    res.json(await prisma.producto.update({
      where: { id: req.id },
      data: {
        ...(nombre        !== undefined && { nombre }),
        ...(descripcion   !== undefined && { descripcion }),
        ...(id_vendedor   !== undefined && { id_vendedor }),
        ...(id_pais       !== undefined && { id_pais }),
        ...(id_categoria  !== undefined && { id_categoria }),
        ...(id_videojuego !== undefined && { id_videojuego }),
      },
    }));
  } catch (err) { next(err); }
}

export async function deleteProducto(req, res, next) {
  try {
    await prisma.producto.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
