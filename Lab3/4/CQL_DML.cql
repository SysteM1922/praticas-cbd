DROP KEYSPACE torneio;

CREATE KEYSPACE torneio WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 3};

-- a) e c)

CREATE TABLE torneio.equipa(
	id int,
	jogadores set<int>,
	name text,
	localidade text,
	pontos int,
	grupo_id int,
	PRIMARY KEY (grupo_id, pontos, id),
	);

CREATE TABLE torneio.grupo(
	id int PRIMARY KEY,
	name text,
	pontos_equipa map<int, int>,
	);

CREATE TABLE torneio.jogador(
	id int PRIMARY KEY,
	name text,
	equipa_id int,
	);

CREATE TABLE torneio.jogo(
	id int PRIMARY KEY,
	equipas_golos map<int, int>,
	data timestamp,
	golos list<int>,
	);

CREATE TABLE torneio.golo(
	id int PRIMARY KEY,
	jogador_id int,
	minuto int,
	jogo_id int,
	);

-- b)

INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (1, 'Ronaldo', 1);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (2, 'Messi', 1);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (3, 'Neymar', 1);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (4, 'Cristiano', 2);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (5, 'Bale', 2);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (6, 'Modric', 2);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (7, 'Suarez', 3);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (8, 'Griezmann', 3);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (9, 'Neymar', 3);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (10, 'Mbappe', 4);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (11, 'Dembele', 4);
INSERT INTO torneio.jogador(id, name, equipa_id) VALUES (12, 'Pogba', 4);

INSERT INTO torneio.equipa(id, jogadores, name, localidade, pontos, grupo_id) VALUES (1, {1, 2, 3}, 'Borussia Doutro Mundo', 'Almada', 6, 1);
INSERT INTO torneio.equipa(id, jogadores, name, localidade, pontos, grupo_id) VALUES (2, {4, 5, 6}, 'Porco', 'Contumil', 4, 1);
INSERT INTO torneio.equipa(id, jogadores, name, localidade, pontos, grupo_id) VALUES (3, {7, 8, 9}, 'Bem Fica', 'Lesboa', 6, 1);
INSERT INTO torneio.equipa(id, jogadores, name, localidade, pontos, grupo_id) VALUES (4, {10, 11, 12}, 'Supporting', 'Lisboa', 1, 1);

INSERT INTO torneio.grupo(id, name, pontos_equipa) VALUES (1, 'A', {1: 0, 2: 0, 3: 0, 4: 0});

INSERT INTO torneio.jogo(id, equipas_golos, data, golos) VALUES (1, {1: 2, 2: 1}, '2018-06-14 20:00:00+0000', [1, 2, 3]);
INSERT INTO torneio.jogo(id, equipas_golos, data, golos) VALUES (2, {1: 0, 3: 2}, '2018-06-15 20:00:00+0000', [4, 5]);
INSERT INTO torneio.jogo(id, equipas_golos, data, golos) VALUES (3, {1: 3, 4: 2}, '2018-06-16 20:00:00+0000', [6,7,8,9,10]);
INSERT INTO torneio.jogo(id, equipas_golos, data, golos) VALUES (4, {2: 1, 3: 0}, '2018-06-17 20:00:00+0000', [11]);
INSERT INTO torneio.jogo(id, equipas_golos, data, golos) VALUES (5, {2: 1, 4: 1}, '2018-06-18 20:00:00+0000', [12,13]);
INSERT INTO torneio.jogo(id, equipas_golos, data, golos) VALUES (6, {3: 3, 4: 2}, '2018-06-19 20:00:00+0000', [14,15,16,17,18]);

INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (1, 1, 10, 1);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (2, 2, 20, 1);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (3, 4, 30, 1);

INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (4, 7, 10, 2);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (5, 8, 20, 2);

INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (6, 1, 10, 3);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (7, 10, 20, 3);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (8, 3, 30, 3);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (9, 3, 40, 3);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (10, 11, 50, 3);

INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (11, 4, 10, 4);

INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (12, 5, 10, 5);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (13, 12, 20, 5);

INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (14, 7, 10, 6);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (15, 7, 20, 6);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (16, 10, 30, 6);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (17, 11, 40, 6);
INSERT INTO torneio.golo(id, jogador_id, minuto, jogo_id) VALUES (18, 9, 50, 6);

-- d)

CREATE INDEX golo_jogador ON torneio.golo(jogador_id);
CREATE INDEX golo_jogo ON torneio.golo(jogo_id);
CREATE INDEX jogador_equipa ON torneio.jogador(equipa_id);
CREATE INDEX grupo_pontos_equipa_keys ON torneio.grupo (KEYS(pontos_equipa));

-- f)

SELECT * FROM torneio.equipa;

SELECT name, jogadores FROM torneio.equipa;

SELECT * FROM torneio.jogador WHERE equipa_id = 1;

SELECT * FROM torneio.golo WHERE jogador_id = 1;

SELECT * FROM torneio.equipa WHERE grupo_id = 1 ORDER BY pontos DESC;

SELECT * FROM torneio.jogo WHERE data >= '2018-06-17 20:00:00+0000' AND data <= '2018-06-18 20:00:00+0000' ALLOW FILTERING;

SELECT * FROM torneio.jogo WHERE equipas_golos[1] = 3 ALLOW FILTERING;

SELECT jogador_id FROM torneio.golo WHERE jogo_id = 1;

SELECT * FROM torneio.golo WHERE jogo_id = 3 AND minuto > 20 LIMIT 3 ALLOW FILTERING;

SELECT * FROM torneio.grupo WHERE pontos_equipa CONTAINS KEY 1;

-- e)

UPDATE torneio.grupo SET pontos_equipa = pontos_equipa + {1: 0} WHERE id = 1;
UPDATE torneio.golo SET minuto = 90 WHERE id = 1;
UPDATE torneio.jogo SET golos = golos + [19] WHERE id = 1;
UPDATE torneio.jogador SET name = 'JOAO' WHERE id = 1;
UPDATE torneio.jogador SET equipa_id = 2 WHERE id = 1;

DELETE FROM torneio.golo WHERE id = 1;
DELETE name FROM torneio.jogador WHERE id = 1;
DELETE FROM torneio.jogo WHERE id = 1;
DELETE golos FROM torneio.jogo WHERE id = 1;
DELETE FROM torneio.grupo WHERE id = 1;





