/*
  Warnings:

  - You are about to drop the column `referalId` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[referalcode]` on the table `User` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "User_referalId_key";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "referalId",
ADD COLUMN     "referalcode" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "User_referalcode_key" ON "User"("referalcode");
