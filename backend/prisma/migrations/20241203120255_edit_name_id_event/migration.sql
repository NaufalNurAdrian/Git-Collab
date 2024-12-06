/*
  Warnings:

  - You are about to drop the column `event_id` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `event_id` on the `Ticket` table. All the data in the column will be lost.
  - Added the required column `Event_id` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Event_id` to the `Ticket` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_event_id_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_event_id_fkey";

-- AlterTable
ALTER TABLE "Review" DROP COLUMN "event_id",
ADD COLUMN     "Event_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Ticket" DROP COLUMN "event_id",
ADD COLUMN     "Event_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_Event_id_fkey" FOREIGN KEY ("Event_id") REFERENCES "Event"("event_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_Event_id_fkey" FOREIGN KEY ("Event_id") REFERENCES "Event"("event_id") ON DELETE RESTRICT ON UPDATE CASCADE;
