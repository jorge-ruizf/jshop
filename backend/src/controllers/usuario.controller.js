import { prisma } from '../services/prisma.js';

export async function listUsuarios(req, res, next) {
  try {
    res.json(await prisma.usuario.findMany());
  } catch (err) { next(err); }
}

export async function getUsuario(req, res, next) {
  try {
    const item = await prisma.usuario.findUnique({ where: { id: req.id } });
    if (!item) return res.status(404).json({ error: { message: 'Usuario not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createUsuario(req, res, next) {
  try {
    const { nombre, usuario, correo, id_pais, id_rol, id_metodo_pago_fav } = req.body;
    const created = await prisma.usuario.create({
      data: { nombre, usuario, correo, id_pais, id_rol, id_metodo_pago_fav },
    });
    res.status(201).json(created);
  } catch (err) { next(err); }
}

export async function updateUsuario(req, res, next) {
  try {
    const { nombre, usuario, correo, id_pais, id_rol, id_metodo_pago_fav } = req.body;
    const updated = await prisma.usuario.update({
      where: { id: req.id },
      data: { nombre, usuario, correo, id_pais, id_rol, id_metodo_pago_fav },
    });
    res.json(updated);
  } catch (err) { next(err); }
}

export async function deleteUsuario(req, res, next) {
  try {
    await prisma.usuario.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}
