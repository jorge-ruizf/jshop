/*
  Warnings:

  - You are about to drop the `Carrito` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Categoria` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Chat` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Imagen_Mensaje` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Imagen_Producto` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Mensaje` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Metodo_Pago` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Notificacion` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Pais` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Precio` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Producto` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Producto_Deseado` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Rol` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Usuario` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Valoracion` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Venta` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Venta_x_Producto` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Videojuego` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Carrito" DROP CONSTRAINT "Carrito_id_producto_fkey";

-- DropForeignKey
ALTER TABLE "Carrito" DROP CONSTRAINT "Carrito_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "Chat" DROP CONSTRAINT "Chat_id_usuario_a_fkey";

-- DropForeignKey
ALTER TABLE "Chat" DROP CONSTRAINT "Chat_id_usuario_b_fkey";

-- DropForeignKey
ALTER TABLE "Imagen_Mensaje" DROP CONSTRAINT "Imagen_Mensaje_id_mensaje_fkey";

-- DropForeignKey
ALTER TABLE "Imagen_Producto" DROP CONSTRAINT "Imagen_Producto_id_producto_fkey";

-- DropForeignKey
ALTER TABLE "Mensaje" DROP CONSTRAINT "Mensaje_id_chat_fkey";

-- DropForeignKey
ALTER TABLE "Mensaje" DROP CONSTRAINT "Mensaje_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "Notificacion" DROP CONSTRAINT "Notificacion_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "Precio" DROP CONSTRAINT "Precio_id_pais_fkey";

-- DropForeignKey
ALTER TABLE "Precio" DROP CONSTRAINT "Precio_id_producto_fkey";

-- DropForeignKey
ALTER TABLE "Producto" DROP CONSTRAINT "Producto_id_categoria_fkey";

-- DropForeignKey
ALTER TABLE "Producto" DROP CONSTRAINT "Producto_id_pais_fkey";

-- DropForeignKey
ALTER TABLE "Producto" DROP CONSTRAINT "Producto_id_vendedor_fkey";

-- DropForeignKey
ALTER TABLE "Producto_Deseado" DROP CONSTRAINT "Producto_Deseado_id_producto_fkey";

-- DropForeignKey
ALTER TABLE "Producto_Deseado" DROP CONSTRAINT "Producto_Deseado_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "Usuario" DROP CONSTRAINT "Usuario_id_metodo_pago_fav_fkey";

-- DropForeignKey
ALTER TABLE "Usuario" DROP CONSTRAINT "Usuario_id_pais_fkey";

-- DropForeignKey
ALTER TABLE "Usuario" DROP CONSTRAINT "Usuario_id_rol_fkey";

-- DropForeignKey
ALTER TABLE "Valoracion" DROP CONSTRAINT "Valoracion_id_producto_fkey";

-- DropForeignKey
ALTER TABLE "Valoracion" DROP CONSTRAINT "Valoracion_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "Venta" DROP CONSTRAINT "Venta_id_usuario_fkey";

-- DropForeignKey
ALTER TABLE "Venta" DROP CONSTRAINT "Venta_metodo_pago_fkey";

-- DropForeignKey
ALTER TABLE "Venta_x_Producto" DROP CONSTRAINT "Venta_x_Producto_id_producto_fkey";

-- DropForeignKey
ALTER TABLE "Venta_x_Producto" DROP CONSTRAINT "Venta_x_Producto_id_venta_fkey";

-- DropTable
DROP TABLE "Carrito";

-- DropTable
DROP TABLE "Categoria";

-- DropTable
DROP TABLE "Chat";

-- DropTable
DROP TABLE "Imagen_Mensaje";

-- DropTable
DROP TABLE "Imagen_Producto";

-- DropTable
DROP TABLE "Mensaje";

-- DropTable
DROP TABLE "Metodo_Pago";

-- DropTable
DROP TABLE "Notificacion";

-- DropTable
DROP TABLE "Pais";

-- DropTable
DROP TABLE "Precio";

-- DropTable
DROP TABLE "Producto";

-- DropTable
DROP TABLE "Producto_Deseado";

-- DropTable
DROP TABLE "Rol";

-- DropTable
DROP TABLE "Usuario";

-- DropTable
DROP TABLE "Valoracion";

-- DropTable
DROP TABLE "Venta";

-- DropTable
DROP TABLE "Venta_x_Producto";

-- DropTable
DROP TABLE "Videojuego";

-- CreateTable
CREATE TABLE "tbl_rol" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,

    CONSTRAINT "tbl_rol_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_pais" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,

    CONSTRAINT "tbl_pais_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_metodo_pago" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "id_pais" INTEGER NOT NULL,

    CONSTRAINT "tbl_metodo_pago_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_categoria" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,

    CONSTRAINT "tbl_categoria_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_videojuego" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,

    CONSTRAINT "tbl_videojuego_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_tipo_imagen" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,

    CONSTRAINT "tbl_tipo_imagen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_usuario" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "usuario" VARCHAR(50) NOT NULL,
    "ventas" INTEGER NOT NULL,
    "correo" VARCHAR(200) NOT NULL,
    "id_pais" INTEGER NOT NULL,
    "id_rol" INTEGER NOT NULL,
    "id_metodo_pago_fav" INTEGER NOT NULL,

    CONSTRAINT "tbl_usuario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_producto" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "descripcion" TEXT NOT NULL,
    "id_vendedor" INTEGER NOT NULL,
    "id_pais" INTEGER NOT NULL,
    "id_categoria" INTEGER NOT NULL,
    "id_videojuego" INTEGER NOT NULL,

    CONSTRAINT "tbl_producto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_precio" (
    "id" SERIAL NOT NULL,
    "precio" DECIMAL(20,2) NOT NULL,
    "id_pais" INTEGER NOT NULL,
    "id_producto" INTEGER NOT NULL,

    CONSTRAINT "tbl_precio_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_imagen_producto" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "ruta" VARCHAR(150) NOT NULL,
    "id_producto" INTEGER NOT NULL,
    "id_tipo_imagen" INTEGER NOT NULL,

    CONSTRAINT "tbl_imagen_producto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_carrito" (
    "id" SERIAL NOT NULL,
    "id_producto" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "tbl_carrito_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_producto_deseado" (
    "id" SERIAL NOT NULL,
    "precio_objetivo" DECIMAL(20,2) NOT NULL,
    "id_producto" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "tbl_producto_deseado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_venta" (
    "id" SERIAL NOT NULL,
    "total" DECIMAL(30,2) NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "id_metodo_pago" INTEGER NOT NULL,

    CONSTRAINT "tbl_venta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_venta_x_producto" (
    "id" SERIAL NOT NULL,
    "id_producto" INTEGER NOT NULL,
    "id_venta" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "precio" DECIMAL(20,2) NOT NULL,

    CONSTRAINT "tbl_venta_x_producto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_chat" (
    "id" SERIAL NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL,
    "id_venta_x_producto" INTEGER NOT NULL,

    CONSTRAINT "tbl_chat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_mensaje" (
    "id" SERIAL NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL,
    "contenido" TEXT NOT NULL,
    "id_chat" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "tbl_mensaje_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_imagen_mensaje" (
    "id" SERIAL NOT NULL,
    "ruta" VARCHAR(150) NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL,
    "id_tipo_imagen" INTEGER NOT NULL,
    "id_chat" INTEGER NOT NULL,

    CONSTRAINT "tbl_imagen_mensaje_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_valoracion" (
    "id" SERIAL NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL,
    "puntaje" INTEGER NOT NULL,
    "id_venta_x_producto" INTEGER NOT NULL,

    CONSTRAINT "tbl_valoracion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tbl_notificacion" (
    "id" SERIAL NOT NULL,
    "fecha_notificado" TIMESTAMP(3) NOT NULL,
    "descripcion" TEXT NOT NULL,
    "id_producto_deseado" INTEGER NOT NULL,

    CONSTRAINT "tbl_notificacion_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "tbl_chat_id_venta_x_producto_key" ON "tbl_chat"("id_venta_x_producto");

-- CreateIndex
CREATE UNIQUE INDEX "tbl_valoracion_id_venta_x_producto_key" ON "tbl_valoracion"("id_venta_x_producto");

-- AddForeignKey
ALTER TABLE "tbl_metodo_pago" ADD CONSTRAINT "tbl_metodo_pago_id_pais_fkey" FOREIGN KEY ("id_pais") REFERENCES "tbl_pais"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_usuario" ADD CONSTRAINT "tbl_usuario_id_pais_fkey" FOREIGN KEY ("id_pais") REFERENCES "tbl_pais"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_usuario" ADD CONSTRAINT "tbl_usuario_id_rol_fkey" FOREIGN KEY ("id_rol") REFERENCES "tbl_rol"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_usuario" ADD CONSTRAINT "tbl_usuario_id_metodo_pago_fav_fkey" FOREIGN KEY ("id_metodo_pago_fav") REFERENCES "tbl_metodo_pago"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_producto" ADD CONSTRAINT "tbl_producto_id_vendedor_fkey" FOREIGN KEY ("id_vendedor") REFERENCES "tbl_usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_producto" ADD CONSTRAINT "tbl_producto_id_pais_fkey" FOREIGN KEY ("id_pais") REFERENCES "tbl_pais"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_producto" ADD CONSTRAINT "tbl_producto_id_categoria_fkey" FOREIGN KEY ("id_categoria") REFERENCES "tbl_categoria"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_producto" ADD CONSTRAINT "tbl_producto_id_videojuego_fkey" FOREIGN KEY ("id_videojuego") REFERENCES "tbl_videojuego"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_precio" ADD CONSTRAINT "tbl_precio_id_pais_fkey" FOREIGN KEY ("id_pais") REFERENCES "tbl_pais"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_precio" ADD CONSTRAINT "tbl_precio_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "tbl_producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_imagen_producto" ADD CONSTRAINT "tbl_imagen_producto_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "tbl_producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_imagen_producto" ADD CONSTRAINT "tbl_imagen_producto_id_tipo_imagen_fkey" FOREIGN KEY ("id_tipo_imagen") REFERENCES "tbl_tipo_imagen"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_carrito" ADD CONSTRAINT "tbl_carrito_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "tbl_producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_carrito" ADD CONSTRAINT "tbl_carrito_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "tbl_usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_producto_deseado" ADD CONSTRAINT "tbl_producto_deseado_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "tbl_producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_producto_deseado" ADD CONSTRAINT "tbl_producto_deseado_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "tbl_usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_venta" ADD CONSTRAINT "tbl_venta_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "tbl_usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_venta" ADD CONSTRAINT "tbl_venta_id_metodo_pago_fkey" FOREIGN KEY ("id_metodo_pago") REFERENCES "tbl_metodo_pago"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_venta_x_producto" ADD CONSTRAINT "tbl_venta_x_producto_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "tbl_producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_venta_x_producto" ADD CONSTRAINT "tbl_venta_x_producto_id_venta_fkey" FOREIGN KEY ("id_venta") REFERENCES "tbl_venta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_chat" ADD CONSTRAINT "tbl_chat_id_venta_x_producto_fkey" FOREIGN KEY ("id_venta_x_producto") REFERENCES "tbl_venta_x_producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_mensaje" ADD CONSTRAINT "tbl_mensaje_id_chat_fkey" FOREIGN KEY ("id_chat") REFERENCES "tbl_chat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_mensaje" ADD CONSTRAINT "tbl_mensaje_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "tbl_usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_imagen_mensaje" ADD CONSTRAINT "tbl_imagen_mensaje_id_tipo_imagen_fkey" FOREIGN KEY ("id_tipo_imagen") REFERENCES "tbl_tipo_imagen"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_imagen_mensaje" ADD CONSTRAINT "tbl_imagen_mensaje_id_chat_fkey" FOREIGN KEY ("id_chat") REFERENCES "tbl_chat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_valoracion" ADD CONSTRAINT "tbl_valoracion_id_venta_x_producto_fkey" FOREIGN KEY ("id_venta_x_producto") REFERENCES "tbl_venta_x_producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tbl_notificacion" ADD CONSTRAINT "tbl_notificacion_id_producto_deseado_fkey" FOREIGN KEY ("id_producto_deseado") REFERENCES "tbl_producto_deseado"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
