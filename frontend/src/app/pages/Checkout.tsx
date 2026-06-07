import { useState, useEffect } from "react";
import { useNavigate } from "react-router";
import { Card } from "../components/ui/card";
import { Button } from "../components/ui/button";
import { Label } from "../components/ui/label";
import { Badge } from "../components/ui/badge";
import { RadioGroup, RadioGroupItem } from "../components/ui/radio-group";
import { Separator } from "../components/ui/separator";
import { Wallet, Trash2, ArrowLeft, Minus, Package, Infinity, Loader2 } from "lucide-react";
import { paisesService, metodosPagoService } from "../services";
import { useAuthContext } from "../contexts/AuthContext";
import { carritoService } from "../services/carrito.service";
import { useFetch } from "../hooks/useFetch";
import { pagosService } from "../services/pagos.service";


// Shape used by the existing rendering code below.
type CartItem = {
  id: string;       // id del registro tbl_carrito (usado para DELETE)
  title: string;
  price: number;
  image: string;
  quantity: number;
};

// Shape real que devuelve GET /carrito?id_usuario=X
type CarritoBackendItem = {
  id: number;
  id_producto: number;
  id_usuario: number;
  producto: {
    id: number;
    nombre: string;
    descripcion: string;
    imagenes?: { ruta: string }[];
    precios?: { id_pais: number; precio: number }[];
  };
};

const PLACEHOLDER_IMG =
  'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&h=400&fit=crop';

function carritoItemToCartItem(c: CarritoBackendItem, id_pais?: number): CartItem {
  // Precio según país del usuario — fallback 0 si no existe
  const precioMatch = id_pais
    ? c.producto?.precios?.find((p) => p.id_pais === id_pais)
    : undefined;
  const precio = precioMatch ? Number(precioMatch.precio) : 0;

  return {
    id: String(c.id),
    title: c.producto?.nombre ?? 'Producto',
    price: precio,
    image: c.producto?.imagenes?.[0]?.ruta ?? PLACEHOLDER_IMG,
    quantity: 1,
  };
}

