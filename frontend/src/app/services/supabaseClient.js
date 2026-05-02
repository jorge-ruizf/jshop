import { createClient } from "@supabase/supabase-js";

const supabaseUrl = "https://gdwhecwatzmitbfsozbi.supabase.co";
const supabaseAnonKey = "sb_publishable_xb8jQ_yEHiKY5FmgpszneQ_1Uyd-4XX";

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
