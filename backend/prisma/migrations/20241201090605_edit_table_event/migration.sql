/*
  Warnings:

  - You are about to drop the column `Event_id` on the `Description` table. All the data in the column will be lost.
  - Added the required column `descriptionDescription_id` to the `Event` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Description" DROP CONSTRAINT "Description_Event_id_fkey";

-- AlterTable
ALTER TABLE "Description" DROP COLUMN "Event_id";

-- AlterTable
ALTER TABLE "Event" ADD COLUMN     "descriptionDescription_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Event" ADD CONSTRAINT "Event_descriptionDescription_id_fkey" FOREIGN KEY ("descriptionDescription_id") REFERENCES "Description"("description_id") ON DELETE RESTRICT ON UPDATE CASCADE;
