import { RouterProvider } from "react-router";
import { router } from "./routes";
import { StoreProvider } from "./data/store-context";
import { AuthProvider } from "./contexts/AuthContext";

export default function App() {
  return (
    <AuthProvider>
      <StoreProvider>
        <RouterProvider router={router} />
      </StoreProvider>
    </AuthProvider>
  );
}
