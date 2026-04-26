--
-- PostgreSQL database dump
--

\restrict ZytmJnMkXbfXiS2RkrNmAzeqnL9qinPbwSaN09EaqJJ25N8WoHS140tE1LiiIES

-- Dumped from database version 17.9 (Debian 17.9-0+deb13u1)
-- Dumped by pg_dump version 17.9 (Debian 17.9-0+deb13u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: jorge
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO jorge;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Carrito; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Carrito" (
    id integer NOT NULL,
    id_producto integer NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public."Carrito" OWNER TO jorge;

--
-- Name: Carrito_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Carrito_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Carrito_id_seq" OWNER TO jorge;

--
-- Name: Carrito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Carrito_id_seq" OWNED BY public."Carrito".id;


--
-- Name: Categoria; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Categoria" (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public."Categoria" OWNER TO jorge;

--
-- Name: Categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Categoria_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Categoria_id_seq" OWNER TO jorge;

--
-- Name: Categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Categoria_id_seq" OWNED BY public."Categoria".id;


--
-- Name: Chat; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Chat" (
    id integer NOT NULL,
    id_usuario_a integer NOT NULL,
    id_usuario_b integer NOT NULL,
    creado_en timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Chat" OWNER TO jorge;

--
-- Name: Chat_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Chat_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Chat_id_seq" OWNER TO jorge;

--
-- Name: Chat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Chat_id_seq" OWNED BY public."Chat".id;


--
-- Name: Imagen_Mensaje; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Imagen_Mensaje" (
    id integer NOT NULL,
    id_mensaje integer NOT NULL,
    url text NOT NULL
);


ALTER TABLE public."Imagen_Mensaje" OWNER TO jorge;

--
-- Name: Imagen_Mensaje_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Imagen_Mensaje_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Imagen_Mensaje_id_seq" OWNER TO jorge;

--
-- Name: Imagen_Mensaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Imagen_Mensaje_id_seq" OWNED BY public."Imagen_Mensaje".id;


--
-- Name: Imagen_Producto; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Imagen_Producto" (
    id integer NOT NULL,
    id_producto integer NOT NULL,
    url text NOT NULL
);


ALTER TABLE public."Imagen_Producto" OWNER TO jorge;

--
-- Name: Imagen_Producto_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Imagen_Producto_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Imagen_Producto_id_seq" OWNER TO jorge;

--
-- Name: Imagen_Producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Imagen_Producto_id_seq" OWNED BY public."Imagen_Producto".id;


--
-- Name: Mensaje; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Mensaje" (
    id integer NOT NULL,
    id_chat integer NOT NULL,
    id_usuario integer NOT NULL,
    contenido text NOT NULL,
    enviado_en timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Mensaje" OWNER TO jorge;

--
-- Name: Mensaje_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Mensaje_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Mensaje_id_seq" OWNER TO jorge;

--
-- Name: Mensaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Mensaje_id_seq" OWNED BY public."Mensaje".id;


--
-- Name: Metodo_Pago; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Metodo_Pago" (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public."Metodo_Pago" OWNER TO jorge;

--
-- Name: Metodo_Pago_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Metodo_Pago_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Metodo_Pago_id_seq" OWNER TO jorge;

--
-- Name: Metodo_Pago_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Metodo_Pago_id_seq" OWNED BY public."Metodo_Pago".id;


--
-- Name: Notificacion; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Notificacion" (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    contenido text NOT NULL,
    leida boolean DEFAULT false NOT NULL,
    creado_en timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Notificacion" OWNER TO jorge;

--
-- Name: Notificacion_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Notificacion_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Notificacion_id_seq" OWNER TO jorge;

--
-- Name: Notificacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Notificacion_id_seq" OWNED BY public."Notificacion".id;


--
-- Name: Pais; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Pais" (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public."Pais" OWNER TO jorge;

--
-- Name: Pais_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Pais_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Pais_id_seq" OWNER TO jorge;

--
-- Name: Pais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Pais_id_seq" OWNED BY public."Pais".id;


--
-- Name: Precio; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Precio" (
    id integer NOT NULL,
    id_producto integer NOT NULL,
    id_pais integer NOT NULL,
    precio double precision NOT NULL
);


ALTER TABLE public."Precio" OWNER TO jorge;

--
-- Name: Precio_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Precio_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Precio_id_seq" OWNER TO jorge;

--
-- Name: Precio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Precio_id_seq" OWNED BY public."Precio".id;


--
-- Name: Producto; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Producto" (
    id integer NOT NULL,
    nombre text NOT NULL,
    descripcion text NOT NULL,
    id_categoria integer NOT NULL,
    id_pais integer NOT NULL,
    id_vendedor integer NOT NULL
);


