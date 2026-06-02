export async function notificarPagoDiscord({
  usuario,
  productos,
  total,
  metodoPago,
}) {
  if (!process.env.DISCORD_WEBHOOK_URL) return;

  const fecha = new Date().toLocaleString("es-CO", {
    timeZone: "America/Bogota",
  });

  const productosTexto = productos
    .map(
      (p) =>
        `• **${p.nombre}**\n${p.descripcion || "Sin descripción"}`
    )
    .join("\n\n");

  await fetch(process.env.DISCORD_WEBHOOK_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      embeds: [
        {
          title: "💰 Nuevo pago reportado",
          color: 5763719,
          fields: [
            {
              name: "👤 Cliente",
              value: usuario.nombre,
              inline: true,
            },
            {
              name: "📧 Correo",
              value: usuario.correo,
              inline: true,
            },
            {
              name: "💳 Método",
              value: metodoPago,
              inline: true,
            },
            {
              name: "💵 Total",
              value: `$${Number(total).toFixed(2)}`,
              inline: true,
            },
            {
              name: "📅 Fecha",
              value: fecha,
              inline: true,
            },
            {
              name: "🛒 Productos",
              value: productosTexto.substring(0, 1024),
            },
            {
            name: "🔎 Ver usuario",
            value: `ID: ${usuario.id}`
            },
          ],
          footer: {
            text: "JShop • Auditoría de pagos",
          },
          timestamp: new Date().toISOString(),
        },
      ],
    }),
  });
}