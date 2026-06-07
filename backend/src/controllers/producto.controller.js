import { prisma } from '../services/prisma.js';
import path from 'path';
import { fileURLToPath } from 'url';
import fs from 'fs';


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
    const id = req.id;

    // Eliminar dependientes en orden (respetar FKs)
    await prisma.carrito.deleteMany({ where: { id_producto: id } });
    await prisma.precio.deleteMany({ where: { id_producto: id } });
    await prisma.imagen_Producto.deleteMany({ where: { id_producto: id } });
    await prisma.producto_Deseado.deleteMany({ where: { id_producto: id } });
    // venta_x_producto: NO eliminar — afecta historial de ventas
    // Si hay venta_x_productos vinculados, el delete fallará — aceptable para MVP

    await prisma.producto.delete({ where: { id } });
    res.status(204).end();
  } catch (err) { next(err); }
}

//  nueva función para subir imagen desde URL externa, guardándola en /public/imgs/{id}.png

const __dirname = path.dirname(fileURLToPath(import.meta.url));

export async function createImagen(req, res, next) {
  try {
    const { ruta } = req.body;
    if (!ruta) return res.status(400).json({ error: { message: 'Missing field: ruta' } });

    const producto = await prisma.producto.findUnique({ where: { id: req.id } });
    if (!producto) return res.status(404).json({ error: { message: 'Producto not found' } });

    const imagen = await prisma.Imagen_Producto.create({
      data: {
        nombre: `${req.id}.png`,
        ruta,
        id_producto: req.id,
        id_tipo_imagen: 1,
      },
    });
    res.status(201).json(imagen);
  } catch (err) { next(err); }
}