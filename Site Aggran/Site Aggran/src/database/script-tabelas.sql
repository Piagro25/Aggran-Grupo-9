
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
    tipoUsuario CHAR(8),
    CONSTRAINT chkCliente CHECK (statusCliente IN ('Ativo', 'Inativo')),
	CONSTRAINT chk_usuario CHECK (tipoUsuario IN ('Administrador', 'Funcionário')),
    CONSTRAINT fkcadastroUsuario FOREIGN KEY (fk_cadastroEmpresa) REFERENCES cadastroEmpresa(idCadastro),
    CONSTRAINT fkusuario_Responsavel FOREIGN KEY (fk_responsavel) REFERENCES usuario(idUsuario)
);


CREATE TABLE loteSensor (
	idLoteSensor INT PRIMARY KEY AUTO_INCREMENT,
    numeroLote INT UNIQUE
);

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

CREATE TABLE usuarioSensor (
	idUsuarioSensor INT,
	fkidUsuario INT NOT NULL,
    fkidSensor INT NOT NULL,
    PRIMARY KEY (fkidUsuario, fkidSensor),
    CONSTRAINT fkUsuarioUsuarioSensor FOREIGN KEY (fkidUsuario) REFERENCES usuario(idUsuario),
    CONSTRAINT fkSensorUsuarioSensor FOREIGN KEY (fkidSensor) REFERENCES sensor(idSensor)
);

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

CREATE TABLE registro (
	idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    umidadeSolo DECIMAL(5,2),
    dataRegistro DATETIME DEFAULT current_timestamp,
    fkidSensor INT,
    CONSTRAINT fkregistroSensor FOREIGN KEY (fkidSensor) REFERENCES sensor(idSensor)
);