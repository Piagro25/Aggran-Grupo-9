var registrosModel = require("../models/registrosModel");

function buscarUltimosRegistros(req, res) {

    var Hectare_ID = req.params.Hectare_ID
    var ID_USUARIO = registrosModel.params.

    console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

    registrosModel.buscarUltimosRegistros(Hectare_ID, ID_USUARIO).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
};

module.exports = {
    buscarUltimasMedidas

}