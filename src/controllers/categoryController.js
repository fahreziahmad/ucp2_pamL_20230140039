const db = require('../config/db');
const response = require('../utils/responseHelper');

exports.getAllCategories = async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM categories ORDER BY created_at DESC');
        response.success(res, rows);
    } catch (error) {
        response.error(res, 'Error fetching categories: ' + error.message);
    }
};

exports.createCategory = async (req, res) => {
    try {
        const { name, description } = req.body;
        if (!name) return response.error(res, 'Category name is required', 400);

        const [result] = await db.query('INSERT INTO categories (name, description) VALUES (?, ?)', [name, description]);
        response.success(res, { id: result.insertId, name, description }, 'Category created', 201);
    } catch (error) {
        response.error(res, 'Error creating category: ' + error.message);
    }
};

exports.updateCategory = async (req, res) => {
    try {
        const { id } = req.params;
        const { name, description } = req.body;
        
        await db.query('UPDATE categories SET name = ?, description = ? WHERE id = ?', [name, description, id]);
        response.success(res, null, 'Category updated successfully');
    } catch (error) {
        response.error(res, 'Error updating category: ' + error.message);
    }
};

exports.deleteCategory = async (req, res) => {
    try {
        const { id } = req.params;
        await db.query('DELETE FROM categories WHERE id = ?', [id]);
        response.success(res, null, 'Category deleted successfully');
    } catch (error) {
        response.error(res, 'Error deleting category: ' + error.message);
    }
};
