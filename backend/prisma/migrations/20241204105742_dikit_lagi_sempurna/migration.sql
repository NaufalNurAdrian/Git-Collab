/*
  Warnings:

  - You are about to drop the column `referredBy_id` on the `User` table. All the data in the column will be lost.
  - Added the required column `coupon_id` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User" DROP COLUMN "referredBy_id",
ADD COLUMN     "coupon_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_coupon_id_fkey" FOREIGN KEY ("coupon_id") REFERENCES "Coupon"("coupon_id") ON DELETE RESTRICT ON UPDATE CASCADE;
