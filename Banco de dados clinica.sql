CREATE DATABASE Clinica;
USE Clinica;

CREATE TABLE Ambulatorios (
    nroa INT PRIMARY KEY,
    andar NUMERIC(3) NOT NULL,
    capacidade SMALLINT );
    
    CREATE TABLE Medicos (
    codm INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    especialidade CHAR(20),
    CPF NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    nroa INT,
    FOREIGN KEY (nroa) REFERENCES Ambulatorios(nroa)
);

CREATE TABLE Pacientes (
    codp INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    cidade CHAR(30),
    CPF NUMERIC(11) UNIQUE,
    doenca VARCHAR(40) NOT NULL
);

CREATE TABLE Funcionarios (
    codf INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT,
    CPF NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    salario NUMERIC(10),
    cargo VARCHAR(20)
);

CREATE TABLE Consultas (
    codm INT,
    codp INT,
    data DATE,
    hora TIME,
    PRIMARY KEY (codm, codp, data, hora),
    FOREIGN KEY (codm) REFERENCES Medicos(codm),
    FOREIGN KEY (codp) REFERENCES Pacientes(codp)
);

ALTER TABLE Funcionarios ADD nroa INT;
CREATE UNIQUE INDEX idx_medicos_cpf ON Medicos(CPF);
CREATE INDEX idx_pacientes_doenca ON Pacientes(doenca);
DROP INDEX idx_pacientes_doenca ON Pacientes;
ALTER TABLE Funcionarios DROP COLUMN cargo;
ALTER TABLE Funcionarios DROP COLUMN nroa;

INSERT INTO Ambulatorios VALUES (1, 1, 30), (2, 1, 50), (3, 2, 40), (4, 2, 25), (5, 2, 55);

INSERT INTO Pacientes VALUES
(1, 'Ana', 20, 'Florianopolis', 2000020000, 'gripe'),
(2, 'Paulo', 24, 'Palhoca', 2000022000, 'fratura'),
(3, 'Lucia', 30, 'Biguacu', 2200020000, 'tendinite'),
(4, 'Carlos', 28, 'Joinville', 1100011000, 'sarampo');

INSERT INTO Funcionarios VALUES
(1, 'Rita', 32, 2000010000, 'Sao Jose', 1200),
(2, 'Maria', 55, 3000011000, 'Palhoca', 1220),
(3, 'Caio', 45, 4100010000, 'Florianopolis', 1100),
(4, 'Carlos', 44, 5100011000, 'Florianopolis', 1200),
(5, 'Paula', 33, 6100011100, 'Florianopolis', 2500);

INSERT INTO Medicos VALUES
(1, 'Joao', 40, 'ortopedia', 1000010000, 'Florianopolis', 1),
(2, 'Maria', 42, 'traumatologia', 1000011000, 'Blumenau', 2),
(3, 'Pedro', 51, 'pediatria', 1100010000, 'São José', 2),
(4, 'Carlos', 28, 'ortopedia', 1100011000, 'Joinville', 3),
(5, 'Marcia', 33, 'neurologia', 1100011100, 'Biguacu', 3);

INSERT INTO Consultas VALUES
(1, 1, '2006-06-12', '14:00'),
(1, 4, '2006-06-13', '10:00'),
(2, 1, '2006-06-13', '09:00'),
(2, 2, '2006-06-13', '11:00'),
(2, 3, '2006-06-14', '14:00'),
(2, 4, '2006-06-14', '17:00'),
(3, 1, '2006-06-19', '18:00'),
(3, 3, '2006-06-12', '10:00'),
(3, 4, '2006-06-19', '13:00'),
(4, 4, '2006-06-20', '13:00'),
(4, 4, '2006-07-22', '19:30');

UPDATE Pacientes SET cidade = 'Ilhota' WHERE nome = 'Paulo';

UPDATE Consultas 
SET data = '2006-07-04', hora = '12:00' 
WHERE codm = 1 AND codp = 4;

UPDATE Pacientes 
SET idade = idade + 1, doenca = 'cancer' 
WHERE nome = 'Ana';

UPDATE Consultas 
SET hora = ADDTIME(hora, '01:30:00') 
WHERE codm = 3 AND codp = 4;

DELETE FROM Funcionarios WHERE codf = 4;

DELETE FROM Consultas WHERE hora > '19:00:00';

DELETE FROM Pacientes WHERE doenca = 'cancer' OR idade < 10;

DELETE FROM Medicos WHERE cidade IN ('Biguacu', 'Palhoca');
