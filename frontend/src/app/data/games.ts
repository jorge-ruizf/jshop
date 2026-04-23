export interface CountryConfig {
  code: string;
  name: string;
  flag: string;
  currency: string;
  archived?: boolean;
}

export interface CategoryConfig {
  id: string;
  name: string;
  archived?: boolean;
}

export interface PaymentMethodConfig {
  id: string;
  value: string;
  name: string;
  description: string;
  countryCode: string;
  archived?: boolean;
}

export interface OfferConfig {
  id: string;
  gameId: string;
  discountPercent: number;
  startDate: string;
  endDate: string;
  active: boolean;
  archived?: boolean;
}

export interface Seller {
  id: string;
  username: string;
  displayName: string;
  avatar: string;
  rating: number;
  reviewCount: number;
  joinedDate: string;
  archived?: boolean;
}

export interface Game {
  id: string;
  title: string;
  prices: Record<string, number>;
  category: string;
  description: string;
  image: string;
  releaseDate: string;
  stock: number | "unlimited";
  sellerId?: string;
  archived?: boolean;
}

export const defaultCountries: CountryConfig[] = [
  { code: "colombia", name: "Colombia", flag: "🇨🇴", currency: "COP" },
  { code: "mexico", name: "México", flag: "🇲🇽", currency: "MXN" },
  { code: "brasil", name: "Brasil", flag: "🇧🇷", currency: "BRL" },
  { code: "argentina", name: "Argentina", flag: "🇦🇷", currency: "ARS" },
  { code: "peru", name: "Perú", flag: "🇵🇪", currency: "PEN" },
  { code: "chile", name: "Chile", flag: "🇨🇱", currency: "CLP" },
  { code: "uruguay", name: "Uruguay", flag: "🇺🇾", currency: "UYU" },
  { code: "venezuela", name: "Venezuela", flag: "🇻🇪", currency: "VES" },
  { code: "ecuador", name: "Ecuador", flag: "🇪🇨", currency: "USD" },
  { code: "usa", name: "USA", flag: "🇺🇸", currency: "USD" },
];

export const defaultCategories: CategoryConfig[] = [
  { id: "cat-1", name: "Acción" },
  { id: "cat-2", name: "Aventura" },
  { id: "cat-3", name: "RPG" },
  { id: "cat-4", name: "Estrategia" },
  { id: "cat-5", name: "Deportes" },
  { id: "cat-6", name: "Carreras" },
  { id: "cat-7", name: "Simulación" },
  { id: "cat-8", name: "Puzzle" },
];

