--
-- PostgreSQL database dump
--

\restrict BCMDPC8v8SD4Ed3vxQi5qhxnUDge7nwdOjTGnPvJPuZ2pkzOuCZDapsqahapADC

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

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: jorge
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

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
-- Name: tbl_carrito; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_carrito (
    id integer NOT NULL,
    id_producto integer NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public.tbl_carrito OWNER TO jorge;

--
-- Name: tbl_carrito_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_carrito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_carrito_id_seq OWNER TO jorge;

--
-- Name: tbl_carrito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_carrito_id_seq OWNED BY public.tbl_carrito.id;


--
-- Name: tbl_categoria; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_categoria (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tbl_categoria OWNER TO jorge;

--
-- Name: tbl_categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_categoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_categoria_id_seq OWNER TO jorge;

--
-- Name: tbl_categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_categoria_id_seq OWNED BY public.tbl_categoria.id;


--
-- Name: tbl_chat; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_chat (
    id integer NOT NULL,
    fecha timestamp(3) without time zone NOT NULL,
    id_venta_x_producto integer NOT NULL
);


ALTER TABLE public.tbl_chat OWNER TO jorge;

--
-- Name: tbl_chat_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_chat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_chat_id_seq OWNER TO jorge;

--
-- Name: tbl_chat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_chat_id_seq OWNED BY public.tbl_chat.id;


--
-- Name: tbl_imagen_mensaje; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_imagen_mensaje (
    id integer NOT NULL,
    ruta character varying(150) NOT NULL,
    fecha timestamp(3) without time zone NOT NULL,
    id_tipo_imagen integer NOT NULL,
    id_chat integer NOT NULL
);


ALTER TABLE public.tbl_imagen_mensaje OWNER TO jorge;

--
-- Name: tbl_imagen_mensaje_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_imagen_mensaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_imagen_mensaje_id_seq OWNER TO jorge;

--
-- Name: tbl_imagen_mensaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_imagen_mensaje_id_seq OWNED BY public.tbl_imagen_mensaje.id;


--
-- Name: tbl_imagen_producto; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_imagen_producto (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    ruta character varying(150) NOT NULL,
    id_producto integer NOT NULL,
    id_tipo_imagen integer NOT NULL
);


ALTER TABLE public.tbl_imagen_producto OWNER TO jorge;

--
-- Name: tbl_imagen_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_imagen_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_imagen_producto_id_seq OWNER TO jorge;

--
-- Name: tbl_imagen_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_imagen_producto_id_seq OWNED BY public.tbl_imagen_producto.id;


--
-- Name: tbl_mensaje; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_mensaje (
    id integer NOT NULL,
    fecha timestamp(3) without time zone NOT NULL,
    contenido text NOT NULL,
    id_chat integer NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public.tbl_mensaje OWNER TO jorge;

--
-- Name: tbl_mensaje_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_mensaje_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_mensaje_id_seq OWNER TO jorge;

--
-- Name: tbl_mensaje_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_mensaje_id_seq OWNED BY public.tbl_mensaje.id;


--
-- Name: tbl_metodo_pago; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_metodo_pago (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    id_pais integer NOT NULL
);


ALTER TABLE public.tbl_metodo_pago OWNER TO jorge;

--
-- Name: tbl_metodo_pago_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_metodo_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_metodo_pago_id_seq OWNER TO jorge;

--
-- Name: tbl_metodo_pago_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_metodo_pago_id_seq OWNED BY public.tbl_metodo_pago.id;


--
-- Name: tbl_notificacion; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_notificacion (
    id integer NOT NULL,
    fecha_notificado timestamp(3) without time zone NOT NULL,
    descripcion text NOT NULL,
    id_producto_deseado integer NOT NULL
);


ALTER TABLE public.tbl_notificacion OWNER TO jorge;

--
-- Name: tbl_notificacion_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_notificacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_notificacion_id_seq OWNER TO jorge;

--
-- Name: tbl_notificacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_notificacion_id_seq OWNED BY public.tbl_notificacion.id;


--
-- Name: tbl_pais; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_pais (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tbl_pais OWNER TO jorge;

--
-- Name: tbl_pais_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_pais_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_pais_id_seq OWNER TO jorge;

--
-- Name: tbl_pais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_pais_id_seq OWNED BY public.tbl_pais.id;


--
-- Name: tbl_precio; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_precio (
    id integer NOT NULL,
    precio numeric(20,2) NOT NULL,
    id_pais integer NOT NULL,
    id_producto integer NOT NULL
);


ALTER TABLE public.tbl_precio OWNER TO jorge;

--
-- Name: tbl_precio_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_precio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_precio_id_seq OWNER TO jorge;

--
-- Name: tbl_precio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_precio_id_seq OWNED BY public.tbl_precio.id;


--
-- Name: tbl_producto; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_producto (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text NOT NULL,
    id_vendedor integer NOT NULL,
    id_pais integer NOT NULL,
    id_categoria integer NOT NULL,
    id_videojuego integer NOT NULL
);


ALTER TABLE public.tbl_producto OWNER TO jorge;

--
-- Name: tbl_producto_deseado; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_producto_deseado (
    id integer NOT NULL,
    precio_objetivo numeric(20,2) NOT NULL,
    id_producto integer NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public.tbl_producto_deseado OWNER TO jorge;

--
-- Name: tbl_producto_deseado_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_producto_deseado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_producto_deseado_id_seq OWNER TO jorge;

--
-- Name: tbl_producto_deseado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_producto_deseado_id_seq OWNED BY public.tbl_producto_deseado.id;


--
-- Name: tbl_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_producto_id_seq OWNER TO jorge;

--
-- Name: tbl_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_producto_id_seq OWNED BY public.tbl_producto.id;


--
-- Name: tbl_rol; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_rol (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tbl_rol OWNER TO jorge;

--
-- Name: tbl_rol_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_rol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_rol_id_seq OWNER TO jorge;

--
-- Name: tbl_rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_rol_id_seq OWNED BY public.tbl_rol.id;


--
-- Name: tbl_tipo_imagen; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_tipo_imagen (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tbl_tipo_imagen OWNER TO jorge;

--
-- Name: tbl_tipo_imagen_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_tipo_imagen_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_tipo_imagen_id_seq OWNER TO jorge;

--
-- Name: tbl_tipo_imagen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_tipo_imagen_id_seq OWNED BY public.tbl_tipo_imagen.id;


--
-- Name: tbl_usuario; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_usuario (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    usuario character varying(50) NOT NULL,
    ventas integer NOT NULL,
    correo character varying(200) NOT NULL,
    id_pais integer NOT NULL,
    id_rol integer NOT NULL,
    id_metodo_pago_fav integer NOT NULL
);


ALTER TABLE public.tbl_usuario OWNER TO jorge;

--
-- Name: tbl_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_usuario_id_seq OWNER TO jorge;

--
-- Name: tbl_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_usuario_id_seq OWNED BY public.tbl_usuario.id;


--
-- Name: tbl_valoracion; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_valoracion (
    id integer NOT NULL,
    fecha timestamp(3) without time zone NOT NULL,
    puntaje integer NOT NULL,
    id_venta_x_producto integer NOT NULL
);


ALTER TABLE public.tbl_valoracion OWNER TO jorge;

--
-- Name: tbl_valoracion_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_valoracion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_valoracion_id_seq OWNER TO jorge;

--
-- Name: tbl_valoracion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_valoracion_id_seq OWNED BY public.tbl_valoracion.id;


--
-- Name: tbl_venta; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_venta (
    id integer NOT NULL,
    total numeric(30,2) NOT NULL,
    fecha timestamp(3) without time zone NOT NULL,
    id_usuario integer NOT NULL,
    id_metodo_pago integer NOT NULL
);


ALTER TABLE public.tbl_venta OWNER TO jorge;

--
-- Name: tbl_venta_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_venta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_venta_id_seq OWNER TO jorge;

--
-- Name: tbl_venta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_venta_id_seq OWNED BY public.tbl_venta.id;


--
-- Name: tbl_venta_x_producto; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_venta_x_producto (
    id integer NOT NULL,
    id_producto integer NOT NULL,
    id_venta integer NOT NULL,
    cantidad integer NOT NULL,
    precio numeric(20,2) NOT NULL
);


ALTER TABLE public.tbl_venta_x_producto OWNER TO jorge;

--
-- Name: tbl_venta_x_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_venta_x_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_venta_x_producto_id_seq OWNER TO jorge;

--
-- Name: tbl_venta_x_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_venta_x_producto_id_seq OWNED BY public.tbl_venta_x_producto.id;


--
-- Name: tbl_videojuego; Type: TABLE; Schema: public; Owner: jorge
--

CREATE TABLE public.tbl_videojuego (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tbl_videojuego OWNER TO jorge;

--
-- Name: tbl_videojuego_id_seq; Type: SEQUENCE; Schema: public; Owner: jorge
--

CREATE SEQUENCE public.tbl_videojuego_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tbl_videojuego_id_seq OWNER TO jorge;

--
-- Name: tbl_videojuego_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jorge
--

ALTER SEQUENCE public.tbl_videojuego_id_seq OWNED BY public.tbl_videojuego.id;


--
-- Name: tbl_carrito id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_carrito ALTER COLUMN id SET DEFAULT nextval('public.tbl_carrito_id_seq'::regclass);


--
-- Name: tbl_categoria id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_categoria ALTER COLUMN id SET DEFAULT nextval('public.tbl_categoria_id_seq'::regclass);


--
-- Name: tbl_chat id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_chat ALTER COLUMN id SET DEFAULT nextval('public.tbl_chat_id_seq'::regclass);


--
-- Name: tbl_imagen_mensaje id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_imagen_mensaje ALTER COLUMN id SET DEFAULT nextval('public.tbl_imagen_mensaje_id_seq'::regclass);


--
-- Name: tbl_imagen_producto id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_imagen_producto ALTER COLUMN id SET DEFAULT nextval('public.tbl_imagen_producto_id_seq'::regclass);


--
-- Name: tbl_mensaje id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_mensaje ALTER COLUMN id SET DEFAULT nextval('public.tbl_mensaje_id_seq'::regclass);


--
-- Name: tbl_metodo_pago id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_metodo_pago ALTER COLUMN id SET DEFAULT nextval('public.tbl_metodo_pago_id_seq'::regclass);


--
-- Name: tbl_notificacion id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_notificacion ALTER COLUMN id SET DEFAULT nextval('public.tbl_notificacion_id_seq'::regclass);


--
-- Name: tbl_pais id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_pais ALTER COLUMN id SET DEFAULT nextval('public.tbl_pais_id_seq'::regclass);


--
-- Name: tbl_precio id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_precio ALTER COLUMN id SET DEFAULT nextval('public.tbl_precio_id_seq'::regclass);


--
-- Name: tbl_producto id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_producto ALTER COLUMN id SET DEFAULT nextval('public.tbl_producto_id_seq'::regclass);


--
-- Name: tbl_producto_deseado id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_producto_deseado ALTER COLUMN id SET DEFAULT nextval('public.tbl_producto_deseado_id_seq'::regclass);


--
-- Name: tbl_rol id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_rol ALTER COLUMN id SET DEFAULT nextval('public.tbl_rol_id_seq'::regclass);


--
-- Name: tbl_tipo_imagen id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_tipo_imagen ALTER COLUMN id SET DEFAULT nextval('public.tbl_tipo_imagen_id_seq'::regclass);


--
-- Name: tbl_usuario id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_usuario ALTER COLUMN id SET DEFAULT nextval('public.tbl_usuario_id_seq'::regclass);


--
-- Name: tbl_valoracion id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_valoracion ALTER COLUMN id SET DEFAULT nextval('public.tbl_valoracion_id_seq'::regclass);


--
-- Name: tbl_venta id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_venta ALTER COLUMN id SET DEFAULT nextval('public.tbl_venta_id_seq'::regclass);


--
-- Name: tbl_venta_x_producto id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_venta_x_producto ALTER COLUMN id SET DEFAULT nextval('public.tbl_venta_x_producto_id_seq'::regclass);


--
-- Name: tbl_videojuego id; Type: DEFAULT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_videojuego ALTER COLUMN id SET DEFAULT nextval('public.tbl_videojuego_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
1fd7aac0-6ba8-41d0-91ec-b7a9282fee49	3a61c41613363f04c3674ace0b8c03e6f3bb30fcb9074ffe6c93e784a9d01056	2026-04-26 16:30:17.04404-05	20260424014139_init	\N	\N	2026-04-26 16:30:17.0288-05	1
c3922c3b-10de-4031-86fa-206bf346d112	6472c3ad1b87c17acf77d21ad3df8778c91817567f2e7c2fe6717c87537fdcc8	2026-04-26 16:30:17.069112-05	20260424014320_relations	\N	\N	2026-04-26 16:30:17.045051-05	1
a21e62c5-f7d6-4c87-b858-9b94359a6fd8	2c43d6913b1287d5775fe8994ef7bb0c0a7d72ce6c85ae709a9540c2a62b14ef	2026-04-26 16:30:17.091753-05	20260424015226_chat_mensaje_imagen_valoracion_notificacion	\N	\N	2026-04-26 16:30:17.069961-05	1
94542f02-07cc-4b6a-a578-9366aa1c33ec	1c49afd306a488801386cb39ff6b5ac4e30add2922d171ed60630ea51223a1d4	2026-04-26 16:30:39.887178-05	20260426213039_fix_schema	\N	\N	2026-04-26 16:30:39.826247-05	1
\.


--
-- Data for Name: tbl_carrito; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_carrito (id, id_producto, id_usuario) FROM stdin;
\.


--
-- Data for Name: tbl_categoria; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_categoria (id, nombre) FROM stdin;
1	MOBA
2	RPG
3	SandBox
4	Survival
5	FPS
\.


--
-- Data for Name: tbl_chat; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_chat (id, fecha, id_venta_x_producto) FROM stdin;
\.


--
-- Data for Name: tbl_imagen_mensaje; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_imagen_mensaje (id, ruta, fecha, id_tipo_imagen, id_chat) FROM stdin;
\.


--
-- Data for Name: tbl_imagen_producto; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_imagen_producto (id, nombre, ruta, id_producto, id_tipo_imagen) FROM stdin;
\.


--
-- Data for Name: tbl_mensaje; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_mensaje (id, fecha, contenido, id_chat, id_usuario) FROM stdin;
\.


--
-- Data for Name: tbl_metodo_pago; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_metodo_pago (id, nombre, id_pais) FROM stdin;
2	Bancolombia	1
1	Nequi	1
\.


--
-- Data for Name: tbl_notificacion; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_notificacion (id, fecha_notificado, descripcion, id_producto_deseado) FROM stdin;
\.


--
-- Data for Name: tbl_pais; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_pais (id, nombre) FROM stdin;
1	Colombia
3	Estados Unidos
\.


--
-- Data for Name: tbl_precio; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_precio (id, precio, id_pais, id_producto) FROM stdin;
\.


--
-- Data for Name: tbl_producto; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_producto (id, nombre, descripcion, id_vendedor, id_pais, id_categoria, id_videojuego) FROM stdin;
1	cuenta LOL	rango: Grand Master	1	1	1	1
3	Cuenta Valorant	rango 5	1	1	5	1
\.


--
-- Data for Name: tbl_producto_deseado; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_producto_deseado (id, precio_objetivo, id_producto, id_usuario) FROM stdin;
\.


--
-- Data for Name: tbl_rol; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_rol (id, nombre) FROM stdin;
1	Usuario
2	Vendedor
4	
\.


--
-- Data for Name: tbl_tipo_imagen; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_tipo_imagen (id, nombre) FROM stdin;
1	png
2	jpg
3	
\.


--
-- Data for Name: tbl_usuario; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_usuario (id, nombre, usuario, ventas, correo, id_pais, id_rol, id_metodo_pago_fav) FROM stdin;
1	Jose Luis	NextShop	0	joseluis34@gmail.com	1	2	1
2	Julian	juliangamer	0	juliangames@gmail.com	1	1	2
\.


--
-- Data for Name: tbl_valoracion; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_valoracion (id, fecha, puntaje, id_venta_x_producto) FROM stdin;
\.


--
-- Data for Name: tbl_venta; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_venta (id, total, fecha, id_usuario, id_metodo_pago) FROM stdin;
\.


--
-- Data for Name: tbl_venta_x_producto; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_venta_x_producto (id, id_producto, id_venta, cantidad, precio) FROM stdin;
\.


--
-- Data for Name: tbl_videojuego; Type: TABLE DATA; Schema: public; Owner: jorge
--

COPY public.tbl_videojuego (id, nombre) FROM stdin;
1	League Of Leguends
2	Minecraft
3	Roblox
4	Resident Evil Requiem
5	The Forest 2
\.


--
-- Name: tbl_carrito_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_carrito_id_seq', 1, false);


--
-- Name: tbl_categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_categoria_id_seq', 5, true);


--
-- Name: tbl_chat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_chat_id_seq', 1, false);


--
-- Name: tbl_imagen_mensaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_imagen_mensaje_id_seq', 1, false);


--
-- Name: tbl_imagen_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_imagen_producto_id_seq', 1, false);


--
-- Name: tbl_mensaje_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_mensaje_id_seq', 1, false);


--
-- Name: tbl_metodo_pago_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_metodo_pago_id_seq', 5, true);


--
-- Name: tbl_notificacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_notificacion_id_seq', 1, false);


--
-- Name: tbl_pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_pais_id_seq', 3, true);


--
-- Name: tbl_precio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_precio_id_seq', 1, false);


--
-- Name: tbl_producto_deseado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_producto_deseado_id_seq', 1, false);


--
-- Name: tbl_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_producto_id_seq', 3, true);


--
-- Name: tbl_rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_rol_id_seq', 4, true);


--
-- Name: tbl_tipo_imagen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_tipo_imagen_id_seq', 3, true);


--
-- Name: tbl_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_usuario_id_seq', 2, true);


--
-- Name: tbl_valoracion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_valoracion_id_seq', 1, false);


--
-- Name: tbl_venta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_venta_id_seq', 1, false);


--
-- Name: tbl_venta_x_producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_venta_x_producto_id_seq', 1, false);


--
-- Name: tbl_videojuego_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jorge
--

SELECT pg_catalog.setval('public.tbl_videojuego_id_seq', 5, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: tbl_carrito tbl_carrito_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_carrito
    ADD CONSTRAINT tbl_carrito_pkey PRIMARY KEY (id);


--
-- Name: tbl_categoria tbl_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_categoria
    ADD CONSTRAINT tbl_categoria_pkey PRIMARY KEY (id);


--
-- Name: tbl_chat tbl_chat_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_chat
    ADD CONSTRAINT tbl_chat_pkey PRIMARY KEY (id);


--
-- Name: tbl_imagen_mensaje tbl_imagen_mensaje_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_imagen_mensaje
    ADD CONSTRAINT tbl_imagen_mensaje_pkey PRIMARY KEY (id);


--
-- Name: tbl_imagen_producto tbl_imagen_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_imagen_producto
    ADD CONSTRAINT tbl_imagen_producto_pkey PRIMARY KEY (id);


--
-- Name: tbl_mensaje tbl_mensaje_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_mensaje
    ADD CONSTRAINT tbl_mensaje_pkey PRIMARY KEY (id);


--
-- Name: tbl_metodo_pago tbl_metodo_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_metodo_pago
    ADD CONSTRAINT tbl_metodo_pago_pkey PRIMARY KEY (id);


--
-- Name: tbl_notificacion tbl_notificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_notificacion
    ADD CONSTRAINT tbl_notificacion_pkey PRIMARY KEY (id);


--
-- Name: tbl_pais tbl_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_pais
    ADD CONSTRAINT tbl_pais_pkey PRIMARY KEY (id);


--
-- Name: tbl_precio tbl_precio_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_precio
    ADD CONSTRAINT tbl_precio_pkey PRIMARY KEY (id);


--
-- Name: tbl_producto_deseado tbl_producto_deseado_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_producto_deseado
    ADD CONSTRAINT tbl_producto_deseado_pkey PRIMARY KEY (id);


--
-- Name: tbl_producto tbl_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_producto
    ADD CONSTRAINT tbl_producto_pkey PRIMARY KEY (id);


--
-- Name: tbl_rol tbl_rol_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_rol
    ADD CONSTRAINT tbl_rol_pkey PRIMARY KEY (id);


--
-- Name: tbl_tipo_imagen tbl_tipo_imagen_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_tipo_imagen
    ADD CONSTRAINT tbl_tipo_imagen_pkey PRIMARY KEY (id);


--
-- Name: tbl_usuario tbl_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_pkey PRIMARY KEY (id);


--
-- Name: tbl_valoracion tbl_valoracion_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_valoracion
    ADD CONSTRAINT tbl_valoracion_pkey PRIMARY KEY (id);


--
-- Name: tbl_venta tbl_venta_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_venta
    ADD CONSTRAINT tbl_venta_pkey PRIMARY KEY (id);


--
-- Name: tbl_venta_x_producto tbl_venta_x_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_venta_x_producto
    ADD CONSTRAINT tbl_venta_x_producto_pkey PRIMARY KEY (id);


--
-- Name: tbl_videojuego tbl_videojuego_pkey; Type: CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_videojuego
    ADD CONSTRAINT tbl_videojuego_pkey PRIMARY KEY (id);


--
-- Name: tbl_chat_id_venta_x_producto_key; Type: INDEX; Schema: public; Owner: jorge
--

CREATE UNIQUE INDEX tbl_chat_id_venta_x_producto_key ON public.tbl_chat USING btree (id_venta_x_producto);


--
-- Name: tbl_valoracion_id_venta_x_producto_key; Type: INDEX; Schema: public; Owner: jorge
--

CREATE UNIQUE INDEX tbl_valoracion_id_venta_x_producto_key ON public.tbl_valoracion USING btree (id_venta_x_producto);


--
-- Name: tbl_carrito tbl_carrito_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_carrito
    ADD CONSTRAINT tbl_carrito_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.tbl_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_carrito tbl_carrito_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_carrito
    ADD CONSTRAINT tbl_carrito_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.tbl_usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_chat tbl_chat_id_venta_x_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_chat
    ADD CONSTRAINT tbl_chat_id_venta_x_producto_fkey FOREIGN KEY (id_venta_x_producto) REFERENCES public.tbl_venta_x_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_imagen_mensaje tbl_imagen_mensaje_id_chat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_imagen_mensaje
    ADD CONSTRAINT tbl_imagen_mensaje_id_chat_fkey FOREIGN KEY (id_chat) REFERENCES public.tbl_chat(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_imagen_mensaje tbl_imagen_mensaje_id_tipo_imagen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_imagen_mensaje
    ADD CONSTRAINT tbl_imagen_mensaje_id_tipo_imagen_fkey FOREIGN KEY (id_tipo_imagen) REFERENCES public.tbl_tipo_imagen(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_imagen_producto tbl_imagen_producto_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_imagen_producto
    ADD CONSTRAINT tbl_imagen_producto_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.tbl_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_imagen_producto tbl_imagen_producto_id_tipo_imagen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_imagen_producto
    ADD CONSTRAINT tbl_imagen_producto_id_tipo_imagen_fkey FOREIGN KEY (id_tipo_imagen) REFERENCES public.tbl_tipo_imagen(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_mensaje tbl_mensaje_id_chat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_mensaje
    ADD CONSTRAINT tbl_mensaje_id_chat_fkey FOREIGN KEY (id_chat) REFERENCES public.tbl_chat(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_mensaje tbl_mensaje_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_mensaje
    ADD CONSTRAINT tbl_mensaje_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.tbl_usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_metodo_pago tbl_metodo_pago_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_metodo_pago
    ADD CONSTRAINT tbl_metodo_pago_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES public.tbl_pais(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_notificacion tbl_notificacion_id_producto_deseado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_notificacion
    ADD CONSTRAINT tbl_notificacion_id_producto_deseado_fkey FOREIGN KEY (id_producto_deseado) REFERENCES public.tbl_producto_deseado(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_precio tbl_precio_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_precio
    ADD CONSTRAINT tbl_precio_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES public.tbl_pais(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_precio tbl_precio_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_precio
    ADD CONSTRAINT tbl_precio_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.tbl_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto_deseado tbl_producto_deseado_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_producto_deseado
    ADD CONSTRAINT tbl_producto_deseado_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.tbl_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto_deseado tbl_producto_deseado_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_producto_deseado
    ADD CONSTRAINT tbl_producto_deseado_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.tbl_usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto tbl_producto_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_producto
    ADD CONSTRAINT tbl_producto_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.tbl_categoria(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto tbl_producto_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_producto
    ADD CONSTRAINT tbl_producto_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES public.tbl_pais(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto tbl_producto_id_vendedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_producto
    ADD CONSTRAINT tbl_producto_id_vendedor_fkey FOREIGN KEY (id_vendedor) REFERENCES public.tbl_usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_producto tbl_producto_id_videojuego_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_producto
    ADD CONSTRAINT tbl_producto_id_videojuego_fkey FOREIGN KEY (id_videojuego) REFERENCES public.tbl_videojuego(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_usuario tbl_usuario_id_metodo_pago_fav_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_id_metodo_pago_fav_fkey FOREIGN KEY (id_metodo_pago_fav) REFERENCES public.tbl_metodo_pago(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_usuario tbl_usuario_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES public.tbl_pais(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_usuario tbl_usuario_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_usuario
    ADD CONSTRAINT tbl_usuario_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES public.tbl_rol(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_valoracion tbl_valoracion_id_venta_x_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_valoracion
    ADD CONSTRAINT tbl_valoracion_id_venta_x_producto_fkey FOREIGN KEY (id_venta_x_producto) REFERENCES public.tbl_venta_x_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_venta tbl_venta_id_metodo_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_venta
    ADD CONSTRAINT tbl_venta_id_metodo_pago_fkey FOREIGN KEY (id_metodo_pago) REFERENCES public.tbl_metodo_pago(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_venta tbl_venta_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_venta
    ADD CONSTRAINT tbl_venta_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.tbl_usuario(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_venta_x_producto tbl_venta_x_producto_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_venta_x_producto
    ADD CONSTRAINT tbl_venta_x_producto_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.tbl_producto(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tbl_venta_x_producto tbl_venta_x_producto_id_venta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jorge
--

ALTER TABLE ONLY public.tbl_venta_x_producto
    ADD CONSTRAINT tbl_venta_x_producto_id_venta_fkey FOREIGN KEY (id_venta) REFERENCES public.tbl_venta(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: jorge
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict BCMDPC8v8SD4Ed3vxQi5qhxnUDge7nwdOjTGnPvJPuZ2pkzOuCZDapsqahapADC

