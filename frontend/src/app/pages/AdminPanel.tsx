import { useState } from "react";
import { Button } from "../components/ui/button";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";
import { Textarea } from "../components/ui/textarea";
import { Badge } from "../components/ui/badge";
import { AdminExpandableCard } from "../components/AdminExpandableCard";
import { useStore } from "../data/store-context";
import { useFetch } from "../hooks/useFetch";
import { productosService } from "../services";
import {
  Plus,
  Upload,
  Gamepad2,
  Globe,
  Tag,
  Wallet,
  Percent,
  Pencil,
  Trash2,
  Archive,
  ArchiveRestore,
  Infinity,
  Package,
  X,
  Check,
  Users,
  Search,
  Star,
  UserPlus,
} from "lucide-react";

// ─── Reusable sub-tab component ─────────────────────────────────────────
function SubTabs({
  tabs,
  active,
  onChange,
}: {
  tabs: { key: string; label: string }[];
  active: string;
  onChange: (k: string) => void;
}) {
  return (
    <div className="flex gap-1 bg-muted/50 rounded-lg p-1 mb-5">
      {tabs.map((t) => (
        <button
          key={t.key}
          type="button"
          onClick={() => onChange(t.key)}
          className={`flex-1 py-2 px-3 rounded-md text-sm transition-colors cursor-pointer ${
            active === t.key
              ? "bg-white shadow-sm text-foreground"
              : "text-muted-foreground hover:text-foreground"
          }`}
        >
          {t.label}
        </button>
      ))}
    </div>
  );
}

// ─── Star rating mini display ────────────────────────────────────────────
function StarRatingDisplay({ rating }: { rating: number }) {
  return (
    <span className="flex items-center gap-0.5">
      {[1, 2, 3, 4, 5].map((i) => (
        <Star
          key={i}
          className={`w-3 h-3 ${
            i <= Math.floor(rating)
              ? "fill-amber-400 text-amber-400"
              : i === Math.floor(rating) + 1 && rating - Math.floor(rating) >= 0.5
              ? "fill-amber-400/50 text-amber-400"
              : "fill-muted text-muted-foreground/30"
          }`}
        />
      ))}
      <span className="text-xs text-amber-500 ml-0.5">{rating.toFixed(1)}</span>
    </span>
  );
}

