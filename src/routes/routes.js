const express = require('express');
const router = new express.Router();

const controller  = require('../controllers/index');

router.get('/cidr-to-mask', (req, res) => {
    try {
        const result = controller.cidrToMask(req.query);
        return res.send(result);
    } catch (error) {
        res.status(422);
        res.send(error);
    }
});

router.get('/mask-to-cidr', (req, res) => {
    try {
        const result = controller.maskToCidr(req.query);
        return res.send(result);
    } catch (error) {
        res.status(422);
        res.send(error);
    }
});

module.exports = router;