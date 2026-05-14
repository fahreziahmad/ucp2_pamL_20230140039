const db = require('../config/db');
const response = require('../utils/responseHelper');

exports.getAllCatalog = async (req, res) => {
    try {
        const { search } = req.query;
        let query = 'SELECT m.*, c.name as category_name FROM motors m LEFT JOIN categories c ON m.category_id = c.id';
        let params = [];

        if (search) {
            query += ' WHERE m.name LIKE ? OR m.model LIKE ?';
            params = [`%${search}%`, `%${search}%`];
        }

        const [rows] = await db.query(query, params);
        response.success(res, rows, 'Catalog retrieved successfully');
    } catch (error) {
        response.error(res, 'Error fetching catalog: ' + error.message);
    }
};

exports.getCatalogById = async (req, res) => {
    try {
        const [rows] = await db.query('SELECT m.*, c.name as category_name FROM motors m LEFT JOIN categories c ON m.category_id = c.id WHERE m.id = ?', [req.params.id]);
        if (rows.length === 0) return response.error(res, 'Motor not found', 404);
        response.success(res, rows[0], 'Motor details retrieved');
    } catch (error) {
        response.error(res, 'Error fetching motor: ' + error.message);
    }
};

exports.createCatalog = async (req, res) => {
    try {
        const { name, model, year, category_id, price_per_day, image_url } = req.body;
        const [result] = await db.query(
            'INSERT INTO motors (name, model, year, category_id, price_per_day, image_url) VALUES (?, ?, ?, ?, ?, ?)',
            [name, model, year, category_id, price_per_day, image_url]
        );
        response.success(res, { id: result.insertId }, 'Motor added to catalog', 201);
    } catch (error) {
        response.error(res, 'Error creating catalog entry: ' + error.message);
    }
};

exports.updateCatalog = async (req, res) => {
    try {
        const { name, model, year, category_id, price_per_day, status, image_url } = req.body;
        await db.query(
            'UPDATE motors SET name=?, model=?, year=?, category_id=?, price_per_day=?, status=?, image_url=? WHERE id=?',
            [name, model, year, category_id, price_per_day, status, image_url, req.params.id]
        );
        response.success(res, null, 'Motor updated successfully');
    } catch (error) {
        response.error(res, 'Error updating motor: ' + error.message);
    }
};

exports.deleteCatalog = async (req, res) => {
    try {
        await db.query('DELETE FROM motors WHERE id = ?', [req.params.id]);
        response.success(res, null, 'Motor removed from catalog');
    } catch (error) {
        response.error(res, 'Error deleting motor: ' + error.message);
    }
};
