import { useState, type ReactNode } from "react";
import { ChevronUp, ChevronDown } from "lucide-react";

interface AdminExpandableCardProps {
  icon: ReactNode;
  title: string;
  subtitle: string;
  children: ReactNode;
  defaultOpen?: boolean;
  accentColor?: string;
}

export function AdminExpandableCard({
  icon,
  title,
  subtitle,
  children,
  defaultOpen = false,
  accentColor = "bg-primary/10 text-primary",
}: AdminExpandableCardProps) {
  const [isExpanded, setIsExpanded] = useState(defaultOpen);

  return (
    <div className="rounded-xl border border-border bg-card shadow-sm overflow-hidden transition-all duration-200">
      {/* Header - always visible */}
      <button
        type="button"
        onClick={() => setIsExpanded(!isExpanded)}
        className="w-full flex items-center justify-between p-5 hover:bg-muted/30 transition-colors cursor-pointer"
      >
        <div className="flex items-center gap-3">
          <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${accentColor}`}>
            {icon}
          </div>
          <div className="text-left">
            <h3 className="text-[1rem]">{title}</h3>
            <p className="text-sm text-muted-foreground">{subtitle}</p>
          </div>
        </div>
        <div className="flex items-center justify-center w-8 h-8 rounded-md hover:bg-muted transition-colors">
          {isExpanded ? (
            <ChevronUp className="w-5 h-5 text-muted-foreground" />
          ) : (
            <ChevronDown className="w-5 h-5 text-muted-foreground" />
          )}
        </div>
      </button>

      {/* Content - expandable */}
      {isExpanded && (
        <div className="border-t border-border px-5 pb-5 pt-4">
          {children}
        </div>
      )}
    </div>
  );
}
