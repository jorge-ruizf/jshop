export interface ReportarPagoRequest {
  id_usuario: number;
  metodo_pago: string;
  total: number;
}

const BASE_URL = "https://jshop-edzf.onrender.com/api/pagos";

export const pagosService = {
  reportar: async (
    payload: ReportarPagoRequest,
  ): Promise<{ ok: boolean }> => {
    const res = await fetch(`${BASE_URL}/reportar`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(payload),
    });

    if (!res.ok) {
      const text = await res.text();
      throw new Error(
        `Error reportando pago (${res.status}): ${text}`
      );
    }

    return res.json();
  },
};