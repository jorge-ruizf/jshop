# E-Shop Cuentas & Videojuegos

React + Vite frontend (TypeScript, Tailwind v4, shadcn/ui, MUI, react-router) + Node/Express backend with Prisma + PostgreSQL.

## Structure
- `frontend/` — Vite app (port 5000)
  - `src/main.tsx` — entry
  - `src/app/App.tsx` — root
  - `src/app/routes.ts` — routes (Store, Login, Checkout, AdminPanel)
  - `src/app/services/` — backend service layer (one module per entity + barrel)
  - `src/app/hooks/useFetch.ts` — `{ data, loading, error, refresh }` fetch helper
  - `src/styles/` — global styles (tailwind v4)
- `backend/` — Express + Prisma (port 3001, bound to 127.0.0.1)
  - `src/routes/index.js` — mounts `/api/*` routes
  - REST endpoints: `/api/usuarios`, `/api/productos`, `/api/categorias`, `/api/paises`, `/api/metodos-pago`

## Backend wiring progress
Iteratively connecting one entity at a time across all listed pages, replacing mocks with real API calls via the service layer (loading/error/empty states handled).
- Producto → Store, Login, Layout (cart badge), AdminPanel (Productos card), Checkout (cart items).
- Categoria → Store (filters), AdminPanel (CRUD).
- Pais → AdminPanel (CRUD), Layout (preferred-country dropdown), Checkout (payment country).
- MetodoPago → AdminPanel (CRUD), Checkout (payment method radio).

Backend `Pais` and `MetodoPago` schemas only contain `{ id, nombre }`, so flag/currency/code/description/per-country grouping from the mock store-context are intentionally not surfaced when consuming backend data.

## Dev
- Workflow `Frontend`: `cd frontend && npm run dev` on port 5000 (host `0.0.0.0`, `allowedHosts: true`, vite proxy `/api → http://127.0.0.1:3001`).
- Workflow `Backend`: `cd backend && npm start` on port 3001.

## Deployment
Static frontend — builds via `cd frontend && npm run build`, serves `frontend/dist`. Backend deployed separately.
