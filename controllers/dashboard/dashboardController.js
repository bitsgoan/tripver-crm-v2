import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function getAllSpecialists(req, res) {
    try {
        console.log("Inside get All Specialists Fn API")
        const specialists = await prisma.specialist.findMany({
            select: {
                id: true,
                fullName: true,
                phone: true,
                email: true
            },
            orderBy: { fullName: 'asc' }
        });
        res.status(201).json(specialists)
    }
    catch (error) {
        res.status(500).json({ message: "Server Error", error: error.message })
    }
};

export async function getAllLeads(req, res) {
    try {
        console.log("Inside get All Leads Fn API")
        const specialists = await prisma.specialist.findMany({
            select: {
                id: true,
                // fullName: true,
                phone: true,
                email: true
            },
            orderBy: { fullName: 'asc' }
        });
        res.status(201).json(specialists)
    }
    catch (error) {
        res.status(500).json({ message: "Server Error", error: error.message })
    }
};