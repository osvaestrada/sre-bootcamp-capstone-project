const express = require('express');
const { send } = require('express/lib/response');
const router = new express.Router();

const controller  = require('../controllers/index');

router.post('/login', async (req, res) => {
    const result = await controller.login(req.body.username, req.body.password)
    if (result) {
        res.send(result);
    } else {
        res.status(401);
        res.send('The data you have entered is incorrect');
    }
});

router.get('/_health', (req, res) => {
    const result = controller.health();
    return res.send(result)
});

router.get('/', (req, res) => {
    res.status(200);
    return res.send()
});

module.exports = router;