// ─── PRODUCTS SECTION ───────────────────────────────────────────────────
function ProductsSection() {
  const store = useStore();
  const [tab, setTab] = useState("add");
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editTitle, setEditTitle] = useState("");
  const [editDesc, setEditDesc] = useState("");

  // Add form state
  const emptyPrices: Record<string, string> = {};
  store.countries.forEach((c) => (emptyPrices[c.code] = ""));

  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [prices, setPrices] = useState<Record<string, string>>(emptyPrices);
  const [category, setCategory] = useState("");
  const [image, setImage] = useState("");
  const [stock, setStock] = useState("");
  const [unlimitedStock, setUnlimitedStock] = useState(false);
  const [sellerId, setSellerId] = useState("");

  const resetForm = () => {
    setTitle("");
    setDescription("");
    const fresh: Record<string, string> = {};
    store.countries.forEach((c) => (fresh[c.code] = ""));
    setPrices(fresh);
    setCategory("");
    setImage("");
    setStock("");
    setUnlimitedStock(false);
    setSellerId("");
  };

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    const numPrices: Record<string, number> = {};
    Object.keys(prices).forEach((k) => (numPrices[k] = parseFloat(prices[k]) || 0));
    store.addGame({
      title,
      description,
      prices: numPrices,
      category,
      image,
      releaseDate: new Date().toISOString().split("T")[0],
      stock: unlimitedStock ? "unlimited" : parseInt(stock) || 0,
      sellerId: sellerId || undefined,
    });
    resetForm();
  };

  const startEdit = (g: { id: string; title: string; description: string }) => {
    setEditingId(g.id);
    setEditTitle(g.title);
    setEditDesc(g.description);
  };
  const saveEdit = () => {
    if (editingId) {
      store.updateGame(editingId, { title: editTitle, description: editDesc });
      setEditingId(null);
    }
  };

  return (
    <>
      <SubTabs
        tabs={[
          { key: "add", label: "Agregar" },
          { key: "manage", label: "Administrar" },
        ]}
        active={tab}
        onChange={setTab}
      />

      {tab === "add" && (
        <form onSubmit={handleAdd} className="space-y-5">
          <div className="space-y-2">
            <Label>Título del Juego *</Label>
            <Input value={title} onChange={(e) => setTitle(e.target.value)} placeholder="Ej: The Legend of Zelda" required />
          </div>
          <div className="space-y-2">
            <Label>Descripción *</Label>
            <Textarea value={description} onChange={(e) => setDescription(e.target.value)} placeholder="Describe el juego..." rows={3} required />
          </div>

          {/* Seller */}
          <div className="space-y-2">
            <Label>Vendedor</Label>
            <select
              value={sellerId}
              onChange={(e) => setSellerId(e.target.value)}
              className="flex h-9 w-full rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
            >
              <option value="">Sin vendedor asignado</option>
              {store.getActiveSellers().map((s) => (
                <option key={s.id} value={s.id}>@{s.username} — {s.displayName}</option>
              ))}
            </select>
          </div>

          {/* Stock */}
          <div className="space-y-2">
            <Label>Stock *</Label>
            <div className="flex gap-2">
              <Input
                type="number"
                min="0"
                value={unlimitedStock ? "" : stock}
                onChange={(e) => setStock(e.target.value)}
                placeholder={unlimitedStock ? "Ilimitado" : "Cantidad"}
                disabled={unlimitedStock}
                className="flex-1"
              />
              <Button
                type="button"
                variant={unlimitedStock ? "default" : "outline"}
                onClick={() => setUnlimitedStock(!unlimitedStock)}
                className={unlimitedStock ? "bg-accent hover:bg-accent/90" : ""}
              >
                <Infinity className="w-4 h-4 mr-1" />
                Ilimitado
              </Button>
            </div>
          </div>

          {/* Category */}
          <div className="space-y-2">
            <Label>Categoría *</Label>
            <select
              value={category}
              onChange={(e) => setCategory(e.target.value)}
              required
              className="flex h-9 w-full rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
            >
              <option value="">Selecciona una categoría</option>
              {store.getActiveCategories().map((c) => (
                <option key={c.id} value={c.name}>{c.name}</option>
              ))}
            </select>
          </div>

          {/* Prices */}
          <div className="space-y-3">
            <div className="border-b pb-2">
              <h4 className="text-[0.95rem]">Precios por País *</h4>
              <p className="text-sm text-muted-foreground">Moneda local de cada país</p>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
              {store.countries.map((c) => (
                <div key={c.code} className="space-y-1">
                  <Label className="text-sm">{c.flag} {c.name} ({c.currency})</Label>
                  <Input
                    type="number"
                    step="0.01"
                    min="0"
                    value={prices[c.code] || ""}
                    onChange={(e) => setPrices({ ...prices, [c.code]: e.target.value })}
                    placeholder="0"
                    required
                  />
                </div>
              ))}
            </div>
          </div>

          {/* Image */}
          <div className="space-y-2">
            <Label>URL de la Imagen *</Label>
            <div className="flex gap-2">
              <Input type="url" value={image} onChange={(e) => setImage(e.target.value)} placeholder="https://example.com/image.jpg" required className="flex-1" />
              <Button type="button" variant="outline" size="icon"><Upload className="w-4 h-4" /></Button>
            </div>
            {image && (
              <div className="mt-2 p-2 border rounded-lg">
                <p className="text-sm text-muted-foreground mb-1">Vista previa:</p>
                <img src={image} alt="Preview" className="w-full max-w-xs h-32 object-cover rounded" onError={(e) => { (e.target as HTMLImageElement).src = "https://via.placeholder.com/300x200?text=Invalid"; }} />
              </div>
            )}
          </div>

          <div className="flex gap-3 pt-2">
            <Button type="submit" className="bg-primary hover:bg-primary/90">
              <Plus className="w-4 h-4 mr-1" /> Agregar Juego
            </Button>
            <Button type="button" variant="outline" onClick={resetForm}>Limpiar</Button>
          </div>
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-3">
          {store.games.length === 0 ? (
            <p className="text-center py-8 text-muted-foreground">No hay productos</p>
          ) : (
            store.games.map((g) => {
              const seller = g.sellerId ? store.getSeller(g.sellerId) : undefined;
              return (
                <div key={g.id} className={`flex items-center gap-3 p-3 rounded-lg border transition-colors ${g.archived ? "bg-muted/30 opacity-60" : "bg-muted/10 hover:bg-muted/30"}`}>
                  <img src={g.image} alt={g.title} className="w-14 h-14 rounded-lg object-cover flex-shrink-0" />
                  <div className="flex-1 min-w-0">
                    {editingId === g.id ? (
                      <div className="space-y-2">
                        <Input value={editTitle} onChange={(e) => setEditTitle(e.target.value)} className="h-8" />
                        <Input value={editDesc} onChange={(e) => setEditDesc(e.target.value)} className="h-8" />
                      </div>
                    ) : (
                      <>
                        <p className={`truncate ${g.archived ? "line-through text-muted-foreground" : ""}`}>{g.title}</p>
                        <div className="flex items-center gap-2 mt-1 flex-wrap">
                          <Badge variant="outline" className="text-xs">{g.category}</Badge>
                          <span className="text-xs text-muted-foreground">
                            Stock: {g.stock === "unlimited" ? "∞" : g.stock}
                          </span>
                          {seller && (
                            <span className="text-xs text-muted-foreground flex items-center gap-1">
                              <Users className="w-3 h-3" />
                              @{seller.username}
                            </span>
                          )}
                          {g.archived && <Badge variant="secondary" className="text-xs">Archivado</Badge>}
                        </div>
                      </>
                    )}
                  </div>
                  <div className="flex items-center gap-1 flex-shrink-0">
                    {editingId === g.id ? (
                      <>
                        <Button variant="ghost" size="icon" className="h-8 w-8" onClick={saveEdit}><Check className="w-4 h-4 text-accent" /></Button>
                        <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => setEditingId(null)}><X className="w-4 h-4" /></Button>
                      </>
                    ) : (
                      <>
                        <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => startEdit(g)}><Pencil className="w-3.5 h-3.5" /></Button>
                        <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => store.archiveGame(g.id)}>
                          {g.archived ? <ArchiveRestore className="w-3.5 h-3.5 text-accent" /> : <Archive className="w-3.5 h-3.5 text-muted-foreground" />}
                        </Button>
                        <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => store.deleteGame(g.id)}><Trash2 className="w-3.5 h-3.5 text-destructive" /></Button>
                      </>
                    )}
                  </div>
                </div>
              );
            })
          )}
        </div>
      )}
    </>
  );
}

