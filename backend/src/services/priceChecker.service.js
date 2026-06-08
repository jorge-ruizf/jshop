import cron from 'node-cron';
import { prisma } from './prisma.js';
import { enviarAlertaPrecio } from './resend.service.js';

/**
 * Revisa todos los Producto_Deseado activos y dispara
 * una Notificacion + email cuando precio_actual <= precio_objetivo.
 *
 * "Activo" = no tiene ninguna Notificacion todavía (aún no fue disparado).
 */
async function verificarPrecios() {
  console.log(`[priceChecker] Iniciando verificación — ${new Date().toISOString()}`);

  // 1. Traer deseos sin notificación previa, con precio y correo del usuario
  const deseos = await prisma.producto_Deseado.findMany({
    where: {
      notificaciones: { none: {} }, // solo los que aún no se dispararon
    },
    include: {
      usuario: { select: { correo: true, nombre: true } },
      producto: {
        include: {
          precios: true, // todos los precios por país
        },
      },
    },
  });

  if (deseos.length === 0) {
    console.log('[priceChecker] Sin alertas pendientes.');
    return;
  }

  console.log(`[priceChecker] Revisando ${deseos.length} alerta(s)…`);

  for (const deseo of deseos) {
    try {
      const { precio_objetivo, producto, usuario } = deseo;

      // Precio más bajo disponible entre todos los países
      // (ajusta esta lógica si quieres filtrar por país del usuario)
      const precioMinimo = producto.precios.reduce((min, p) => {
        const val = Number(p.precio);
        return val < min ? val : min;
      }, Infinity);

      if (precioMinimo === Infinity) continue; // producto sin precios cargados

      const objetivo = Number(precio_objetivo);

      if (precioMinimo <= objetivo) {
        console.log(
          `[priceChecker] ¡Alerta! "${producto.nombre}" — objetivo: ${objetivo}, actual: ${precioMinimo}`
        );

        // 2. Registrar la Notificacion en la DB primero (evita doble envío si falla el email)
        await prisma.notificacion.create({
          data: {
            fecha_notificado: new Date(),
            descripcion: `El precio de "${producto.nombre}" bajó a ${precioMinimo}. Tu objetivo era ${objetivo}.`,
            id_producto_deseado: deseo.id,
          },
        });

        // 3. Enviar email
        await enviarAlertaPrecio({
          to: usuario.correo,
          nombreProducto: producto.nombre,
          precioActual: precioMinimo,
          precioObjetivo: objetivo,
        });

        console.log(`[priceChecker] Email enviado a ${usuario.correo}`);
      }
    } catch (err) {
      // Error aislado por deseo — no corta el loop
      console.error(`[priceChecker] Error en deseo ID ${deseo.id}:`, err.message);
    }
  }

  console.log('[priceChecker] Verificación completada.');
}

/**
 * Inicia el cron. Llámalo una vez al arrancar el servidor.
 * Por defecto corre cada 30 minutos.
 * Cambia el schedule con PRICE_CHECKER_CRON en .env
 * Ejemplos:
 *   '0 * * * *'     → cada hora
 *   '*15 * * * *'  → cada 15 min
 */
export function iniciarPriceChecker() {
  const schedule = process.env.PRICE_CHECKER_CRON ?? '*/30 * * * *';
  console.log(`[priceChecker] Cron iniciado. Schedule: "${schedule}"`);

  // Ejecutar inmediatamente al arrancar (opcional, útil para pruebas)
  verificarPrecios();

  cron.schedule(schedule, verificarPrecios);
}

export { verificarPrecios };