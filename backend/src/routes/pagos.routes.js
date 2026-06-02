import { Router } from "express";
import { sendDiscordMessage } from "../services/discord.service.js";

const pagosRouter = Router();

pagosRouter.post("/test", async (req, res) => {
  await sendDiscordMessage(
    "🧪 Webhook Discord funcionando correctamente"
  );

  res.json({
    ok: true,
  });
});

export { pagosRouter };