// ─── CATEGORIES SECTION ─────────────────────────────────────────────────
function CategoriesSection() {
  const store = useStore();
  const [tab, setTab] = useState("add");
  const [name, setName] = useState("");
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editName, setEditName] = useState("");

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    if (name.trim()) {
      store.addCategory(name.trim());
      setName("");
    }
  };

  return (
    <>
      <SubTabs tabs={[{ key: "add", label: "Agregar" }, { key: "manage", label: "Administrar" }]} active={tab} onChange={setTab} />

      {tab === "add" && (
        <form onSubmit={handleAdd} className="flex gap-3">
          <Input value={name} onChange={(e) => setName(e.target.value)} placeholder="Nombre de la categoría" required className="flex-1" />
          <Button type="submit" className="bg-primary hover:bg-primary/90"><Plus className="w-4 h-4 mr-1" /> Agregar</Button>
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-2">
          {store.categories.length === 0 ? (
            <p className="text-center py-6 text-muted-foreground">No hay categorías</p>
          ) : (
            store.categories.map((c) => (
              <div key={c.id} className={`flex items-center gap-3 p-3 rounded-lg border ${c.archived ? "bg-muted/30 opacity-60" : "bg-muted/10 hover:bg-muted/30"}`}>
                <Tag className="w-4 h-4 text-primary flex-shrink-0" />
                {editingId === c.id ? (
                  <Input value={editName} onChange={(e) => setEditName(e.target.value)} className="flex-1 h-8" />
                ) : (
                  <span className={`flex-1 ${c.archived ? "line-through text-muted-foreground" : ""}`}>{c.name}</span>
                )}
                {c.archived && <Badge variant="secondary" className="text-xs">Archivado</Badge>}
                <div className="flex items-center gap-1">
                  {editingId === c.id ? (
                    <>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => { store.updateCategory(c.id, editName); setEditingId(null); }}><Check className="w-4 h-4 text-accent" /></Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => setEditingId(null)}><X className="w-4 h-4" /></Button>
                    </>
                  ) : (
                    <>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => { setEditingId(c.id); setEditName(c.name); }}><Pencil className="w-3.5 h-3.5" /></Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => store.archiveCategory(c.id)}>
                        {c.archived ? <ArchiveRestore className="w-3.5 h-3.5 text-accent" /> : <Archive className="w-3.5 h-3.5 text-muted-foreground" />}
                      </Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => store.deleteCategory(c.id)}><Trash2 className="w-3.5 h-3.5 text-destructive" /></Button>
                    </>
                  )}
                </div>
              </div>
            ))
          )}
        </div>
      )}
    </>
  );
}

