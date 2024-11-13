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
    Aeronave_codAeronave INT NOT NULL, -- Nova coluna de chave estrangeira para aeronaves
    PRIMARY KEY (codVoo),
    FOREIGN KEY (Companhia_Aerea_codCompAerea) REFERENCES companhias_aereas (codCompAerea),
    FOREIGN KEY (Aeroporto_codAeroporto) REFERENCES aeroportos (codAeroporto),
    FOREIGN KEY (Aeronave_codAeronave) REFERENCES aeronaves (codAeronave) -- Conexão com aeronaves
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
    tipoBagagem VARCHAR(45) NOT NULL COMMENT 'de mão ou despache',
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

-- 2- INSERÇÃO DE DADOS

-- Inserir dados em aeroportos 
INSERT INTO aeroportos (siglaAeroporto, nomeAeroporto, cidadeEpaisAeroporto) VALUES
  ('GRU', 'Aeroporto São Paulo Guarulhos', 'São Paulo, Brasil'),
  ('CDG', 'Aeroporto Charles de Gaulle', 'Paris, França'),
  ('LHR', 'Aeroporto de Heathrow', 'Londres, Reino Unido'),
  ('HND', 'Aeroporto de Haneda', 'Tóquio, Japão'),
  ('SYD', 'Aeroporto de Sydney', 'Sydney, Austrália'),
  ('FRA', 'Aeroporto de Frankfurt', 'Frankfurt, Alemanha'),
  ('MEX', 'Aeroporto Internacional da Cidade do México', 'Cidade do México, México'),
  ('SFO', 'San Francisco International Airport', 'San Francisco, USA'),
  ('JFK', 'Kennedy International Airport', 'New York, USA'),
  ('DXB', 'Aeroporto Internacional de Dubai', 'Dubai, Emirados Árabes Unidos');

-- Inserir dados em companhias aéreas
INSERT INTO companhias_aereas (nomeCompAerea, codIATACompAerea, paisDorigemCompAerea) VALUES 
  ('Air France', 'AF', 'França'),
  ('British Airways', 'BA', 'Reino Unido'),
  ('Latam', 'LT', 'Brasil'),
  ('Gol', 'GO', 'Brasil'),
  ('Lufthansa', 'LH', 'Alemanha'),
  ('Aeroméxico', 'AM', 'México'),
  ('Korean Air', 'KE', 'Coreia do Sul'),
  ('Iberia', 'IB', 'Espanha'),
  ('Swiss International', 'LX', 'Suíça'),
  ('Azul Linhas Aéreas', 'AD', 'Brasil');

-- Inserir dados em aeronaves
INSERT INTO aeronaves (modeloAeronave, capacidadeAeronave, fabricanteAeronave) VALUES 
  ('Embraer E195', 132, 'Embraer'),
  ('Airbus A380', 853, 'Airbus'),
  ('Boeing 737', 189, 'Boeing'),
  ('Airbus A350', 300, 'Airbus'),
  ('Boeing 747', 416, 'Boeing'),
  ('Embraer E175', 88, 'Embraer'),
  ('Airbus A330', 277, 'Airbus'),
  ('Boeing 767', 218, 'Boeing'),
  ('Cessna Citation', 9, 'Cessna'),
  ('Bombardier CRJ900', 90, 'Bombardier');

