import { createBrowserRouter } from "react-router";
import { Layout } from "./components/Layout";
import { Store } from "./pages/Store";
import { Login } from "./pages/Login";
import { Checkout } from "./pages/Checkout";
import { AdminPanel } from "./pages/AdminPanel";

export const router = createBrowserRouter([
  {
    path: "/",
    Component: Layout,
    children: [
      {
        index: true,
        Component: Store,
      },
      {
        path: "login",
        Component: Login,
      },
      {
        path: "checkout",
        Component: Checkout,
      },
      {
        path: "admin",
        Component: AdminPanel,
      },
    ],
  },
]);
