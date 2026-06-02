import { supabase } from './supabaseClient';

const BUCKET = 'productos';

export const storageService = {

  uploadFromUrl: async (productoId: number, url: string): Promise<string> => {
    // 1. Descargar imagen desde URL externa
    const response = await fetch(url);
    if (!response.ok) throw new Error('No se pudo descargar la imagen');

    const contentType = response.headers.get('content-type') ?? 'image/png';
    if (!contentType.startsWith('image/')) {
      throw new Error('La URL no apunta a una imagen válida');
    }

    const blob = await response.blob();
    const path = `${productoId}.png`;

    // 2. Subir a Supabase Storage
    const { error } = await supabase.storage
      .from(BUCKET)
      .upload(path, blob, {
        contentType: 'image/png',
        upsert: true,       // sobreescribe si ya existe
      });

    if (error) throw new Error(`Supabase Storage error: ${error.message}`);

    // 3. Retornar URL pública permanente
    const { data } = supabase.storage.from(BUCKET).getPublicUrl(path);
    return data.publicUrl;
  },

};