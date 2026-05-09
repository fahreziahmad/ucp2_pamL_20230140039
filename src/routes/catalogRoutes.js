const express = require('express');
const router = express.Router();
const catalogController = require('../controllers/catalogController');
const authenticateToken = require('../middleware/authMiddleware');

// Protected routes (require valid JWT)
router.get('/', authenticateToken, catalogController.getAllCars);
router.post('/', authenticateToken, catalogController.createCar);
router.put('/:id', authenticateToken, catalogController.updateCar);
router.delete('/:id', authenticateToken, catalogController.deleteCar);

module.exports = router;