export const defaultPaymentMethods: PaymentMethodConfig[] = [
  { id: "pm-1", value: "nequi", name: "Nequi", description: "Transferencia rápida con Nequi", countryCode: "colombia" },
  { id: "pm-2", value: "bancolombia", name: "Bancolombia", description: "Transferencia Bancolombia", countryCode: "colombia" },
  { id: "pm-3", value: "transfermex", name: "TransferMex", description: "Transferencia nacional mexicana", countryCode: "mexico" },
  { id: "pm-4", value: "oxxo", name: "Depósito Oxxo", description: "Pago en efectivo en tiendas Oxxo", countryCode: "mexico" },
  { id: "pm-5", value: "pix", name: "Pix", description: "Pago instantáneo con Pix", countryCode: "brasil" },
  { id: "pm-6", value: "prex-br", name: "Prex", description: "Tarjeta prepaga Prex", countryCode: "brasil" },
  { id: "pm-7", value: "bancoargentina", name: "Banco Argentina", description: "Transferencia bancaria argentina", countryCode: "argentina" },
  { id: "pm-8", value: "prex-ar", name: "Prex", description: "Tarjeta prepaga Prex", countryCode: "argentina" },
  { id: "pm-9", value: "yape", name: "Yape", description: "Pago móvil con Yape", countryCode: "peru" },
  { id: "pm-10", value: "bancopichincha-pe", name: "Banco Pichincha", description: "Transferencia Banco Pichincha", countryCode: "peru" },
  { id: "pm-11", value: "prex-cl", name: "Prex", description: "Tarjeta prepaga Prex", countryCode: "chile" },
  { id: "pm-12", value: "prex-uy", name: "Prex", description: "Tarjeta prepaga Prex", countryCode: "uruguay" },
  { id: "pm-13", value: "bancopichincha-ec", name: "Banco Pichincha", description: "Transferencia Banco Pichincha", countryCode: "ecuador" },
  { id: "pm-14", value: "pagomovil", name: "Pago Móvil", description: "Transferencia con Pago Móvil", countryCode: "venezuela" },
  { id: "pm-15", value: "remitly", name: "Remitly (Dólares)", description: "Transferencia internacional", countryCode: "usa" },
  { id: "pm-16", value: "revolut", name: "Revolut (Dólares)", description: "Pago con Revolut", countryCode: "usa" },
  { id: "pm-17", value: "swift", name: "Swift (Dólares)", description: "Transferencia bancaria Swift", countryCode: "usa" },
  { id: "pm-18", value: "paypal", name: "PayPal (Solo familiares y amigos)", description: "Pago seguro con PayPal", countryCode: "internacional" },
  { id: "pm-19", value: "binance", name: "Binance", description: "Pago con criptomonedas Binance", countryCode: "internacional" },
  { id: "pm-20", value: "airtm", name: "Airtm", description: "Transferencia con Airtm", countryCode: "internacional" },
  { id: "pm-21", value: "ltc", name: "LTC", description: "Pago con Litecoin", countryCode: "internacional" },
];

export const categories = defaultCategories.map((c) => c.name);

// ─── Example Sellers ────────────────────────────────────────────────────
export const defaultSellers: Seller[] = [
  {
    id: "seller-1",
    username: "nexgamer",
    displayName: "NexGamer Store",
    avatar: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=80&h=80&fit=crop",
    rating: 4.8,
    reviewCount: 234,
    joinedDate: "2023-01-15",
  },
  {
    id: "seller-2",
    username: "playzone_pro",
    displayName: "PlayZone Pro",
    avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=80&h=80&fit=crop",
    rating: 4.5,
    reviewCount: 189,
    joinedDate: "2023-04-22",
  },
  {
    id: "seller-3",
    username: "digital_vault",
    displayName: "Digital Vault",
    avatar: "https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=80&h=80&fit=crop",
    rating: 4.2,
    reviewCount: 156,
    joinedDate: "2023-07-10",
  },
];

