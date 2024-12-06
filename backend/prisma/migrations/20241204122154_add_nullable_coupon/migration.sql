-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_coupon_id_fkey";

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "coupon_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_coupon_id_fkey" FOREIGN KEY ("coupon_id") REFERENCES "Coupon"("coupon_id") ON DELETE SET NULL ON UPDATE CASCADE;