-- Inserir dados em voos
INSERT INTO voos (dataEhoraPartidaVoo, dataEhoraChegadaVoo, aeroportoOrigemVoo, aeroportoChegadaVoo, statusVoo, Companhia_Aerea_codCompAerea, Aeroporto_codAeroporto, Aeronave_codAeronave) VALUES 
  ('2024-12-01 10:00:00', '2024-12-01 14:00:00', 'GRU', 'SFO', 'Scheduled', 1, 1, 1),
  ('2024-12-02 18:00:00', '2024-12-02 22:00:00', 'SFO', 'JFK', 'Scheduled', 2, 2, 2),
  ('2024-12-03 08:00:00', '2024-12-03 12:00:00', 'JFK', 'GRU', 'Scheduled', 3, 3, 3),
  ('2024-12-04 06:00:00', '2024-12-04 08:30:00', 'CDG', 'LHR', 'Scheduled', 4, 4, 4),
  ('2024-12-05 15:00:00', '2024-12-05 23:00:00', 'HND', 'SYD', 'Scheduled', 5, 5, 5),
  ('2024-12-06 09:00:00', '2024-12-06 14:00:00', 'FRA', 'CDG', 'Scheduled', 6, 6, 6),
  ('2024-12-07 12:00:00', '2024-12-07 20:00:00', 'SYD', 'MEX', 'Scheduled', 7, 7, 7),
  ('2024-12-08 18:00:00', '2024-12-08 22:30:00', 'FRA', 'GRU', 'Scheduled', 8, 1, 8),
  ('2024-12-09 08:00:00', '2024-12-09 12:00:00', 'MEX', 'JFK', 'Scheduled', 9, 2, 9),
  ('2024-12-10 05:00:00', '2024-12-10 13:00:00', 'JFK', 'CDG', 'Scheduled', 10, 4, 10);

-- Inserir dados em reservas
INSERT INTO reservas (dataReserva, statusReserva, Voo_codVoo) VALUES 
  ('2024-11-01 10:00:00', 'Confirmed', 1),
  ('2024-11-01 12:00:00', 'Confirmed', 2),
  ('2024-11-02 15:00:00', 'Confirmed', 3),
  ('2024-11-03 16:00:00', 'Confirmed', 4),
  ('2024-11-04 10:00:00', 'Confirmed', 5),
  ('2024-11-05 08:00:00', 'Confirmed', 6),
  ('2024-11-06 12:00:00', 'Confirmed', 7),
  ('2024-11-07 09:30:00', 'Not Confirmed', 8),
  ('2024-11-08 11:00:00', 'Confirmed', 9),
  ('2024-11-09 14:00:00', 'Confirmed', 10);

-- Inserir dados em passageiros
INSERT INTO passageiros (cpfPassageiro, nomePassageiro, numTelPassageiro, emailPassageiro, birthDatePassageiro, cepPassageiro, idadePassageiro, reservas_codReserva) VALUES
  ('12345678901', 'João Silva', '11987654321', 'joao.silva@email.com', '1990-05-10', '12345678', 34, 1),
  ('98765432100', 'Maria Oliveira', '11911223344', 'maria.oliveira@email.com', '1985-07-22', '87654321', 39, 2),
  ('55544433322', 'Carlos Souza', '11922334455', 'carlos.souza@email.com', '1980-11-30', '34567890', 44, 3),
  ('44433322211', 'Fernanda Lima', '11987651234', 'fernanda.lima@email.com', '1992-03-14', '12345876', 32, 4),
  ('33322211100', 'Rodrigo Santos', '11922336789', 'rodrigo.santos@email.com', '1987-08-15', '87651234', 37, 5),
  ('77788899933', 'Aline Sousa', '11933334444', 'aline.sousa@email.com', '1995-12-01', '65432178', 28, 6),
  ('22233311109', 'Marcos Braga', '11955556677', 'marcos.braga@email.com', '1979-10-19', '98765432', 45, 7),
  ('99988877766', 'Paula Rocha', '11966557788', 'paula.rocha@email.com', '1983-11-20', '12346789', 40, 8),
  ('88877766655', 'Ricardo Farias', '11977443322', 'ricardo.farias@email.com', '1999-02-14', '23456789', 25, 9),
  ('11122233344', 'Camila Rezende', '11955668899', 'camila.rezende@email.com', '1994-04-23', '34567821', 30, 10);

