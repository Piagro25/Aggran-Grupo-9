CREATE DATABASE aggran;
USE aggran;

CREATE TABLE cadastro (
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
    tamanhoTerreno DECIMAL,
    dataCadastro DATETIME DEFAULT current_timestamp,
	senha VARCHAR(255) NOT NULL,
    CONSTRAINT chktipoProducao CHECK(tipoProducao IN ('Lavoura', 'Pastagem', 'Perene'))
);

CREATE TABLE Usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    statusCliente VARCHAR(10),
    dataStatus DATETIME DEFAULT current_timestamp,
    dataCadastro DATETIME DEFAULT current_timestamp,
    fkidCadastro INT NOT NULL,
    CONSTRAINT chkCliente CHECK (statusCliente IN ('Ativo', 'Inativo')),
    CONSTRAINT fkcadastroUsuario FOREIGN KEY (fkidCadastro) REFERENCES Cadastro(idCadastro)
);

CREATE TABLE LoteSensor (
	idloteSensor INT PRIMARY KEY AUTO_INCREMENT,
    numeroLote INT UNIQUE
);

CREATE TABLE Sensor (
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
    numeroSensor CHAR(20) NOT NULL UNIQUE,
	latitudeSensor DECIMAL(9,6),
	longitudeSensor DECIMAL (9,6),
    fkidCadastro INT,
    fkidloteSensor INT,
    CONSTRAINT fksensorCadastro FOREIGN KEY (fkidCadastro) REFERENCES Cadastro(idCadastro),
    CONSTRAINT fkloteSensor FOREIGN KEY (fkidloteSensor) REFERENCES LoteSensor(idloteSensor)
);

CREATE TABLE UsuarioSensor (
	idUsuarioSensor INT,
	fkidUsuario INT NOT NULL,
    fkidSensor INT NOT NULL,
    PRIMARY KEY (fkidUsuario, fkidSensor),
    CONSTRAINT fkUsuarioUsuarioSensor FOREIGN KEY (fkidUsuario) REFERENCES Usuario(idUsuario),
    CONSTRAINT fkSensorUsuarioSensor FOREIGN KEY (fkidSensor) REFERENCES Sensor(idSensor)
);


CREATE TABLE StatusSensor (
	idManutencao INT PRIMARY KEY AUTO_INCREMENT,
    statusSensor VARCHAR(10),
    CONSTRAINT chkstatus CHECK (statusSensor IN ('Manutenção', 'Para uso', 'Em uso')),
    tipoFalha VARCHAR(30),
    CONSTRAINT chktipoFalha CHECK (tipoFalha IN ('Sensor', 'Arduino', 'Jumpers', 'Software', 'Pinos', 'Sem falhas')),
    descricao VARCHAR(150),
    dataStatus DATETIME DEFAULT current_timestamp,
    fkidSensor INT,
    CONSTRAINT fkstatusSensor FOREIGN KEY (fkidSensor) REFERENCES Sensor(idSensor)
);

CREATE TABLE Registro (
	idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    umidadeSolo DECIMAL(5,2),
    dataRegistro DATETIME DEFAULT current_timestamp,
    fkidSensor INT,
    CONSTRAINT fkregistroSensor FOREIGN KEY (fkidSensor) REFERENCES Sensor(idSensor)
);

SELECT umidadeSolo FROM registro;

INSERT INTO Cadastro (nomeResponsavel, cnpj, nomeEmpresa, email, senha, cep, logradouro, numero, complemento, bairro, cidade, uf, tipoProducao)
VALUES
('Fernando Brandão', '12345678000199', 'SPtech agro', 'brandão@mail.com', '123456', '01310923', 'Itaim bibi', 120, NULL, 'Plano Diretor Norte', 'Palmas', 'TO', 'Lavoura'),
('Julia', '98765432000155', 'Verde mata', 'julia@mail.com', 'senha123', '88010000', 'Av. das Planta', 450, 'Sala 2', 'Centro', 'Uberlândia', 'MG', 'Pastagem'),
('Vivian', '45678912000133', 'Dadosplus', 'vivian@mail.com', 'plant2024', '74000000', 'Rua Balneario', 80, NULL, 'Setor Central', 'Goiânia', 'GO', 'Perene');

INSERT INTO Usuario (nome, email, senha, statusCliente, fkidCadastro)
VALUES
('Brandão', 'brandao@mail.com', 'senha123', 'Ativo', 1),
('Julia', 'julia@mail.com', 'verde2024', 'Ativo', 2),
('Vivian', 'viviana@mail.com', 'planta123', 'Inativo', 3);

INSERT INTO LoteSensor (numeroLote)
VALUES
(1001),
(1002),
(1003);

INSERT INTO Sensor (numeroSensor, latitudeSensor, longitudeSensor, fkidCadastro, fkidloteSensor)
VALUES
('SENS-001', -10.184445, -48.333619, 1, 1), 
('SENS-002', -18.918804, -48.276783, 2, 2),  
('SENS-003', -20.442778, -54.646389, 3, 3); 

INSERT INTO UsuarioSensor (fkidUsuario, fkidSensor)
VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO StatusSensor (statusSensor, tipoFalha, descricao, fkidSensor)
VALUES
('Em uso', 'Sem falhas', 'Sensor operando', 1),
('Manutenção', 'Arduino', 'Falha', 2),
('Para uso', 'Sem falhas', 'Pronto para instalação no lote 3.', 3);

INSERT INTO Registro (umidadeSolo, fkidSensor)
VALUES
(31.7, 1),
(26.3, 2),
(44.8, 3);







