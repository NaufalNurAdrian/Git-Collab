-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_coupon_Id_fkey";

-- AlterTable
ALTER TABLE "Transaction" ALTER COLUMN "coupon_Id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_coupon_Id_fkey" FOREIGN KEY ("coupon_Id") REFERENCES "Coupon"("coupon_id") ON DELETE SET NULL ON UPDATE CASCADE;
