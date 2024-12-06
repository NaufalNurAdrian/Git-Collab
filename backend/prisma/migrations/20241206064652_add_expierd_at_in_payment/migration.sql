/*
  Warnings:

  - You are about to drop the column `upload_payment` on the `Payment` table. All the data in the column will be lost.
  - Added the required column `expierdAt` to the `Payment` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Payment" DROP COLUMN "upload_payment",
ADD COLUMN     "expierdAt" TIMESTAMP(3) NOT NULL;
