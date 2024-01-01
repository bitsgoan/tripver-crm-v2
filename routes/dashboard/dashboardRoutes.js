import { Router } from "express";
import { getAllLeads, getAllSpecialists } from '../../controllers/dashboard/dashboardController.js';
const router = Router();

console.log("Inside Dashboard Routes")

router.get("/leads", getAllLeads)
router.get("/specialists", getAllSpecialists)

export default router;