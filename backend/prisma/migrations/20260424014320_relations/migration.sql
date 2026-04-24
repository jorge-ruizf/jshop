/*
  Warnings:

  - Added the required column `id_categoria` to the `Producto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_pais` to the `Producto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_vendedor` to the `Producto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_metodo_pago_fav` to the `Usuario` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_pais` to the `Usuario` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_rol` to the `Usuario` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Producto" ADD COLUMN     "id_categoria" INTEGER NOT NULL,
ADD COLUMN     "id_pais" INTEGER NOT NULL,
ADD COLUMN     "id_vendedor" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Usuario" ADD COLUMN     "id_metodo_pago_fav" INTEGER NOT NULL,
ADD COLUMN     "id_pais" INTEGER NOT NULL,
ADD COLUMN     "id_rol" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "Rol" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "Rol_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Metodo_Pago" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "Metodo_Pago_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Venta" (
    "id" SERIAL NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "metodo_pago" INTEGER NOT NULL,

    CONSTRAINT "Venta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Venta_x_Producto" (
    "id" SERIAL NOT NULL,
    "id_producto" INTEGER NOT NULL,
    "id_venta" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "precio" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Venta_x_Producto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Carrito" (
    "id" SERIAL NOT NULL,
    "id_producto" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "Carrito_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Producto_Deseado" (
    "id" SERIAL NOT NULL,
    "id_producto" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "Producto_Deseado_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Precio" (
    "id" SERIAL NOT NULL,
    "id_producto" INTEGER NOT NULL,
    "id_pais" INTEGER NOT NULL,
    "precio" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Precio_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Videojuego" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "Videojuego_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Usuario" ADD CONSTRAINT "Usuario_id_pais_fkey" FOREIGN KEY ("id_pais") REFERENCES "Pais"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Usuario" ADD CONSTRAINT "Usuario_id_rol_fkey" FOREIGN KEY ("id_rol") REFERENCES "Rol"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Usuario" ADD CONSTRAINT "Usuario_id_metodo_pago_fav_fkey" FOREIGN KEY ("id_metodo_pago_fav") REFERENCES "Metodo_Pago"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Producto" ADD CONSTRAINT "Producto_id_vendedor_fkey" FOREIGN KEY ("id_vendedor") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Producto" ADD CONSTRAINT "Producto_id_categoria_fkey" FOREIGN KEY ("id_categoria") REFERENCES "Categoria"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Producto" ADD CONSTRAINT "Producto_id_pais_fkey" FOREIGN KEY ("id_pais") REFERENCES "Pais"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Venta" ADD CONSTRAINT "Venta_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Venta" ADD CONSTRAINT "Venta_metodo_pago_fkey" FOREIGN KEY ("metodo_pago") REFERENCES "Metodo_Pago"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Venta_x_Producto" ADD CONSTRAINT "Venta_x_Producto_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "Producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Venta_x_Producto" ADD CONSTRAINT "Venta_x_Producto_id_venta_fkey" FOREIGN KEY ("id_venta") REFERENCES "Venta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Carrito" ADD CONSTRAINT "Carrito_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "Producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Carrito" ADD CONSTRAINT "Carrito_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Producto_Deseado" ADD CONSTRAINT "Producto_Deseado_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "Producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Producto_Deseado" ADD CONSTRAINT "Producto_Deseado_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Precio" ADD CONSTRAINT "Precio_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "Producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Precio" ADD CONSTRAINT "Precio_id_pais_fkey" FOREIGN KEY ("id_pais") REFERENCES "Pais"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
