import { useState } from "react";
import { useNavigate } from "react-router";
import { Card } from "../components/ui/card";
import { Button } from "../components/ui/button";
import { Badge } from "../components/ui/badge";
import { ShoppingCart, Package, Star, ArrowLeft, Users, Loader2 } from "lucide-react";
import { useStore } from "../data/store-context";
import { useFetch } from "../hooks";
import { productosService } from "../services";
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

  // Fetch real products from the backend via the service layer.
  const {
    data: productos,
    loading,
    error,
  } = useFetch(() => productosService.list(), []);

  const activeCategories = store.getActiveCategories();
  const selectedSeller = selectedSellerId ? store.getSeller(selectedSellerId) : null;

  // Map backend Producto -> the shape used by the existing Card UI.
  // Fields not present on the backend model use safe defaults so the
  // existing visual structure is preserved.
  const filteredProductos = productos ?? [];

  const clearSellerFilter = () => {
    setSelectedSellerId(null);
  };

  const addToCart = (_productoId: number) => {
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
            gameCount={filteredProductos.length}
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

        {/* Loading state */}
        {loading && (
          <div className="flex items-center justify-center py-16 text-muted-foreground">
            <Loader2 className="w-5 h-5 animate-spin mr-2" />
            Cargando productos…
          </div>
        )}

        {/* Error state */}
        {error && !loading && (
          <div className="text-center py-12">
            <p className="text-destructive">
              No se pudieron cargar los productos: {error.message}
            </p>
          </div>
        )}

        {/* Products Grid (real backend data) */}
        {!loading && !error && (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            {filteredProductos.map((producto) => (
              <Card
                key={producto.id}
                className="overflow-hidden hover:shadow-lg transition-shadow group"
              >
                <div className="relative overflow-hidden">
                  <img
                    src="https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&h=200&fit=crop"
                    alt={producto.nombre}
                    className="w-full h-48 object-cover group-hover:scale-105 transition-transform duration-300"
                    onError={(e) => {
                      (e.target as HTMLImageElement).src =
                        "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&h=200&fit=crop";
                    }}
                  />
                  <Badge className="absolute top-2 right-2 bg-accent">
                    Producto
                  </Badge>
                </div>
                <div className="p-4">
                  <h3 className="mb-1 line-clamp-1">{producto.nombre}</h3>

                  <p className="text-sm text-muted-foreground mt-2 mb-3 line-clamp-2">
                    {producto.descripcion}
                  </p>

                  <div className="flex items-center gap-1.5 mb-3">
                    <span className="flex items-center gap-1 text-xs text-muted-foreground">
                      <Package className="w-3.5 h-3.5" />
                      ID #{producto.id}
                    </span>
                  </div>

                  <div className="flex items-center justify-between">
                    <span className="text-xl text-primary">—</span>
                    <Button
                      size="sm"
                      onClick={() => addToCart(producto.id)}
                      className="bg-secondary hover:bg-secondary/90"
                    >
                      <ShoppingCart className="w-4 h-4 mr-1" />
                      Agregar
                    </Button>
                  </div>
                </div>
              </Card>
            ))}
          </div>
        )}

        {!loading && !error && filteredProductos.length === 0 && (
          <div className="text-center py-12">
            <p className="text-muted-foreground">
              {selectedSellerId
                ? "Este vendedor no tiene productos disponibles."
                : "No hay productos disponibles."}
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

// Note: SellerBadge is intentionally retained (not removed) for future use
// when the backend exposes seller details on Producto (id_vendedor → Usuario).
void SellerBadge;
