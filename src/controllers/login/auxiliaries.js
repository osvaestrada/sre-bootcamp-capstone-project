const crypto = require("crypto");
const jwt = require('jsonwebtoken');

const secret = process.env.secret;

const { login } = require('../../data/index');

const getLogin = async userName => login(userName);

const generateToken = (result, input_password) => {
	try {
		const user = result[0];
		const hashedPassword = crypto.createHash('sha512').update(input_password + user.salt).digest('hex');
		if(!hashedPassword.localeCompare(user.password)){           
			const tokenSigned = jwt.sign(
				{
					role: user.role,
				},
					secret,
				{
					noTimestamp: true,
				}
			);
            return {
                data: tokenSigned
            }
		} else {
			throw new Error('The data you have entered is incorrect');
		}
	} catch (error) {
		throw new Error(error);
	}
}

module.exports = {
    getLogin,
    generateToken,
}