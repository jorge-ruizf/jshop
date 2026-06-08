import { Resend } from 'resend';

const resend = new Resend(process.env.RESEND_API_KEY);
const FROM = process.env.RESEND_FROM_EMAIL ?? 'onboarding@resend.dev';

/**
 * Envía el email de alerta de precio al usuario.
 * @param {object} opts
 * @param {string} opts.to          - correo del usuario
 * @param {string} opts.nombreProducto
 * @param {number} opts.precioActual
 * @param {number} opts.precioObjetivo
 */
export async function enviarAlertaPrecio({ to, nombreProducto, precioActual, precioObjetivo }) {
  const fmt = (n) =>
    Number(n).toLocaleString('es-CO', { style: 'currency', currency: 'COP', maximumFractionDigits: 0 });

  const { data, error } = await resend.emails.send({
    from: FROM,
    to: process.env.RESEND_TEST_TO ?? to, // para pruebas, redirige a un email fijo
    subject: `¡Bajó el precio! ${nombreProducto} ya está en ${fmt(precioActual)}`,
    html: `
      <!DOCTYPE html>
      <html lang="es">
      <head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
      <body style="margin:0;padding:0;background:#f4f4f5;font-family:sans-serif">
        <table width="100%" cellpadding="0" cellspacing="0" style="padding:40px 0">
          <tr><td align="center">
            <table width="520" cellpadding="0" cellspacing="0"
              style="background:#fff;border-radius:12px;overflow:hidden;border:1px solid #e4e4e7">

              <!-- Header -->
              <tr>
                <td style="background:linear-gradient(135deg,#6d28d9,#4f46e5);padding:28px 32px">
                  <p style="margin:0;color:#fff;font-size:22px;font-weight:600">🔔 JShop — Alerta de precio</p>
                </td>
              </tr>

              <!-- Body -->
              <tr>
                <td style="padding:32px">
                  <p style="margin:0 0 8px;color:#3f3f46;font-size:15px">Tu producto bajó de precio:</p>
                  <p style="margin:0 0 24px;color:#18181b;font-size:20px;font-weight:600">${nombreProducto}</p>

                  <table width="100%" cellpadding="0" cellspacing="0"
                    style="background:#f4f4f5;border-radius:8px;overflow:hidden;margin-bottom:28px">
                    <tr>
                      <td style="padding:14px 20px;color:#71717a;font-size:13px">Precio objetivo</td>
                      <td style="padding:14px 20px;text-align:right;color:#71717a;font-size:13px">${fmt(precioObjetivo)}</td>
                    </tr>
                    <tr style="border-top:1px solid #e4e4e7">
                      <td style="padding:14px 20px;color:#18181b;font-size:15px;font-weight:600">Precio actual</td>
                      <td style="padding:14px 20px;text-align:right;color:#16a34a;font-size:18px;font-weight:700">${fmt(precioActual)}</td>
                    </tr>
                  </table>

                  <a href="${process.env.FRONTEND_URL ?? 'http://localhost:5173'}"
                    style="display:inline-block;background:#6d28d9;color:#fff;padding:12px 28px;
                    border-radius:8px;text-decoration:none;font-size:14px;font-weight:500">
                    Ver en JShop →
                  </a>
                </td>
              </tr>

              <!-- Footer -->
              <tr>
                <td style="padding:16px 32px;border-top:1px solid #e4e4e7;background:#fafafa">
                  <p style="margin:0;color:#a1a1aa;font-size:12px">
                    Recibiste este correo porque creaste una alerta de precio en JShop.
                    Esta alerta ya no enviará más notificaciones por este producto.
                  </p>
                </td>
              </tr>

            </table>
          </td></tr>
        </table>
      </body>
      </html>
    `,
  });

  if (error) throw new Error(`Resend error: ${JSON.stringify(error)}`);
  return data;
}