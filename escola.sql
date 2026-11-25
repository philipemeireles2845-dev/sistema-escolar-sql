CREATE DATABASE escola; 
USE escola;
CREATE TABLE professores (
    id_professor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    disciplina VARCHAR(50) NOT NULL,
    telefone VARCHAR(15)
);
DESCRIBE professores;
CREATE TABLE turmas (
    id_turma INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    serie VARCHAR(20) NOT NULL,
    turno VARCHAR(10) NOT NULL
);
DESCRIBE turmas;
CREATE TABLE alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    responsavel VARCHAR(100) NOT NULL,
    telefone_responsavel VARCHAR(15),
    id_turma INT NOT NULL,
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma)
);
DESCRIBE alunos;
CREATE TABLE professores_turmas (
    id_professor INT NOT NULL,
    id_turma INT NOT NULL,
    PRIMARY KEY (id_professor, id_turma),
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor),
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma)
);
SHOW TABLES;
INSERT INTO professores (nome, email, disciplina, telefone) VALUES
('Carlos Silva', 'carlos.silva@escola.com', 'Matemática', '11987654321'),
('Maria Santos', 'maria.santos@escola.com', 'Português', '11976543210'),
('João Oliveira', 'joao.oliveira@escola.com', 'História', '11965432109'),
('Ana Costa', 'ana.costa@escola.com', 'Ciências', '11954321098'),
('Paulo Lima', 'paulo.lima@escola.com', 'Educação Física', '11943210987');

SELECT * FROM professores;
INSERT INTO turmas (nome, serie, turno) VALUES
('6A', '6º ano', 'manhã'),
('7B', '7º ano', 'tarde'),
('8A', '8º ano', 'manhã'),
('9C', '9º ano', 'tarde');

SELECT * FROM turmas;

INSERT INTO alunos (nome, data_nascimento, responsavel, telefone_responsavel, id_turma) VALUES
('Pedro Alves', '2010-03-15', 'Roberto Alves', '11999887766', 1),
('Julia Mendes', '2010-05-20', 'Carla Mendes', '11988776655', 1),
('Lucas Rocha', '2010-08-10', 'Fernanda Rocha', '11977665544', 1),
('Beatriz Souza', '2009-02-28', 'Marcos Souza', '11966554433', 2),
('Gabriel Lima', '2009-07-12', 'Patricia Lima', '11955443322', 2),
('Mariana Costa', '2009-11-05', 'José Costa', '11944332211', 2),
('Rafael Santos', '2008-01-18', 'Ana Santos', '11933221100', 3),
('Larissa Oliveira', '2008-04-22', 'Paulo Oliveira', '11922110099', 3),
('Felipe Martins', '2008-09-30', 'Sandra Martins', '11911009988', 3),
('Camila Ferreira', '2008-12-15', 'Ricardo Ferreira', '11900998877', 3),
('Thiago Ribeiro', '2007-03-08', 'Juliana Ribeiro', '11899887766', 4),
('Amanda Silva', '2007-06-25', 'Carlos Silva', '11888776655', 4),
('Bruno Carvalho', '2007-10-14', 'Marcia Carvalho', '11877665544', 4),
('Isabela Gomes', '2007-12-20', 'Fernando Gomes', '11866554433', 4),
('Vitor Pereira', '2008-02-11', 'Lucia Pereira', '11855443322', 4);

SELECT COUNT(*) FROM alunos;

INSERT INTO professores_turmas (id_professor, id_turma) VALUES
(1, 1),
(2, 1),
(4, 1),
(1, 2),
(2, 2),
(3, 2),
(1, 3),
(3, 3),
(5, 3),
(2, 4),
(3, 4),
(4, 4);

SELECT * FROM professores_turmas;

UPDATE alunos 
SET id_turma = 2 
WHERE id_aluno = 1;

SELECT nome, id_turma FROM alunos WHERE id_aluno = 1;

UPDATE professores 

SET telefone = '11999999999' 
WHERE id_professor = 1;

SELECT nome, telefone FROM professores WHERE id_professor = 1;

UPDATE turmas 
SET turno = 'tarde' 
WHERE id_turma = 3;

SELECT * FROM turmas WHERE id_turma = 3;

DELETE FROM alunos 
WHERE id_aluno = 15;

SELECT COUNT(*) FROM alunos;

DELETE FROM professores_turmas 
WHERE id_professor = 5 AND id_turma = 3;

SELECT * FROM professores_turmas WHERE id_professor = 5;

DELETE FROM turmas 
WHERE id_turma = 1;

CREATE VIEW vw_lista_alunos AS
SELECT 
    t.nome AS turma,
    t.serie,
    a.nome AS aluno
FROM alunos a
INNER JOIN turmas t ON a.id_turma = t.id_turma
ORDER BY t.nome, a.nome;

SELECT * FROM vw_lista_alunos;

CREATE VIEW vw_professores_turmas AS
SELECT 
    t.nome AS turma,
    p.nome AS professor,
    p.disciplina
FROM professores_turmas pt
INNER JOIN professores p ON pt.id_professor = p.id_professor
INNER JOIN turmas t ON pt.id_turma = t.id_turma
ORDER BY t.nome, p.nome;

SELECT * FROM vw_professores_turmas;

CREATE VIEW vw_total_alunos_turma AS
SELECT 
    t.nome AS turma,
    t.serie,
    t.turno,
    COUNT(a.id_aluno) AS total_alunos
FROM turmas t
LEFT JOIN alunos a ON t.id_turma = a.id_turma
GROUP BY t.id_turma, t.nome, t.serie, t.turno
ORDER BY t.nome;

SELECT * FROM vw_total_alunos_turma;

CREATE VIEW vw_alunos_menores AS
SELECT 
    nome AS aluno,
    data_nascimento,
    TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade,
    responsavel,
    telefone_responsavel
FROM alunos
WHERE TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) < 18
ORDER BY nome;

SELECT * FROM vw_alunos_menores;