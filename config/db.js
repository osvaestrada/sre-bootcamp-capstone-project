const mysql = require('mysql');

const database = mysql.createConnection({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    host:process.env.HOST,
});

module.exports = database;