-- Inserir dados em assentos
INSERT INTO assentos (Passageiro_codPassageiro, classeAssento, localizacaoAssento, Voo_codVoo) VALUES 
  (1, 'Economy', '12A', 1),
  (2, 'Business', '5B', 2),
  (3, 'First', '1C', 3),
  (4, 'Econômica', '13C', 4),
  (5, 'Executiva', '6D', 5),
  (6, 'Primeira Classe', '1B', 6),
  (7, 'Econômica', '15E', 7),
  (8, 'Executiva', '8A', 8),
  (9, 'Primeira Classe', '2C', 9),
  (10, 'Econômica', '22F', 10);
  

-- Inserir dados em bagagens
INSERT INTO bagagens (pesoBagagem, dimensoesBagagem, tipoBagagem, Passageiro_codPassageiro) VALUES 
  (20, 60, 'Despache', 1),
  (15, 45, 'De Mão', 2),
  (10, 40, 'De Mão', 3),
  (25, 70, 'Despachada', 4),
  (18, 55, 'De Mão', 5),
  (22, 65, 'Despachada', 6),
  (12, 50, 'De Mão', 7),
  (19, 60, 'Despachada', 8),
  (15, 45, 'De Mão', 9),
  (10, 40, 'De Mão', 10);

-- Inserir dados em pilotos
INSERT INTO pilotos (nomePiloto, licencaPiloto, cpfPiloto, emailPiloto, historicoPiloto, horasVooPiloto, Voo_codVoo) VALUES
  ('Carlos Souza', 'LicencaA', '12345678901', 'carlos.souza@email.com', 'Ex-Força Aérea, 10 anos de experiência comercial.', 2500, 1),
  ('Mariana Lima', 'LicencaB', '23456789012', 'mariana.lima@email.com', 'Experiência em rotas internacionais na Ásia e Europa.', 1800, 2),
  ('João Silva', 'LicencaC', '34567890123', 'joao.silva@email.com', 'Especialista em voos de longa distância.', 2200, 3),
  ('Ana Pereira', 'LicencaD', '45678901234', 'ana.pereira@email.com', 'Instrutora de novos pilotos.', 3000, 4),
  ('Bruno Oliveira', 'LicencaE', '56789012345', 'bruno.oliveira@email.com', 'Participou de operações de resgate aéreo.', 1700, 5),
  ('Camila Martins', 'LicencaF', '67890123456', 'camila.martins@email.com', 'Experiência com aeronaves de carga.', 1900, 6),
  ('Ricardo Santos', 'LicencaG', '78901234567', 'ricardo.santos@email.com', 'Experiência em voos executivos.', 2100, 7),
  ('Fernanda Costa', 'LicencaH', '89012345678', 'fernanda.costa@email.com', '10 anos em rotas nacionais.', 1600, 8),
  ('Lucas Almeida', 'LicencaI', '90123456789', 'lucas.almeida@email.com', 'Especialista em manobras de alta complexidade.', 2300, 9),
  ('Renata Ribeiro', 'LicencaJ', '01234567890', 'renata.ribeiro@email.com', 'Experiência em simulações e treinamentos.', 2600, 10);

-- Inserção de funcionários
INSERT INTO funcionarios (nomeFuncionario, cargoFuncionario, setorFuncionario, contatoFuncionario, Voo_codVoo) VALUES
  ('Alice Costa', 'Comissária de Bordo', 'Atendimento', '11912345678', 1),
  ('Pedro Ferreira', 'Comissário de Bordo', 'Atendimento', '11912345679', 2),
  ('Julia Almeida', 'Comissária de Bordo', 'Atendimento', '11912345680', 3),
  ('Felipe Souza', 'Equipe de Solo', 'Operações', '11912345681', 4),
  ('Patrícia Lima', 'Manutenção', 'Manutenção', '11912345682', 5),
  ('Gabriel Melo', 'Comissário de Bordo', 'Atendimento', '11912345683', 6),
  ('Sofia Rocha', 'Comissária de Bordo', 'Atendimento', '11912345684', 7),
  ('Marcelo Martins', 'Equipe de Solo', 'Operações', '11912345685', 8),
  ('Larissa Santos', 'Comissária de Bordo', 'Atendimento', '11912345686', 9),
  ('Tiago Teixeira', 'Manutenção', 'Manutenção', '11912345687', 10);
  
  -- 3- EXEMPLOS DE SCRIPTS
