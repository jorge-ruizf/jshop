import { supabase } from './supabaseClient';

const BUCKET = 'productos';

export const storageService = {

  uploadFile: async (productoId: number, file: File): Promise<string> => {
    const ext = file.name.split('.').pop() ?? 'png';
    const path = `${productoId}.${ext}`;

    const { error } = await supabase.storage
      .from(BUCKET)
      .upload(path, file, {
        contentType: file.type,
        upsert: true,
      });

    if (error) throw new Error(`Supabase Storage error: ${error.message}`);

    const { data } = supabase.storage.from(BUCKET).getPublicUrl(path);
    return data.publicUrl;
  },

};