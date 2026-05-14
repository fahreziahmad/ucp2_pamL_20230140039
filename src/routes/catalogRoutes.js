const express = require('express');
const router = express.Router();
const catalogController = require('../controllers/catalogController');
const authenticateToken = require('../middleware/authMiddleware');

// Protected routes (require valid JWT)
router.get('/', authenticateToken, catalogController.getAllCatalog);
router.get('/:id', authenticateToken, catalogController.getCatalogById);
router.post('/', authenticateToken, catalogController.createCatalog);
router.put('/:id', authenticateToken, catalogController.updateCatalog);
router.delete('/:id', authenticateToken, catalogController.deleteCatalog);

module.exports = router;
