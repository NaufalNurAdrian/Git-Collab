/*
  Warnings:

  - Added the required column `referalId` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN     "referalId" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "Referal" (
    "id" SERIAL NOT NULL,
    "point" INTEGER NOT NULL,
    "code" TEXT NOT NULL,
    "expierd" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Referal_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_referalId_fkey" FOREIGN KEY ("referalId") REFERENCES "Referal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
