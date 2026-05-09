const db = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const response = require('../utils/responseHelper');
require('dotenv').config();

exports.register = async (req, res) => {
    try {
        const { username, password } = req.body;
        if (!username || !password) {
            return res.status(400).json({ message: 'Username and password are required' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        await db.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, hashedPassword]);

        response.success(res, null, 'User registered successfully', 201);
    } catch (error) {
        if (error.code === 'ER_DUP_ENTRY') {
            return response.error(res, 'Username already exists', 400);
        }
        response.error(res, 'Error registering user: ' + error.message);
    }
};

exports.login = async (req, res) => {
    try {
        const { username, password } = req.body;
        const [rows] = await db.query('SELECT * FROM users WHERE username = ?', [username]);

        if (rows.length === 0) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        const user = rows[0];
        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) {
            return response.error(res, 'Invalid credentials', 401);
        }

        const token = jwt.sign(
            { id: user.id, username: user.username, role: user.role },
            process.env.JWT_SECRET,
            { expiresIn: '24h' }
        );

        response.success(res, {
            token,
            user: { id: user.id, username: user.username, role: user.role }
        }, 'Login successful');
    } catch (error) {
        response.error(res, 'Error logging in: ' + error.message);
    }
};