-- DROP DATABASE aeroporto

-- DROP TABLE funcionarios

-- ALTER TABLE funcionarios DROP COLUMN nomeFuncionario

-- ALTER TABLE funcionarios ADD COLUMN Genero CHAR(1)

-- UPDATE funcionarios SET cargoFuncionario = 'Técnico de computação' WHERE Voo_codVoo = 4

-- DELETE FROM pilotos WHERE horasVooPiloto < 1700

-- 4- CONSULTAS
-- Duas consultas utilizando apenas uma tabela.
SELECT * FROM aeronaves 
WHERE fabricanteAeronave LIKE 'B%';

SELECT nomeCompAerea AS nome FROM companhias_aereas 
WHERE paisDorigemCompAerea = 'Brasil'
ORDER BY nome ASC;

-- Três consultas com duas tabelas utilizando `INNER JOIN`.
SELECT nomePassageiro, classeAssento
FROM passageiros INNER JOIN assentos ON codPassageiro = Passageiro_codPassageiro;

SELECT COUNT(codPassageiro) AS Num_passageiros, tipoBagagem
FROM passageiros INNER JOIN bagagens ON codPassageiro = Passageiro_codPassageiro
GROUP BY tipoBagagem
ORDER BY Num_passageiros DESC;

SELECT nomeCompAerea, COUNT(codVoo) AS numeroDeVoos
FROM voos INNER JOIN companhias_aereas ON Companhia_Aerea_codCompAerea = codCompAerea
WHERE LOWER(nomeCompAerea) LIKE '%a%' 
GROUP BY nomeCompAerea
HAVING COUNT(codVoo) = 1 
ORDER BY nomeCompAerea ASC;


-- Uma consulta utilizando `LEFT JOIN`.
SELECT nomePiloto, horasVooPiloto AS hrs, aeroportoOrigemVoo 
FROM pilotos LEFT JOIN voos ON Voo_codVoo = codVoo
WHERE horasVooPiloto > 1500
ORDER BY hrs ASC;

-- Uma consulta utilizando `RIGHT JOIN`.
SELECT nomeFuncionario, cargoFuncionario, aeroportoOrigemVoo
FROM funcionarios
RIGHT JOIN voos ON funcionarios.Voo_codVoo = voos.codVoo
WHERE cargoFuncionario LIKE 'Comissário%'
GROUP BY cargoFuncionario, nomeFuncionario, aeroportoOrigemVoo 
HAVING COUNT(nomeFuncionario) = 1 
ORDER BY aeroportoOrigemVoo ASC;

--  Uma consulta utilizando `FULL JOIN`.
SELECT aeroportoOrigemVoo, aeroportoChegadaVoo, statusReserva
FROM voos
FULL JOIN reservas ON codVoo = Voo_codVoo
WHERE statusReserva = 'Confirmed';

-- Uma consulta com 3 tabelas
SELECT nomePassageiro, statusReserva, aeroportoChegadaVoo
FROM 
    passageiros
INNER JOIN reservas ON reservas_codReserva = codReserva
INNER JOIN voos ON Voo_codVoo = codVoo
WHERE statusVoo = 'Scheduled'
ORDER BY dataEhoraPartidaVoo DESC;

-- Uma consulta com quatro tabelas
SELECT nomeCompAerea, aeroportoChegadaVoo, COUNT(codReserva) AS totalReservas, COUNT(codPassageiro) AS totalPassageiros
FROM 
    companhias_aereas