export const games: Game[] = [
  {
    id: "1",
    title: "Cyber Warriors 2077",
    prices: {
      colombia: 239900, mexico: 1199, brasil: 299, argentina: 59900,
      peru: 229, chile: 54990, uruguay: 2399, venezuela: 599, ecuador: 59.99, usa: 59.99,
    },
    category: "Acción",
    description: "Una experiencia futurista de acción en mundo abierto con combates épicos y una historia inmersiva.",
    image: "https://images.unsplash.com/flagged/photo-1572383761657-4919d351d433?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjeWJlcnB1bmslMjBmdXR1cmlzdGljJTIwZ2FtZSUyMGNvdmVyfGVufDF8fHx8MTc3MTI5NTQzOHww&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-03-15",
    stock: "unlimited",
    sellerId: "seller-1",
  },
  {
    id: "2",
    title: "Fantasy Realms",
    prices: {
      colombia: 199900, mexico: 999, brasil: 249, argentina: 49900,
      peru: 189, chile: 45990, uruguay: 1999, venezuela: 499, ecuador: 49.99, usa: 49.99,
    },
    category: "RPG",
    description: "Explora un mundo mágico lleno de criaturas místicas y completa misiones épicas.",
    image: "https://images.unsplash.com/photo-1562576650-27130b06c0ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmYW50YXN5JTIwbWVkaWV2YWwlMjBnYW1lJTIwY292ZXJ8ZW58MXx8fHwxNzcxMjk1NDM5fDA&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-02-20",
    stock: 50,
    sellerId: "seller-1",
  },
  {
    id: "3",
    title: "Speed Legends",
    prices: {
      colombia: 159900, mexico: 799, brasil: 199, argentina: 39900,
      peru: 149, chile: 36990, uruguay: 1599, venezuela: 399, ecuador: 39.99, usa: 39.99,
    },
    category: "Carreras",
    description: "Corre a velocidades extremas en los circuitos más desafiantes del mundo.",
    image: "https://images.unsplash.com/photo-1762857361982-0cc8fece7848?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxyYWNpbmclMjBjYXIlMjBnYW1lJTIwY292ZXJ8ZW58MXx8fHwxNzcxMjk1NDM5fDA&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-01-10",
    stock: 25,
    sellerId: "seller-2",
  },
  {
    id: "4",
    title: "Strategic Empire",
    prices: {
      colombia: 179900, mexico: 899, brasil: 224, argentina: 44900,
      peru: 169, chile: 41990, uruguay: 1799, venezuela: 449, ecuador: 44.99, usa: 44.99,
    },
    category: "Estrategia",
    description: "Construye tu imperio y conquista territorios con estrategias magistrales.",
    image: "https://images.unsplash.com/photo-1761274441884-357dad8f28ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzdHJhdGVneSUyMHdhciUyMGdhbWUlMjBjb3ZlcnxlbnwxfHx8fDE3NzEyOTU0Mzl8MA&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-04-05",
    stock: "unlimited",
    sellerId: "seller-2",
  },
  {
    id: "5",
    title: "Jungle Explorer",
    prices: {
      colombia: 219900, mexico: 1099, brasil: 274, argentina: 54900,
      peru: 209, chile: 50990, uruguay: 2199, venezuela: 549, ecuador: 54.99, usa: 54.99,
    },
    category: "Aventura",
    description: "Embárcate en una aventura tropical llena de misterios y tesoros ocultos.",
    image: "https://images.unsplash.com/photo-1690222038670-07a9ed820b2b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxqdW5nbGUlMjBhZHZlbnR1cmUlMjBnYW1lJTIwY292ZXJ8ZW58MXx8fHwxNzcxMjk1NDM5fDA&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-05-12",
    stock: 100,
    sellerId: "seller-3",
  },
  {
    id: "6",
    title: "Soccer Pro 2024",
    prices: {
      colombia: 199900, mexico: 999, brasil: 249, argentina: 49900,
      peru: 189, chile: 45990, uruguay: 1999, venezuela: 499, ecuador: 49.99, usa: 49.99,
    },
    category: "Deportes",
    description: "Vive la emoción del fútbol profesional con gráficos realistas y jugabilidad fluida.",
    image: "https://images.unsplash.com/flagged/photo-1550413231-202a9d53a331?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzb2NjZXIlMjBmb290YmFsbCUyMGdhbWUlMjBzdGFkaXVtfGVufDF8fHx8MTc3MTI5NTQ0MHww&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-06-01",
    stock: 0,
    sellerId: "seller-3",
  },
  {
    id: "7",
    title: "Mind Maze",
    prices: {
      colombia: 79900, mexico: 399, brasil: 99, argentina: 19900,
      peru: 79, chile: 18990, uruguay: 799, venezuela: 199, ecuador: 19.99, usa: 19.99,
    },
    category: "Puzzle",
    description: "Desafía tu mente con rompecabezas intrincados y acertijos creativos.",
    image: "https://images.unsplash.com/photo-1635744837759-051facae9e6a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwdXp6bGUlMjBtaW5kJTIwZ2FtZSUyMGFic3RyYWN0fGVufDF8fHx8MTc3MTI5NTQ0MHww&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-03-25",
    stock: "unlimited",
    sellerId: "seller-1",
  },
  {
    id: "8",
    title: "Flight Simulator X",
    prices: {
      colombia: 239900, mexico: 1199, brasil: 299, argentina: 59900,
      peru: 229, chile: 54990, uruguay: 2399, venezuela: 599, ecuador: 59.99, usa: 59.99,
    },
    category: "Simulación",
    description: "Experimenta el realismo de pilotar aeronaves en condiciones auténticas.",
    image: "https://images.unsplash.com/photo-1761599604364-f892b204f5b1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmbGlnaHQlMjBzaW11bGF0b3IlMjBhaXJwbGFuZSUyMGNvY2twaXR8ZW58MXx8fHwxNzcxMjk1NDQwfDA&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-02-14",
    stock: 15,
    sellerId: "seller-2",
  },
  {
    id: "9",
    title: "Dark Shadows",
    prices: {
      colombia: 179900, mexico: 899, brasil: 224, argentina: 44900,
      peru: 169, chile: 41990, uruguay: 1799, venezuela: 449, ecuador: 44.99, usa: 44.99,
    },
    category: "Acción",
    description: "Sobrevive en un mundo postapocalíptico lleno de peligros y criaturas hostiles.",
    image: "https://images.unsplash.com/photo-1766186616102-5f2bcb39b678?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkYXJrJTIwYXBvY2FseXB0aWMlMjBnYW1lJTIwaG9ycm9yfGVufDF8fHx8MTc3MTI5NTQ0MXww&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-07-20",
    stock: "unlimited",
    sellerId: "seller-3",
  },
  {
    id: "10",
    title: "Space Odyssey",
    prices: {
      colombia: 259900, mexico: 1299, brasil: 324, argentina: 64900,
      peru: 249, chile: 59990, uruguay: 2599, venezuela: 649, ecuador: 64.99, usa: 64.99,
    },
    category: "Aventura",
    description: "Explora galaxias distantes y descubre civilizaciones alienígenas.",
    image: "https://images.unsplash.com/photo-1762441112136-4dfc6edf58e8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxzcGFjZSUyMGdhbGF4eSUyMGdhbWUlMjBzY2ktZml8ZW58MXx8fHwxNzcxMjk1NDQxfDA&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-08-10",
    stock: 75,
    sellerId: "seller-1",
  },
  {
    id: "11",
    title: "Medieval Kingdoms",
    prices: {
      colombia: 159900, mexico: 799, brasil: 199, argentina: 39900,
      peru: 149, chile: 36990, uruguay: 1599, venezuela: 399, ecuador: 39.99, usa: 39.99,
    },
    category: "Estrategia",
    description: "Gobierna tu reino medieval y lidera ejércitos en batallas tácticas.",
    image: "https://images.unsplash.com/photo-1629892472806-4a12db8e3e03?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZWRpZXZhbCUyMGNhc3RsZSUyMGtpbmdkb20lMjBnYW1lfGVufDF8fHx8MTc3MTI5NTQ0MXww&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-04-30",
    stock: 30,
    sellerId: "seller-2",
  },
  {
    id: "12",
    title: "Dragon Quest Chronicles",
    prices: {
      colombia: 219900, mexico: 1099, brasil: 274, argentina: 54900,
      peru: 209, chile: 50990, uruguay: 2199, venezuela: 549, ecuador: 54.99, usa: 54.99,
    },
    category: "RPG",
    description: "Conviértete en un héroe legendario y enfrenta dragones poderosos.",
    image: "https://images.unsplash.com/photo-1745130839558-55b2f78f5739?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcmFnb24lMjBjcmVhdHVyZSUyMGZhbnRhc3l8ZW58MXx8fHwxNzcxMjcxMzIzfDA&ixlib=rb-4.1.0&q=80&w=1080",
    releaseDate: "2024-05-18",
    stock: "unlimited",
    sellerId: "seller-3",
  },
];
