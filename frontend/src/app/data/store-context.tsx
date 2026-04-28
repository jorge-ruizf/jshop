
import { createContext, useContext, useState, type ReactNode } from "react";
import {
  type Game,
  type CountryConfig,
  type CategoryConfig,
  type PaymentMethodConfig,
  type OfferConfig,
  type Seller,
  games as defaultGames,
  defaultCountries,
  defaultCategories,
  defaultPaymentMethods,
  defaultSellers,
} from "./games";

interface StoreState {
  games: Game[];
  countries: CountryConfig[];
  categories: CategoryConfig[];
  paymentMethods: PaymentMethodConfig[];
  offers: OfferConfig[];
  sellers: Seller[];
  // Game actions
  addGame: (game: Omit<Game, "id">) => void;
  updateGame: (id: string, game: Partial<Game>) => void;
  deleteGame: (id: string) => void;
  archiveGame: (id: string) => void;
  // Country actions
  addCountry: (country: Omit<CountryConfig, "archived">) => void;
  updateCountry: (code: string, country: Partial<CountryConfig>) => void;
  deleteCountry: (code: string) => void;
  archiveCountry: (code: string) => void;
  // Category actions
  addCategory: (name: string) => void;
  updateCategory: (id: string, name: string) => void;
  deleteCategory: (id: string) => void;
  archiveCategory: (id: string) => void;
  // Payment method actions
  addPaymentMethod: (method: Omit<PaymentMethodConfig, "id" | "archived">) => void;
  updatePaymentMethod: (id: string, method: Partial<PaymentMethodConfig>) => void;
  deletePaymentMethod: (id: string) => void;
  archivePaymentMethod: (id: string) => void;
  // Offer actions
  addOffer: (offer: Omit<OfferConfig, "id" | "archived">) => void;
  updateOffer: (id: string, offer: Partial<OfferConfig>) => void;
  deleteOffer: (id: string) => void;
  archiveOffer: (id: string) => void;
  // Seller actions
  addSeller: (seller: Omit<Seller, "id" | "archived">) => void;
  updateSeller: (id: string, seller: Partial<Seller>) => void;
  deleteSeller: (id: string) => void;
  archiveSeller: (id: string) => void;
  // Helpers
  getActiveGames: () => Game[];
  getActiveCategories: () => CategoryConfig[];
  getActiveCountries: () => CountryConfig[];
  getActivePaymentMethods: (countryCode: string) => PaymentMethodConfig[];
  getActiveOffers: () => OfferConfig[];
  getGameOffer: (gameId: string) => OfferConfig | undefined;
  getActiveSellers: () => Seller[];
  getSeller: (id: string) => Seller | undefined;
}

const StoreContext = createContext<StoreState | null>(null);

let nextId = 100;
const genId = () => String(nextId++);

