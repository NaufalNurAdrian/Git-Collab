/*
  Warnings:

  - The primary key for the `Description` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Description` table. All the data in the column will be lost.
  - You are about to drop the column `organizerId` on the `Event` table. All the data in the column will be lost.
  - You are about to drop the column `ownerId` on the `Referal` table. All the data in the column will be lost.
  - You are about to drop the column `descriptionId` on the `Ticket` table. All the data in the column will be lost.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[user_id]` on the table `Referal` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `user_id` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `Referal` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description_Id` to the `Ticket` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Event" DROP CONSTRAINT "Event_organizerId_fkey";

-- DropForeignKey
ALTER TABLE "Referal" DROP CONSTRAINT "Referal_ownerId_fkey";

-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_userId_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_descriptionId_fkey";

-- DropIndex
DROP INDEX "Referal_ownerId_key";

-- AlterTable
ALTER TABLE "Description" DROP CONSTRAINT "Description_pkey",
DROP COLUMN "id",
ADD COLUMN     "description_id" SERIAL NOT NULL,
ADD CONSTRAINT "Description_pkey" PRIMARY KEY ("description_id");

-- AlterTable
ALTER TABLE "Event" DROP COLUMN "organizerId",
ADD COLUMN     "user_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Referal" DROP COLUMN "ownerId",
ADD COLUMN     "user_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Ticket" DROP COLUMN "descriptionId",
ADD COLUMN     "description_Id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
DROP COLUMN "id",
ADD COLUMN     "user_id" SERIAL NOT NULL,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Referal_user_id_key" ON "Referal"("user_id");

-- AddForeignKey
ALTER TABLE "Referal" ADD CONSTRAINT "Referal_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Event" ADD CONSTRAINT "Event_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_description_Id_fkey" FOREIGN KEY ("description_Id") REFERENCES "Description"("description_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;
