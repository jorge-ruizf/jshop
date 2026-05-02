import { api } from "./api"; // tu axios base

export const usuariosService = {
    async getByEmail(correo) {
        const res = await api.get(`/usuarios?correo=${correo}`);
        return res.data;
    },

    async create(user) {
        const res = await api.post("/usuarios", user);
        return res.data;
    }
};