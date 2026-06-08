import { Bell } from "lucide-react";
import type { ProductoDeseado } from "../services/types.ts";

interface Props {
  alertaExistente?: ProductoDeseado;
  onClick: () => void;
}

export function PriceAlertButton({ alertaExistente, onClick }: Props) {
  return (
    <button
      onClick={(e) => {
        e.stopPropagation();
        onClick();
      }}
      title={alertaExistente ? "Editar alerta de precio" : "Crear alerta de precio"}
      className={`
        absolute top-2 left-2 w-[16.6%] aspect-square
        rounded-full backdrop-blur-sm border transition-all duration-200
        flex items-center justify-center
        opacity-0 group-hover:opacity-100
        ${alertaExistente
          ? "bg-primary/90 border-primary text-primary-foreground"
          : "bg-black/40 border-white/20 text-white hover:bg-black/60"
        }
      `}
    >
      <Bell
        className="w-1/2 h-1/2"
        fill={alertaExistente ? "currentColor" : "none"}
        strokeWidth={1.8}
      />
    </button>
  );
}