export function StoreProvider({ children }: { children: ReactNode }) {
  const [gamesList, setGames] = useState<Game[]>(defaultGames);
  const [countriesList, setCountries] = useState<CountryConfig[]>(defaultCountries);
  const [categoriesList, setCategories] = useState<CategoryConfig[]>(defaultCategories);
  const [paymentMethodsList, setPaymentMethods] = useState<PaymentMethodConfig[]>(defaultPaymentMethods);
  const [sellersList, setSellers] = useState<Seller[]>(defaultSellers);
  const [offersList, setOffers] = useState<OfferConfig[]>([
    {
      id: "offer-1",
      gameId: "2",
      discountPercent: 20,
      startDate: "2026-02-01",
      endDate: "2026-03-01",
      active: true,
    },
    {
      id: "offer-2",
      gameId: "7",
      discountPercent: 50,
      startDate: "2026-02-10",
      endDate: "2026-02-28",
      active: true,
    },
  ]);

  // --- Game actions ---
  const addGame = (game: Omit<Game, "id">) => {
    setGames((prev) => [...prev, { ...game, id: genId() }]);
  };
  const updateGame = (id: string, updates: Partial<Game>) => {
    setGames((prev) => prev.map((g) => (g.id === id ? { ...g, ...updates } : g)));
  };
  const deleteGame = (id: string) => {
    setGames((prev) => prev.filter((g) => g.id !== id));
  };
  const archiveGame = (id: string) => {
    setGames((prev) => prev.map((g) => (g.id === id ? { ...g, archived: !g.archived } : g)));
  };

  // --- Country actions ---
  const addCountry = (country: Omit<CountryConfig, "archived">) => {
    setCountries((prev) => [...prev, { ...country }]);
  };
  const updateCountry = (code: string, updates: Partial<CountryConfig>) => {
    setCountries((prev) => prev.map((c) => (c.code === code ? { ...c, ...updates } : c)));
  };
  const deleteCountry = (code: string) => {
    setCountries((prev) => prev.filter((c) => c.code !== code));
  };
  const archiveCountry = (code: string) => {
    setCountries((prev) => prev.map((c) => (c.code === code ? { ...c, archived: !c.archived } : c)));
  };

  // --- Category actions ---
  const addCategory = (name: string) => {
    setCategories((prev) => [...prev, { id: `cat-${genId()}`, name }]);
  };
  const updateCategory = (id: string, name: string) => {
    setCategories((prev) => prev.map((c) => (c.id === id ? { ...c, name } : c)));
  };
  const deleteCategory = (id: string) => {
    setCategories((prev) => prev.filter((c) => c.id !== id));
  };
  const archiveCategory = (id: string) => {
    setCategories((prev) => prev.map((c) => (c.id === id ? { ...c, archived: !c.archived } : c)));
  };

  // --- Payment method actions ---
  const addPaymentMethod = (method: Omit<PaymentMethodConfig, "id" | "archived">) => {
    setPaymentMethods((prev) => [...prev, { ...method, id: `pm-${genId()}` }]);
  };
  const updatePaymentMethod = (id: string, updates: Partial<PaymentMethodConfig>) => {
    setPaymentMethods((prev) => prev.map((m) => (m.id === id ? { ...m, ...updates } : m)));
  };
  const deletePaymentMethod = (id: string) => {
    setPaymentMethods((prev) => prev.filter((m) => m.id !== id));
  };
  const archivePaymentMethod = (id: string) => {
    setPaymentMethods((prev) => prev.map((m) => (m.id === id ? { ...m, archived: !m.archived } : m)));
  };

  // --- Offer actions ---
  const addOffer = (offer: Omit<OfferConfig, "id" | "archived">) => {
    setOffers((prev) => [...prev, { ...offer, id: `offer-${genId()}` }]);
  };
  const updateOffer = (id: string, updates: Partial<OfferConfig>) => {
    setOffers((prev) => prev.map((o) => (o.id === id ? { ...o, ...updates } : o)));
  };
  const deleteOffer = (id: string) => {
    setOffers((prev) => prev.filter((o) => o.id !== id));
  };
  const archiveOffer = (id: string) => {
    setOffers((prev) => prev.map((o) => (o.id === id ? { ...o, archived: !o.archived } : o)));
  };

  // --- Seller actions ---
  const addSeller = (seller: Omit<Seller, "id" | "archived">) => {
    setSellers((prev) => [...prev, { ...seller, id: `seller-${genId()}` }]);
  };
  const updateSeller = (id: string, updates: Partial<Seller>) => {
    setSellers((prev) => prev.map((s) => (s.id === id ? { ...s, ...updates } : s)));
  };
  const deleteSeller = (id: string) => {
    setSellers((prev) => prev.filter((s) => s.id !== id));
  };
  const archiveSeller = (id: string) => {
    setSellers((prev) => prev.map((s) => (s.id === id ? { ...s, archived: !s.archived } : s)));
  };

  // --- Helpers ---
  const getActiveGames = () => gamesList.filter((g) => !g.archived);
  const getActiveCategories = () => categoriesList.filter((c) => !c.archived);
  const getActiveCountries = () => countriesList.filter((c) => !c.archived);
  const getActivePaymentMethods = (countryCode: string) =>
    paymentMethodsList.filter((m) => m.countryCode === countryCode && !m.archived);
  const getActiveOffers = () => offersList.filter((o) => !o.archived && o.active);
  const getGameOffer = (gameId: string) => {
    const now = new Date().toISOString().split("T")[0];
    return offersList.find(
      (o) => o.gameId === gameId && !o.archived && o.active && o.startDate <= now && o.endDate >= now
    );
  };
  const getActiveSellers = () => sellersList.filter((s) => !s.archived);
  const getSeller = (id: string) => sellersList.find((s) => s.id === id);

  return (
    <StoreContext.Provider
      value={{
        games: gamesList,
        countries: countriesList,
        categories: categoriesList,
        paymentMethods: paymentMethodsList,
        offers: offersList,
        sellers: sellersList,
        addGame, updateGame, deleteGame, archiveGame,
        addCountry, updateCountry, deleteCountry, archiveCountry,
        addCategory, updateCategory, deleteCategory, archiveCategory,
        addPaymentMethod, updatePaymentMethod, deletePaymentMethod, archivePaymentMethod,
        addOffer, updateOffer, deleteOffer, archiveOffer,
        addSeller, updateSeller, deleteSeller, archiveSeller,
        getActiveGames, getActiveCategories, getActiveCountries,
        getActivePaymentMethods, getActiveOffers, getGameOffer,
        getActiveSellers, getSeller,
      }}
    >
      {children}
    </StoreContext.Provider>
  );
}

export function useStore() {
  const ctx = useContext(StoreContext);
  if (!ctx) throw new Error("useStore must be used within StoreProvider");
  return ctx;
}
