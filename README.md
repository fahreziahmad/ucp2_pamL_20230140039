# DriveEase Backend API

This is the RESTful API for the DriveEase Fleet Management system.

## Tech Stack
- Node.js
- Express
- MySQL
- JSON Web Token (JWT)

## Setup Instructions
1. Install dependencies:
   ```bash
   npm install
   ```
2. Setup Database:
   - Create a database named `driveease_db` in MySQL/phpMyAdmin.
   - Run the SQL script in `init_db.sql` to create tables.
   - (Optional) Run `node seed_db.js` to populate sample data.
3. Configure Environment Variables:
   - Create a `.env` file based on the template below:
     ```env
     PORT=3000
     DB_HOST=localhost
     DB_USER=root
     DB_PASSWORD=
     DB_NAME=driveease_db
     JWT_SECRET=your_secret_key
     ```
4. Start the server:
   ```bash
   npm start
   ```

## API Endpoints
### Auth
- `POST /api/auth/register`
- `POST /api/auth/login`

### Categories (Protected)
- `GET /api/categories`
- `POST /api/categories`
- `PUT /api/categories/:id`
- `DELETE /api/categories/:id`

### Catalog (Protected)
- `GET /api/catalog`
- `POST /api/catalog`
- `PUT /api/catalog/:id`
- `DELETE /api/catalog/:id`