// ─── COUNTRIES SECTION ──────────────────────────────────────────────────
function CountriesSection() {
  const store = useStore();
  const [tab, setTab] = useState("add");
  const [code, setCode] = useState("");
  const [name, setName] = useState("");
  const [flag, setFlag] = useState("");
  const [currency, setCurrency] = useState("");
  const [editingCode, setEditingCode] = useState<string | null>(null);
  const [editName, setEditName] = useState("");
  const [editCurrency, setEditCurrency] = useState("");

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    if (code && name && currency) {
      store.addCountry({ code: code.toLowerCase().trim(), name: name.trim(), flag: flag.trim() || "🏳️", currency: currency.toUpperCase().trim() });
      setCode(""); setName(""); setFlag(""); setCurrency("");
    }
  };

  return (
    <>
      <SubTabs tabs={[{ key: "add", label: "Agregar" }, { key: "manage", label: "Administrar" }]} active={tab} onChange={setTab} />

      {tab === "add" && (
        <form onSubmit={handleAdd} className="space-y-3">
          <div className="grid grid-cols-2 gap-3">
            <div className="space-y-1">
              <Label className="text-sm">Código *</Label>
              <Input value={code} onChange={(e) => setCode(e.target.value)} placeholder="ej: bolivia" required />
            </div>
            <div className="space-y-1">
              <Label className="text-sm">Nombre *</Label>
              <Input value={name} onChange={(e) => setName(e.target.value)} placeholder="Bolivia" required />
            </div>
            <div className="space-y-1">
              <Label className="text-sm">Bandera (emoji)</Label>
              <Input value={flag} onChange={(e) => setFlag(e.target.value)} placeholder="🇧🇴" />
            </div>
            <div className="space-y-1">
              <Label className="text-sm">Moneda *</Label>
              <Input value={currency} onChange={(e) => setCurrency(e.target.value)} placeholder="BOB" required />
            </div>
          </div>
          <Button type="submit" className="bg-primary hover:bg-primary/90"><Plus className="w-4 h-4 mr-1" /> Agregar País</Button>
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-2">
          {store.countries.length === 0 ? (
            <p className="text-center py-6 text-muted-foreground">No hay países configurados</p>
          ) : (
            store.countries.map((c) => (
              <div key={c.code} className={`flex items-center gap-3 p-3 rounded-lg border ${c.archived ? "bg-muted/30 opacity-60" : "bg-muted/10 hover:bg-muted/30"}`}>
                <span className="text-xl flex-shrink-0">{c.flag}</span>
                {editingCode === c.code ? (
                  <div className="flex-1 flex gap-2">
                    <Input value={editName} onChange={(e) => setEditName(e.target.value)} className="h-8 flex-1" placeholder="Nombre" />
                    <Input value={editCurrency} onChange={(e) => setEditCurrency(e.target.value)} className="h-8 w-24" placeholder="Moneda" />
                  </div>
                ) : (
                  <div className="flex-1">
                    <span className={c.archived ? "line-through text-muted-foreground" : ""}>{c.name}</span>
                    <span className="text-sm text-muted-foreground ml-2">({c.currency})</span>
                  </div>
                )}
                {c.archived && <Badge variant="secondary" className="text-xs">Archivado</Badge>}
                <div className="flex items-center gap-1">
                  {editingCode === c.code ? (
                    <>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => { store.updateCountry(c.code, { name: editName, currency: editCurrency }); setEditingCode(null); }}><Check className="w-4 h-4 text-accent" /></Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => setEditingCode(null)}><X className="w-4 h-4" /></Button>
                    </>
                  ) : (
                    <>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => { setEditingCode(c.code); setEditName(c.name); setEditCurrency(c.currency); }}><Pencil className="w-3.5 h-3.5" /></Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => store.archiveCountry(c.code)}>
                        {c.archived ? <ArchiveRestore className="w-3.5 h-3.5 text-accent" /> : <Archive className="w-3.5 h-3.5 text-muted-foreground" />}
                      </Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => store.deleteCountry(c.code)}><Trash2 className="w-3.5 h-3.5 text-destructive" /></Button>
                    </>
                  )}
                </div>
              </div>
            ))
          )}
        </div>
      )}
    </>
  );
}

