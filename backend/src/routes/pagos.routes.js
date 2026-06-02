import { Router } from "express";
import { prisma } from "../services/prisma.js";
import { sendDiscordMessage } from "../services/discord.service.js";

const pagosRouter = Router();

pagosRouter.post("/test", async (req, res) => {
  await sendDiscordMessage(
    "🧪 Webhook Discord funcionando correctamente"
  );

  res.json({ ok: true });
});

pagosRouter.post("/reportar", async (req, res) => {
  try {
    const {
      id_usuario,
      metodo_pago,
      total,
    } = req.body;

    const usuario = await prisma.usuario.findUnique({
      where: {
        id: Number(id_usuario),
      },
    });

    if (!usuario) {
      return res.status(404).json({
        error: {
          message: "Usuario no encontrado",
        },
      });
    }

    const carrito = await prisma.carrito.findMany({
      where: {
        id_usuario: Number(id_usuario),
      },
      include: {
        producto: true,
      },
    });

    await notificarPagoDiscord({
      usuario,
      productos: carrito.map((item) => item.producto),
      total: Number(total),
      metodoPago: metodo_pago,
    });

    res.json({
      ok: true,
    });
  } catch (err) {
    console.error(err);

    res.status(500).json({
      error: {
        message: "Error reportando pago",
      },
    });
  }
});


export { pagosRouter };