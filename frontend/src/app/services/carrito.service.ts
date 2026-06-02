import type { CarritoItem } from "./types";

const BASE = "https://jshop-edzf.onrender.com/api/carrito";

export const carritoService = {

  getByUsuario: async (id_usuario: number): Promise<CarritoItem[]> => {
    const res = await fetch(`${BASE}?id_usuario=${id_usuario}`);
    if (!res.ok) throw new Error("Error al obtener carrito");
    return res.json();
  },

  add: async (id_producto: number, id_usuario: number): Promise<CarritoItem> => {
    const res = await fetch(BASE, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ id_producto, id_usuario }),
    });
    if (!res.ok) throw new Error("Error al agregar al carrito");
    return res.json();
  },

  remove: async (id: number): Promise<void> => {
    const res = await fetch(`${BASE}/${id}`, { method: "DELETE" });
    if (!res.ok) throw new Error("Error al eliminar del carrito");
  },

};