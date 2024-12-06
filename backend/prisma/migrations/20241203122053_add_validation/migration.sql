/*
  Warnings:

  - You are about to drop the column `eventEvent_id` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `eventEvent_id` on the `Ticket` table. All the data in the column will be lost.
  - Added the required column `validation` to the `Referal` table without a default value. This is not possible if the table is not empty.
  - Added the required column `event_id` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Added the required column `event_id` to the `Ticket` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_eventEvent_id_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_eventEvent_id_fkey";

-- AlterTable
ALTER TABLE "Referal" ADD COLUMN     "validation" BOOLEAN NOT NULL;

-- AlterTable
ALTER TABLE "Review" DROP COLUMN "eventEvent_id",
ADD COLUMN     "event_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Ticket" DROP COLUMN "eventEvent_id",
ADD COLUMN     "event_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "Event"("event_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "Event"("event_id") ON DELETE RESTRICT ON UPDATE CASCADE;
