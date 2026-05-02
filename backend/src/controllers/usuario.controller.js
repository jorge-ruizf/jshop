import { prisma } from '../services/prisma.js';

// CAMBIOS vs versión anterior:
// ✅ Añadido campo 'ventas' (Int, contador de ventas del usuario, requerido en schema).
//    En create se inicializa a 0 por defecto si no se provee.
// ✅ include completo en get/list: pais, rol, metodo_pago_fav.

export async function listUsuarios(req, res, next) {
  try {
    res.json(await prisma.usuario.findMany({
      include: { pais: true, rol: true, metodo_pago_fav: true },
    }));
  } catch (err) { next(err); }
}

export async function getUsuario(req, res, next) {
  try {
    const item = await prisma.usuario.findUnique({
      where: { id: req.id },
      include: { pais: true, rol: true, metodo_pago_fav: true },
    });
    if (!item) return res.status(404).json({ error: { message: 'Usuario not found' } });
    res.json(item);
  } catch (err) { next(err); }
}

export async function createUsuario(req, res, next) {
  try {
    const { nombre, usuario, correo, id_pais, id_rol, id_metodo_pago_fav, ventas } = req.body;

    const nuevo = await prisma.usuario.create({
      data: {
        nombre,
        usuario,
        correo,
        id_pais,
        id_rol,
        id_metodo_pago_fav,
        ventas: ventas ?? 0,
      },
    });

    res.status(201).json(nuevo);

  } catch (err) {
    // 🔥 AQUÍ manejas el error UNIQUE
    if (err.code === "P2002") {
      try {
        // 👇 ya existe → lo buscamos y lo devolvemos
        const existente = await prisma.usuario.findUnique({
          where: { correo: req.body.correo },
        });

        return res.status(200).json(existente);
      } catch (e) {
        return next(e);
      }
    }

    next(err);
  }
}

export async function updateUsuario(req, res, next) {
  try {
    const { nombre, usuario, correo, id_pais, id_rol, id_metodo_pago_fav, ventas } = req.body;
    res.json(await prisma.usuario.update({
      where: { id: req.id },
      data: {
        ...(nombre             !== undefined && { nombre }),
        ...(usuario            !== undefined && { usuario }),
        ...(correo             !== undefined && { correo }),
        ...(id_pais            !== undefined && { id_pais }),
        ...(id_rol             !== undefined && { id_rol }),
        ...(id_metodo_pago_fav !== undefined && { id_metodo_pago_fav }),
        ...(ventas             !== undefined && { ventas }),
      },
    }));
  } catch (err) { next(err); }
}

export async function deleteUsuario(req, res, next) {
  try {
    await prisma.usuario.delete({ where: { id: req.id } });
    res.status(204).end();
  } catch (err) { next(err); }
}

export async function getUsuarioByCorreo(req, res, next) {
  try {
    const { correo } = req.query;

    if (!correo) {
      return res.status(400).json({ error: { message: "correo es requerido" } });
    }

    const usuario = await prisma.usuario.findUnique({
      where: { correo },
      include: { pais: true, rol: true, metodo_pago_fav: true },
    });

    if (!usuario) {
      return res.status(404).json({ error: { message: "Usuario not found" } });
    }

    res.json(usuario);
  } catch (err) {
    next(err);
  }
}