ALTER TABLE public."Producto" OWNER TO jorge;

--
-- Name: Producto_Deseado; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Producto_Deseado" (
    id integer NOT NULL,
    id_producto integer NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public."Producto_Deseado" OWNER TO jorge;

--
-- Name: Producto_Deseado_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Producto_Deseado_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Producto_Deseado_id_seq" OWNER TO jorge;

--
-- Name: Producto_Deseado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Producto_Deseado_id_seq" OWNED BY public."Producto_Deseado".id;


--
-- Name: Producto_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Producto_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Producto_id_seq" OWNER TO jorge;

--
-- Name: Producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Producto_id_seq" OWNED BY public."Producto".id;


--
-- Name: Rol; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Rol" (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public."Rol" OWNER TO jorge;

--
-- Name: Rol_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Rol_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Rol_id_seq" OWNER TO jorge;

--
-- Name: Rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Rol_id_seq" OWNED BY public."Rol".id;


--
-- Name: Usuario; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Usuario" (
    id integer NOT NULL,
    nombre text NOT NULL,
    usuario text NOT NULL,
    correo text NOT NULL,
    id_metodo_pago_fav integer NOT NULL,
    id_pais integer NOT NULL,
    id_rol integer NOT NULL
);


ALTER TABLE public."Usuario" OWNER TO jorge;

--
-- Name: Usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Usuario_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Usuario_id_seq" OWNER TO jorge;

--
-- Name: Usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Usuario_id_seq" OWNED BY public."Usuario".id;


--
-- Name: Valoracion; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Valoracion" (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    id_producto integer NOT NULL,
    puntuacion integer NOT NULL,
    comentario text,
    creado_en timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Valoracion" OWNER TO jorge;

--
-- Name: Valoracion_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Valoracion_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Valoracion_id_seq" OWNER TO jorge;

--
-- Name: Valoracion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Valoracion_id_seq" OWNED BY public."Valoracion".id;


--
-- Name: Venta; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Venta" (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    metodo_pago integer NOT NULL
);


ALTER TABLE public."Venta" OWNER TO jorge;

--
-- Name: Venta_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Venta_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Venta_id_seq" OWNER TO jorge;

--
-- Name: Venta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Venta_id_seq" OWNED BY public."Venta".id;


--
-- Name: Venta_x_Producto; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Venta_x_Producto" (
    id integer NOT NULL,
    id_producto integer NOT NULL,
    id_venta integer NOT NULL,
    cantidad integer NOT NULL,
    precio double precision NOT NULL
);


ALTER TABLE public."Venta_x_Producto" OWNER TO jorge;

--
-- Name: Venta_x_Producto_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Venta_x_Producto_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Venta_x_Producto_id_seq" OWNER TO jorge;

--
-- Name: Venta_x_Producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Venta_x_Producto_id_seq" OWNED BY public."Venta_x_Producto".id;


