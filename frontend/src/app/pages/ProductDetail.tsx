import { useState, useEffect, useRef } from "react";
import { useParams, useNavigate } from "react-router";
import { Button } from "../components/ui/button";
import { Badge } from "../components/ui/badge";
import { Separator } from "../components/ui/separator";
import { ShoppingCart, ArrowLeft, ChevronLeft, ChevronRight, Package, Tag, Gamepad2, Loader2 } from "lucide-react";
import { useFetch } from "../hooks";
import { productosService } from "../services";
import { carritoService } from "../services/carrito.service";
import { useAuthContext } from "../contexts/AuthContext";
import { productosDeseadosService } from "../services/productosDeseados.service";
import type { Producto, ProductoDeseado } from "../services/types";
import { PriceAlertModal } from "../components/PriceAlertModal";
import { formatPrecio } from "../utils/formatPrecio";

// ─── Carrusel ────────────────────────────────────────────────────────────────
function ImageCarousel({ images, title }: { images: string[]; title: string }) {
  const [current, setCurrent] = useState(0);
  const [paused, setPaused] = useState(false);
  const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

  const prev = () => setCurrent((c) => (c - 1 + images.length) % images.length);
  const next = () => setCurrent((c) => (c + 1) % images.length);

  // Auto-avance cada 4s solo si hay más de una imagen
  useEffect(() => {
    if (images.length <= 1 || paused) return;
    intervalRef.current = setInterval(next, 4000);
    return () => { if (intervalRef.current) clearInterval(intervalRef.current); };
  }, [images.length, paused, current]);

  const [touchStart, setTouchStart] = useState<number | null>(null);
  const handleTouchStart = (e: React.TouchEvent) => setTouchStart(e.touches[0].clientX);
  const handleTouchEnd = (e: React.TouchEvent) => {
    if (touchStart === null) return;
    const diff = touchStart - e.changedTouches[0].clientX;
    if (Math.abs(diff) > 40) diff > 0 ? next() : prev();
    setTouchStart(null);
  };

  const hasMultiple = images.length > 1;

  return (
    <div className="relative w-full select-none">
      <div
        className="relative overflow-hidden rounded-2xl bg-muted aspect-[4/3]"
        onMouseEnter={() => setPaused(true)}
        onMouseLeave={() => setPaused(false)}
        onTouchStart={handleTouchStart}
        onTouchEnd={handleTouchEnd}
      >
        <img
          key={current}
          src={images[current]}
          alt={`${title} — imagen ${current + 1}`}
          className="absolute inset-0 w-full h-full object-cover transition-opacity duration-300"
          onError={(e) => {
            (e.target as HTMLImageElement).src =
              "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800&h=600&fit=crop";
          }}
        />

        {hasMultiple && (
          <div className="absolute top-3 right-3 bg-black/60 text-white text-xs px-2.5 py-1 rounded-full backdrop-blur-sm">
            {current + 1} / {images.length}
          </div>
        )}

        {hasMultiple && (
          <>
            <button type="button" onClick={prev} aria-label="Anterior"
              className="absolute left-3 top-1/2 -translate-y-1/2 w-9 h-9 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center backdrop-blur-sm transition-colors">
              <ChevronLeft className="w-5 h-5" />
            </button>
            <button type="button" onClick={next} aria-label="Siguiente"
              className="absolute right-3 top-1/2 -translate-y-1/2 w-9 h-9 rounded-full bg-black/50 hover:bg-black/70 text-white flex items-center justify-center backdrop-blur-sm transition-colors">
              <ChevronRight className="w-5 h-5" />
            </button>
          </>
        )}
      </div>

      {/* Dots */}
      {hasMultiple && (
        <div className="flex items-center justify-center gap-2 mt-4">
          {images.map((_, i) => (
            <button key={i} type="button" onClick={() => setCurrent(i)}
              className={`rounded-full transition-all duration-200 ${i === current ? "w-6 h-2.5 bg-primary" : "w-2.5 h-2.5 bg-muted-foreground/30 hover:bg-muted-foreground/60"
                }`} />
          ))}
        </div>
      )}

      {/* Thumbnails para 3+ */}
      {images.length >= 3 && (
        <div className="flex gap-2 mt-4 overflow-x-auto pb-1">
          {images.map((src, i) => (
            <button key={i} type="button" onClick={() => setCurrent(i)}
              className={`flex-shrink-0 w-20 h-14 rounded-lg overflow-hidden border-2 transition-all ${i === current ? "border-primary ring-2 ring-primary/30" : "border-transparent hover:border-border"
                }`}>
              <img src={src} alt={`Miniatura ${i + 1}`} className="w-full h-full object-cover"
                onError={(e) => { (e.target as HTMLImageElement).src = "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=160&h=112&fit=crop"; }} />
            </button>
          ))}
        </div>
      )}
    </div>
  );
}

