import { useState } from "react";
import { useNavigate } from "react-router";
import { Card } from "../components/ui/card";
import { Button } from "../components/ui/button";
import { Badge } from "../components/ui/badge";
import { ShoppingCart, Package, Infinity, Star, ArrowLeft, Users } from "lucide-react";
import { useStore } from "../data/store-context";
import type { Seller } from "../data/games";

// ─── Star Rating display ─────────────────────────────────────────────────
function StarRating({ rating, size = "sm" }: { rating: number; size?: "sm" | "xs" }) {
  const full = Math.floor(rating);
  const half = rating - full >= 0.5;
  const iconSize = size === "xs" ? "w-3 h-3" : "w-3.5 h-3.5";
  return (
    <span className="flex items-center gap-0.5">
      {[1, 2, 3, 4, 5].map((i) => (
        <Star
          key={i}
          className={`${iconSize} ${
            i <= full
              ? "fill-amber-400 text-amber-400"
              : i === full + 1 && half
              ? "fill-amber-400/50 text-amber-400"
              : "fill-muted text-muted-foreground/30"
          }`}
        />
      ))}
    </span>
  );
}

// ─── Seller badge / link ─────────────────────────────────────────────────
function SellerBadge({
  seller,
  onClick,
}: {
  seller: Seller;
  onClick: (id: string) => void;
}) {
  return (
    <button
      type="button"
      onClick={() => onClick(seller.id)}
      className="flex items-center gap-1.5 group/seller mt-1 w-full text-left"
      title={`Ver todos los productos de ${seller.displayName}`}
    >
      <img
        src={seller.avatar}
        alt={seller.displayName}
        className="w-5 h-5 rounded-full object-cover flex-shrink-0 ring-1 ring-border"
        onError={(e) => {
          (e.target as HTMLImageElement).src =
            "https://ui-avatars.com/api/?name=" + encodeURIComponent(seller.displayName);
        }}
      />
      <span className="text-xs text-muted-foreground group-hover/seller:text-primary transition-colors truncate">
        {seller.displayName}
      </span>
      <StarRating rating={seller.rating} size="xs" />
      <span className="text-xs text-amber-500 flex-shrink-0">{seller.rating.toFixed(1)}</span>
    </button>
  );
}

// ─── Seller Profile Banner ───────────────────────────────────────────────
function SellerBanner({
  seller,
  gameCount,
  onClear,
}: {
  seller: Seller;
  gameCount: number;
  onClear: () => void;
}) {
  return (
    <div className="mb-8 rounded-2xl border border-border bg-card p-5 flex flex-col sm:flex-row items-start sm:items-center gap-4 shadow-sm">
      <button
        type="button"
        onClick={onClear}
        className="flex items-center gap-1.5 text-sm text-muted-foreground hover:text-foreground transition-colors flex-shrink-0"
      >
        <ArrowLeft className="w-4 h-4" />
        Todos los juegos
      </button>

      <div className="w-px h-8 bg-border hidden sm:block" />

      <img
        src={seller.avatar}
        alt={seller.displayName}
        className="w-14 h-14 rounded-full object-cover ring-2 ring-primary/30"
        onError={(e) => {
          (e.target as HTMLImageElement).src =
            "https://ui-avatars.com/api/?name=" + encodeURIComponent(seller.displayName) + "&size=56";
        }}
      />

      <div className="flex-1 min-w-0">
        <div className="flex flex-wrap items-center gap-2 mb-1">
          <h2 className="text-lg">{seller.displayName}</h2>
          <Badge variant="outline" className="text-xs">
            @{seller.username}
          </Badge>
        </div>
        <div className="flex flex-wrap items-center gap-3 text-sm text-muted-foreground">
          <span className="flex items-center gap-1.5">
            <StarRating rating={seller.rating} />
            <span className="text-amber-500">{seller.rating.toFixed(1)}</span>
            <span>({seller.reviewCount} reseñas)</span>
          </span>
          <span className="flex items-center gap-1">
            <Package className="w-3.5 h-3.5" />
            {gameCount} {gameCount === 1 ? "producto" : "productos"}
          </span>
          <span className="flex items-center gap-1">
            <Users className="w-3.5 h-3.5" />
            Miembro desde {new Date(seller.joinedDate).toLocaleDateString("es-ES", { year: "numeric", month: "long" })}
          </span>
        </div>
      </div>
    </div>
  );
}