// ─── PAYMENT METHODS SECTION ────────────────────────────────────────────
function PaymentMethodsSection() {
  const store = useStore();
  const [tab, setTab] = useState("add");
  const [value, setValue] = useState("");
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [countryCode, setCountryCode] = useState("");
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editName, setEditName] = useState("");
  const [editDesc, setEditDesc] = useState("");

  const allCountryCodes = [...store.countries.map((c) => c.code), "internacional"];

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    if (value && name && countryCode) {
      store.addPaymentMethod({ value: value.trim(), name: name.trim(), description: description.trim(), countryCode });
      setValue(""); setName(""); setDescription(""); setCountryCode("");
    }
  };

  // Group methods by country
  const grouped: Record<string, typeof store.paymentMethods> = {};
  store.paymentMethods.forEach((m) => {
    if (!grouped[m.countryCode]) grouped[m.countryCode] = [];
    grouped[m.countryCode].push(m);
  });

  const getCountryLabel = (cc: string) => {
    if (cc === "internacional") return "🌎 Internacional";
    const c = store.countries.find((x) => x.code === cc);
    return c ? `${c.flag} ${c.name}` : cc;
  };

  return (
    <>
      <SubTabs tabs={[{ key: "add", label: "Agregar" }, { key: "manage", label: "Administrar" }]} active={tab} onChange={setTab} />

      {tab === "add" && (
        <form onSubmit={handleAdd} className="space-y-3">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            <div className="space-y-1">
              <Label className="text-sm">Identificador *</Label>
              <Input value={value} onChange={(e) => setValue(e.target.value)} placeholder="ej: nequi" required />
            </div>
            <div className="space-y-1">
              <Label className="text-sm">Nombre visible *</Label>
              <Input value={name} onChange={(e) => setName(e.target.value)} placeholder="Nequi" required />
            </div>
          </div>
          <div className="space-y-1">
            <Label className="text-sm">Descripción</Label>
            <Input value={description} onChange={(e) => setDescription(e.target.value)} placeholder="Transferencia rápida con Nequi" />
          </div>
          <div className="space-y-1">
            <Label className="text-sm">País asociado *</Label>
            <select value={countryCode} onChange={(e) => setCountryCode(e.target.value)} required className="flex h-9 w-full rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring">
              <option value="">Selecciona país</option>
              {allCountryCodes.map((cc) => (
                <option key={cc} value={cc}>{getCountryLabel(cc)}</option>
              ))}
            </select>
          </div>
          <Button type="submit" className="bg-primary hover:bg-primary/90"><Plus className="w-4 h-4 mr-1" /> Agregar Método</Button>
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-4">
          {Object.keys(grouped).length === 0 ? (
            <p className="text-center py-6 text-muted-foreground">No hay métodos de pago</p>
          ) : (
            Object.entries(grouped).map(([cc, methods]) => (
              <div key={cc}>
                <p className="text-sm text-muted-foreground mb-2">{getCountryLabel(cc)}</p>
                <div className="space-y-2">
                  {methods.map((m) => (
                    <div key={m.id} className={`flex items-center gap-3 p-3 rounded-lg border ${m.archived ? "bg-muted/30 opacity-60" : "bg-muted/10 hover:bg-muted/30"}`}>
                      <Wallet className="w-4 h-4 text-primary flex-shrink-0" />
                      {editingId === m.id ? (
                        <div className="flex-1 flex gap-2">
                          <Input value={editName} onChange={(e) => setEditName(e.target.value)} className="h-8 flex-1" />
                          <Input value={editDesc} onChange={(e) => setEditDesc(e.target.value)} className="h-8 flex-1" />
                        </div>
                      ) : (
                        <div className="flex-1 min-w-0">
                          <p className={`truncate ${m.archived ? "line-through text-muted-foreground" : ""}`}>{m.name}</p>
                          <p className="text-xs text-muted-foreground truncate">{m.description}</p>
                        </div>
                      )}
                      {m.archived && <Badge variant="secondary" className="text-xs">Archivado</Badge>}
                      <div className="flex items-center gap-1 flex-shrink-0">
                        {editingId === m.id ? (
                          <>
                            <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => { store.updatePaymentMethod(m.id, { name: editName, description: editDesc }); setEditingId(null); }}><Check className="w-4 h-4 text-accent" /></Button>
                            <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => setEditingId(null)}><X className="w-4 h-4" /></Button>
                          </>
                        ) : (
                          <>
                            <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => { setEditingId(m.id); setEditName(m.name); setEditDesc(m.description); }}><Pencil className="w-3.5 h-3.5" /></Button>
                            <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => store.archivePaymentMethod(m.id)}>
                              {m.archived ? <ArchiveRestore className="w-3.5 h-3.5 text-accent" /> : <Archive className="w-3.5 h-3.5 text-muted-foreground" />}
                            </Button>
                            <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => store.deletePaymentMethod(m.id)}><Trash2 className="w-3.5 h-3.5 text-destructive" /></Button>
                          </>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            ))
          )}
        </div>
      )}
    </>
  );
}