// ─── ProductDetail ────────────────────────────────────────────────────────────
export function ProductDetail() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { usuario } = useAuthContext();
  const [agregando, setAgregando] = useState(false);
  const [alertaExistente, setAlertaExistente] = useState<ProductoDeseado | undefined>();
  const [modalOpen, setModalOpen] = useState(false);

  const { data: producto, loading, error } = useFetch(
    (signal) => productosService.get(Number(id), signal),
    [id]
  );

  const getStock = (producto: Partial<Producto> | null | undefined): number =>
    producto?.cantidad ?? 0;

  // Cargar alerta existente si el usuario está logueado
  useEffect(() => {
    if (!usuario?.id || !id) return;
    productosDeseadosService.listar(usuario.id).then((alertas) => {
      const alerta = alertas.find((a) => a.id_producto === Number(id));
      setAlertaExistente(alerta);
    }).catch(() => { });
  }, [usuario?.id, id]);

  if (loading) return (
    <div className="min-h-screen flex items-center justify-center text-muted-foreground">
      <Loader2 className="w-5 h-5 animate-spin mr-2" /> Cargando producto…
    </div>
  );

  if (error || !producto) return (
    <div className="min-h-screen flex flex-col items-center justify-center gap-4 text-center px-4">
      <Gamepad2 className="w-16 h-16 text-muted-foreground/40" />
      <h2>Producto no encontrado</h2>
      <p className="text-muted-foreground">El producto que buscas no existe o fue eliminado.</p>
      <Button onClick={() => navigate("/")} className="bg-primary hover:bg-primary/90">
        <ArrowLeft className="w-4 h-4 mr-2" />Volver a la tienda
      </Button>
    </div>
  );

  // Precio para el país del usuario
  const precioMatch = usuario?.id_pais
    ? producto.precios?.find((p) => p.id_pais === usuario.id_pais)
    : null;
  const precioNum = precioMatch && Number(precioMatch.precio) > 0 ? Number(precioMatch.precio) : null;
  const stock = getStock(producto);
  const agotado = stock === 0;
  const noDisponible = precioNum === null || agotado;

  const images = producto.imagenes?.length
    ? producto.imagenes.map((img) => img.ruta)
    : ["https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800&h=600&fit=crop"];

  const handleAgregar = async () => {
    if (!usuario || noDisponible) return;
    setAgregando(true);
    try {
      await carritoService.add(producto.id, usuario.id);
      navigate("/checkout");
    } catch (err) {
      console.error(err);
    } finally {
      setAgregando(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-background to-muted/20">
      {/* Breadcrumb */}
      <div className="sticky top-0 z-10 bg-background/80 backdrop-blur-md border-b border-border px-4 sm:px-8 py-3 flex items-center gap-3">
        <button type="button" onClick={() => navigate("/")}
          className="flex items-center gap-1.5 text-sm text-muted-foreground hover:text-foreground transition-colors">
          <ArrowLeft className="w-4 h-4" />
          Volver a la tienda
        </button>
        <span className="text-muted-foreground/40 hidden sm:block">/</span>
        <span className="text-sm text-muted-foreground hidden sm:block truncate max-w-xs">
          {producto.nombre}
        </span>
      </div>

      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div className="grid grid-cols-1 lg:grid-cols-[1fr_420px] gap-10 xl:gap-16 items-start">

          {/* Carrusel */}
          <ImageCarousel images={images} title={producto.nombre} />

          {/* Detalle */}
          <div className="flex flex-col gap-5">

            {/* Badges */}
            <div className="flex flex-wrap items-center gap-2">
              <Badge className="bg-accent text-accent-foreground flex items-center gap-1">
                <Tag className="w-3 h-3" />
                Producto
              </Badge>
              {noDisponible && (
                <Badge variant="outline" className="text-destructive border-destructive/40">
                  No disponible en tu región
                </Badge>
              )}{agotado && (
                <Badge variant="destructive">
                  Agotado
                </Badge>
              )}
            </div>

            {/* Título */}
            <h1 className="leading-tight">{producto.nombre}</h1>

            <Separator />

            {/* Descripción */}
            <p className="text-sm leading-relaxed text-muted-foreground">
              {producto.descripcion}
            </p>

            {/* Chips de info */}
            <div className="flex flex-wrap gap-2">
              <div className="flex items-center gap-1.5 text-xs bg-muted rounded-lg px-3 py-1.5">
                <Package className="w-3.5 h-3.5 text-muted-foreground" />
                <span>
                  {images.length} {images.length === 1 ? "imagen" : "imágenes"}
                </span>
              </div>
              {producto.precios && producto.precios.length > 0 && (
                <div className="flex items-center gap-1.5 text-xs bg-muted rounded-lg px-3 py-1.5">
                  <Gamepad2 className="w-3.5 h-3.5 text-primary" />
                  <span>{producto.precios.length} {producto.precios.length === 1 ? "región" : "regiones"}</span>
                </div>
              )}
            </div>

            <Separator />

            {/* Precio */}
            <div className="flex items-end gap-3">
              <span className={`text-4xl ${noDisponible ? "text-muted-foreground" : "text-primary"}`}>
                {noDisponible ? "—" : formatPrecio(precioNum!)}
              </span>
              {noDisponible && (
                <span className="text-sm text-muted-foreground mb-1">
                  Sin precio para tu región
                </span>
              )}
            </div>

            {/* Botones */}
            <div className="flex gap-3">
              <Button size="lg" onClick={handleAgregar}
                disabled={noDisponible || agregando}
                className="flex-1 bg-secondary hover:bg-secondary/90 disabled:opacity-60">
                <ShoppingCart className="w-5 h-5 mr-2" />
                {agregando ? "Añadiendo..." : agotado ? "Agotado" : noDisponible ? "No disponible" : "Añadir al carrito"}
              </Button>

              {usuario && (
                <Button size="lg" variant="outline" onClick={() => setModalOpen(true)}
                  className={`flex-shrink-0 ${alertaExistente
                    ? "border-primary text-primary bg-primary/10 hover:bg-primary/20"
                    : "hover:border-primary/60"
                    }`}>
                  {/* Bell inline para no crear otro componente */}
                  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                    fill={alertaExistente ? "currentColor" : "none"} stroke="currentColor"
                    strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9" />
                    <path d="M10.3 21a1.94 1.94 0 0 0 3.4 0" />
                  </svg>
                </Button>
              )}
            </div>

            {alertaExistente && (
              <p className="text-xs text-primary text-center -mt-2">
                Alerta activa en {formatPrecio(alertaExistente.precio_objetivo)}
              </p>
            )}
          </div>
        </div>
      </div>

      {modalOpen && usuario && (
        <PriceAlertModal
          producto={producto}
          idUsuario={usuario.id}
          alertaExistente={alertaExistente}
          onClose={() => setModalOpen(false)}
          onSuccess={(alerta) => {
            setAlertaExistente(alerta ?? undefined);
            setModalOpen(false);
          }}
        />
      )}
    </div>
  );
}