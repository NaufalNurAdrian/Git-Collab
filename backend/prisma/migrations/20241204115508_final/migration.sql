/*
  Warnings:

  - You are about to drop the column `pointsExpiry` on the `User` table. All the data in the column will be lost.
  - Added the required column `used` to the `ReferralLog` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ReferralLog" ADD COLUMN     "used" BOOLEAN NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "pointsExpiry";
