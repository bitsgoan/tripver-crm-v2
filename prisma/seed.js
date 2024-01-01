import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {
    await insertSpecialists();
    // add more seed functions
}

main()
    .catch((e) => {
        console.error(e);
    })
    .finally(async () => {
        await prisma.$disconnect();
    })

async function insertSpecialists() {
    const specialists = [
        { 'id': 1, 'fullName': "Akshat", 'phone': '9999999991', email: "tripver1@gmail.com" },
        { 'id': 2, 'fullName': "Goofy", 'phone': '9999999992', email: "tripver2@gmail.com" },
        { 'id': 3, 'fullName': "Addy", 'phone': '9999999993', email: "tripver3@gmail.com" },
        { 'id': 4, 'fullName': "Ayesha", 'phone': '9999999994', email: "tripver4@gmail.com" },
    ];

    console.log('Seeding Specialists')

    for (const specialist of specialists) {
        const specialistRecord = await prisma.specialist.create({
            data: specialist,
        })
        console.log(`Created Specialist with ID: ${specialistRecord.id}`);
    }
}