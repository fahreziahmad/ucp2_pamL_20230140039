const db = require('../config/db');

exports.getAllCars = async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT cars.*, categories.name as category_name 
            FROM cars 
            LEFT JOIN categories ON cars.category_id = categories.id 
            ORDER BY cars.created_at DESC
        `);
        res.json(rows);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching cars', error: error.message });
    }
};

exports.createCar = async (req, res) => {
    try {
        const { name, model, year, category_id, price_per_day, status, image_url } = req.body;
        if (!name || !model || !year || !price_per_day) {
            return res.status(400).json({ message: 'Missing required fields' });
        }

        const [result] = await db.query(
            'INSERT INTO cars (name, model, year, category_id, price_per_day, status, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [name, model, year, category_id, price_per_day, status || 'available', image_url]
        );
        res.status(201).json({ id: result.insertId, ...req.body });
    } catch (error) {
        res.status(500).json({ message: 'Error creating car entry', error: error.message });
    }
};

exports.updateCar = async (req, res) => {
    try {
        const { id } = req.params;
        const { name, model, year, category_id, price_per_day, status, image_url } = req.body;

        await db.query(
            'UPDATE cars SET name = ?, model = ?, year = ?, category_id = ?, price_per_day = ?, status = ?, image_url = ? WHERE id = ?',
            [name, model, year, category_id, price_per_day, status, image_url, id]
        );
        res.json({ message: 'Car updated successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Error updating car', error: error.message });
    }
};

exports.deleteCar = async (req, res) => {
    try {
        const { id } = req.params;
        await db.query('DELETE FROM cars WHERE id = ?', [id]);
        res.json({ message: 'Car deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Error deleting car', error: error.message });
    }
};
