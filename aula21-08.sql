
USE db_pet;
CREATE TABLE vets(
	id_vet INT NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    especializacao VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone INT(100) UNIQUE,
    data_de_nascimento DATE NOT NULL,
    PRIMARY KEY (id_vet)
    );

CREATE TABLE clientes(
	id_cliente INT NOT NULL UNIQUE,
    id_pet INT NOT NULL UNIQUE,
    telefone INT(11) UNIQUE,
    endereco VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    profissao VARCHAR(80),
    PRIMARY KEY (id_cliente)
    );
    
CREATE TABLE pets(
	id_pet INT NOT NULL UNIQUE,
    id_vet INT NOT NULL UNIQUE,
    id_cliente INT NOT NULL UNIQUE,
    raca CHAR(45),
    nome VARCHAR(50) NOT NULL,
    idade INTEGER,
    peso FLOAT(2),
    porte ENUM ("pequeno", "medio", "grande"),
    PRIMARY KEY (id_pet)
    ); 
CREATE TABLE atendimentos(
	id_atend INT NOT NULL UNIQUE,
    id_pet INT NOT NULL UNIQUE,
    id_vet INT NOT NULL UNIQUE,
    PRIMARY KEY (id_atend),
    FOREIGN KEY (id_pet) REFERENCES pets(id_pet),
    FOREIGN KEY (id_vet) REFERENCES vets(id_vet)
    );
    
CREATE TABLE microchips(
	id_microchip INT NOT NULL UNIQUE,
    id_pet INT NOT NULL UNIQUE,
    id_dono INT NOT NULL UNIQUE,
    nome_pet VARCHAR(50) NOT NULL UNIQUE,
    nome_dono VARCHAR(100) NOT NULL UNIQUE,
    localizacao VARCHAR(100) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_microchip),
    FOREIGN KEY (id_pet) REFERENCES pets(id_pet),
    FOREIGN KEY (id_dono) REFERENCES clientes(id_cliente)
    );
