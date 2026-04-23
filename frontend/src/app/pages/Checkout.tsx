import { useState } from "react";
import { useNavigate } from "react-router";
import { Card } from "../components/ui/card";
import { Button } from "../components/ui/button";
import { Label } from "../components/ui/label";
import { Badge } from "../components/ui/badge";
import { RadioGroup, RadioGroupItem } from "../components/ui/radio-group";
import { Separator } from "../components/ui/separator";
import { Wallet, Trash2, ArrowLeft, Minus, Package, Infinity, Star } from "lucide-react";
import { useStore } from "../data/store-context";

// Mock cart items
const mockCartItems = [
  {
    id: "1",
    title: "Cyber Warriors 2077",
    price: 59.99,
    image:
      "https://images.unsplash.com/flagged/photo-1572383761657-4919d351d433?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjeWJlcnB1bmslMjBmdXR1cmlzdGljJTIwZ2FtZSUyMGNvdmVyfGVufDF8fHx8MTc3MTI5NTQzOHww&ixlib=rb-4.1.0&q=80&w=1080",
    quantity: 1,
  },
  {
    id: "2",
    title: "Fantasy Realms",
    price: 49.99,
    image:
      "https://images.unsplash.com/photo-1562576650-27130b06c0ab?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmYW50YXN5JTIwbWVkaWV2YWwlMjBnYW1lJTIwY292ZXJ8ZW58MXx8fHwxNzcxMjk1NDM5fDA&ixlib=rb-4.1.0&q=80&w=1080",
    quantity: 1,
  },
];

