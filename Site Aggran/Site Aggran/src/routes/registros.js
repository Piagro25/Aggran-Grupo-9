var express = require("express");
var router = express.Router();
var registrosController = require("../controllers/registrosController");


router.get("/listar", function (req, res) {
    registrosController.listar(req, res);
});

router.get("/buscarUltimosRegistros", function (req, res) {
    registrosController.buscarUltimosRegistros(req, res);
});

module.exports = router;