import { useState, useEffect } from "react";
import { useNavigate } from "react-router";
import { Card } from "../components/ui/card";
import { Button } from "../components/ui/button";
import { Badge } from "../components/ui/badge";
import { ShoppingCart, Package, Star, ArrowLeft, Users, Loader2, Bell } from "lucide-react";
import { useStore } from "../data/store-context";
import { useFetch } from "../hooks";
import { productosService, categoriasService } from "../services";
import type { Seller } from "../data/games";
import { carritoService } from "../services/carrito.service";
import { useAuthContext } from "../contexts/AuthContext";
import type { Producto } from "../services/types";
import { productosDeseadosService } from "../services/productosDeseados.service";
import type { ProductoDeseado } from "../services/types.ts";
import { PriceAlertModal } from "../components/PriceAlertModal";
import { PriceAlertButton } from "../components/PriceAlertButton";
import { formatPrecio } from "../utils/formatPrecio";

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
          className={`${iconSize} ${i <= full
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
            "https://ui-avatars.com/api/?name=" +
            encodeURIComponent(seller.displayName) +
            "&size=56";
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
            Miembro desde{" "}
            {new Date(seller.joinedDate).toLocaleDateString("es-ES", {
              year: "numeric",
              month: "long",
            })}
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
  const { usuario } = useAuthContext();
  const [agregando, setAgregando] = useState<number | null>(null);

  // ── Alertas de precio ─────────────────────────────────────────────────
  // Map de id_producto → ProductoDeseado (alerta existente del usuario)
  const [alertasMap, setAlertasMap] = useState<Map<number, ProductoDeseado>>(new Map());
  // Modal: producto seleccionado para crear/editar alerta
  const [modalProducto, setModalProducto] = useState<Producto | null>(null);

  // Cargar alertas existentes del usuario al montar
  useEffect(() => {
    if (!usuario?.id) return;
    productosDeseadosService.listar(usuario.id).then((alertas) => {
      const map = new Map<number, ProductoDeseado>();
      for (const a of alertas) map.set(a.id_producto, a);
      setAlertasMap(map);
    }).catch(() => {
      // silencioso — no bloquea la store si falla
    });
  }, [usuario?.id]);

  const handleAlertaSuccess = (productoId: number, alerta: ProductoDeseado | null) => {
    setAlertasMap((prev) => {
      const next = new Map(prev);
      if (alerta === null) next.delete(productoId);
      else next.set(productoId, alerta);
      return next;
    });
  };
  // ─────────────────────────────────────────────────────────────────────

  const {
    data: productos,
    loading,
    error,
  } = useFetch((signal) => productosService.list(signal), []);

  const {
    data: categorias,
    loading: categoriasLoading,
    error: categoriasError,
  } = useFetch((signal) => categoriasService.list(signal), []);

  const activeCategories = store.getActiveCategories();
  const selectedSeller = selectedSellerId ? store.getSeller(selectedSellerId) : null;
  const filteredProductos = productos ?? [];
  const clearSellerFilter = () => setSelectedSellerId(null);

  const handleAgregar = async (id_producto: number) => {
    if (!usuario) return;
    setAgregando(id_producto);
    try {
      await carritoService.add(id_producto, usuario.id);
    } catch (err) {
      console.error(err);
    } finally {
      setAgregando(null);
    }
  };

  const getPrecioNum = (producto: Producto): number | null => {
    if (!usuario?.id_pais || !producto.precios?.length) return null;
    const match = producto.precios.find((p) => p.id_pais === usuario.id_pais);
    if (!match || Number(match.precio) <= 0) return null;
    return Number(match.precio);
  };


  return (
    <div className="min-h-screen bg-gradient-to-b from-background to-muted/20">
      {/* Hero Section */}
      <div className="bg-gradient-to-r from-primary via-secondary to-accent py-16 px-4">
        <div className="max-w-7xl mx-auto text-center">
          <h1 className="text-4xl md:text-5xl mb-4 text-white">
            Bienvenido a JShop
          </h1>
          <p className="text-xl text-white/90 max-w-2xl mx-auto">
            Descubre las mejores cuentas y ofertas para tus videojuegos favoritos
          </p>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {selectedSeller && (
          <SellerBanner
            seller={selectedSeller}
            gameCount={filteredProductos.length}
            onClear={clearSellerFilter}
          />
        )}

        {selectedSellerId && (
          <h2 className="mb-6 text-muted-foreground">
            Productos de{" "}
            <span className="text-foreground">{selectedSeller?.displayName}</span>
          </h2>
        )}

        {loading && (
          <div className="flex items-center justify-center py-16 text-muted-foreground">
            <Loader2 className="w-5 h-5 animate-spin mr-2" />
            Cargando productos…
          </div>
        )}

        {error && !loading && (
          <div className="text-center py-12">
            <p className="text-destructive">
              No se pudieron cargar los productos: {error.message}
            </p>
          </div>
        )}

        {/* Products Grid */}
        {!loading && !error && (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            {filteredProductos.map((producto) => {
              const alertaExistente = alertasMap.get(producto.id);
              const tieneAlerta = !!alertaExistente;
              const precioNum = getPrecioNum(producto);
              const noDisponible = precioNum === null;

              return (
                <Card
                  key={producto.id}
                  className="overflow-hidden hover:shadow-lg transition-shadow group cursor-pointer"
                  onClick={() => navigate(`/producto/${producto.id}`)}
                >
                  <div className="relative overflow-hidden">
                    <img
                      src={
                        producto.imagenes?.[0]?.ruta ??
                        'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&h=400&fit=crop'
                      }
                      alt={producto.nombre}
                      className={`w-full h-48 object-cover group-hover:scale-105 transition-transform duration-300 ${noDisponible ? "grayscale brightness-75" : ""
                        }`}
                    />
                    {noDisponible && (
                      <span className="absolute bottom-2 left-2 bg-destructive text-destructive-foreground text-[10px] font-medium px-2 py-0.5 rounded-full">
                        No disponible
                      </span>
                    )}
                    <Badge className="absolute top-2 right-2 bg-accent">Producto</Badge>
                  </div>

                  <div className="p-4">
                    <h3 className="mb-1 line-clamp-1">{producto.nombre}</h3>

                    <p className="text-sm text-muted-foreground mt-2 mb-3 line-clamp-2">
                      {producto.descripcion}
                    </p>

                    <div className="flex items-center gap-1.5 mb-3">
                      <span className="flex items-center gap-1 text-xs text-muted-foreground">
                        <Package className="w-3.5 h-3.5" />
                        {producto.imagenes?.length
                          ? `${producto.imagenes.length} ${producto.imagenes.length === 1 ? "imagen" : "imágenes"}`
                          : "Sin imágenes"}
                        {"  ·  "}
                        {noDisponible ? "Sin stock" : "Disponible"}
                      </span>
                    </div>

                    <div className="flex items-center justify-between mb-2">
                      <span className={`text-xl ${noDisponible ? "text-muted-foreground" : "text-primary"}`}>
                        {noDisponible ? "—" : formatPrecio(precioNum!)}
                      </span>
                      <Button
                        size="sm"
                        onClick={(e) => {
                          e.stopPropagation();
                          handleAgregar(producto.id);
                        }}
                        disabled={agregando === producto.id || noDisponible}
                        className="bg-secondary hover:bg-secondary/90 disabled:opacity-50"
                      >
                        <ShoppingCart className="w-4 h-4 mr-1" />
                        {agregando === producto.id ? "Agregando..." : "Agregar"}
                      </Button>
                    </div>

                    {/* ── Botón de alerta de precio ─────────────────── */}
                    {usuario && (
                      <Button
                        variant="outline"
                        size="sm"
                        className={`w-full text-xs ${tieneAlerta
                          ? "border-primary/40 text-primary hover:bg-primary/5"
                          : "text-muted-foreground"
                          }`}
                        onClick={(e) => {
                          e.stopPropagation();
                          setModalProducto(producto);
                        }}
                      >
                        <Bell className={`w-3.5 h-3.5 mr-1.5 ${tieneAlerta ? "fill-primary/20" : ""}`} />
                        {tieneAlerta
                          ? `Alerta: $${Number(alertaExistente.precio_objetivo).toLocaleString("es-CO")}`
                          : "Crear alerta de precio"}
                      </Button>
                    )}
                    {/* ─────────────────────────────────────────────── */}
                  </div>
                </Card>
              );
            })}
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

      {/* Modal de alerta de precio */}
      {modalProducto && usuario && (
        <PriceAlertModal
          producto={modalProducto}
          idUsuario={usuario.id}
          alertaExistente={alertasMap.get(modalProducto.id)}
          onClose={() => setModalProducto(null)}
          onSuccess={(alerta) => {
            handleAlertaSuccess(modalProducto.id, alerta);
            setModalProducto(null);
          }}
        />
      )}

      {/*void (SellerBadge, selectedCategory, setSelectedCategory, activeCategories, categorias, categoriasLoading, categoriasError)*/}
    </div>
  );
}