// ─── Main Store component ────────────────────────────────────────────────
export function Store() {
  const navigate = useNavigate();
  const store = useStore();
  const [selectedCategory, setSelectedCategory] = useState<string>("Todos");
  const [selectedSellerId, setSelectedSellerId] = useState<string | null>(null);

  const activeGames = store.getActiveGames();
  const activeCategories = store.getActiveCategories();

  const selectedSeller = selectedSellerId ? store.getSeller(selectedSellerId) : null;

  // When a seller is active, ignore category filter
  const filteredGames = selectedSellerId
    ? activeGames.filter((g) => g.sellerId === selectedSellerId)
    : selectedCategory === "Todos"
    ? activeGames
    : activeGames.filter((game) => game.category === selectedCategory);

  const handleSellerClick = (sellerId: string) => {
    setSelectedSellerId(sellerId);
    setSelectedCategory("Todos");
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  const clearSellerFilter = () => {
    setSelectedSellerId(null);
  };

  const addToCart = (_gameId: string) => {
    navigate("/checkout");
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-background to-muted/20">
      {/* Hero Section */}
      <div className="bg-gradient-to-r from-primary via-secondary to-accent py-16 px-4">
        <div className="max-w-7xl mx-auto text-center">
          <h1 className="text-4xl md:text-5xl mb-4 text-white">
            Bienvenido a GameStore Pro
          </h1>
          <p className="text-xl text-white/90 max-w-2xl mx-auto">
            Descubre los mejores videojuegos para todas las plataformas
          </p>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">

        {/* Seller Banner (when filtering by seller) */}
        {selectedSeller && (
          <SellerBanner
            seller={selectedSeller}
            gameCount={filteredGames.length}
            onClear={clearSellerFilter}
          />
        )}

        {/* Category Filter (hidden when filtering by seller) */}
        {!selectedSellerId && (
          <div className="mb-8">
            <h2 className="mb-4">Categorías</h2>
            <div className="flex flex-wrap gap-2">
              <Button
                variant={selectedCategory === "Todos" ? "default" : "outline"}
                onClick={() => setSelectedCategory("Todos")}
                className={selectedCategory === "Todos" ? "bg-primary hover:bg-primary/90" : ""}
              >
                Todos
              </Button>
              {activeCategories.map((cat) => (
                <Button
                  key={cat.id}
                  variant={selectedCategory === cat.name ? "default" : "outline"}
                  onClick={() => setSelectedCategory(cat.name)}
                  className={selectedCategory === cat.name ? "bg-primary hover:bg-primary/90" : ""}
                >
                  {cat.name}
                </Button>
              ))}
            </div>
          </div>
        )}

        {/* Section title when filtering */}
        {selectedSellerId && (
          <h2 className="mb-6 text-muted-foreground">
            Productos de{" "}
            <span className="text-foreground">{selectedSeller?.displayName}</span>
          </h2>
        )}

        {/* Games Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
          {filteredGames.map((game) => {
            const offer = store.getGameOffer(game.id);
            const basePrice = game.prices.usa ?? 0;
            const finalPrice = offer
              ? basePrice * (1 - offer.discountPercent / 100)
              : basePrice;
            const outOfStock = game.stock !== "unlimited" && game.stock <= 0;
            const seller = game.sellerId ? store.getSeller(game.sellerId) : undefined;

            return (
              <Card
                key={game.id}
                className={`overflow-hidden hover:shadow-lg transition-shadow group ${
                  outOfStock ? "opacity-70" : ""
                }`}
              >
                <div className="relative overflow-hidden">
                  <img
                    src={game.image}
                    alt={game.title}
                    className={`w-full h-48 object-cover group-hover:scale-105 transition-transform duration-300 ${
                      outOfStock ? "grayscale" : ""
                    }`}
                    onError={(e) => {
                      (e.target as HTMLImageElement).src =
                        "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&h=200&fit=crop";
                    }}
                  />
                  <Badge className="absolute top-2 right-2 bg-accent">
                    {game.category}
                  </Badge>
                  {offer && (
                    <Badge className="absolute top-2 left-2 bg-destructive">
                      -{offer.discountPercent}%
                    </Badge>
                  )}
                  {outOfStock && (
                    <div className="absolute inset-0 flex items-center justify-center bg-black/40">
                      <Badge className="bg-destructive text-white px-3 py-1">
                        Agotado
                      </Badge>
                    </div>
                  )}
                </div>
                <div className="p-4">
                  <h3 className="mb-1 line-clamp-1">{game.title}</h3>

                  {/* Seller info */}
                  {seller && (
                    <SellerBadge seller={seller} onClick={handleSellerClick} />
                  )}

                  <p className="text-sm text-muted-foreground mt-2 mb-3 line-clamp-2">
                    {game.description}
                  </p>

                  {/* Stock indicator */}
                  <div className="flex items-center gap-1.5 mb-3">
                    {game.stock === "unlimited" ? (
                      <span className="flex items-center gap-1 text-xs text-accent">
                        <Infinity className="w-3.5 h-3.5" />
                        Disponible
                      </span>
                    ) : game.stock > 0 ? (
                      <span className="flex items-center gap-1 text-xs text-muted-foreground">
                        <Package className="w-3.5 h-3.5" />
                        {game.stock} en stock
                      </span>
                    ) : (
                      <span className="flex items-center gap-1 text-xs text-destructive">
                        <Package className="w-3.5 h-3.5" />
                        Sin stock
                      </span>
                    )}
                  </div>

                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      {offer ? (
                        <>
                          <span className="text-sm text-muted-foreground line-through">
                            ${basePrice.toFixed(2)}
                          </span>
                          <span className="text-xl text-accent">
                            ${finalPrice.toFixed(2)}
                          </span>
                        </>
                      ) : (
                        <span className="text-xl text-primary">
                          ${basePrice.toFixed(2)}
                        </span>
                      )}
                    </div>
                    <Button
                      size="sm"
                      onClick={() => addToCart(game.id)}
                      className="bg-secondary hover:bg-secondary/90"
                      disabled={outOfStock}
                    >
                      <ShoppingCart className="w-4 h-4 mr-1" />
                      Agregar
                    </Button>
                  </div>
                </div>
              </Card>
            );
          })}
        </div>

        {filteredGames.length === 0 && (
          <div className="text-center py-12">
            <p className="text-muted-foreground">
              {selectedSellerId
                ? "Este vendedor no tiene productos disponibles."
                : "No se encontraron juegos en esta categoría."}
            </p>
            {selectedSellerId && (
              <Button variant="outline" className="mt-4" onClick={clearSellerFilter}>
                <ArrowLeft className="w-4 h-4 mr-1" />
                Ver todos los juegos
              </Button>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
