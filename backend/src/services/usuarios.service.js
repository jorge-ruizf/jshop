import { api } from "./api"; // tu axios base

export const usuariosService = {
    async getByEmail(correo) {
        const res = await api.get(`/usuarios?correo=${correo}`);
        return res.data;
        console.log("Backend=> correo buscado:", correo);
    },

    async create(user) {
        const res = await api.post("/usuarios", user);
        return res.data;
    }
};