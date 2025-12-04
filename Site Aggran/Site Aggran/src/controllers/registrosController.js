var registrosModel = require("../models/registrosModel");

function buscarUltimosRegistros(req, res) {

    var ID_USUARIO = req.params.ID_USUARIO;

    registrosModel.buscarUltimosRegistros(ID_USUARIO).then(function (resultado) {
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
function listar(req, res) {

    registrosModel.listar()
    .then(function (resultado) {
        console.log('controller listar', resultado)
        // precisamos informar que o resultado voltará para o front-end como uma resposta em json
        res.status(200).json(resultado);
    }).catch(function (erro) {
        res.status(500).json(erro);
    })
}
module.exports = {
    buscarUltimosRegistros,
    listar
}