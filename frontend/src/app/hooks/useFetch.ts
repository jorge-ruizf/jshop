import { useEffect, useRef, useState } from "react";
import { ApiError } from "../services/api";

export interface FetchState<T> {
  data: T | null;
  loading: boolean;
  error: ApiError | Error | null;
}

// Generic data-fetching hook for use with the resource services.
// The fetcher receives an AbortSignal so in-flight requests are cancelled
// when the component unmounts or deps change.
// Usage: const { data, loading, error } = useFetch((signal) => productosService.list(signal), []);
export function useFetch<T>(
  fetcher: (signal: AbortSignal) => Promise<T>,
  deps: ReadonlyArray<unknown> = [],
): FetchState<T> & { refresh: () => void } {
  const [state, setState] = useState<FetchState<T>>({
    data: null,
    loading: true,
    error: null,
  });
  const tickRef = useRef(0);

  useEffect(() => {
    const controller = new AbortController();
    setState((s) => ({ ...s, loading: true, error: null }));
    fetcher(controller.signal)
      .then((data) => setState({ data, loading: false, error: null }))
      .catch((error) => {
        if (controller.signal.aborted) return;
        setState({ data: null, loading: false, error });
      });
    return () => controller.abort();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [...deps, tickRef.current]);

  return {
    ...state,
    refresh: () => {
      tickRef.current += 1;
      setState((s) => ({ ...s, loading: true }));
    },
  };
}
