const util = require('util');
const db = require('../../config/db');


db.query = util.promisify(db.query);
const login = (username) => db.query(
        "SELECT username, salt, role,password FROM users WHERE username = ?",
        [ username ]
    );

module.exports = {
    login,
}