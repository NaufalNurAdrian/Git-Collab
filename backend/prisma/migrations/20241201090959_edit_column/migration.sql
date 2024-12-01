/*
  Warnings:

  - You are about to drop the column `descriptionDescription_id` on the `Event` table. All the data in the column will be lost.
  - Added the required column `Description_id` to the `Event` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Event" DROP CONSTRAINT "Event_descriptionDescription_id_fkey";

-- AlterTable
ALTER TABLE "Event" DROP COLUMN "descriptionDescription_id",
ADD COLUMN     "Description_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Event" ADD CONSTRAINT "Event_Description_id_fkey" FOREIGN KEY ("Description_id") REFERENCES "Description"("description_id") ON DELETE RESTRICT ON UPDATE CASCADE;
