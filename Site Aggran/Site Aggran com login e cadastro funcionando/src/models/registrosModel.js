var database = require("../database/config");

function buscarUltimosRegistros(Hectare_ID, ID_USUARIO) {

    var instrucaoSql = `
        CREATE VIEW vw_vizualizacao_risco AS 
SELECT
    ROUND(r.fkidSensor / 4.0) AS Hectare_ID,
    AVG(r.umidadeSolo) AS Umidade_Media,
    CASE
        -- vermelho: Umidade média menor que 20%
        WHEN AVG(r.umidadeSolo) < 20.00 THEN 'Vermelho (Risco de Queimadas)'
        -- amarelo: Umidade média entre 20% e 40%
        WHEN AVG(r.umidadeSolo) >= 20.00 AND AVG(r.umidadeSolo) <= 40.00 THEN 'Amarelo (Atenção)'
        -- verde: Umidade média maior que 40%
        ELSE 'Verde (Ideal)'
    END AS Status_Umidade
FROM
    registro r
    LEFT JOIN sensor s
    ON s.idSensor = r.fkidSensor
    JOIN usuarioSensor AS us
    ON us.fkidSensor = s.idSensor
    JOIN Usuario AS u
    ON us.fkidUsuario = u.idUsuario
    WHERE idUsuario = ${ID_USUARIO}
GROUP BY
    ${Hectare_ID}
ORDER BY
    ${Hectare_ID};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimosRegistros
    
}
