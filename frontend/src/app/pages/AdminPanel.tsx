import { useState } from "react";
import { Button } from "../components/ui/button";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";
import { Textarea } from "../components/ui/textarea";
import { Badge } from "../components/ui/badge";
import { AdminExpandableCard } from "../components/AdminExpandableCard";
import { useFetch } from "../hooks/useFetch";
import {
  productosService,
  categoriasService,
  paisesService,
  videojuegoService,
  metodosPagoService,
  usuariosService,
} from "../services";
import type { Pais, Videojuego, MetodoPago, Producto, Usuario } from "../services/types";
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
  Loader2,
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

// ─── Helper for consistent mutation loading ──────────────────────────────
function useMutation() {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const mutate = async (fn: () => Promise<unknown>) => {
    setLoading(true);
    setError(null);
    try {
      await fn();
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setLoading(false);
    }
  };

  return { loading, error, mutate, clearError: () => setError(null) };
}

// ─── PRODUCTS SECTION ───────────────────────────────────────────────────
function ProductsSection() {
  const [tab, setTab] = useState("add");
  const [editingId, setEditingId] = useState<number | null>(null);
  const [editTitle, setEditTitle] = useState("");
  const [editDesc, setEditDesc] = useState("");
  const { loading: mutating, error: mutationError, mutate } = useMutation();

  const { data: categorias, loading: categoriasLoading } = useFetch(
    (signal) => categoriasService.list(signal),
    [],
  );

  const { data: paises, loading: paisesLoading } = useFetch(
    (signal) => paisesService.list(signal),
    [],
  );

  const { data: videojuegos, loading: videojuegosLoading } = useFetch(
    (signal) => videojuegoService.list(signal),
    [],
  );

  const { data: usuarios, loading: usuariosLoading } = useFetch(
    (signal) => usuariosService.list(signal),
    [],
  );

  const {
    data: productos,
    loading: productosLoading,
    error: productosError,
    refresh: refreshProductos,
  } = useFetch((signal) => productosService.list(signal), []);

  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [categoryId, setCategoryId] = useState("");
  const [paisId, setPaisId] = useState("");
  const [videojuegoId, setVideojuegoId] = useState("");
  const [vendedorId, setVendedorId] = useState("");
  const [image, setImage] = useState("");

  const resetForm = () => {
    setTitle("");
    setDescription("");
    setCategoryId("");
    setPaisId("");
    setVideojuegoId("");
    setVendedorId("");
    setImage("");
  };

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    mutate(async () => {
      await productosService.create({
        nombre: title.trim(),
        descripcion: description.trim(),
        id_categoria: Number(categoryId),
        id_pais: Number(paisId),
        id_videojuego: Number(videojuegoId),
        id_vendedor: Number(vendedorId) || 0,
      });
      resetForm();
      refreshProductos();
    });
  };

  const startEdit = (p: Producto) => {
    setEditingId(p.id);
    setEditTitle(p.nombre);
    setEditDesc(p.descripcion);
  };

  const saveEdit = () => {
    if (editingId === null) return;
    mutate(async () => {
      await productosService.update(editingId, {
        nombre: editTitle.trim(),
        descripcion: editDesc.trim(),
      });
      setEditingId(null);
      refreshProductos();
    });
  };

  const handleDelete = (id: number) => {
    mutate(async () => {
      await productosService.remove(id);
      refreshProductos();
    });
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

      {mutationError && (
        <p className="mb-3 text-sm text-destructive">Error: {mutationError}</p>
      )}

      {tab === "add" && (
        <form onSubmit={handleAdd} className="space-y-5">
          <div className="space-y-2">
            <Label>Título del Juego *</Label>
            <Input
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="Ej: The Legend of Zelda"
              required
              disabled={mutating}
            />
          </div>
          <div className="space-y-2">
            <Label>Descripción *</Label>
            <Textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              placeholder="Describe el juego..."
              rows={3}
              required
              disabled={mutating}
            />
          </div>

          <div className="space-y-2">
            <Label>Vendedor</Label>
            <select
              value={vendedorId}
              onChange={(e) => setVendedorId(e.target.value)}
              disabled={usuariosLoading || mutating}
              className="flex h-9 w-full rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
            >
              <option value="">
                {usuariosLoading ? "Cargando usuarios…" : "Sin vendedor asignado"}
              </option>
              {(usuarios ?? []).map((u) => (
                <option key={u.id} value={u.id}>
                  @{u.usuario} — {u.nombre}
                </option>
              ))}
            </select>
          </div>

          {/* Stock field — backend doesn't have stock yet */}
          <div className="space-y-2">
            <Label>Stock *</Label>
            <div className="flex gap-2">
              <Input
                type="number"
                min="0"
                placeholder="Cantidad"
                className="flex-1"

              />
              <Button
                type="button"
                variant="outline"
                disabled
              >
                <Infinity className="w-4 h-4 mr-1" />
                Ilimitado
              </Button>
            </div>
          </div>

          <div className="space-y-2">
            <Label>Categoría *</Label>
            <select
              value={categoryId}
              onChange={(e) => setCategoryId(e.target.value)}
              required
              disabled={categoriasLoading || mutating}
              className="flex h-9 w-full rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
            >
              <option value="">
                {categoriasLoading ? "Cargando categorías…" : "Selecciona una categoría"}
              </option>
              {(categorias ?? []).map((c) => (
                <option key={c.id} value={c.id}>
                  {c.nombre}
                </option>
              ))}
            </select>
          </div>

          <div className="space-y-2">
            <Label>País *</Label>
            <select
                value={paisId}
                onChange={(e) => setPaisId(e.target.value)}
                required
                disabled={paisesLoading || mutating}
                className="flex h-9 w-full rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
            >
              <option value="">
                {paisesLoading ? "Cargando países…" : "Selecciona un país"}
              </option>
              {(paises ?? []).map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.nombre}
                  </option>
              ))}
            </select>
          </div>

          <div className="space-y-2">
            <Label>Videojuego *</Label>
            <select
                value={videojuegoId}
                onChange={(e) => setVideojuegoId(e.target.value)}
                required
                disabled={videojuegosLoading || mutating}
                className="flex h-9 w-full rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
            >
              <option value="">
                {videojuegosLoading ? "Cargando videojuegos…" : "Selecciona un videojuego"}
              </option>
              {(videojuegos ?? []).map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.nombre}
                  </option>
              ))}
            </select>
          </div>

          <div className="space-y-2">
            <Label>URL de la Imagen *</Label>
            <div className="flex gap-2">
              <Input
                type="url"
                value={image}
                onChange={(e) => setImage(e.target.value)}
                placeholder="https://example.com/image.jpg"
                required
                className="flex-1"
                disabled={mutating}
              />
              <Button type="button" variant="outline" size="icon">
                <Upload className="w-4 h-4" />
              </Button>
            </div>
            {image && (
              <div className="mt-2 p-2 border rounded-lg">
                <p className="text-sm text-muted-foreground mb-1">Vista previa:</p>
                <img
                  src={image}
                  alt="Preview"
                  className="w-full max-w-xs h-32 object-cover rounded"
                  onError={(e) => {
                    (e.target as HTMLImageElement).src =
                      "https://via.placeholder.com/300x200?text=Invalid";
                  }}
                />
              </div>
            )}
          </div>

          <div className="flex gap-3 pt-2">
            <Button type="submit" className="bg-primary hover:bg-primary/90" disabled={mutating}>
              <Plus className="w-4 h-4 mr-1" />
              {mutating ? "Guardando…" : "Agregar Juego"}
            </Button>
            <Button type="button" variant="outline" onClick={resetForm} disabled={mutating}>
              Limpiar
            </Button>
          </div>
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-3">
          {productosLoading ? (
            <div className="flex items-center justify-center py-8 text-muted-foreground">
              <Loader2 className="w-4 h-4 mr-2 animate-spin" />
              Cargando productos…
            </div>
          ) : productosError ? (
            <p className="text-center py-8 text-destructive">
              No se pudieron cargar los productos: {productosError.message}
            </p>
          ) : !productos || productos.length === 0 ? (
            <p className="text-center py-8 text-muted-foreground">No hay productos</p>
          ) : (
            productos.map((p) => {
              const seller = (usuarios ?? []).find((u) => u.id === p.id_vendedor);
              return (
                <div
                  key={p.id}
                  className="flex items-center gap-3 p-3 rounded-lg border bg-muted/10 hover:bg-muted/30 transition-colors"
                >
                  <img
                    src="https://images.unsplash.com/photo-1542751371-adc38448a05e?w=56&h=56&fit=crop"
                    alt={p.nombre}
                    className="w-14 h-14 rounded-lg object-cover flex-shrink-0"
                  />
                  <div className="flex-1 min-w-0">
                    {editingId === p.id ? (
                      <div className="space-y-2">
                        <Input
                          value={editTitle}
                          onChange={(e) => setEditTitle(e.target.value)}
                          className="h-8"
                          disabled={mutating}
                        />
                        <Input
                          value={editDesc}
                          onChange={(e) => setEditDesc(e.target.value)}
                          className="h-8"
                          disabled={mutating}
                        />
                      </div>
                    ) : (
                      <>
                        <p className="truncate">{p.nombre}</p>
                        <div className="flex items-center gap-2 mt-1 flex-wrap">
                          <Badge variant="outline" className="text-xs">
                            Cat: {p.id_categoria}
                          </Badge>
                          <span className="text-xs text-muted-foreground">
                            Stock: ∞ {/* TODO: real stock */}
                          </span>
                          {seller && (
                            <span className="text-xs text-muted-foreground flex items-center gap-1">
                              <Users className="w-3 h-3" />
                              @{seller.usuario}
                            </span>
                          )}
                        </div>
                      </>
                    )}
                  </div>
                  <div className="flex items-center gap-1 flex-shrink-0">
                    {editingId === p.id ? (
                      <>
                        <Button
                          variant="ghost"
                          size="icon"
                          className="h-8 w-8"
                          onClick={saveEdit}
                          disabled={mutating}
                        >
                          <Check className="w-4 h-4 text-accent" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          className="h-8 w-8"
                          onClick={() => setEditingId(null)}
                          disabled={mutating}
                        >
                          <X className="w-4 h-4" />
                        </Button>
                      </>
                    ) : (
                      <>
                        <Button
                          variant="ghost"
                          size="icon"
                          className="h-8 w-8"
                          onClick={() => startEdit(p)}
                          disabled={mutating}
                        >
                          <Pencil className="w-3.5 h-3.5" />
                        </Button>
                        <Button
                          variant="ghost"
                          size="icon"
                          className="h-8 w-8"
                          onClick={() => handleDelete(p.id)}
                          disabled={mutating}
                        >
                          <Trash2 className="w-3.5 h-3.5 text-destructive" />
                        </Button>
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
  const {
    data: categorias,
    loading,
    error,
    refresh,
  } = useFetch((signal) => categoriasService.list(signal), []);

  const [tab, setTab] = useState("add");
  const [name, setName] = useState("");
  const [editingId, setEditingId] = useState<number | null>(null);
  const [editName, setEditName] = useState("");
  const { loading: mutating, error: mutationError, mutate } = useMutation();

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    const trimmed = name.trim();
    if (!trimmed) return;
    mutate(async () => {
      await categoriasService.create({ nombre: trimmed });
      setName("");
      refresh();
    });
  };

  const handleSaveEdit = (id: number) => {
    mutate(async () => {
      await categoriasService.update(id, { nombre: editName.trim() });
      setEditingId(null);
      refresh();
    });
  };

  const handleDelete = (id: number) => {
    mutate(async () => {
      await categoriasService.remove(id);
      refresh();
    });
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

      {mutationError && (
        <p className="mb-3 text-sm text-destructive">Error: {mutationError}</p>
      )}

      {tab === "add" && (
        <form onSubmit={handleAdd} className="flex gap-3">
          <Input
            value={name}
            onChange={(e) => setName(e.target.value)}
            placeholder="Nombre de la categoría"
            required
            className="flex-1"
            disabled={mutating}
          />
          <Button type="submit" className="bg-primary hover:bg-primary/90" disabled={mutating}>
            <Plus className="w-4 h-4 mr-1" />
            {mutating ? "Guardando…" : "Agregar"}
          </Button>
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-2">
          {loading ? (
            <p className="text-center py-6 text-muted-foreground">Cargando categorías…</p>
          ) : error ? (
            <p className="text-center py-6 text-destructive">
              No se pudieron cargar las categorías: {error.message}
            </p>
          ) : !categorias || categorias.length === 0 ? (
            <p className="text-center py-6 text-muted-foreground">No hay categorías</p>
          ) : (
            categorias.map((c) => (
              <div
                key={c.id}
                className="flex items-center gap-3 p-3 rounded-lg border bg-muted/10 hover:bg-muted/30"
              >
                <Tag className="w-4 h-4 text-primary flex-shrink-0" />
                {editingId === c.id ? (
                  <Input
                    value={editName}
                    onChange={(e) => setEditName(e.target.value)}
                    className="flex-1 h-8"
                    disabled={mutating}
                  />
                ) : (
                  <span className="flex-1">{c.nombre}</span>
                )}
                <div className="flex items-center gap-1">
                  {editingId === c.id ? (
                    <>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleSaveEdit(c.id)}
                        disabled={mutating}
                      >
                        <Check className="w-4 h-4 text-accent" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => setEditingId(null)}
                        disabled={mutating}
                      >
                        <X className="w-4 h-4" />
                      </Button>
                    </>
                  ) : (
                    <>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => {
                          setEditingId(c.id);
                          setEditName(c.nombre);
                        }}
                        disabled={mutating}
                      >
                        <Pencil className="w-3.5 h-3.5" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleDelete(c.id)}
                        disabled={mutating}
                      >
                        <Trash2 className="w-3.5 h-3.5 text-destructive" />
                      </Button>
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
  const {
    data: paises,
    loading,
    error,
    refresh,
  } = useFetch((signal) => paisesService.list(signal), []);

  const [tab, setTab] = useState("add");
  const [name, setName] = useState("");
  const [editingId, setEditingId] = useState<number | null>(null);
  const [editName, setEditName] = useState("");
  const { loading: mutating, error: mutationError, mutate } = useMutation();

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    const trimmed = name.trim();
    if (!trimmed) return;
    mutate(async () => {
      await paisesService.create({ nombre: trimmed });
      setName("");
      refresh();
    });
  };

  const handleSaveEdit = (id: number) => {
    mutate(async () => {
      await paisesService.update(id, { nombre: editName.trim() });
      setEditingId(null);
      refresh();
    });
  };

  const handleDelete = (id: number) => {
    mutate(async () => {
      await paisesService.remove(id);
      refresh();
    });
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

      {mutationError && (
        <p className="mb-3 text-sm text-destructive">Error: {mutationError}</p>
      )}

      {tab === "add" && (
        <form onSubmit={handleAdd} className="space-y-3">
          <div className="space-y-1">
            <Label className="text-sm">Nombre *</Label>
            <Input
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="Bolivia"
              required
              disabled={mutating}
            />
            <p className="text-xs text-muted-foreground">
              TODO: Los campos bandera y moneda no están disponibles en el backend aún
            </p>
          </div>
          <Button type="submit" className="bg-primary hover:bg-primary/90" disabled={mutating}>
            <Plus className="w-4 h-4 mr-1" />
            {mutating ? "Guardando…" : "Agregar País"}
          </Button>
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-2">
          {loading ? (
            <p className="text-center py-6 text-muted-foreground">Cargando países…</p>
          ) : error ? (
            <p className="text-center py-6 text-destructive">
              No se pudieron cargar los países: {error.message}
            </p>
          ) : !paises || paises.length === 0 ? (
            <p className="text-center py-6 text-muted-foreground">No hay países configurados</p>
          ) : (
            paises.map((c) => (
              <div
                key={c.id}
                className="flex items-center gap-3 p-3 rounded-lg border bg-muted/10 hover:bg-muted/30"
              >
                <span className="text-xl flex-shrink-0">🏳️</span>
                {editingId === c.id ? (
                  <Input
                    value={editName}
                    onChange={(e) => setEditName(e.target.value)}
                    className="h-8 flex-1"
                    placeholder="Nombre"
                    disabled={mutating}
                  />
                ) : (
                  <div className="flex-1">
                    <span>{c.nombre}</span>
                    <span className="text-sm text-muted-foreground ml-2">
                      (TODO: moneda)
                    </span>
                  </div>
                )}
                <div className="flex items-center gap-1">
                  {editingId === c.id ? (
                    <>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleSaveEdit(c.id)}
                        disabled={mutating}
                      >
                        <Check className="w-4 h-4 text-accent" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => setEditingId(null)}
                        disabled={mutating}
                      >
                        <X className="w-4 h-4" />
                      </Button>
                    </>
                  ) : (
                    <>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => {
                          setEditingId(c.id);
                          setEditName(c.nombre);
                        }}
                        disabled={mutating}
                      >
                        <Pencil className="w-3.5 h-3.5" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleDelete(c.id)}
                        disabled={mutating}
                      >
                        <Trash2 className="w-3.5 h-3.5 text-destructive" />
                      </Button>
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

// ─── Videogames SECTION ──────────────────────────────────────────────────
function VideogamesSection() {
  const {
    data: videojuegos,
    loading,
    error,
    refresh,
  } = useFetch((signal) => videojuegoService.list(signal), []);

  const [tab, setTab] = useState("add");
  const [name, setName] = useState("");
  const [editingId, setEditingId] = useState<number | null>(null);
  const [editName, setEditName] = useState("");
  const { loading: mutating, error: mutationError, mutate } = useMutation();

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    const trimmed = name.trim();
    if (!trimmed) return;
    mutate(async () => {
      await videojuegoService.create({ nombre: trimmed });
      setName("");
      refresh();
    });
  };

  const handleSaveEdit = (id: number) => {
    mutate(async () => {
      await videojuegoService.update(id, { nombre: editName.trim() });
      setEditingId(null);
      refresh();
    });
  };

  const handleDelete = (id: number) => {
    mutate(async () => {
      await videojuegoService.remove(id);
      refresh();
    });
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

      {mutationError && (
        <p className="mb-3 text-sm text-destructive">Error: {mutationError}</p>
      )}

      {tab === "add" && (
        <form onSubmit={handleAdd} className="space-y-3">
          <div className="space-y-1">
            <Label className="text-sm">Nombre *</Label>
            <Input
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="Minecraft"
              required
              disabled={mutating}
            />
          </div>
          <Button type="submit" className="bg-primary hover:bg-primary/90" disabled={mutating}>
            <Plus className="w-4 h-4 mr-1" />
            {mutating ? "Guardando…" : "Agregar Videojuego"}
          </Button>
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-2">
          {loading ? (
            <p className="text-center py-6 text-muted-foreground">Cargando videojuegos…</p>
          ) : error ? (
            <p className="text-center py-6 text-destructive">
              No se pudieron cargar los videojuegos: {error.message}
            </p>
          ) : !videojuegos || videojuegos.length === 0 ? (
            <p className="text-center py-6 text-muted-foreground">No hay videojuegos configurados</p>
          ) : (
              videojuegos.map((c) => (
              <div
                key={c.id}
                className="flex items-center gap-3 p-3 rounded-lg border bg-muted/10 hover:bg-muted/30"
              >
                <span className="text-xl flex-shrink-0">🏳️</span>
                {editingId === c.id ? (
                  <Input
                    value={editName}
                    onChange={(e) => setEditName(e.target.value)}
                    className="h-8 flex-1"
                    placeholder="Nombre"
                    disabled={mutating}
                  />
                ) : (
                  <div className="flex-1">
                    <span>{c.nombre}</span>
                  </div>
                )}
                <div className="flex items-center gap-1">
                  {editingId === c.id ? (
                    <>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleSaveEdit(c.id)}
                        disabled={mutating}
                      >
                        <Check className="w-4 h-4 text-accent" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => setEditingId(null)}
                        disabled={mutating}
                      >
                        <X className="w-4 h-4" />
                      </Button>
                    </>
                  ) : (
                    <>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => {
                          setEditingId(c.id);
                          setEditName(c.nombre);
                        }}
                        disabled={mutating}
                      >
                        <Pencil className="w-3.5 h-3.5" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleDelete(c.id)}
                        disabled={mutating}
                      >
                        <Trash2 className="w-3.5 h-3.5 text-destructive" />
                      </Button>
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
  const {
    data: metodos,
    loading,
    error,
    refresh,
  } = useFetch((signal) => metodosPagoService.list(signal), []);

  const { data: paises, loading: paisesLoading } = useFetch(
      (signal) => paisesService.list(signal),
      [],
  );

  const [tab, setTab] = useState("add");
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [paisId, setPaisId] = useState("");
  // TODO: country association when backend supports it
  const [editingId, setEditingId] = useState<number | null>(null);
  const [editName, setEditName] = useState("");
  const [editDesc, setEditDesc] = useState("");
  const { loading: mutating, error: mutationError, mutate } = useMutation();

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    const trimmed = name.trim();
    if (!trimmed) return;
    mutate(async () => {
      await metodosPagoService.create(
          {
            nombre: trimmed,
            id_pais: Number(paisId),
          });
      setName("");
      setDescription("");
      setPaisId("");
      refresh();
    });
  };

  const handleSaveEdit = (id: number) => {
    mutate(async () => {
      // TODO: include description when backend supports it
      await metodosPagoService.update(id, { nombre: editName.trim() });
      setEditingId(null);
      refresh();
    });
  };

  const handleDelete = (id: number) => {
    mutate(async () => {
      await metodosPagoService.remove(id);
      refresh();
    });
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

      {mutationError && (
        <p className="mb-3 text-sm text-destructive">Error: {mutationError}</p>
      )}

      {tab === "add" && (
        <form onSubmit={handleAdd} className="space-y-3">
          <div className="space-y-1">
            <Label className="text-sm">Nombre *</Label>
            <Input
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="ej: Nequi"
              required
              disabled={mutating}
            />
          </div>
          <div className="space-y-1">
            <select
                value={paisId}
                onChange={(e) => setPaisId(e.target.value)}
                required
                disabled={paisesLoading || mutating}
                className="flex h-9 w-full rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
            >
              <option value="">
                {paisesLoading ? "Cargando países…" : "Selecciona un país"}
              </option>
              {(paises ?? []).map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.nombre}
                  </option>
              ))}
            </select>
          </div>
          <Button type="submit" className="bg-primary hover:bg-primary/90" disabled={mutating}>
            <Plus className="w-4 h-4 mr-1" />
            {mutating ? "Guardando…" : "Agregar Método"}
          </Button>
          {/*comentarioN*/}
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-2">
          {loading ? (
            <p className="text-center py-6 text-muted-foreground">Cargando métodos de pago…</p>
          ) : error ? (
            <p className="text-center py-6 text-destructive">
              No se pudieron cargar los métodos: {error.message}
            </p>
          ) : !metodos || metodos.length === 0 ? (
            <p className="text-center py-6 text-muted-foreground">No hay métodos de pago</p>
          ) : (
            metodos.map((m) => (
              <div
                key={m.id}
                className="flex items-center gap-3 p-3 rounded-lg border bg-muted/10 hover:bg-muted/30"
              >
                <Wallet className="w-4 h-4 text-primary flex-shrink-0" />
                {editingId === m.id ? (
                  <div className="flex-1 flex gap-2">
                    <Input
                      value={editName}
                      onChange={(e) => setEditName(e.target.value)}
                      className="h-8 flex-1"
                      disabled={mutating}
                    />
                    <Input
                      value={editDesc}
                      onChange={(e) => setEditDesc(e.target.value)}
                      className="h-8 flex-1"
                      disabled={mutating}
                    />
                  </div>
                ) : (
                  <div className="flex-1 min-w-0">
                    <p className="truncate">{m.nombre}</p>
                  </div>
                )}
                <div className="flex items-center gap-1 flex-shrink-0">
                  {editingId === m.id ? (
                    <>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleSaveEdit(m.id)}
                        disabled={mutating}
                      >
                        <Check className="w-4 h-4 text-accent" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => setEditingId(null)}
                        disabled={mutating}
                      >
                        <X className="w-4 h-4" />
                      </Button>
                    </>
                  ) : (
                    <>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => {
                          setEditingId(m.id);
                          setEditName(m.nombre);
                          setEditDesc(""); // TODO: real description
                        }}
                        disabled={mutating}
                      >
                        <Pencil className="w-3.5 h-3.5" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => handleDelete(m.id)}
                        disabled={mutating}
                      >
                        <Trash2 className="w-3.5 h-3.5 text-destructive" />
                      </Button>
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

// ─── OFFERS SECTION ─────────────────────────────────────────────────────
function OffersSection() {
  const { data: productos, loading: productosLoading } = useFetch(
    (signal) => productosService.list(signal),
    [],
  );

  const [tab, setTab] = useState("add");
  const [productoId, setProductoId] = useState("");
  const [discount, setDiscount] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");

  // TODO: Replace with real backend offers when /api/ofertas exists
  type LocalOffer = {
    id: string;
    productoId: string;
    discountPercent: number;
    startDate: string;
    endDate: string;
    active: boolean;
    archived: boolean;
  };
  const [offers, setOffers] = useState<LocalOffer[]>([]);

  const handleAdd = (e: React.FormEvent) => {
    e.preventDefault();
    if (productoId && discount) {
      setOffers((prev) => [
        ...prev,
        {
          id: crypto.randomUUID(),
          productoId,
          discountPercent: parseFloat(discount),
          startDate: startDate || new Date().toISOString().split("T")[0],
          endDate: endDate || "2099-12-31",
          active: true,
          archived: false,
        },
      ]);
      setProductoId("");
      setDiscount("");
      setStartDate("");
      setEndDate("");
    }
  };

  const getProductoNombre = (id: string) =>
    productos?.find((p) => String(p.id) === id)?.nombre ?? "Desconocido";

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
        <form onSubmit={handleAdd} className="space-y-3">
          <div className="space-y-1">
            <Label className="text-sm">Producto *</Label>
            <select
              value={productoId}
              onChange={(e) => setProductoId(e.target.value)}
              required
              disabled={productosLoading}
              className="flex h-9 w-full rounded-md border border-input bg-input-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
            >
              <option value="">
                {productosLoading ? "Cargando productos…" : "Selecciona un producto"}
              </option>
              {(productos ?? []).map((p) => (
                <option key={p.id} value={String(p.id)}>
                  {p.nombre}
                </option>
              ))}
            </select>
          </div>
          <div className="space-y-1">
            <Label className="text-sm">Descuento (%) *</Label>
            <Input
              type="number"
              min="1"
              max="99"
              value={discount}
              onChange={(e) => setDiscount(e.target.value)}
              placeholder="20"
              required
            />
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div className="space-y-1">
              <Label className="text-sm">Fecha inicio</Label>
              <Input
                type="date"
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
              />
            </div>
            <div className="space-y-1">
              <Label className="text-sm">Fecha fin</Label>
              <Input
                type="date"
                value={endDate}
                onChange={(e) => setEndDate(e.target.value)}
              />
            </div>
          </div>
          <p className="text-xs text-muted-foreground">
            TODO: Conectar con endpoint /api/ofertas cuando esté disponible
          </p>
          <Button type="submit" className="bg-primary hover:bg-primary/90">
            <Plus className="w-4 h-4 mr-1" /> Agregar Oferta
          </Button>
        </form>
      )}

      {tab === "manage" && (
        <div className="space-y-2">
          {offers.length === 0 ? (
            <p className="text-center py-6 text-muted-foreground">No hay ofertas</p>
          ) : (
            offers.map((o) => (
              <div
                key={o.id}
                className={`flex items-center gap-3 p-3 rounded-lg border ${
                  o.archived ? "bg-muted/30 opacity-60" : "bg-muted/10 hover:bg-muted/30"
                }`}
              >
                <Percent className="w-4 h-4 text-accent flex-shrink-0" />
                <div className="flex-1 min-w-0">
                  <p
                    className={`truncate ${
                      o.archived ? "line-through text-muted-foreground" : ""
                    }`}
                  >
                    {getProductoNombre(o.productoId)} —{" "}
                    <span className="text-accent">{o.discountPercent}% OFF</span>
                  </p>
                  <p className="text-xs text-muted-foreground">
                    {o.startDate} → {o.endDate}
                  </p>
                </div>
                {o.archived && (
                  <Badge variant="secondary" className="text-xs">
                    Archivado
                  </Badge>
                )}
                {!o.active && !o.archived && (
                  <Badge variant="outline" className="text-xs">
                    Inactivo
                  </Badge>
                )}
                <div className="flex items-center gap-1 flex-shrink-0">
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-8 w-8"
                    onClick={() =>
                      setOffers((prev) =>
                        prev.map((x) =>
                          x.id === o.id ? { ...x, archived: !x.archived } : x,
                        ),
                      )
                    }
                  >
                    {o.archived ? (
                      <ArchiveRestore className="w-3.5 h-3.5 text-accent" />
                    ) : (
                      <Archive className="w-3.5 h-3.5 text-muted-foreground" />
                    )}
                  </Button>
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-8 w-8"
                    onClick={() =>
                      setOffers((prev) => prev.filter((x) => x.id !== o.id))
                    }
                  >
                    <Trash2 className="w-3.5 h-3.5 text-destructive" />
                  </Button>
                </div>
              </div>
            ))
          )}
        </div>
      )}
    </>
  );
}

// ─── SELLERS SECTION ────────────────────────────────────────────────────
function SellersSection() {
  const {
    data: usuarios,
    loading,
    error,
  } = useFetch((signal) => usuariosService.list(signal), []);

  const [tab, setTab] = useState("manage");
  const [searchQuery, setSearchQuery] = useState("");
  const [sellerSearch, setSellerSearch] = useState("");
  // TODO: Replace with real vendedores endpoint when available
  const [sellerIds, setSellerIds] = useState<number[]>([]);

  const sellers: Usuario[] = (usuarios ?? []).filter((u) => sellerIds.includes(u.id));
  const pool: Usuario[] = (usuarios ?? []).filter((u) => !sellerIds.includes(u.id));

  const filteredPool = pool.filter(
    (u) =>
      u.usuario.toLowerCase().includes(searchQuery.toLowerCase()) ||
      u.nombre.toLowerCase().includes(searchQuery.toLowerCase()),
  );

  const filteredSellers = sellers.filter(
    (s) =>
      s.usuario.toLowerCase().includes(sellerSearch.toLowerCase()) ||
      s.nombre.toLowerCase().includes(sellerSearch.toLowerCase()),
  );

  const getProductCount = (vendedorId: number) =>
    0; // TODO: real count when backend supports it

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

      {tab === "add" && (
        <div className="space-y-4">
          {loading ? (
            <div className="flex items-center justify-center py-6 text-muted-foreground">
              <Loader2 className="w-4 h-4 mr-2 animate-spin" />
              Cargando usuarios…
            </div>
          ) : error ? (
            <p className="text-center py-6 text-destructive">
              No se pudieron cargar los usuarios: {error.message}
            </p>
          ) : (
            <>
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
                  {filteredPool.map((u) => (
                    <div
                      key={u.id}
                      className="flex items-center gap-3 p-3 rounded-lg border bg-muted/10 hover:bg-muted/30 transition-colors"
                    >
                      <img
                        src={`https://ui-avatars.com/api/?name=${encodeURIComponent(u.nombre)}&size=40`}
                        alt={u.nombre}
                        className="w-10 h-10 rounded-full object-cover flex-shrink-0 ring-1 ring-border"
                      />
                      <div className="flex-1 min-w-0">
                        <p className="truncate">{u.nombre}</p>
                        <p className="text-xs text-muted-foreground">@{u.usuario}</p>
                      </div>
                      <Button
                        size="sm"
                        onClick={() => setSellerIds((prev) => [...prev, u.id])}
                        className="bg-primary hover:bg-primary/90 flex-shrink-0"
                      >
                        <UserPlus className="w-4 h-4 mr-1" />
                        Agregar
                      </Button>
                    </div>
                  ))}
                </div>
              )}
            </>
          )}
        </div>
      )}

      {tab === "manage" && (
        <div className="space-y-3">
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
              {sellers.length === 0
                ? "No hay vendedores registrados. Usa «Agregar» para añadir uno."
                : "No se encontraron vendedores con ese nombre."}
            </p>
          ) : (
            <div className="max-h-[864px] overflow-y-auto space-y-2 pr-1">
              {filteredSellers.map((s) => (
                <div
                  key={s.id}
                  className="flex items-center gap-3 p-3 rounded-lg border bg-muted/10 hover:bg-muted/30 transition-colors"
                >
                  <img
                    src={`https://ui-avatars.com/api/?name=${encodeURIComponent(s.nombre)}&size=48`}
                    alt={s.nombre}
                    className="w-12 h-12 rounded-full object-cover flex-shrink-0 ring-1 ring-border"
                  />
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 flex-wrap">
                      <p className="truncate">{s.nombre}</p>
                    </div>
                    <p className="text-xs text-muted-foreground">@{s.usuario}</p>
                    <div className="flex items-center gap-3 mt-1 flex-wrap">
                      {/* TODO: real rating from backend */}
                      <span className="text-xs text-muted-foreground">
                        Sin calificaciones aún
                      </span>
                      <span className="text-xs text-muted-foreground flex items-center gap-1">
                        <Package className="w-3 h-3" />
                        {getProductCount(s.id)} productos
                      </span>
                    </div>
                  </div>
                  <div className="flex items-center gap-1 flex-shrink-0">
                    <Button
                      variant="ghost"
                      size="icon"
                      className="h-8 w-8"
                      onClick={() =>
                        setSellerIds((prev) => prev.filter((id) => id !== s.id))
                      }
                      title="Quitar como vendedor"
                    >
                      <Trash2 className="w-3.5 h-3.5 text-destructive" />
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          )}

          <p className="text-xs text-muted-foreground text-center pt-1">
            {filteredSellers.length}{" "}
            {filteredSellers.length === 1 ? "vendedor" : "vendedores"}
            {sellers.length !== filteredSellers.length &&
              ` de ${sellers.length}`}
          </p>
          <p className="text-xs text-muted-foreground text-center">
            TODO: Conectar con endpoint de vendedores cuando esté disponible
          </p>
        </div>
      )}
    </>
  );
}

// ─── MAIN ADMIN PANEL ───────────────────────────────────────────────────
export function AdminPanel() {
  const {
    data: backendProductos,
    loading: backendProductosLoading,
    error: backendProductosError,
  } = useFetch((signal) => productosService.list(signal), []);
  const productosSubtitle = backendProductosLoading
    ? "Cargando productos del backend…"
    : backendProductosError
      ? `Error: ${backendProductosError.message}`
      : "Agregar y administrar videojuegos del catálogo";

  const {
    data: backendCategorias,
    loading: backendCategoriasLoading,
    error: backendCategoriasError,
  } = useFetch((signal) => categoriasService.list(signal), []);
  const categoriasSubtitle = backendCategoriasLoading
    ? "Cargando categorías del backend…"
    : backendCategoriasError
      ? `Error: ${backendCategoriasError.message}`
      : "Organiza los productos por género o tipo";

  const {
    data: backendPaises,
    loading: backendPaisesLoading,
    error: backendPaisesError,
  } = useFetch((signal) => paisesService.list(signal), []);
  const paisesSubtitle = backendPaisesLoading
    ? "Cargando países del backend…"
    : backendPaisesError
      ? `Error: ${backendPaisesError.message}`
      : "Configura los países disponibles y sus monedas";

  const {
    data: backendVideojuegos,
    loading: backendVideojuegosLoading,
    error: backendVideojuegosError,
  } = useFetch((signal) => videojuegoService.list(signal), []);
  const videojuegosSubtitle = backendVideojuegosLoading
    ? "Cargando videojuegos del backend…"
    : backendVideojuegosError
      ? `Error: ${backendVideojuegosError.message}`
      : "Configura los videojuegos disponibles";

  const {
    data: backendMetodos,
    loading: backendMetodosLoading,
    error: backendMetodosError,
  } = useFetch((signal) => metodosPagoService.list(signal), []);
  const metodosSubtitle = backendMetodosLoading
    ? "Cargando métodos del backend…"
    : backendMetodosError
      ? `Error: ${backendMetodosError.message}`
      : "Gestiona las opciones de pago por país";

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
            count={backendProductos?.length ?? undefined}
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

          {/* <AdminExpandableCard
            icon={<Percent className="w-5 h-5" />}
            title="Ofertas"
            subtitle="Crear y gestionar descuentos en productos"
            accentColor="bg-accent/10 text-accent"
          >
            <OffersSection />
          </AdminExpandableCard> */}

          <AdminExpandableCard
            icon={<Tag className="w-5 h-5" />}
            title="Categorías"
            subtitle={categoriasSubtitle}
            accentColor="bg-secondary/10 text-secondary"
            count={backendCategorias?.length ?? undefined}
            countLabel="en backend"
          >
            <CategoriesSection />
          </AdminExpandableCard>

          <AdminExpandableCard
            icon={<Globe className="w-5 h-5" />}
            title="Países y Monedas"
            subtitle={paisesSubtitle}
            accentColor="bg-amber-500/10 text-amber-600"
            count={backendPaises?.length ?? undefined}
            countLabel="países"
          >
            <CountriesSection />

          </AdminExpandableCard>

          <AdminExpandableCard
              icon={<Globe className="w-5 h-5" />}
              title="Videojuegos"
              subtitle={videojuegosSubtitle}
              accentColor="bg-amber-500/10 text-amber-600"
              count={backendVideojuegos?.length ?? undefined}
              countLabel="videojuegos"
          >
            <VideogamesSection />

          </AdminExpandableCard>


          <AdminExpandableCard
            icon={<Wallet className="w-5 h-5" />}
            title="Métodos de Pago"
            subtitle={metodosSubtitle}
            accentColor="bg-emerald-500/10 text-emerald-600"
            count={backendMetodos?.length ?? undefined}
            countLabel="métodos"
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