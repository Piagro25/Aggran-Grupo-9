var database = require("../database/config");

function buscarUltimosRegistros(ID_USUARIO) {

    var instrucaoSql = `SELECT * FROM vw_media_umidade;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listar() {
    console.log('entrei no model listar')
    var instrucao = `
        SELECT umidadeSolo FROM registro;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    buscarUltimosRegistros,
    listar
}
