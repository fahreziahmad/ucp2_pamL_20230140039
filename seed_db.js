const db = require('./src/config/db');
const bcrypt = require('bcryptjs');

const seed = async () => {
    try {
        // Create Admin User
        const hashedPassword = await bcrypt.hash('admin123', 10);
        await db.query('INSERT IGNORE INTO users (username, password, role) VALUES (?, ?, ?)', ['admin', hashedPassword, 'admin']);
        console.log('Admin user created');

        // Create Categories
        const [catResult] = await db.query('INSERT INTO categories (name, description) VALUES (?, ?), (?, ?)', 
            ['SUV', 'Sport Utility Vehicle', 'Sedan', 'Standard family car']);
        console.log('Categories created');

        const suvId = catResult.insertId;
        const sedanId = catResult.insertId + 1;

        // Create Cars
        await db.query('INSERT INTO cars (name, model, year, category_id, price_per_day, status) VALUES (?, ?, ?, ?, ?, ?), (?, ?, ?, ?, ?, ?)', [
            'Toyota Fortuner', 'VRZ', 2023, suvId, 800000.00, 'available',
            'Honda Civic', 'RS', 2022, sedanId, 600000.00, 'available'
        ]);
        console.log('Sample cars created');

        console.log('Seeding completed successfully');
        process.exit();
    } catch (error) {
        console.error('Error seeding database:', error);
        process.exit(1);
    }
};

seed();
