/*
  Warnings:

  - A unique constraint covering the columns `[code]` on the table `Referal` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Referal" ALTER COLUMN "point" SET DEFAULT 0;

-- CreateIndex
CREATE UNIQUE INDEX "Referal_code_key" ON "Referal"("code");
