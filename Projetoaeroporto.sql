-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS aeroporto;

-- Usar o banco de dados
USE aeroporto;

-- Tabela aeroportos
CREATE TABLE IF NOT EXISTS aeroportos (
    codAeroporto INT AUTO_INCREMENT,
    siglaAeroporto CHAR(3) NOT NULL,
    nomeAeroporto VARCHAR(45) NOT NULL,
    cidadeEpaisAeroporto VARCHAR(45) NOT NULL,
    PRIMARY KEY (codAeroporto),
    UNIQUE (siglaAeroporto)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tabela companhias aéreas
CREATE TABLE IF NOT EXISTS companhias_aereas (
    codCompAerea INT AUTO_INCREMENT,
    nomeCompAerea VARCHAR(45) NOT NULL,
    codIATACompAerea CHAR(3) NOT NULL,
    paisDorigemCompAerea VARCHAR(45) NOT NULL,
    PRIMARY KEY (codCompAerea),
    UNIQUE (codIATACompAerea)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tabela aeronaves
CREATE TABLE IF NOT EXISTS aeronaves (
    codAeronave INT AUTO_INCREMENT,
    modeloAeronave VARCHAR(60) NOT NULL,
    capacidadeAeronave INT NOT NULL,
    fabricanteAeronave VARCHAR(45) NOT NULL,
    PRIMARY KEY (codAeronave)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tabela voos
CREATE TABLE IF NOT EXISTS voos (
    codVoo INT AUTO_INCREMENT,
    dataEhoraPartidaVoo DATETIME NOT NULL,
    dataEhoraChegadaVoo DATETIME NOT NULL,
    aeroportoOrigemVoo VARCHAR(45) NOT NULL,
    aeroportoChegadaVoo VARCHAR(45) NOT NULL,
    statusVoo VARCHAR(45) NOT NULL,
    Companhia_Aerea_codCompAerea INT NOT NULL,
    Aeroporto_codAeroporto INT NOT NULL,
    PRIMARY KEY (codVoo),
    FOREIGN KEY (Companhia_Aerea_codCompAerea) REFERENCES companhias_aereas (codCompAerea),
    FOREIGN KEY (Aeroporto_codAeroporto) REFERENCES aeroportos (codAeroporto)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tabela reservas
CREATE TABLE IF NOT EXISTS reservas (
    codReserva INT AUTO_INCREMENT,
    dataReserva DATETIME NOT NULL,
    statusReserva VARCHAR(45) NOT NULL,
    Voo_codVoo INT NOT NULL,
    PRIMARY KEY (codReserva),
    FOREIGN KEY (Voo_codVoo) REFERENCES voos (codVoo)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tabela passageiros
CREATE TABLE IF NOT EXISTS passageiros (
    codPassageiro INT AUTO_INCREMENT,
    cpfPassageiro CHAR(11) NOT NULL,
    nomePassageiro VARCHAR(60) NOT NULL,
    numTelPassageiro CHAR(11) NOT NULL,
    emailPassageiro VARCHAR(90) NOT NULL,
    birthDatePassageiro DATE NOT NULL,
    cepPassageiro CHAR(8) NOT NULL,
    idadePassageiro INT NOT NULL,
    reservas_codReserva INT,
    PRIMARY KEY (codPassageiro),
    FOREIGN KEY (reservas_codReserva) REFERENCES reservas (codReserva)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tabela assentos
CREATE TABLE IF NOT EXISTS assentos (
    codAssento INT AUTO_INCREMENT,
    Passageiro_codPassageiro INT NOT NULL,
    classeAssento VARCHAR(45) NOT NULL,
    localizacaoAssento VARCHAR(10) NOT NULL,
    Voo_codVoo INT NOT NULL,
    PRIMARY KEY (codAssento),
    FOREIGN KEY (Passageiro_codPassageiro) REFERENCES passageiros (codPassageiro),
    FOREIGN KEY (Voo_codVoo) REFERENCES voos (codVoo)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tabela bagagens
CREATE TABLE IF NOT EXISTS bagagens (
    codBagagem INT AUTO_INCREMENT,
    pesoBagagem INT NOT NULL,
    dimensoesBagagem INT NULL DEFAULT NULL,
    tipoBagagem VARCHAR(45) NOT NULL COMMENT 'mão ou despache',
    Passageiro_codPassageiro INT NOT NULL,
    PRIMARY KEY (codBagagem),
    FOREIGN KEY (Passageiro_codPassageiro) REFERENCES passageiros (codPassageiro)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tabela pilotos
CREATE TABLE IF NOT EXISTS pilotos (
    codPiloto INT AUTO_INCREMENT,
    nomePiloto VARCHAR(60) NOT NULL,
    licencaPiloto VARCHAR(20) NOT NULL,
    cpfPiloto CHAR(11) NOT NULL,
    emailPiloto VARCHAR(90) NOT NULL,
    historicoPiloto TEXT,
    horasVooPiloto INT NOT NULL,
    Voo_codVoo INT NOT NULL,
    PRIMARY KEY (codPiloto),
    FOREIGN KEY (Voo_codVoo) REFERENCES voos (codVoo)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tabela funcionarios
CREATE TABLE IF NOT EXISTS funcionarios (
    codFuncionario INT AUTO_INCREMENT,
    nomeFuncionario VARCHAR(60) NOT NULL,
    cargoFuncionario VARCHAR(45) NOT NULL,
    setorFuncionario VARCHAR(45) NOT NULL,
    contatoFuncionario CHAR(11) NOT NULL,
    Voo_codVoo INT,
    PRIMARY KEY (codFuncionario),
    FOREIGN KEY (Voo_codVoo) REFERENCES voos (codVoo)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Inserções de dados (exemplo para cada tabela)

-- Inserir dados em aeroportos 
INSERT INTO aeroportos (siglaAeroporto, nomeAeroporto, cidadeEpaisAeroporto) VALUES 
  ('GRU', 'Aeroporto São Paulo Guarulhos', 'São Paulo, Brasil'),
  ('SFO', 'San Francisco International Airport', 'San Francisco, USA'),
  ('JFK', 'Kennedy International Airport', 'New York, USA');

-- Inserir dados em companhias aéreas
INSERT INTO companhias_aereas (nomeCompAerea, codIATACompAerea, paisDorigemCompAerea) VALUES 
  ('LATAM Airlines', 'LA', 'Brasil'),
  ('American Airlines', 'AA', 'USA'),
  ('Delta Airlines', 'DL', 'USA');

-- Inserir dados em aeronaves
INSERT INTO aeronaves (modeloAeronave, capacidadeAeronave, fabricanteAeronave) VALUES 
  ('Boeing 777', 350, 'Boeing'),
  ('Airbus A320', 180, 'Airbus'),
  ('Boeing 787', 300, 'Boeing');

-- Inserir dados em voos
INSERT INTO voos (dataEhoraPartidaVoo, dataEhoraChegadaVoo, aeroportoOrigemVoo, aeroportoChegadaVoo, statusVoo, Companhia_Aerea_codCompAerea, Aeroporto_codAeroporto) VALUES 
  ('2024-12-01 10:00:00', '2024-12-01 14:00:00', 'GRU', 'SFO', 'Scheduled', 1, 1),
  ('2024-12-02 18:00:00', '2024-12-02 22:00:00', 'SFO', 'JFK', 'Scheduled', 2, 2),
  ('2024-12-03 08:00:00', '2024-12-03 12:00:00', 'JFK', 'GRU', 'Scheduled', 3, 3);

-- Inserir dados em reservas
INSERT INTO reservas (dataReserva, statusReserva, Voo_codVoo) VALUES 
  ('2024-11-01 10:00:00', 'Confirmed', 1),
  ('2024-11-01 12:00:00', 'Confirmed', 2),
  ('2024-11-02 15:00:00', 'Confirmed', 3);

-- Inserir dados em passageiros
INSERT INTO passageiros (cpfPassageiro, nomePassageiro, numTelPassageiro, emailPassageiro, birthDatePassageiro, cepPassageiro, idadePassageiro, reservas_codReserva) VALUES
  ('12345678901', 'João Silva', '11987654321', 'joao.silva@email.com', '1990-05-10', '12345678', 34, 1),
  ('98765432100', 'Maria Oliveira', '11911223344', 'maria.oliveira@email.com', '1985-07-22', '87654321', 39, 2),
  ('55544433322', 'Carlos Souza', '11922334455', 'carlos.souza@email.com', '1980-11-30', '34567890', 44, 3);

-- Inserir dados em assentos
INSERT INTO assentos (Passageiro_codPassageiro, classeAssento, localizacaoAssento, Voo_codVoo) VALUES 
  (1, 'Economy', '12A', 1),
  (2, 'Business', '5B', 2),
  (3, 'First', '1C', 3);

-- Inserir dados em bagagens
INSERT INTO bagagens (pesoBagagem, dimensoesBagagem, tipoBagagem, Passageiro_codPassageiro) VALUES 
  (20, 60, 'Despache', 1),
  (15, 45, 'Mão', 2),
  (10, 40, 'Mão', 3);

-- Inserir dados em pilotos
INSERT INTO pilotos (nomePiloto, licencaPiloto, cpfPiloto, emailPiloto, historicoPiloto, horasVooPiloto, Voo_codVoo) VALUES 
  ('Roberto Costa', 'ABC1234', '11122334455', 'roberto.costa@aviacao.com', 'Piloto com 10 anos de experiência', 5000, 1),
  ('Luciana Pereira', 'DEF5678', '22233445566', 'luciana.pereira@aviation.com', 'Pilota desde 2010', 3500, 2),
  ('Ricardo Gomes', 'XYZ4321', '33344556677', 'ricardo.gomes@airlines.com', 'Experiência de voo em diversas aeronaves', 4200, 3);

-- Inserir dados em funcionários
INSERT INTO funcionarios (nomeFuncionario, cargoFuncionario, setorFuncionario, contatoFuncionario, Voo_codVoo) VALUES 
  ('Ana Lima', 'Atendente', 'Check-in', '11999887766', 1),
  ('Carlos Mota', 'Assistente de Bordo', 'Cabine', '11997766554', 2),
  ('Juliana Santos', 'Comissária', 'Cabine', '11996655443', 3);
