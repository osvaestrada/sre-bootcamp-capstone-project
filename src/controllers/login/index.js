const { getLogin, generateToken }  = require('./auxiliaries');

const login = async (username, input_password) => {
    try {
        const result = await getLogin(username);
        if (result.length) 
            return generateToken(result, input_password);
        return null;
    } catch (error) {
        console.error(`error login user ${username} with error: `, error);
        return null;
    }
}

module.exports = login;