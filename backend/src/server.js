import { app } from './app.js';
import { iniciarPriceChecker } from './services/priceChecker.service.js'; // ← NUEVO

const PORT = process.env.PORT ?? 3000;

app.listen(PORT, () => {
  console.log(`🚀 Servidor corriendo en puerto ${PORT}`);

  // Iniciar el cron de verificación de precios
  iniciarPriceChecker(); // ← NUEVO
});