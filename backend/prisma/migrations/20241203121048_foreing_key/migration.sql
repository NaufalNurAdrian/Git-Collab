/*
  Warnings:

  - You are about to drop the column `eventId` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `event_id` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `eventId` on the `Ticket` table. All the data in the column will be lost.
  - You are about to drop the column `event_id` on the `Ticket` table. All the data in the column will be lost.
  - Added the required column `eventEvent_id` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Added the required column `eventEvent_id` to the `Ticket` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_event_id_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_event_id_fkey";

-- AlterTable
ALTER TABLE "Review" DROP COLUMN "eventId",
DROP COLUMN "event_id",
ADD COLUMN     "eventEvent_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Ticket" DROP COLUMN "eventId",
DROP COLUMN "event_id",
ADD COLUMN     "eventEvent_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_eventEvent_id_fkey" FOREIGN KEY ("eventEvent_id") REFERENCES "Event"("event_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_eventEvent_id_fkey" FOREIGN KEY ("eventEvent_id") REFERENCES "Event"("event_id") ON DELETE RESTRICT ON UPDATE CASCADE;