INNER JOIN voos ON codCompAerea = Companhia_Aerea_codCompAerea
INNER JOIN reservas ON codVoo = Voo_codVoo
INNER JOIN passageiros ON codReserva = reservas_codReserva
GROUP BY nomeCompAerea, aeroportoChegadaVoo
HAVING totalReservas >= 1
ORDER BY totalReservas DESC;


-- 5. Recursos Adicionais
--    - Criação de três views.
-- View 1: Visualizar informações básicas dos passageiros e suas reservas
CREATE VIEW vw_passageiros_reservas AS
SELECT passageiros.nomePassageiro, reservas.dataReserva, reservas.statusReserva
FROM reservas
INNER JOIN passageiros ON reservas.codReserva = passageiros.reservas_codReserva;

-- visualizar
SELECT * FROM vw_passageiros_reservas;
SELECT * FROM vw_passageiros_reservas
WHERE statusReserva = 'Confirmed';


-- View 2: Visualizar voos com suas respectivas companhias aéreas (já estão criados).
CREATE VIEW vw_voos_companhias AS
SELECT voos.codVoo, companhias_aereas.nomeCompAerea, voos.aeroportoOrigemVoo, voos.aeroportoChegadaVoo
FROM voos
INNER JOIN companhias_aereas 
ON voos.Companhia_Aerea_codCompAerea = companhias_aereas.codCompAerea;

-- visualizar
SELECT * FROM vw_voos_companhias;
SELECT * FROM vw_voos_companhias
WHERE aeroportoOrigemVoo = 'GRU';

-- View 3: Informações de pilotos com número de horas de voo
CREATE VIEW vw_pilotos_horas AS
SELECT nomePiloto, horasVooPiloto
FROM pilotos
WHERE horasVooPiloto > 1000;

-- visualizar
SELECT * FROM vw_pilotos_horas;
SELECT * FROM vw_pilotos_horas
WHERE horasVooPiloto > 2000;

--  - Um trigger (gatilho) no banco de dados.
DELIMITER //

CREATE TRIGGER trg_update_assentos_disponiveis
AFTER INSERT ON reservas
FOR EACH ROW
BEGIN
    UPDATE aeronaves
    SET capacidadeAeronave = capacidadeAeronave - 1
    WHERE codAeronave = (SELECT codAeronave FROM voos WHERE codVoo = NEW.Voo_codVoo);
END //

DELIMITER ;

-- teste
SET SQL_SAFE_UPDATES = 0;-- Desativar o "safe update mode" temporariamente:
INSERT INTO reservas (dataReserva, statusReserva, Voo_codVoo) 
VALUES ('2024-12-15 08:00:00', 'Confirmed', 1);



--    - Três usuários com permissões diferentes. (Já estão criados).
-- Usuário 1: Apenas leitura
CREATE USER 'usuario_leitura'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT ON *.* TO 'usuario_leitura'@'localhost';
FLUSH PRIVILEGES;

-- Usuário 2: Leitura e inserção
CREATE USER 'usuario_insercao'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT, INSERT ON *.* TO 'usuario_insercao'@'localhost';
FLUSH PRIVILEGES;

-- Usuário 3: Acesso total
CREATE USER 'usuario_total'@'localhost' IDENTIFIED BY 'senha123';
GRANT ALL PRIVILEGES ON *.* TO 'usuario_total'@'localhost';
FLUSH PRIVILEGES;

--    - Exclusão de um dos usuários criados.
DROP USER 'usuario_leitura'@'localhost';

--    - Exemplo de `COMMIT`.
START TRANSACTION;
UPDATE reservas
SET statusReserva = 'Cancelled'
WHERE codReserva = 123;

COMMIT;

--    - Exemplo de `REVOKE`.
REVOKE SELECT ON *.* FROM 'usuario_leitura'@'localhost';





