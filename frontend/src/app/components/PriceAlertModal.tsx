import { useState } from "react";
import { Bell, BellOff, X, Check, Loader2 } from "lucide-react";
import { Button } from "./ui/button";
import { productosDeseadosService } from "../services/productosDeseados.service";
import type { Producto } from "../services/types";
import type { ProductoDeseado } from "../services/types.ts";

interface Props {
  producto: Producto;
  idUsuario: number;
  /** Alerta existente para este producto (undefined = no existe aún) */
  alertaExistente?: ProductoDeseado;
  onClose: () => void;
  onSuccess: (alerta: ProductoDeseado | null) => void; // null = eliminada
}

type Estado = "form" | "guardando" | "confirmado" | "eliminando";

export function PriceAlertModal({
  producto,
  idUsuario,
  alertaExistente,
  onClose,
  onSuccess,
}: Props) {
  const precioReferencia = producto.precios?.[0]?.precio ?? 0;

  const [precioObjetivo, setPrecioObjetivo] = useState<string>(
    alertaExistente ? String(alertaExistente.precio_objetivo) : ""
  );
  const [estado, setEstado] = useState<Estado>("form");
  const [error, setError] = useState<string>("");

  const fmt = (n: number) =>
    Number(n).toLocaleString("es-CO", {
      style: "currency",
      currency: "COP",
      maximumFractionDigits: 0,
    });

  const descuento =
    precioReferencia && precioObjetivo
      ? Math.round(((precioReferencia - Number(precioObjetivo)) / precioReferencia) * 100)
      : null;

  const handleGuardar = async () => {
    const valor = Number(precioObjetivo);
    if (!valor || valor <= 0) {
      setError("Ingresa un precio válido mayor a 0.");
      return;
    }
    setError("");
    setEstado("guardando");

    try {
      let resultado: ProductoDeseado;
      if (alertaExistente) {
        resultado = await productosDeseadosService.actualizar(alertaExistente.id, valor);
      } else {
        resultado = await productosDeseadosService.crear({
          id_producto: producto.id,
          id_usuario: idUsuario,
          precio_objetivo: valor,
        });
      }
      setEstado("confirmado");
      setTimeout(() => {
        onSuccess(resultado);
        onClose();
      }, 1800);
    } catch {
      setError("No se pudo guardar la alerta. Intenta de nuevo.");
      setEstado("form");
    }
  };

  const handleEliminar = async () => {
    if (!alertaExistente) return;
    setEstado("eliminando");
    try {
      await productosDeseadosService.eliminar(alertaExistente.id);
      onSuccess(null);
      onClose();
    } catch {
      setError("No se pudo eliminar la alerta.");
      setEstado("form");
    }
  };

  return (
    // Backdrop
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 px-4"
      onClick={(e) => e.target === e.currentTarget && onClose()}
    >
      <div className="w-full max-w-sm rounded-2xl border border-border bg-card shadow-xl">

        {/* Header */}
        <div className="flex items-center justify-between px-5 pt-5 pb-3">
          <div className="flex items-center gap-2">
            <Bell className="w-4 h-4 text-primary" />
            <span className="font-medium text-sm">
              {alertaExistente ? "Editar alerta de precio" : "Crear alerta de precio"}
            </span>
          </div>
          <button onClick={onClose} className="text-muted-foreground hover:text-foreground">
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* Producto info */}
        <div className="mx-5 mb-4 rounded-lg bg-muted/50 px-4 py-3">
          <p className="text-xs text-muted-foreground mb-1">Producto</p>
          <p className="font-medium text-sm leading-snug line-clamp-2">{producto.nombre}</p>
          {precioReferencia > 0 && (
            <p className="text-xs text-muted-foreground mt-1.5">
              Precio actual:{" "}
              <span className="text-foreground font-medium">{fmt(precioReferencia)}</span>
            </p>
          )}
        </div>

        {/* Estados */}
        {(estado === "guardando" || estado === "eliminando") && (
          <div className="flex flex-col items-center gap-3 py-10 px-5">
            <Loader2 className="w-7 h-7 animate-spin text-primary" />
            <p className="text-sm text-muted-foreground">
              {estado === "eliminando" ? "Eliminando alerta…" : "Guardando alerta…"}
            </p>
          </div>
        )}

        {estado === "confirmado" && (
          <div className="flex flex-col items-center gap-3 py-10 px-5">
            <div className="w-12 h-12 rounded-full bg-green-100 dark:bg-green-900/30 flex items-center justify-center">
              <Check className="w-6 h-6 text-green-600 dark:text-green-400" />
            </div>
            <p className="text-sm font-medium">¡Alerta guardada!</p>
            <p className="text-xs text-muted-foreground text-center">
              Te avisaremos por email cuando el precio baje a{" "}
              <strong>{fmt(Number(precioObjetivo))}</strong>
            </p>
          </div>
        )}

        {estado === "form" && (
          <>
            {/* Input precio */}
            <div className="px-5 mb-4">
              <label className="text-xs text-muted-foreground block mb-1.5">
                Notificarme cuando el precio sea igual o menor a
              </label>
              <div className="flex items-center border border-border rounded-lg overflow-hidden focus-within:ring-1 focus-within:ring-primary">
                <span className="px-3 text-sm text-muted-foreground bg-muted border-r border-border py-2.5">
                  $
                </span>
                <input
                  type="number"
                  min={1}
                  placeholder="ej: 3800000"
                  value={precioObjetivo}
                  onChange={(e) => {
                    setPrecioObjetivo(e.target.value);
                    setError("");
                  }}
                  className="flex-1 px-3 py-2.5 text-sm bg-transparent outline-none"
                  autoFocus
                />
              </div>

              {/* Hint de descuento */}
              {descuento !== null && precioReferencia > 0 && (
                <p className={`text-xs mt-1.5 ${descuento < 0 ? "text-amber-500" : "text-muted-foreground"}`}>
                  {descuento < 0
                    ? "⚠ El precio objetivo es mayor al actual — te notificaríamos de inmediato"
                    : descuento === 0
                    ? "Igual al precio actual"
                    : `Descuento de ${descuento}% sobre el precio actual`}
                </p>
              )}

              {error && <p className="text-xs text-destructive mt-1.5">{error}</p>}
            </div>

            {/* Acciones */}
            <div className="flex gap-2 px-5 pb-5">
              {alertaExistente && (
                <Button
                  variant="ghost"
                  size="sm"
                  className="text-destructive hover:text-destructive hover:bg-destructive/10"
                  onClick={handleEliminar}
                >
                  <BellOff className="w-3.5 h-3.5 mr-1" />
                  Eliminar
                </Button>
              )}
              <Button variant="outline" size="sm" className="flex-1" onClick={onClose}>
                Cancelar
              </Button>
              <Button size="sm" className="flex-1" onClick={handleGuardar}>
                <Bell className="w-3.5 h-3.5 mr-1" />
                {alertaExistente ? "Actualizar" : "Guardar alerta"}
              </Button>
            </div>
          </>
        )}

      </div>
    </div>
  );
}