export function Checkout() {
  const navigate = useNavigate();
  const store = useStore();
  const [cartItems, setCartItems] = useState(mockCartItems);
  const [onHoldItems, setOnHoldItems] = useState<string[]>([]);
  const [paymentMethod, setPaymentMethod] = useState("paypal");
  const [paymentCountry, setPaymentCountry] = useState("internacional");

  const activeCountries = store.getActiveCountries();

  // Build country options including "internacional"
  const countryOptions = [
    ...activeCountries.map((c) => ({
      code: c.code,
      label: `${c.flag} ${c.name}`,
    })),
    { code: "internacional", label: "\u{1F30E} Internacional" },
  ];

  const countryNames: Record<string, string> = {};
  activeCountries.forEach((c) => (countryNames[c.code] = c.name));
  countryNames["internacional"] = "Internacional";

  const currentPaymentMethods = store.getActivePaymentMethods(paymentCountry);

  const handleCountryChange = (country: string) => {
    setPaymentCountry(country);
    const methods = store.getActivePaymentMethods(country);
    if (methods.length > 0) {
      setPaymentMethod(methods[0].value);
    }
  };

  const toggleOnHold = (id: string) => {
    setOnHoldItems((prev) =>
      prev.includes(id) ? prev.filter((i) => i !== id) : [...prev, id]
    );
  };

  const activeItems = cartItems.filter((item) => !onHoldItems.includes(item.id));
  const holdItems = cartItems.filter((item) => onHoldItems.includes(item.id));

  const subtotal = activeItems.reduce(
    (sum, item) => sum + item.price * item.quantity,
    0
  );
  const tax = subtotal * 0.1;
  const total = subtotal + tax;

  const removeItem = (id: string) => {
    setCartItems(cartItems.filter((item) => item.id !== id));
    setOnHoldItems(onHoldItems.filter((i) => i !== id));
  };

  const handleCheckout = (e: React.FormEvent) => {
    e.preventDefault();
    console.log("Processing checkout...", { paymentMethod, total });
    alert("¡Compra realizada con éxito!");
    navigate("/");
  };

  // Helper to get stock for a cart item
  const getGameStock = (gameId: string) => {
    const game = store.games.find((g) => g.id === gameId);
    return game ? game.stock : "unlimited";
  };

  // Helper to get seller for a cart item
  const getGameSeller = (gameId: string) => {
    const game = store.games.find((g) => g.id === gameId);
    if (!game?.sellerId) return undefined;
    return store.getSeller(game.sellerId);
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-background to-muted/20 py-8">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="mb-8">
          <Button
            variant="ghost"
            onClick={() => navigate("/")}
            className="mb-4"
          >
            <ArrowLeft className="w-4 h-4 mr-2" />
            Volver a la tienda
          </Button>
          <h1 className="mb-2">Finalizar Compra</h1>
          <p className="text-muted-foreground">
            Revisa tu pedido y completa el pago
          </p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Cart Items */}
          <div className="lg:col-span-2 space-y-4">
            <Card className="p-6">
              <h2 className="mb-4">Productos en el Carrito</h2>
              <div className="space-y-4">
                {cartItems.length === 0 ? (
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
                                src={item.image}
                                alt={item.title}
                                className="w-24 h-24 object-cover rounded"
                              />
                              <div className="flex-1">
                                <h3 className="mb-1">{item.title}</h3>
                                {/* Seller info */}
                                {seller && (
                                  <div className="flex items-center gap-2 mb-2 py-1.5 px-2.5 rounded-md bg-background/60 border border-border/50 w-fit">
                                    <img
                                      src={seller.avatar}
                                      alt={seller.displayName}
                                      className="w-5 h-5 rounded-full object-cover ring-1 ring-amber-400/40 flex-shrink-0"
                                      onError={(e) => {
                                        (e.target as HTMLImageElement).src =
                                          "https://ui-avatars.com/api/?name=" + encodeURIComponent(seller.displayName) + "&size=20";
                                      }}
                                    />
                                    <span className="text-xs text-muted-foreground">{seller.displayName}</span>
                                    <span className="flex items-center gap-0.5">
                                      {[1,2,3,4,5].map((i) => (
                                        <Star key={i} className={`w-3 h-3 ${i <= Math.floor(seller.rating) ? "fill-amber-400 text-amber-400" : i === Math.floor(seller.rating)+1 && seller.rating - Math.floor(seller.rating) >= 0.5 ? "fill-amber-400/50 text-amber-400" : "fill-muted text-muted-foreground/30"}`} />
                                      ))}
                                    </span>
                                    <span className="text-xs text-amber-500">{seller.rating.toFixed(1)}</span>
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
                                <p className="text-lg text-primary">
                                  ${item.price.toFixed(2)}
                                </p>
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
                          <h3 className="text-sm mb-4 text-muted-foreground">
                            En Espera
                          </h3>
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
                                    className="w-24 h-24 object-cover rounded grayscale opacity-60"
                                  />
                                  <div className="flex-1">
                                    <h3 className="mb-1 line-through text-muted-foreground">
                                      {item.title}
                                    </h3>
                                    {/* Seller info (muted) */}
                                    {seller && (
                                      <div className="flex items-center gap-2 mb-2 py-1.5 px-2.5 rounded-md bg-background/40 border border-border/30 w-fit opacity-50">
                                        <img
                                          src={seller.avatar}
                                          alt={seller.displayName}
                                          className="w-5 h-5 rounded-full object-cover flex-shrink-0"
                                          onError={(e) => {
                                            (e.target as HTMLImageElement).src =
                                              "https://ui-avatars.com/api/?name=" + encodeURIComponent(seller.displayName) + "&size=20";
                                          }}
                                        />
                                        <span className="text-xs text-muted-foreground">{seller.displayName}</span>
                                        <span className="flex items-center gap-0.5">
                                          {[1,2,3,4,5].map((i) => (
                                            <Star key={i} className={`w-3 h-3 ${i <= Math.floor(seller.rating) ? "fill-amber-400 text-amber-400" : "fill-muted text-muted-foreground/30"}`} />
                                          ))}
                                        </span>
                                        <span className="text-xs text-amber-500">{seller.rating.toFixed(1)}</span>
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
                    className="flex h-9 w-full items-center justify-between rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
                  >
                    {countryOptions.map((opt) => (
                      <option key={opt.code} value={opt.code}>
                        {opt.label}
                      </option>
                    ))}
                  </select>
                </div>

                <Separator className="mb-4" />

                <h3 className="text-sm text-muted-foreground mb-4">
                  {countryNames[paymentCountry] || paymentCountry}
                </h3>

                {currentPaymentMethods.length === 0 ? (
                  <p className="text-sm text-muted-foreground text-center py-4">
                    No hay métodos de pago configurados para este país
                  </p>
                ) : (
                  <RadioGroup
                    value={paymentMethod}
                    onValueChange={setPaymentMethod}
                  >
                    <div className="space-y-3">
                      {currentPaymentMethods.map((method) => (
                        <label
                          key={method.id}
                          className="flex items-center gap-3 p-4 rounded-lg border cursor-pointer hover:bg-muted/50 transition-colors"
                        >
                          <RadioGroupItem
                            value={method.value}
                            id={method.value}
                          />
                          <Wallet className="w-5 h-5 text-primary" />
                          <div className="flex-1">
                            <p>{method.name}</p>
                            <p className="text-sm text-muted-foreground">
                              {method.description}
                            </p>
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
                  <span className="text-muted-foreground">
                    Impuestos (10%)
                  </span>
                  <span>${tax.toFixed(2)}</span>
                </div>
                <Separator />
                <div className="flex justify-between">
                  <span>Total</span>
                  <span className="text-xl text-primary">
                    ${total.toFixed(2)}
                  </span>
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
    </div>
  );
}