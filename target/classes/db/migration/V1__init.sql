CREATE SCHEMA IF NOT EXISTS guia_iesb;

CREATE TABLE guia_iesb.CAMPUS (
  cep CHAR(8) PRIMARY KEY,
  nome VARCHAR(300) NOT NULL,
  endereco VARCHAR(300) NOT NULL,
  horario_secretaria INTERVAL,
  horario_biblioteca INTERVAL,
  horario_estacionamento INTERVAL
);

CREATE TABLE guia_iesb.EVENTOS(
  cod_evento SERIAL PRIMARY KEY,
  localizacao VARCHAR(300) NOT NULL,
  nome_evento VARCHAR(300) NOT NULL,
  horario INTERVAL NOT NULL,
  organizador VARCHAR(300) NOT NULL
);

CREATE TABLE guia_iesb.CURSOS(
  id_curso SERIAL PRIMARY KEY,
  nome_curso VARCHAR(300) NOT NULL,
  turno VARCHAR(300) NOT NULL,
  semestre SMALLINT NOT NULL,
  modalidade VARCHAR(300) NOT NULL
);

CREATE TABLE guia_iesb.DISCIPLINA(
  id_disciplina SERIAL PRIMARY KEY,
  nome_disciplina VARCHAR(300) NOT NULL,
  carga_horaria SMALLINT NOT NULL,
  horario INTERVAL NOT NULL,
  plano_ensino BYTEA NOT NULL,
  pre_requisitos VARCHAR(300)
);

CREATE TABLE guia_iesb.PROFESSOR(
  matricula_professor CHAR(10) PRIMARY KEY,
  nome_professor VARCHAR(300) NOT NULL,
  email VARCHAR(300) NOT NULL,
  horario INTERVAL
);

CREATE TABLE guia_iesb.SALA(
  cod_sala VARCHAR(6) PRIMARY KEY,
  andar CHAR(1) NOT NULL,
  bloco CHAR(1) NOT NULL,
  tipo_sala VARCHAR(300) NOT NULL
);

CREATE TABLE guia_iesb.cad_aluno(
  matricula CHAR(10) PRIMARY KEY,
  nome_aluno VARCHAR(300) NOT NULL,
  turno VARCHAR(300) NOT NULL,
  turma VARCHAR(300) NOT NULL
);

ALTER TABLE guia_iesb.DISCIPLINA 
  ADD COLUMN id_curso INT,
  ADD CONSTRAINT fk_disciplina_curso
    FOREIGN KEY (id_curso) REFERENCES guia_iesb.CURSOS(id_curso);

ALTER TABLE guia_iesb.DISCIPLINA 
  ADD COLUMN matricula_professor CHAR(10),
  ADD CONSTRAINT fk_disciplina_professor
    FOREIGN KEY (matricula_professor) REFERENCES guia_iesb.PROFESSOR(matricula_professor);

ALTER TABLE guia_iesb.DISCIPLINA 
  ADD COLUMN cod_sala VARCHAR(6),
  ADD CONSTRAINT fk_disciplina_sala
    FOREIGN KEY (cod_sala) REFERENCES guia_iesb.SALA(cod_sala);

ALTER TABLE guia_iesb.cad_aluno 
  ADD COLUMN id_curso INT,
  ADD CONSTRAINT fk_aluno_curso
    FOREIGN KEY (id_curso) REFERENCES guia_iesb.CURSOS(id_curso);

ALTER TABLE guia_iesb.SALA 
  ADD COLUMN cep CHAR(8),
  ADD CONSTRAINT fk_sala_campus
    FOREIGN KEY (cep) REFERENCES guia_iesb.CAMPUS(cep);

ALTER TABLE guia_iesb.EVENTOS 
  ADD COLUMN cep CHAR(8),
  ADD CONSTRAINT fk_evento_campus
    FOREIGN KEY (cep) REFERENCES guia_iesb.CAMPUS(cep);
