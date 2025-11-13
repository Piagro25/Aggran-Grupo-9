CREATE DATABASE aggran;
USE aggran;

CREATE TABLE cadastroEmpresa (
	idCadastro INT PRIMARY KEY AUTO_INCREMENT,
    nomeResponsavel VARCHAR(50) NOT NULL,
    nomeEmpresa VARCHAR(50) DEFAULT NULL,
	cnpj VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
	CONSTRAINT chkEmail CHECK(email LIKE '%@%.%'),
    telefone CHAR(18),
	tipoProducao VARCHAR(10) NOT NULL,
    cep VARCHAR(14) NOT NULL,
	logradouro VARCHAR(40) NOT NULL,
	numero INT NOT NULL,
	complemento VARCHAR(40),
	bairro VARCHAR(40) NOT NULL,
    cidade VARCHAR(40) NOT NULL,
    uf CHAR(2) NOT NULL,
    tamanhoTerreno INT,
    dataCadastro DATETIME DEFAULT current_timestamp,
	senha VARCHAR(255) NOT NULL,
    CONSTRAINT chktipoProducao CHECK(tipoProducao IN ('Lavoura', 'Pastagem', 'Perene'))
);

INSERT INTO cadastroEmpresa (nomeResponsavel, cnpj, nomeEmpresa, email, senha, cep, logradouro, numero, complemento, bairro, cidade, uf, tipoProducao)
VALUES
('Fernando Brandão', '12345678000199', 'SPtech agro', 'brandão@mail.com', '123456', '01310923', 'Itaim bibi', 120, NULL, 'Plano Diretor Norte', 'Palmas', 'TO', 'Lavoura'),
('Julia', '98765432000155', 'Verde mata', 'julia@mail.com', 'senha123', '88010000', 'Av. das Planta', 450, 'Sala 2', 'Centro', 'Uberlândia', 'MG', 'Pastagem'),
('Vivian', '45678912000133', 'Dadosplus', 'vivian@mail.com', 'plant2024', '74000000', 'Rua Balneario', 80, NULL, 'Setor Central', 'Goiânia', 'GO', 'Perene');

CREATE TABLE usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    cpf CHAR(11),
    senha VARCHAR(255) NOT NULL,
    statusCliente VARCHAR(10),
    dataStatus DATETIME DEFAULT current_timestamp,
    dataCadastro DATETIME DEFAULT current_timestamp,
    fk_cadastroEmpresa INT,
    fk_responsavel INT,
    tipoUsuairo CHAR(8),
    CONSTRAINT chkCliente CHECK (statusCliente IN ('Ativo', 'Inativo')),
	CONSTRAINT chk_usuario CHECK (tipoUsuairo IN ('Administrador', 'Funcionário')),
    CONSTRAINT fkcadastroUsuario FOREIGN KEY (fk_cadastroEmpresa) REFERENCES cadastroEmpresa(idCadastro),
    CONSTRAINT fkusuario_Responsavel FOREIGN KEY (fk_responsavel) REFERENCES usuario(idUsuario)
);


INSERT INTO usuario (nome, email, cpf, senha, statusCliente, fk_cadastroEmpresa, fk_responsavel)
VALUES
('Brandão', 'brandao@mail.com', '000.000.000', 'senha123', 'Ativo', null, 1),
('Julia', 'julia@mail.com', '010.000.000', 'senha_julia', 'Ativo', null, 2),
('Vivian', 'Vivian@mail.com', '020.000.000', 'senha_1001', 'Ativo', null, 2),
('joão de paula', 'joao@mail.com', '030.000.000', 'senha_nova', 'Ativo', null, 1);


CREATE TABLE loteSensor (
	idLoteSensor INT PRIMARY KEY AUTO_INCREMENT,
    numeroLote INT UNIQUE
);

INSERT INTO loteSensor (numeroLote)
VALUES
(1001),
(1002),
(1003);

CREATE TABLE sensor (
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    numeroSensor CHAR(20) NOT NULL UNIQUE,
	latitudeSensor DECIMAL(9,6),
	longitudeSensor DECIMAL (9,6),
    fkidCadastro INT,
    fkidloteSensor INT,
    localHectar INT,
    CONSTRAINT fksensorCadastro FOREIGN KEY (fkidCadastro) REFERENCES cadastroEmpresa(idCadastro),
    CONSTRAINT fkloteSensor FOREIGN KEY (fkidloteSensor) REFERENCES loteSensor(idloteSensor)
);

INSERT INTO sensor (numeroSensor, latitudeSensor, longitudeSensor, fkidCadastro, fkidloteSensor)
VALUES
('SENS-001', -10.184445, -48.333619, 1, 1), 
('SENS-002', -18.918804, -48.276783, 2, 2),  
('SENS-003', -20.442778, -54.646389, 3, 3); 


CREATE TABLE usuarioSensor (
	idUsuarioSensor INT,
	fkidUsuario INT NOT NULL,
    fkidSensor INT NOT NULL,
    PRIMARY KEY (fkidUsuario, fkidSensor),
    CONSTRAINT fkUsuarioUsuarioSensor FOREIGN KEY (fkidUsuario) REFERENCES usuario(idUsuario),
    CONSTRAINT fkSensorUsuarioSensor FOREIGN KEY (fkidSensor) REFERENCES sensor(idSensor)
);


INSERT INTO usuarioSensor (fkidUsuario, fkidSensor)
VALUES
(1, 1),
(2, 2),
(3, 3);

CREATE TABLE statusSensor (
	idManutencao INT PRIMARY KEY AUTO_INCREMENT,
    status_Sensor VARCHAR(10),
    tipoFalha VARCHAR(30),
    descricao VARCHAR(150),
    dataStatus DATETIME DEFAULT current_timestamp,
    fk_idSensor INT,
	CONSTRAINT chkstatus_sensor CHECK (status_Sensor IN ('Manutenção', 'Para uso', 'Em uso')),
	CONSTRAINT chktipo_Falha CHECK (tipoFalha IN ('Sensor', 'Arduino', 'Jumpers', 'Software', 'Pinos', 'Sem falhas')),
    CONSTRAINT fkstatus_Sensor FOREIGN KEY (fk_idSensor) REFERENCES sensor(idSensor)
);

INSERT INTO statusSensor (status_Sensor, tipoFalha, descricao, fk_idSensor)
VALUES
('Em uso', 'Sem falhas', 'Sensor operando', 1),
('Manutenção', 'Arduino', 'Falha', 2),
('Para uso', 'Sem falhas', 'Pronto para instalação no lote 3.', 3);

CREATE TABLE registro (
	idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    umidadeSolo DECIMAL(5,2),
    dataRegistro DATETIME DEFAULT current_timestamp,
    fkidSensor INT,
    CONSTRAINT fkregistroSensor FOREIGN KEY (fkidSensor) REFERENCES sensor(idSensor)
);

INSERT INTO registro (umidadeSolo, fkidSensor)
VALUES
(31.7, 1),
(26.3, 2),
(44.8, 3);

SELECT umidadeSolo FROM registro;