export function Checkout() {
  const navigate = useNavigate();
  const { usuario, loading: authLoading } = useAuthContext();

  const [cartItems, setCartItems] = useState<CartItem[]>([]);
  const [productosLoading, setProductosLoading] = useState(true);
  const [productosError, setProductosError] = useState<Error | null>(null);

  useEffect(() => {
    if (!usuario) {
      setProductosLoading(false);
      return;
    }

    setProductosLoading(true);

    carritoService
      .getByUsuario(usuario.id)
      .then((data) => {
        setCartItems(
          (data as CarritoBackendItem[]).map((item) =>
            carritoItemToCartItem(item, usuario.id_pais)
          )
        );
      })
      .catch((err: unknown) => {
        console.error(err);

        setProductosError(
          err instanceof Error
            ? err
            : new Error("Error cargando carrito")
        );
      })
      .finally(() => {
        setProductosLoading(false);
      });
  }, [usuario]);

  const [onHoldItems, setOnHoldItems] = useState<string[]>([]);
  const [paymentMethod, setPaymentMethod] = useState("");
  const [paymentCountry, setPaymentCountry] = useState("");
  const [showQrModal, setShowQrModal] = useState(false);
  const [qrImage, setQrImage] = useState("");

  const getErrorMessage = (error: unknown) => {
    if (error instanceof Error) return error.message;
    if (typeof error === "object" && error !== null && "message" in error) {
      return String((error as { message?: unknown }).message);
    }
    if (typeof error === "string") return error;
    return "Error desconocido";
  };

  // Backend-driven Pais list for the country selector.
  const {
    data: backendPaises,
    loading: paisesLoading,
    error: paisesError,
  } = useFetch((signal) => paisesService.list(signal), []);

  // Backend-driven MetodoPago list.
  const {
    data: backendMetodos,
    loading: metodosLoading,
    error: metodosError,
  } = useFetch((signal) => metodosPagoService.list(signal), []);

  // Default the paymentCountry to the first available backend country.
  useEffect(() => {
    if (!paymentCountry && backendPaises && backendPaises.length > 0) {
      setPaymentCountry(String(backendPaises[0].id));
    }
  }, [backendPaises, paymentCountry]);

  // Default the paymentMethod to the first available backend method.
  useEffect(() => {
    if (!paymentMethod && backendMetodos && backendMetodos.length > 0) {
      setPaymentMethod(String(backendMetodos[0].id));
    }
  }, [backendMetodos, paymentMethod]);

  const selectedCountryName =
    backendPaises?.find((c) => String(c.id) === paymentCountry)?.nombre ?? "";

  const selectedPaymentMethod =
    backendMetodos?.find(
      (m) => String(m.id) === paymentMethod
    );

  const handleCountryChange = (country: string) => {
    setPaymentCountry(country);
  };

  const toggleOnHold = (id: string) => {
    setOnHoldItems((prev) =>
      prev.includes(id) ? prev.filter((i) => i !== id) : [...prev, id],
    );
  };

  const activeItems = cartItems.filter((item) => !onHoldItems.includes(item.id));
  const holdItems = cartItems.filter((item) => onHoldItems.includes(item.id));

  const subtotal = activeItems.reduce((sum, item) => sum + item.price * item.quantity, 0);
  const tax = subtotal * 0.1;
  const total = subtotal + tax;

  const removeItem = async (id: string) => {
    try {
      await carritoService.remove(Number(id));

      setCartItems((prev) =>
        prev.filter((item) => item.id !== id)
      );

      setOnHoldItems((prev) =>
        prev.filter((i) => i !== id)
      );
    } catch (err) {
      console.error("Error eliminando item:", err);
    }
  };

  const handleCheckout = (e: React.FormEvent) => {
    e.preventDefault();

    if (!selectedPaymentMethod) {
      alert("Selecciona un método de pago");
      return;
    }

    const fileName = selectedPaymentMethod.nombre
      .toLowerCase()
      .trim()
      .replace(/\s+/g, "");

    setQrImage(`/qrs/${fileName}.png`);
    setShowQrModal(true);
  };

  // Stock and seller info are not yet available on the backend Producto model.
  // These helpers return safe defaults so the UI renders without errors.
  const getGameStock = (_gameId: string): "unlimited" | number => "unlimited";
  const getGameSeller = (_gameId: string) => undefined;

  {/**aqui */ }
  if (authLoading || productosLoading)
    return <div className="flex items-center text-sm text-muted-foreground"><Loader2 className="w-4 h-4 mr-2 animate-spin" />Cargando carrito...</div>;

  if (!usuario)
    return <div className="flex items-center text-sm text-muted-foreground">Debes iniciar sesión.</div>;

  if (productosError)
    return <div className="flex items-center text-sm text-destructive">Error cargando carrito.</div>;

  if (cartItems.length === 0)
    return <div className="flex items-center text-sm text-muted-foreground">Tu carrito está vacío.</div>;

  return (
    <div className="min-h-screen bg-gradient-to-b from-background to-muted/20 py-8">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="mb-8">
          <Button variant="ghost" onClick={() => navigate("/")} className="mb-4">
            <ArrowLeft className="w-4 h-4 mr-2" />
            Volver a la tienda
          </Button>
          <h1 className="mb-2">Finalizar Compra</h1>
          <p className="text-muted-foreground">Revisa tu pedido y completa el pago</p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Cart Items */}
          <div className="lg:col-span-2 space-y-4">
            <Card className="p-6">
              <h2 className="mb-4">Productos en el Carrito</h2>
              <div className="space-y-4">
                {productosLoading ? (
                  <div className="flex items-center justify-center py-8 text-muted-foreground">
                    <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                    Cargando productos…
                  </div>
                ) : productosError ? (
                  <p className="text-center py-8 text-destructive">
                    No se pudieron cargar los productos: {getErrorMessage(productosError)}
                  </p>
                ) : cartItems.length === 0 ? (
                  <p className="text-center py-8 text-muted-foreground">
                    Tu carrito está vacío
                  </p>
                ) : (
                  <>
                    {/* Active Items */}
                    {activeItems.length > 0 && (
                      <div className="space-y-3">
                        {activeItems.map((item) => {
                          const itemStock = getGameStock(item.id);
                          const seller = getGameSeller(item.id);
                          return (
                            <div
                              key={item.id}
                              className="flex gap-4 p-4 rounded-lg bg-muted/50 hover:bg-muted transition-colors"
                            >
                              <img

                                /*src={
                                  producto.imagenes?.[0]?.ruta ??
                                  'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&h=400&fit=crop'
                                }*/
                                src={item.image} // asi estaba antes al parecer 
                                onError={(e) => {
                                  // fallback si el producto aún no tiene imagen local
                                  (e.target as HTMLImageElement).src =
                                    'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&h=400&fit=crop';
                                }}
                                alt={item.title}
                                className="w-24 h-24 object-cover object-center rounded flex-shrink-0"
                              />
                              <div className="flex-1">
                                <h3 className="mb-1">{item.title}</h3>
                                {seller && (
                                  <div className="flex items-center gap-2 mb-2 py-1.5 px-2.5 rounded-md bg-background/60 border border-border/50 w-fit">
                                    <span className="text-xs text-muted-foreground">
                                      {(seller as { nombre?: string }).nombre}
                                    </span>
                                  </div>
                                )}
                                <p className="text-sm text-muted-foreground mb-1">
                                  Cantidad: {item.quantity}
                                </p>
                                {/* Stock badge */}
                                <div className="flex items-center gap-1.5 mb-1">
                                  {itemStock === "unlimited" ? (
                                    <span className="flex items-center gap-1 text-xs text-accent">
                                      <Infinity className="w-3 h-3" />
                                      Disponible
                                    </span>
                                  ) : typeof itemStock === "number" && itemStock > 0 ? (
                                    <span className="flex items-center gap-1 text-xs text-muted-foreground">
                                      <Package className="w-3 h-3" />
                                      {itemStock} en stock
                                    </span>
                                  ) : (
                                    <Badge variant="destructive" className="text-xs">
                                      Agotado
                                    </Badge>
                                  )}
                                </div>
                                <p className="text-lg text-primary">${item.price.toFixed(2)}</p>
                              </div>
                              <div className="flex gap-2 self-start">
                                <Button
                                  variant="ghost"
                                  size="icon"
                                  onClick={() => toggleOnHold(item.id)}
                                  className="hover:bg-muted"
                                  title="Poner en espera"
                                >
                                  <Minus className="w-4 h-4 text-muted-foreground" />
                                </Button>
                                <Button
                                  variant="ghost"
                                  size="icon"
                                  onClick={() => removeItem(item.id)}
                                >
                                  <Trash2 className="w-4 h-4 text-destructive" />
                                </Button>
                              </div>
                            </div>
                          );
                        })}
                      </div>
                    )}

                    {/* On Hold Section */}
                    {holdItems.length > 0 && (
                      <>
                        <Separator className="my-6" />
                        <div>
                          <h3 className="text-sm mb-4 text-muted-foreground">En Espera</h3>
                          <div className="space-y-3">
                            {holdItems.map((item) => {
                              const itemStock = getGameStock(item.id);
                              const seller = getGameSeller(item.id);
                              return (
                                <div
                                  key={item.id}
                                  className="flex gap-4 p-4 rounded-lg bg-muted/30 transition-colors"
                                >
                                  <img
                                    src={item.image}
                                    alt={item.title}
                                    className="w-24 h-24 object-cover object-center rounded flex-shrink-0 grayscale opacity-60"
                                  />
                                  <div className="flex-1">
                                    <h3 className="mb-1 line-through text-muted-foreground">
                                      {item.title}
                                    </h3>
                                    {seller && (
                                      <div className="flex items-center gap-2 mb-2 py-1.5 px-2.5 rounded-md bg-background/40 border border-border/30 w-fit opacity-50">
                                        <span className="text-xs text-muted-foreground">
                                          {(seller as { nombre?: string }).nombre}
                                        </span>
                                      </div>
                                    )}
                                    <p className="text-sm text-muted-foreground mb-1 line-through">
                                      Cantidad: {item.quantity}
                                    </p>
                                    {/* Stock badge (muted) */}
                                    <div className="flex items-center gap-1.5 mb-1 opacity-50">
                                      {itemStock === "unlimited" ? (
                                        <span className="flex items-center gap-1 text-xs text-muted-foreground">
                                          <Infinity className="w-3 h-3" />
                                          Disponible
                                        </span>
                                      ) : typeof itemStock === "number" && itemStock > 0 ? (
                                        <span className="flex items-center gap-1 text-xs text-muted-foreground">
                                          <Package className="w-3 h-3" />
                                          {itemStock} en stock
                                        </span>
                                      ) : (
                                        <span className="text-xs text-muted-foreground">
                                          Agotado
                                        </span>
                                      )}
                                    </div>
                                    <p className="text-lg text-muted-foreground line-through">
                                      ${item.price.toFixed(2)}
                                    </p>
                                  </div>
                                  <div className="flex gap-2 self-start">
                                    <Button
                                      variant="ghost"
                                      size="icon"
                                      onClick={() => toggleOnHold(item.id)}
                                      className="hover:bg-muted"
                                      title="Activar"
                                    >
                                      <Minus className="w-4 h-4 text-muted-foreground/60" />
                                    </Button>
                                    <Button
                                      variant="ghost"
                                      size="icon"
                                      onClick={() => removeItem(item.id)}
                                    >
                                      <Trash2 className="w-4 h-4 text-destructive/60" />
                                    </Button>
                                  </div>
                                </div>
                              );
                            })}
                          </div>
                        </div>
                      </>
                    )}
                  </>
                )}
              </div>
            </Card>

            {/* Payment Method */}
            {cartItems.length > 0 && (
              <Card className="p-6">
                <h2 className="mb-4">Método de Pago</h2>

                {/* Country Selector */}
                <div className="mb-6 space-y-2">
                  <Label htmlFor="paymentCountry">País de Pago</Label>
                  <select
                    id="paymentCountry"
                    value={paymentCountry}
                    onChange={(e) => handleCountryChange(e.target.value)}
                    disabled={paisesLoading || !!paisesError}
                    className="flex h-9 w-full items-center justify-between rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
                  >
                    {paisesLoading && <option value="">Cargando países…</option>}
                    {paisesError && (
                      <option value="">Error: {getErrorMessage(paisesError)}</option>
                    )}
                    {!paisesLoading && !paisesError && (!backendPaises || backendPaises.length === 0) && (
                      <option value="">Sin países configurados</option>
                    )}
                    {!paisesLoading &&
                      !paisesError &&
                      backendPaises?.map((opt) => (
                        <option key={opt.id} value={String(opt.id)}>
                          {opt.nombre}
                        </option>
                      ))}
                  </select>
                </div>

                <Separator className="mb-4" />

                <h3 className="text-sm text-muted-foreground mb-4">
                  {selectedCountryName || "Selecciona un país"}
                </h3>

                {metodosLoading ? (
                  <p className="text-sm text-muted-foreground text-center py-4">
                    Cargando métodos de pago…
                  </p>
                ) : metodosError ? (
                  <p className="text-sm text-destructive text-center py-4">
                    No se pudieron cargar los métodos: {getErrorMessage(metodosError)}
                  </p>
                ) : !backendMetodos || backendMetodos.length === 0 ? (
                  <p className="text-sm text-muted-foreground text-center py-4">
                    No hay métodos de pago configurados
                  </p>
                ) : (
                  <RadioGroup value={paymentMethod} onValueChange={setPaymentMethod}>
                    <div className="space-y-3">
                      {backendMetodos.map((method) => (
                        <label
                          key={method.id}
                          className="flex items-center gap-3 p-4 rounded-lg border cursor-pointer hover:bg-muted/50 transition-colors"
                        >
                          <RadioGroupItem
                            value={String(method.id)}
                            id={`metodo-${method.id}`}
                          />
                          <Wallet className="w-5 h-5 text-primary" />
                          <div className="flex-1">
                            <p>{method.nombre}</p>
                          </div>
                        </label>
                      ))}
                    </div>
                  </RadioGroup>
                )}
              </Card>
            )}
          </div>

          {/* Order Summary */}
          <div className="lg:col-span-1">
            <Card className="p-6 sticky top-4">
              <h2 className="mb-4">Resumen del Pedido</h2>
              <div className="space-y-3 mb-4">
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Subtotal</span>
                  <span>${subtotal.toFixed(2)}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-muted-foreground">Impuestos (10%)</span>
                  <span>${tax.toFixed(2)}</span>
                </div>
                <Separator />
                <div className="flex justify-between">
                  <span>Total</span>
                  <span className="text-xl text-primary">${total.toFixed(2)}</span>
                </div>
              </div>

              <Button
                className="w-full bg-primary hover:bg-primary/90"
                onClick={handleCheckout}
                disabled={cartItems.length === 0}
              >
                Completar Compra
              </Button>

              <div className="mt-6 p-4 bg-muted/50 rounded-lg">
                <h3 className="text-sm mb-2">Compra Segura</h3>
                <ul className="text-xs text-muted-foreground space-y-1">
                  <li>✓ Pago encriptado SSL</li>
                  <li>✓ Garantía de devolución 30 días</li>
                  <li>✓ Soporte 24/7</li>
                </ul>
              </div>
            </Card>
          </div>
        </div>
      </div>
      {showQrModal && (
        <div className="fixed inset-0 z-50 bg-black/70 flex items-center justify-center">
          <div className="bg-background rounded-xl p-6 shadow-xl max-w-md w-full mx-4">
            <h3 className="text-xl text-center mb-4">
              Escanea el código QR
            </h3>

            <img
              src={qrImage}
              alt="Código QR de pago"
              className="w-72 h-72 object-contain mx-auto"
            />

            <p className="text-sm text-muted-foreground text-center mt-4">
              Completa el pago y luego confirma.
            </p>

            <Button
              className="w-full mt-6"
              onClick={async () => {
                try {
                  const metodoSeleccionado =
                    backendMetodos?.find(
                      (m) => String(m.id) === paymentMethod
                    );

                  await pagosService.reportar({
                    id_usuario: usuario.id,
                    metodo_pago:
                      metodoSeleccionado?.nombre ?? "Desconocido",
                    total,
                  });

                  setShowQrModal(false);

                  alert(
                    "Pago reportado correctamente. Será validado por un administrador."
                  );

                  navigate("/");
                } catch (err) {
                  console.error(err);

                  alert(
                    "No se pudo reportar el pago. Inténtalo nuevamente."
                  );
                }
              }}
            >
              Ya realicé la transferencia
            </Button>

            <Button
              variant="outline"
              className="w-full mt-2"
              onClick={() => setShowQrModal(false)}
            >
              Cancelar
            </Button>
          </div>
        </div>
      )}
    </div>
  );
}
