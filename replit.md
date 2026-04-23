# E-Shop Cuentas & Videojuegos

React + Vite frontend (TypeScript, Tailwind v4, shadcn/ui, MUI, react-router).

## Structure
- `frontend/` — Vite app
  - `src/main.tsx` — entry
  - `src/app/App.tsx` — root
  - `src/app/routes.ts` — routes (Store, Login, Checkout, AdminPanel)
  - `src/styles/` — global styles (tailwind v4)
- `backend/` — placeholder (not implemented yet)

## Dev
Workflow `Frontend`: `cd frontend && npm run dev` on port 5000 (host `0.0.0.0`, `allowedHosts: true` for Replit proxy).

## Deployment
Static — builds via `cd frontend && npm run build`, serves `frontend/dist`.
