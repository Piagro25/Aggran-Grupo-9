CREATE DATABASE grupo2;
use grupo2;

CREATE TABLE cadastro(
id INT PRIMARY KEY AUTO_INCREMENT,
nomeCompleto VARCHAR(100)NOT NULL,
email VARCHAR(30) 
CONSTRAINT chkEmail CHECK(email LIKE '%@%.%')NOT NULL UNIQUE,
cnpj CHAR(18) NOT NULL UNIQUE
CONSTRAINT chkCNPJ CHECK(CNPJ LIKE '__.___.___/____-__') NOT NULL UNIQUE,
telefone VARCHAR(16) NOT NULL UNIQUE,
tamanhoTerreno INT NOT NULL,
produto VARCHAR(30) NOT NULL,
senha VARCHAR(15) NOT NULL,
nomeUsuario VARCHAR(30) NOT NULL UNIQUE,
cep VARCHAR(14) NOT NULL,
logradouro VARCHAR(10) NOT NULL,
endereco VARCHAR(40) NOT NULL,
complemento VARCHAR(40) ,
numero INT NOT NULL,
dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO cadastro VALUES
(DEFAULT, 'Guilherme Souto', 'guilherme@gmail.com','54.068.715/0001-05',
11398527271,200,'milho','abc123', 'Cliente Guilherme', 08120080, 'Rua', 'Serra dos Aimorés','Em frente a loja do Zé' ,148,DEFAULT),

(DEFAULT, 'Guilherme Ornaghi', 'ornaghi@gmail.com','56.354.836/0001-49',
1131336588,500,'tomate','abc321', 'Cliente Ornaghi', 02218150, 'Rua', 'Frei Sebastião dos Anjos','Casa roxa',75,DEFAULT),

(DEFAULT, 'Arthur Rodrigues', 'Arthur@gmail.com','72.981.857/0001-40',
1137761938,300,'alface','cba123', 'Cliente Arthur', 01321010, 'Rua', 'Humaitá', 'Após a placa redonda',320, DEFAULT),

(DEFAULT, 'Rafael Barbosa', 'Rafael@gmail.com','13.625.411/0001-14',
1120852142,100,'uva','cba321', 'Cliente Rafael', 04745040, 'Rua', 'Florença','fazenda do tião',12, DEFAULT);
    

CREATE TABLE custos_recuperacao (
id INT PRIMARY KEY AUTO_INCREMENT,
tipo_producao VARCHAR(50) NOT NULL,
lucro_mensal_medio_ha DECIMAL (12,2) NOT NULL,
custo_recuperacao_ha DECIMAL (12,2) NOT NULL,
meses_recuperacao INT NOT NULL,
custo_mensal_estimado DECIMAL (12,2)
GENERATED ALWAYS AS (ROUND(custo_recuperacao_ha / NULLIF(meses_recuperacao,0),2)) STORED,
prejuizo_estimado_ha DECIMAL (12,2) 
GENERATED ALWAYS AS (
lucro_mensal_medio_ha * meses_recuperacao + custo_recuperacao_ha) STORED
);

INSERT INTO custos_recuperacao 
(tipo_producao, lucro_mensal_medio_ha, custo_recuperacao_ha, meses_recuperacao) VALUES
('Soja', 90.00, 800.00, 6),
('Milho', 30.00, 900.00, 6),
('Pecuária', 18.00, 4400.00, 6),
('Café', 550.00, 6000.00, 6),
('Vegetação Nativa', 0.00, 17000.00, 36);

SELECT 
tipo_producao AS 'Tipo de Produção',
lucro_mensal_medio_ha AS 'Lucro Mensal Médio/HA',
custo_recuperacao_ha AS 'Custo total de recuperação / HA',
meses_recuperacao AS 'Tempo de recuperação (em meses)',
custo_mensal_estimado AS 'Custo de recuperação (mensal estimado)',
prejuizo_estimado_ha AS 'Prejuízo Estimado / HA'
FROM custos_recuperacao;

CREATE TABLE arduino(
id INT PRIMARY KEY AUTO_INCREMENT,
idSensor VARCHAR(10),
umidade DECIMAL (5,2) NOT NULL,
dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
latitudeSensor DECIMAL(9,6) NOT NULL,
longitudeSensor DECIMAL (9,6) NOT NULL
);

INSERT INTO arduino (id,idSensor,umidade,latitudeSensor,longitudeSensor) VALUES

(default, 1, 45.02, -23.550520, -46.633308),
(default, 2, 47.22,-23.551000, -46.632500), 
(default, 3, 50.32, -23.549800, -46.634200), 
(default, 4, 30.00,-23.550900, -46.633900);

INSERT INTO arduino(umidade,latitudeSensor, longitudeSensor) VALUES
(45.02, -23.550520, -46.633308),
(45.20,-23.551000, -46.632500),
(50.02, -23.549800, -46.634200),
(52.20,-23.550900, -46.633900);

SELECT * FROM arduino
	WHERE idSensor = 1;
    
SELECT * FROM arduino;



