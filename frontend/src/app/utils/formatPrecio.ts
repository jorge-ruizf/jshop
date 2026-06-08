/**
 * Formatea un número como precio:
 * - Sin decimales si son .00
 * - Reemplaza miles con "k" si la parte entera tiene 4+ dígitos y los 3 primeros son múltiplos exactos
 * Ejemplos: 15000 → "15k", 15500 → "15.5k", 1250000 → "1.250.000", 1250 → "1.250"
 */
export function formatPrecio(valor: number): string {
  if (!valor || valor <= 0) return "—";

  // Si es múltiplo exacto de 1000 y >= 1000 → usar "k"
  if (valor >= 1000 && valor % 1000 === 0) {
    return `$${valor / 1000}k`;
  }

  // Si es múltiplo de 100 con parte "k" limpia (ej: 15500 → 15.5k)
  if (valor >= 1000 && valor % 100 === 0) {
    const k = valor / 1000;
    if (Number.isFinite(k) && String(k).length <= 5) {
      return `$${k}k`;
    }
  }

  // Formato normal: separador de miles, sin decimales si son .00
  const num = Number(valor);
  const hasDecimals = num % 1 !== 0;
  return `$${num.toLocaleString("es-CO", {
    minimumFractionDigits: hasDecimals ? 2 : 0,
    maximumFractionDigits: 2,
  })}`;
}