// ─── OFFERS SECTION ─────────────────────────────────────────────────────
function OffersSection() {
  const store = useStore();
  const [tab, setTab] = useState("add");
  const [gameId, setGameId] = useState("");
  const [discount, setDiscount] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editDiscount, setEditDiscount] = useState("");
  const [editStart, setEditStart] = useState("");
  const [editEnd, setEditEnd] = useState("");

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    if (gameId && discount) {
      store.addOffer({
        gameId,
        discountPercent: parseFloat(discount),
        startDate: startDate || new Date().toISOString().split("T")[0],
        endDate: endDate || "2099-12-31",
        active: true,
      });
      setGameId(""); setDiscount(""); setStartDate(""); setEndDate("");
    }
  };

  const getGameTitle = (id: string) => store.games.find((g) => g.id === id)?.title || "Desconocido";

  return (
    <>
      <SubTabs tabs={[{ key: "add", label: "Agregar" }, { key: "manage", label: "Administrar" }]} active={tab} onChange={setTab} />

      {tab === "add" && (
        <form onSubmit={handleAdd} className="space-y-3">
          <div className="space-y-1">
            <Label className="text-sm">Producto *</Label>
            <select value={gameId} onChange={(e) => setGameId(e.target.value)} required className="flex h-9 w-full rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring">
              <option value="">Selecciona un juego</option>
              {store.getActiveGames().map((g) => (
                <option key={g.id} value={g.id}>{g.title}</option>
              ))}
            </select>
          </div>
          <div className="space-y-1">
            <Label className="text-sm">Descuento (%) *</Label>
            <Input type="number" min="1" max="99" value={discount} onChange={(e) => setDiscount(e.target.value)} placeholder="20" required />
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div className="space-y-1">
              <Label className="text-sm">Fecha inicio</Label>
              <Input type="date" value={startDate} onChange={(e) => setStartDate(e.target.value)} />
            </div>
            <div className="space-y-1">
              <Label className="text-sm">Fecha fin</Label>
              <Input type="date" value={endDate} onChange={(e) => setEndDate(e.target.value)} />
            </div>
          </div>
          <Button type="submit" className="bg-primary hover:bg-primary/90"><Plus className="w-4 h-4 mr-1" /> Agregar Oferta</Button>
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-2">
          {store.offers.length === 0 ? (
            <p className="text-center py-6 text-muted-foreground">No hay ofertas</p>
          ) : (
            store.offers.map((o) => (
              <div key={o.id} className={`flex items-center gap-3 p-3 rounded-lg border ${o.archived ? "bg-muted/30 opacity-60" : "bg-muted/10 hover:bg-muted/30"}`}>
                <Percent className="w-4 h-4 text-accent flex-shrink-0" />
                {editingId === o.id ? (
                  <div className="flex-1 flex flex-wrap gap-2">
                    <Input type="number" min="1" max="99" value={editDiscount} onChange={(e) => setEditDiscount(e.target.value)} className="h-8 w-20" placeholder="%" />
                    <Input type="date" value={editStart} onChange={(e) => setEditStart(e.target.value)} className="h-8 flex-1" />
                    <Input type="date" value={editEnd} onChange={(e) => setEditEnd(e.target.value)} className="h-8 flex-1" />
                  </div>
                ) : (
                  <div className="flex-1 min-w-0">
                    <p className={`truncate ${o.archived ? "line-through text-muted-foreground" : ""}`}>
                      {getGameTitle(o.gameId)} — <span className="text-accent">{o.discountPercent}% OFF</span>
                    </p>
                    <p className="text-xs text-muted-foreground">{o.startDate} → {o.endDate}</p>
                  </div>
                )}
                {o.archived && <Badge variant="secondary" className="text-xs">Archivado</Badge>}
                {!o.active && !o.archived && <Badge variant="outline" className="text-xs">Inactivo</Badge>}
                <div className="flex items-center gap-1 flex-shrink-0">
                  {editingId === o.id ? (
                    <>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => { store.updateOffer(o.id, { discountPercent: parseFloat(editDiscount), startDate: editStart, endDate: editEnd }); setEditingId(null); }}><Check className="w-4 h-4 text-accent" /></Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => setEditingId(null)}><X className="w-4 h-4" /></Button>
                    </>
                  ) : (
                    <>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => { setEditingId(o.id); setEditDiscount(String(o.discountPercent)); setEditStart(o.startDate); setEditEnd(o.endDate); }}><Pencil className="w-3.5 h-3.5" /></Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => store.archiveOffer(o.id)}>
                        {o.archived ? <ArchiveRestore className="w-3.5 h-3.5 text-accent" /> : <Archive className="w-3.5 h-3.5 text-muted-foreground" />}
                      </Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => store.deleteOffer(o.id)}><Trash2 className="w-3.5 h-3.5 text-destructive" /></Button>
                    </>
                  )}
                </div>
              </div>
            ))
          )}
        </div>
      )}
    </>
  );
}

