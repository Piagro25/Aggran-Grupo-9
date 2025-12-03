var express = require("express");
var router = express.Router();

var registrosController = require("../controllers/registrosController");

router.get("/registros/:Hectare_ID:ID_USUARIO", function (req, res) {
    registrosController.buscarUltimosRegistros(req, res);
});

module.exports = router;