/*
  Warnings:

  - You are about to drop the column `transaction_id` on the `OrderDetail` table. All the data in the column will be lost.
  - Added the required column `orderDetail_id` to the `Transaction` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "OrderDetail" DROP CONSTRAINT "OrderDetail_transaction_id_fkey";

-- AlterTable
ALTER TABLE "OrderDetail" DROP COLUMN "transaction_id";

-- AlterTable
ALTER TABLE "Transaction" ADD COLUMN     "orderDetail_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_orderDetail_id_fkey" FOREIGN KEY ("orderDetail_id") REFERENCES "OrderDetail"("order_id") ON DELETE RESTRICT ON UPDATE CASCADE;
