const db = require('./src/config/db');
const bcrypt = require('bcryptjs');

const seed = async () => {
    try {
        // Create Admin User (Tanpa Role)
        const hashedPassword = await bcrypt.hash('admin123', 10);
        await db.query('INSERT IGNORE INTO users (username, password) VALUES (?, ?)', ['admin', hashedPassword]);
        console.log('Default user created');

        // Create Categories
        const [catResult] = await db.query('INSERT INTO categories (name, description) VALUES (?, ?), (?, ?), (?, ?)', 
            ['Sport', 'Motor sport berperforma tinggi', 'Automatic', 'Motor matic untuk penggunaan harian', 'Off-road', 'Motor trail untuk medan berat']);
        console.log('Categories created');

        const sportId = catResult.insertId;
        const maticId = catResult.insertId + 1;

        // Create Motors
        await db.query('INSERT INTO motors (name, model, year, category_id, price_per_day, status) VALUES (?, ?, ?, ?, ?, ?), (?, ?, ?, ?, ?, ?)', [
            'Kawasaki Ninja', 'ZX-25R', 2023, sportId, 500000.00, 'available',
            'Honda Vario', '160 ABS', 2024, maticId, 150000.00, 'available'
        ]);
        console.log('Sample motors created');

        console.log('Seeding MotoEase completed successfully');
        process.exit();
    } catch (error) {
        console.error('Error seeding database:', error);
        process.exit(1);
    }
};

seed();
