import { prisma } from '../services/prisma.js';

export async function listVideojuegos(req, res, next) {
  try {
    res.json(await prisma.videojuego.findMany());
  } catch (err) { next(err); }
}

export async function getVideojuego(req, res, next) {
  try {
    const item = await prisma.videojuego.findUnique({
      where: { id: req.id },
    });

    if (!item) {
      return res.status(404).json({ error: { message: 'Videojuego not found' } });
    }

    res.json(item);
  } catch (err) { next(err); }
}

export async function createVideojuego(req, res, next) {
  try {
    const { nombre } = req.body;

    res.status(201).json(
        await prisma.videojuego.create({
          data: { nombre },
        })
    );
  } catch (err) { next(err); }
}

export async function updateVideojuego(req, res, next) {
  try {
    const { nombre } = req.body;

    res.json(
        await prisma.videojuego.update({
          where: { id: req.id },
          data: { nombre },
        })
    );
  } catch (err) { next(err); }
}

export async function deleteVideojuego(req, res, next) {
  try {
    await prisma.videojuego.delete({
      where: { id: req.id },
    });

    res.status(204).end();
  } catch (err) { next(err); }
}