// ─── Mock user pool for seller search ───────────────────────────────────
const MOCK_USER_POOL = [
  { username: "alpha_games", displayName: "Alpha Games", avatar: "https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=80&h=80&fit=crop" },
  { username: "retro_master", displayName: "Retro Master", avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=80&h=80&fit=crop" },
  { username: "gamer_vault", displayName: "Gamer Vault", avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=80&h=80&fit=crop" },
  { username: "indie_studio", displayName: "Indie Studio", avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=80&h=80&fit=crop" },
  { username: "console_king", displayName: "Console King", avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=80&h=80&fit=crop" },
  { username: "pixelcraft", displayName: "PixelCraft Store", avatar: "https://images.unsplash.com/photo-1580489944761-15a19d654956?w=80&h=80&fit=crop" },
  { username: "stealth_games", displayName: "Stealth Games", avatar: "https://images.unsplash.com/photo-1463453091185-61582044d556?w=80&h=80&fit=crop" },
  { username: "vrgaming", displayName: "VR Gaming Hub", avatar: "https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?w=80&h=80&fit=crop" },
];

// ─── SELLERS SECTION ────────────────────────────────────────────────────
function SellersSection() {
  const store = useStore();
  const [tab, setTab] = useState("manage");
  const [searchQuery, setSearchQuery] = useState("");
  const [sellerSearch, setSellerSearch] = useState("");

  // Search users to add
  const filteredPool = MOCK_USER_POOL.filter(
    (u) =>
      !store.sellers.some((s) => s.username === u.username) &&
      (u.username.toLowerCase().includes(searchQuery.toLowerCase()) ||
        u.displayName.toLowerCase().includes(searchQuery.toLowerCase()))
  );

  const handleAddSeller = (user: (typeof MOCK_USER_POOL)[0]) => {
    store.addSeller({
      username: user.username,
      displayName: user.displayName,
      avatar: user.avatar,
      rating: 0,
      reviewCount: 0,
      joinedDate: new Date().toISOString().split("T")[0],
    });
  };

  // Manage list filtering
  const filteredSellers = store.sellers.filter(
    (s) =>
      s.username.toLowerCase().includes(sellerSearch.toLowerCase()) ||
      s.displayName.toLowerCase().includes(sellerSearch.toLowerCase())
  );

  // Count products per seller
  const getProductCount = (sellerId: string) =>
    store.games.filter((g) => g.sellerId === sellerId && !g.archived).length;

  return (
    <>
      <SubTabs
        tabs={[
          { key: "manage", label: "Vendedores" },
          { key: "add", label: "Agregar" },
        ]}
        active={tab}
        onChange={setTab}
      />

      {/* ── ADD tab: search user pool ── */}
      {tab === "add" && (
        <div className="space-y-4">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground pointer-events-none" />
            <Input
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Buscar usuario por username o nombre..."
              className="pl-9"
            />
          </div>

          {searchQuery.trim() === "" ? (
            <p className="text-center py-6 text-muted-foreground text-sm">
              Escribe un username para buscar usuarios disponibles
            </p>
          ) : filteredPool.length === 0 ? (
            <p className="text-center py-6 text-muted-foreground text-sm">
              No se encontraron usuarios con ese nombre, o ya son vendedores
            </p>
          ) : (
            <div className="space-y-2">
              {filteredPool.map((user) => (
                <div
                  key={user.username}
                  className="flex items-center gap-3 p-3 rounded-lg border bg-muted/10 hover:bg-muted/30 transition-colors"
                >
                  <img
                    src={user.avatar}
                    alt={user.displayName}
                    className="w-10 h-10 rounded-full object-cover flex-shrink-0 ring-1 ring-border"
                    onError={(e) => {
                      (e.target as HTMLImageElement).src =
                        "https://ui-avatars.com/api/?name=" + encodeURIComponent(user.displayName);
                    }}
                  />
                  <div className="flex-1 min-w-0">
                    <p className="truncate">{user.displayName}</p>
                    <p className="text-xs text-muted-foreground">@{user.username}</p>
                  </div>
                  <Button
                    size="sm"
                    onClick={() => handleAddSeller(user)}
                    className="bg-primary hover:bg-primary/90 flex-shrink-0"
                  >
                    <UserPlus className="w-4 h-4 mr-1" />
                    Agregar
                  </Button>
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {/* ── MANAGE tab: sellers list with search + scroll ── */}
      {tab === "manage" && (
        <div className="space-y-3">
          {/* Search bar */}
          <div className="relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground pointer-events-none" />
            <Input
              value={sellerSearch}
              onChange={(e) => setSellerSearch(e.target.value)}
              placeholder="Filtrar vendedores..."
              className="pl-9"
            />
          </div>

          {filteredSellers.length === 0 ? (
            <p className="text-center py-8 text-muted-foreground text-sm">
              {store.sellers.length === 0
                ? "No hay vendedores registrados. Usa «Agregar» para añadir uno."
                : "No se encontraron vendedores con ese nombre."}
            </p>
          ) : (
            /* Scrollable list — max ~12 items visible (~72px each = ~864px) */
            <div className="max-h-[864px] overflow-y-auto space-y-2 pr-1">
              {filteredSellers.map((s) => {
                const productCount = getProductCount(s.id);
                return (
                  <div
                    key={s.id}
                    className={`flex items-center gap-3 p-3 rounded-lg border transition-colors ${
                      s.archived ? "bg-muted/30 opacity-60" : "bg-muted/10 hover:bg-muted/30"
                    }`}
                  >
                    <img
                      src={s.avatar}
                      alt={s.displayName}
                      className="w-12 h-12 rounded-full object-cover flex-shrink-0 ring-1 ring-border"
                      onError={(e) => {
                        (e.target as HTMLImageElement).src =
                          "https://ui-avatars.com/api/?name=" + encodeURIComponent(s.displayName) + "&size=48";
                      }}
                    />
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 flex-wrap">
                        <p className={`truncate ${s.archived ? "line-through text-muted-foreground" : ""}`}>
                          {s.displayName}
                        </p>
                        {s.archived && <Badge variant="secondary" className="text-xs">Archivado</Badge>}
                      </div>
                      <p className="text-xs text-muted-foreground">@{s.username}</p>
                      <div className="flex items-center gap-3 mt-1 flex-wrap">
                        {s.rating > 0 ? (
                          <StarRatingDisplay rating={s.rating} />
                        ) : (
                          <span className="text-xs text-muted-foreground">Sin calificaciones aún</span>
                        )}
                        {s.reviewCount > 0 && (
                          <span className="text-xs text-muted-foreground">({s.reviewCount} reseñas)</span>
                        )}
                        <span className="text-xs text-muted-foreground flex items-center gap-1">
                          <Package className="w-3 h-3" />
                          {productCount} {productCount === 1 ? "producto" : "productos"}
                        </span>
                      </div>
                    </div>
                    <div className="flex items-center gap-1 flex-shrink-0">
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => store.archiveSeller(s.id)}
                        title={s.archived ? "Restaurar" : "Archivar"}
                      >
                        {s.archived ? (
                          <ArchiveRestore className="w-3.5 h-3.5 text-accent" />
                        ) : (
                          <Archive className="w-3.5 h-3.5 text-muted-foreground" />
                        )}
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => store.deleteSeller(s.id)}
                        title="Eliminar vendedor"
                      >
                        <Trash2 className="w-3.5 h-3.5 text-destructive" />
                      </Button>
                    </div>
                  </div>
                );
              })}
            </div>
          )}

          <p className="text-xs text-muted-foreground text-center pt-1">
            {filteredSellers.length} {filteredSellers.length === 1 ? "vendedor" : "vendedores"}
            {store.sellers.length !== filteredSellers.length && ` de ${store.sellers.length}`}
          </p>
        </div>
      )}
    </>
  );
}

// ─── MAIN ADMIN PANEL ───────────────────────────────────────────────────
export function AdminPanel() {
  // Live Producto count from backend, surfaced in the Productos card header.
  const { data: backendProductos, loading: backendProductosLoading, error: backendProductosError } =
    useFetch(() => productosService.list(), []);
  const productosSubtitle = backendProductosLoading
    ? "Cargando productos del backend…"
    : backendProductosError
    ? `Error: ${backendProductosError.message}`
    : "Agregar y administrar videojuegos del catálogo";

  return (
    <div className="min-h-screen bg-gradient-to-b from-background to-muted/20 py-8">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="mb-8">
          <h1 className="mb-2">Panel de Administración</h1>
          <p className="text-muted-foreground">
            Gestiona todos los aspectos de tu tienda desde aquí
          </p>
        </div>

        {/* Expandable Cards */}
        <div className="space-y-4">
          <AdminExpandableCard
            icon={<Gamepad2 className="w-5 h-5" />}
            title="Productos"
            subtitle={productosSubtitle}
            defaultOpen={true}
            accentColor="bg-primary/10 text-primary"
            count={backendProductos?.length ?? null}
            countLabel="en backend"
          >
            <ProductsSection />
          </AdminExpandableCard>

          <AdminExpandableCard
            icon={<Users className="w-5 h-5" />}
            title="Vendedores"
            subtitle="Gestiona los vendedores asociados a los productos"
            accentColor="bg-amber-500/10 text-amber-600"
          >
            <SellersSection />
          </AdminExpandableCard>

          <AdminExpandableCard
            icon={<Percent className="w-5 h-5" />}
            title="Ofertas"
            subtitle="Crear y gestionar descuentos en productos"
            accentColor="bg-accent/10 text-accent"
          >
            <OffersSection />
          </AdminExpandableCard>

          <AdminExpandableCard
            icon={<Tag className="w-5 h-5" />}
            title="Categorías"
            subtitle="Organiza los productos por género o tipo"
            accentColor="bg-secondary/10 text-secondary"
          >
            <CategoriesSection />
          </AdminExpandableCard>

          <AdminExpandableCard
            icon={<Globe className="w-5 h-5" />}
            title="Países y Monedas"
            subtitle="Configura los países disponibles y sus monedas"
            accentColor="bg-amber-500/10 text-amber-600"
          >
            <CountriesSection />
          </AdminExpandableCard>

          <AdminExpandableCard
            icon={<Wallet className="w-5 h-5" />}
            title="Métodos de Pago"
            subtitle="Gestiona las opciones de pago por país"
            accentColor="bg-emerald-500/10 text-emerald-600"
          >
            <PaymentMethodsSection />
          </AdminExpandableCard>
        </div>

        {/* Info */}
        <div className="mt-6 rounded-xl border border-border bg-muted/50 p-5">
          <div className="flex items-center gap-2 mb-2">
            <Package className="w-5 h-5 text-muted-foreground" />
            <h3 className="text-[0.95rem]">Información</h3>
          </div>
          <ul className="space-y-1.5 text-sm text-muted-foreground">
            <li>• Usa las flechas ˄/˅ para expandir o colapsar cada sección</li>
            <li>• Los elementos archivados no serán visibles para los clientes</li>
            <li>• Eliminar es permanente, archivar es reversible</li>
            <li>• El stock ilimitado indica productos fácilmente renovables</li>
            <li>• Los vendedores archivados siguen vinculados a sus productos</li>
          </ul>
        </div>
      </div>
    </div>
  );
}