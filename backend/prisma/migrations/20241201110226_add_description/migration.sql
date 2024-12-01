/*
  Warnings:

  - Added the required column `descriptionId` to the `Ticket` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Ticket" ADD COLUMN     "descriptionId" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "Description" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "terms" JSONB NOT NULL,

    CONSTRAINT "Description_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_descriptionId_fkey" FOREIGN KEY ("descriptionId") REFERENCES "Description"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
