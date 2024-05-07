const express = require('express');
const jwt = require('jsonwebtoken');

if (process.env.NODE_ENV === 'production') {
    require('dotenv').config({ path: './config/.env' });
} else {
    require('dotenv').config({ path: './config/.env' });
}
const app = express();

const routes = require('./src/routes/routes');
const publicRoutes = require('./src/routes/public-routes');
const secret = process.env.secret;

const protectFunction = (authorization) => {
    try {
      const user = jwt.verify(authorization, secret);
      if (user) {
        return true;
      }
      return null
    } catch (err) {
      console.error("Invalid JWT Token!", err);
      return null
    }
}

app.use(express.json());
app.use(publicRoutes);

app.use((req, res, next) => {
    const { token } = req.headers;
    if (token) {
        if (protectFunction(token)) {
            next();
        } else {
            res.status(401);
            res.send("unauthorized")
        }
    } else {
        res.status(401);
        res.send("You must provide a token")
    }
});

app.use(routes);

const port = process.env.PORT;

app.listen(port, () => {
    console.log(`ENV: ${process.env.NODE_ENV}`);
    console.log(`listening at port: ${port}`);
})