--
-- Name: Videojuego; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public."Videojuego" (
    id integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public."Videojuego" OWNER TO jorge;

--
-- Name: Videojuego_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public."Videojuego_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Videojuego_id_seq" OWNER TO jorge;

--
-- Name: Videojuego_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public."Videojuego_id_seq" OWNED BY public."Videojuego".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO jorge;

--
-- Name: Carrito id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Carrito" ALTER COLUMN id SET DEFAULT nextval('public."Carrito_id_seq"'::regclass);


--
-- Name: Categoria id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Categoria" ALTER COLUMN id SET DEFAULT nextval('public."Categoria_id_seq"'::regclass);


--
-- Name: Chat id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Chat" ALTER COLUMN id SET DEFAULT nextval('public."Chat_id_seq"'::regclass);


--
-- Name: Imagen_Mensaje id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Imagen_Mensaje" ALTER COLUMN id SET DEFAULT nextval('public."Imagen_Mensaje_id_seq"'::regclass);


--
-- Name: Imagen_Producto id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Imagen_Producto" ALTER COLUMN id SET DEFAULT nextval('public."Imagen_Producto_id_seq"'::regclass);


--
-- Name: Mensaje id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Mensaje" ALTER COLUMN id SET DEFAULT nextval('public."Mensaje_id_seq"'::regclass);


--
-- Name: Metodo_Pago id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Metodo_Pago" ALTER COLUMN id SET DEFAULT nextval('public."Metodo_Pago_id_seq"'::regclass);


--
-- Name: Notificacion id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Notificacion" ALTER COLUMN id SET DEFAULT nextval('public."Notificacion_id_seq"'::regclass);


--
-- Name: Pais id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Pais" ALTER COLUMN id SET DEFAULT nextval('public."Pais_id_seq"'::regclass);


--
-- Name: Precio id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Precio" ALTER COLUMN id SET DEFAULT nextval('public."Precio_id_seq"'::regclass);


--
-- Name: Producto id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Producto" ALTER COLUMN id SET DEFAULT nextval('public."Producto_id_seq"'::regclass);


--
-- Name: Producto_Deseado id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Producto_Deseado" ALTER COLUMN id SET DEFAULT nextval('public."Producto_Deseado_id_seq"'::regclass);


--
-- Name: Rol id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Rol" ALTER COLUMN id SET DEFAULT nextval('public."Rol_id_seq"'::regclass);


--
-- Name: Usuario id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Usuario" ALTER COLUMN id SET DEFAULT nextval('public."Usuario_id_seq"'::regclass);


--
-- Name: Valoracion id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Valoracion" ALTER COLUMN id SET DEFAULT nextval('public."Valoracion_id_seq"'::regclass);


--
-- Name: Venta id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Venta" ALTER COLUMN id SET DEFAULT nextval('public."Venta_id_seq"'::regclass);


--
-- Name: Venta_x_Producto id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Venta_x_Producto" ALTER COLUMN id SET DEFAULT nextval('public."Venta_x_Producto_id_seq"'::regclass);


--
-- Name: Videojuego id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Videojuego" ALTER COLUMN id SET DEFAULT nextval('public."Videojuego_id_seq"'::regclass);


--
-- Data for Name: Carrito; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Carrito" (id, id_producto, id_usuario) FROM stdin;
\.


--
-- Data for Name: Categoria; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Categoria" (id, nombre) FROM stdin;
1	MOBA
2	RPG
3	Sandbox
4	Supervivencia
\.


--
-- Data for Name: Chat; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Chat" (id, id_usuario_a, id_usuario_b, creado_en) FROM stdin;
\.


--
-- Data for Name: Imagen_Mensaje; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Imagen_Mensaje" (id, id_mensaje, url) FROM stdin;
\.


--
-- Data for Name: Imagen_Producto; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Imagen_Producto" (id, id_producto, url) FROM stdin;
\.


--
-- Data for Name: Mensaje; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Mensaje" (id, id_chat, id_usuario, contenido, enviado_en) FROM stdin;
\.


--
-- Data for Name: Metodo_Pago; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Metodo_Pago" (id, nombre) FROM stdin;
1	Nequi
\.


--
-- Data for Name: Notificacion; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Notificacion" (id, id_usuario, contenido, leida, creado_en) FROM stdin;
\.


--
-- Data for Name: Pais; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Pais" (id, nombre) FROM stdin;
1	Colombia
\.


--
-- Data for Name: Precio; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Precio" (id, id_producto, id_pais, precio) FROM stdin;
\.


--
-- Data for Name: Producto; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Producto" (id, nombre, descripcion, id_categoria, id_pais, id_vendedor) FROM stdin;
1	cuenta de LoL	cuenta de Lol con rango Grand Master	1	1	1
\.


--
-- Data for Name: Producto_Deseado; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Producto_Deseado" (id, id_producto, id_usuario) FROM stdin;
\.


--
-- Data for Name: Rol; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Rol" (id, nombre) FROM stdin;
1	Usuario
2	Vendedor
3	Administrador
\.


--
-- Data for Name: Usuario; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Usuario" (id, nombre, usuario, correo, id_metodo_pago_fav, id_pais, id_rol) FROM stdin;
1	Jose Luis	NextShop	joseluis32@gmail.com	1	1	2
\.


--
-- Data for Name: Valoracion; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Valoracion" (id, id_usuario, id_producto, puntuacion, comentario, creado_en) FROM stdin;
\.


--
-- Data for Name: Venta; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Venta" (id, id_usuario, metodo_pago) FROM stdin;
\.


--
-- Data for Name: Venta_x_Producto; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Venta_x_Producto" (id, id_producto, id_venta, cantidad, precio) FROM stdin;
\.


--
-- Data for Name: Videojuego; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public."Videojuego" (id, nombre) FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
bd1f396a-9876-4e9f-9e58-9572cd445784	3a61c41613363f04c3674ace0b8c03e6f3bb30fcb9074ffe6c93e784a9d01056	2026-04-26 11:53:15.71863-05	20260424014139_init	\N	\N	2026-04-26 11:53:15.702365-05	1
0634d820-620c-4ec6-90b4-62fcc0492fb2	6472c3ad1b87c17acf77d21ad3df8778c91817567f2e7c2fe6717c87537fdcc8	2026-04-26 11:53:15.750929-05	20260424014320_relations	\N	\N	2026-04-26 11:53:15.721121-05	1
26e92a75-c84b-47f3-b3a2-88f14a9ca5e4	2c43d6913b1287d5775fe8994ef7bb0c0a7d72ce6c85ae709a9540c2a62b14ef	2026-04-26 11:53:15.774203-05	20260424015226_chat_mensaje_imagen_valoracion_notificacion	\N	\N	2026-04-26 11:53:15.752101-05	1
\.


--
-- Name: Carrito_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Carrito_id_seq"', 1, false);


--
-- Name: Categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Categoria_id_seq"', 4, true);


--
-- Name: Chat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Chat_id_seq"', 1, false);


--
-- Name: Imagen_Mensaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Imagen_Mensaje_id_seq"', 1, false);


--
-- Name: Imagen_Producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Imagen_Producto_id_seq"', 1, false);


--
-- Name: Mensaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Mensaje_id_seq"', 1, false);


--
-- Name: Metodo_Pago_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Metodo_Pago_id_seq"', 1, true);


--
-- Name: Notificacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Notificacion_id_seq"', 1, false);


--
-- Name: Pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Pais_id_seq"', 4, true);


--
-- Name: Precio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Precio_id_seq"', 1, false);


--
-- Name: Producto_Deseado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Producto_Deseado_id_seq"', 1, false);


--
-- Name: Producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Producto_id_seq"', 1, true);


--
-- Name: Rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Rol_id_seq"', 3, true);


--
-- Name: Usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Usuario_id_seq"', 1, true);


--
-- Name: Valoracion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Valoracion_id_seq"', 1, false);


--
-- Name: Venta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Venta_id_seq"', 1, false);


--
-- Name: Venta_x_Producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Venta_x_Producto_id_seq"', 1, false);


--
-- Name: Videojuego_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public."Videojuego_id_seq"', 1, false);


--
-- Name: Carrito Carrito_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Carrito"
    ADD CONSTRAINT "Carrito_pkey" PRIMARY KEY (id);


--
-- Name: Categoria Categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Categoria"
    ADD CONSTRAINT "Categoria_pkey" PRIMARY KEY (id);


--
-- Name: Chat Chat_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Chat"
    ADD CONSTRAINT "Chat_pkey" PRIMARY KEY (id);


--
-- Name: Imagen_Mensaje Imagen_Mensaje_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Imagen_Mensaje"
    ADD CONSTRAINT "Imagen_Mensaje_pkey" PRIMARY KEY (id);


--
-- Name: Imagen_Producto Imagen_Producto_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Imagen_Producto"
    ADD CONSTRAINT "Imagen_Producto_pkey" PRIMARY KEY (id);


--
-- Name: Mensaje Mensaje_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Mensaje"
    ADD CONSTRAINT "Mensaje_pkey" PRIMARY KEY (id);


--
-- Name: Metodo_Pago Metodo_Pago_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Metodo_Pago"
    ADD CONSTRAINT "Metodo_Pago_pkey" PRIMARY KEY (id);


--
-- Name: Notificacion Notificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Notificacion"
    ADD CONSTRAINT "Notificacion_pkey" PRIMARY KEY (id);


--
-- Name: Pais Pais_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Pais"
    ADD CONSTRAINT "Pais_pkey" PRIMARY KEY (id);


--
-- Name: Precio Precio_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Precio"
    ADD CONSTRAINT "Precio_pkey" PRIMARY KEY (id);


--
-- Name: Producto_Deseado Producto_Deseado_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Producto_Deseado"
    ADD CONSTRAINT "Producto_Deseado_pkey" PRIMARY KEY (id);


--
-- Name: Producto Producto_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_pkey" PRIMARY KEY (id);


--
-- Name: Rol Rol_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_pkey" PRIMARY KEY (id);


--
-- Name: Usuario Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY (id);


--
-- Name: Valoracion Valoracion_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Valoracion"
    ADD CONSTRAINT "Valoracion_pkey" PRIMARY KEY (id);


--
-- Name: Venta Venta_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Venta"
    ADD CONSTRAINT "Venta_pkey" PRIMARY KEY (id);


--
-- Name: Venta_x_Producto Venta_x_Producto_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Venta_x_Producto"
    ADD CONSTRAINT "Venta_x_Producto_pkey" PRIMARY KEY (id);


--
-- Name: Videojuego Videojuego_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Videojuego"
    ADD CONSTRAINT "Videojuego_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Usuario_correo_key; Type: INDEX; Schema: public; Owner: jorge
--

CREATE UNIQUE INDEX "Usuario_correo_key" ON public."Usuario" USING btree (correo);


--
-- Name: Usuario_usuario_key; Type: INDEX; Schema: public; Owner: jorge
--

CREATE UNIQUE INDEX "Usuario_usuario_key" ON public."Usuario" USING btree (usuario);


--
-- Name: Carrito Carrito_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Carrito"
    ADD CONSTRAINT "Carrito_id_producto_fkey" FOREIGN KEY (id_producto) REFERENCES public."Producto"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Carrito Carrito_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Carrito"
    ADD CONSTRAINT "Carrito_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Chat Chat_id_usuario_a_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Chat"
    ADD CONSTRAINT "Chat_id_usuario_a_fkey" FOREIGN KEY (id_usuario_a) REFERENCES public."Usuario"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Chat Chat_id_usuario_b_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Chat"
    ADD CONSTRAINT "Chat_id_usuario_b_fkey" FOREIGN KEY (id_usuario_b) REFERENCES public."Usuario"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Imagen_Mensaje Imagen_Mensaje_id_mensaje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Imagen_Mensaje"
    ADD CONSTRAINT "Imagen_Mensaje_id_mensaje_fkey" FOREIGN KEY (id_mensaje) REFERENCES public."Mensaje"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Imagen_Producto Imagen_Producto_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Imagen_Producto"
    ADD CONSTRAINT "Imagen_Producto_id_producto_fkey" FOREIGN KEY (id_producto) REFERENCES public."Producto"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Mensaje Mensaje_id_chat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Mensaje"
    ADD CONSTRAINT "Mensaje_id_chat_fkey" FOREIGN KEY (id_chat) REFERENCES public."Chat"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Mensaje Mensaje_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Mensaje"
    ADD CONSTRAINT "Mensaje_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Notificacion Notificacion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Notificacion"
    ADD CONSTRAINT "Notificacion_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Precio Precio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Precio"
    ADD CONSTRAINT "Precio_id_pais_fkey" FOREIGN KEY (id_pais) REFERENCES public."Pais"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Precio Precio_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Precio"
    ADD CONSTRAINT "Precio_id_producto_fkey" FOREIGN KEY (id_producto) REFERENCES public."Producto"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Producto_Deseado Producto_Deseado_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Producto_Deseado"
    ADD CONSTRAINT "Producto_Deseado_id_producto_fkey" FOREIGN KEY (id_producto) REFERENCES public."Producto"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Producto_Deseado Producto_Deseado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Producto_Deseado"
    ADD CONSTRAINT "Producto_Deseado_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Producto Producto_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_id_categoria_fkey" FOREIGN KEY (id_categoria) REFERENCES public."Categoria"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Producto Producto_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_id_pais_fkey" FOREIGN KEY (id_pais) REFERENCES public."Pais"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Producto Producto_id_vendedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_id_vendedor_fkey" FOREIGN KEY (id_vendedor) REFERENCES public."Usuario"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Usuario Usuario_id_metodo_pago_fav_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_id_metodo_pago_fav_fkey" FOREIGN KEY (id_metodo_pago_fav) REFERENCES public."Metodo_Pago"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Usuario Usuario_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_id_pais_fkey" FOREIGN KEY (id_pais) REFERENCES public."Pais"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Usuario Usuario_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_id_rol_fkey" FOREIGN KEY (id_rol) REFERENCES public."Rol"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Valoracion Valoracion_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Valoracion"
    ADD CONSTRAINT "Valoracion_id_producto_fkey" FOREIGN KEY (id_producto) REFERENCES public."Producto"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Valoracion Valoracion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Valoracion"
    ADD CONSTRAINT "Valoracion_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Venta Venta_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Venta"
    ADD CONSTRAINT "Venta_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."Usuario"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Venta Venta_metodo_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Venta"
    ADD CONSTRAINT "Venta_metodo_pago_fkey" FOREIGN KEY (metodo_pago) REFERENCES public."Metodo_Pago"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Venta_x_Producto Venta_x_Producto_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Venta_x_Producto"
    ADD CONSTRAINT "Venta_x_Producto_id_producto_fkey" FOREIGN KEY (id_producto) REFERENCES public."Producto"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Venta_x_Producto Venta_x_Producto_id_venta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public."Venta_x_Producto"
    ADD CONSTRAINT "Venta_x_Producto_id_venta_fkey" FOREIGN KEY (id_venta) REFERENCES public."Venta"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict ZytmJnMkXbfXiS2RkrNmAzeqnL9qinPbwSaN09EaqJJ25N8WoHS140tE1LiiIES

