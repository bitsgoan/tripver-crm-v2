/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "leadSource" AS ENUM ('TripverWebsite', 'Instagram', 'Referral', 'FriendsAndFamily', 'NonInstagramSocial', 'Search', 'Others');

-- CreateEnum
CREATE TYPE "tripType" AS ENUM ('CUSTOM', 'STANDARD');

-- CreateEnum
CREATE TYPE "destination" AS ENUM ('Vietnam', 'Thailand', 'IndiaLeh', 'IndiaSpiti');

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Specialist" (
    "id" SERIAL NOT NULL,
    "fullName" TEXT NOT NULL,
    "dateCreated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "profilePic" TEXT,

    CONSTRAINT "Specialist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Lead" (
    "id" SERIAL NOT NULL,
    "customerName" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT,
    "leadSource" "leadSource" NOT NULL,
    "dateCreated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tentativeStartDate" TIMESTAMP(3),
    "tentativeEndDate" TIMESTAMP(3),
    "addedBy" TEXT,
    "tripType" "tripType",
    "noDays" INTEGER,
    "destination" "destination",
    "noPax" INTEGER,
    "amountQuoted" DOUBLE PRECISION,
    "notes" TEXT,
    "specialistId" INTEGER NOT NULL,

    CONSTRAINT "Lead_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisqualifiedLead" (
    "id" SERIAL NOT NULL,
    "leadID" INTEGER NOT NULL,
    "reason" TEXT NOT NULL,

    CONSTRAINT "DisqualifiedLead_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QualifiedLead" (
    "id" SERIAL NOT NULL,
    "leadID" INTEGER NOT NULL,
    "dateCreated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "tripType" "tripType",
    "noDays" INTEGER,
    "destination" "destination",
    "noPax" INTEGER,
    "amountQuoted" DOUBLE PRECISION,
    "notes" TEXT NOT NULL,

    CONSTRAINT "QualifiedLead_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Booking" (
    "id" SERIAL NOT NULL,
    "qualifiedLeadID" INTEGER NOT NULL,
    "dateCreated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "tripType" "tripType" NOT NULL,
    "noDays" INTEGER NOT NULL,
    "destination" "destination" NOT NULL,
    "noPax" INTEGER NOT NULL,
    "totalAmountPaid" DOUBLE PRECISION NOT NULL,
    "PaymentDetails" TEXT NOT NULL,
    "notes" TEXT NOT NULL,

    CONSTRAINT "Booking_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Specialist_phone_key" ON "Specialist"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "Specialist_email_key" ON "Specialist"("email");

-- AddForeignKey
ALTER TABLE "Lead" ADD CONSTRAINT "Lead_specialistId_fkey" FOREIGN KEY ("specialistId") REFERENCES "Specialist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisqualifiedLead" ADD CONSTRAINT "DisqualifiedLead_leadID_fkey" FOREIGN KEY ("leadID") REFERENCES "Lead"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QualifiedLead" ADD CONSTRAINT "QualifiedLead_leadID_fkey" FOREIGN KEY ("leadID") REFERENCES "Lead"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_qualifiedLeadID_fkey" FOREIGN KEY ("qualifiedLeadID") REFERENCES "QualifiedLead"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
