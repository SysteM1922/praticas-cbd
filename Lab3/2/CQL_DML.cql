DROP KEYSPACE videos;

-- a)

CREATE KEYSPACE videos WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 3};

CREATE TABLE videos.users(
	id uuid PRIMARY KEY,
	username text,
	name text,
	email text,
	registered_date timestamp,
	);

CREATE TABLE videos.videos(
	id uuid,
	user_id uuid,
	title text,
	description text,
	tags set<text>,
	upload_date timestamp,
	PRIMARY KEY ((user_id, id), upload_date),
	) WITH CLUSTERING ORDER BY (upload_date DESC);

CREATE TABLE videos.comments(
	video_id uuid,
	user_id uuid,
	comment text,
	comment_date timestamp,
	PRIMARY KEY ((user_id, video_id), comment_date),
	) WITH CLUSTERING ORDER BY (comment_date DESC);

CREATE TABLE videos.followers(
	user_id uuid,
	video_id uuid,
	PRIMARY KEY (user_id, video_id),
	);

CREATE TABLE videos.events(
	user_id uuid,
	video_id uuid,
	event_type text,
	event_date timestamp,
	video_time int,
	PRIMARY KEY (user_id, video_id, event_type, event_date, video_time),
	);

CREATE TABLE videos.ratings(
	id uuid,
	video_id uuid,
	rating int,
	PRIMARY KEY (id, rating),
	) WITH CLUSTERING ORDER BY (rating DESC);

-- b)

BEGIN BATCH
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (a16c5dd1-4650-4879-ba44-830365ef7735, 'user1', 'Guilherme Antunes', 'guilhermeantunes@gmail.com', '2015-01-01 00:00:00')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (ef700fb5-0a7d-4517-8c37-c11176b93a1e, 'user2', 'Rita Silva', 'ritasilva@gmail.com', '2016-02-23 12:33:16')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (dc2d21ed-a835-4aa7-8003-fce63c104cc0, 'user3', 'João Santos', 'joaosantos@gmail.com', '2016-03-01 05:24:12')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (713bef7a-7c82-4fe7-9e35-96b251226950, 'user4', 'Maria Oliveira', 'mariaoliveira@gmail.com', '2019-05-12 09:54:29')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (2d8005e0-27c9-4bed-84c6-154746989505, 'user5', 'Pedro Almeida', 'pedroalmeida@gmail.com', '2020-01-30 10:04:47')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (944a0a54-0dc3-409f-b10a-f53ea68e62af, 'user6', 'Fernando Silva', 'fernandosilva@gmail.com', '2020-02-01 11:32:28')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, 'user7', 'Ana Almeida', 'anaalmeida@gmail.com', '2017-03-12 13:45:12')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, 'user8', 'Paulo Rebelo', 'paulorebelo@gmail.com', '2018-04-23 15:12:34')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, 'user9', 'Mariana Costa', 'marianacosta@gmail.com', '2019-05-01 17:23:45')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, 'user10', 'Ricardo Quaresma', 'ricardoquaresma@gmail.com', '2018-06-12 19:34:56')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, 'user11', 'David Jerumenha', 'davidjerumenha@gmail.com', '2019-07-23 21:45:12')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, 'user12', 'Rui Patrício', 'ruipatricio@gmail.com', '2019-08-01 23:56:23')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, 'user13', 'Bruno Fernandes', 'brunofernandes@gmail.com', '2019-09-12 01:07:34')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, 'user14', 'Cristiano Aveiro', 'cristianoaveiro@gmail.com', '2019-10-23 03:18:45')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (9fad9e15-7e9c-48f7-9fb2-d5c869cab383, 'user15', 'Renato Sanches', 'renatosanches@gmail.com', '2019-11-01 05:29:56')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (215ac6bb-4056-463a-be8f-7de28e7c623f, 'user16', 'João Félix', 'joaofelix@gmail.com', '2019-12-12 07:40:12')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (b8d6cb90-1302-45cb-86eb-fd4654d47c76, 'user17', 'Rúben Dias', 'rubendias@gmail.com', '2020-01-23 09:51:23')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (b0ca19f1-dee5-4778-95ed-52c265b299d0, 'user18', 'Bernardo Silva', 'bernardosilva@gmail.com', '2020-02-01 11:02:34')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (e5a7b077-e06a-4f90-85fd-4dbfc50d359d, 'user19', 'Diogo Jota', 'diogojota@gmail.com', '2020-03-12 13:13:45')
INSERT INTO videos.users(id, username, name, email, registered_date) VALUES (46901da4-4eed-4256-9f93-653a0892f069, 'user20', 'Rúben Neves', 'rubenneves@gmail.com', '2020-04-23 15:24:56')
APPLY BATCH;

BEGIN BATCH
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (567066fa-a4f5-45fa-a9d7-9b391b6be2a6, a16c5dd1-4650-4879-ba44-830365ef7735, 'Video 1', 'Description 1', {'Aveiro', 'Portugal', 'Europe'}, '2022-11-30 14:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (663e59ee-3fb2-4177-a2f3-a56485e08a4d, a16c5dd1-4650-4879-ba44-830365ef7735, 'Video 2', 'Description 2', {'Coimbra', 'Portugal', 'Europe'}, '2022-11-30 14:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (1d269a9e-01bf-4467-b77f-7bacfba2ad5b, a16c5dd1-4650-4879-ba44-830365ef7735, 'Video 3', 'Description 3', {'Lisboa', 'Portugal', 'Europe'}, '2022-11-30 14:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (4a02a0d6-d5ab-4922-a75b-645fd660dc70, ef700fb5-0a7d-4517-8c37-c11176b93a1e, 'Video 4', 'Description 4', {'Porto', 'Portugal', 'Europe'}, '2022-11-30 14:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, ef700fb5-0a7d-4517-8c37-c11176b93a1e, 'Video 5', 'Description 5', {'Porto', 'Portugal', 'Europe'}, '2022-07-23 14:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (172a2dae-3cce-4243-b7d2-f48dd117d14d, ef700fb5-0a7d-4517-8c37-c11176b93a1e, 'Video 6', 'Description 6', {'Porto', 'Portugal', 'Europe'}, '2022-07-30 14:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (db5867ef-e11b-4c5e-86e8-ed218e253cc9, dc2d21ed-a835-4aa7-8003-fce63c104cc0, 'Video 7', 'Description 7', {'Cairo', 'Egypt', 'Africa'}, '2022-07-30 14:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (4614e178-f4b7-4cbb-8ee5-75795a9f41c9, dc2d21ed-a835-4aa7-8003-fce63c104cc0, 'Video 8', 'Description 8', {'Alexandria', 'Egypt', 'Africa'}, '2022-07-10 15:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (d969fdeb-b126-401b-8bbb-c37626cc9b12, 713bef7a-7c82-4fe7-9e35-96b251226950, 'Video 9', 'Description 9', {'Minecraft', 'Game', 'PC'}, '2022-02-11 10:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (eb4a8ca1-0280-4562-86f1-9b8a285bac30, 713bef7a-7c82-4fe7-9e35-96b251226950, 'Video 10', 'Description 10', {'Minecraft', 'Game', 'PC'}, '2022-02-12 10:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (61d218d0-516f-4855-89dc-6c75247d3f39, 713bef7a-7c82-4fe7-9e35-96b251226950, 'Video 11', 'Description 11', {'Minecraft', 'Game', 'PC'}, '2022-02-13 10:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (a437ecff-0ac8-4e25-a426-059ea7e02296, 713bef7a-7c82-4fe7-9e35-96b251226950, 'Video 12', 'Description 12', {'Minecraft', 'Game', 'PC'}, '2022-02-14 10:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc, 2d8005e0-27c9-4bed-84c6-154746989505, 'Video 13', 'Description 13', {'Vlog', 'UK', 'Trip'}, '2022-05-10 10:00:00')
INSERT INTO videos.videos(id, user_id, title, description, tags, upload_date) VALUES (6be75f07-b1ee-4183-a567-dc30fef5e9bf, 944a0a54-0dc3-409f-b10a-f53ea68e62af, 'Video 14', 'Description 14', {'Tutorial', 'Beber Água', 'Saúde'}, '2021-12-24 23:59:59')
APPLY BATCH;

BEGIN BATCH
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'Comment 1', '2022-11-30 14:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'Comment 2', '2022-11-30 14:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'Comment 3', '2022-11-30 14:30:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'Comment 4', '2022-11-30 14:40:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'Comment 5', '2022-11-30 14:50:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc, 'Comment 1', '2022-05-10 10:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc, 'Comment 2', '2022-05-10 10:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc, 'Comment 3', '2022-05-10 10:30:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc, 'Comment 4', '2022-05-10 10:40:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (46901da4-4eed-4256-9f93-653a0892f069, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 'Comment 1', '2022-11-30 14:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 'Comment 2', '2022-11-30 14:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 'Comment 3', '2022-11-30 14:30:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, 663e59ee-3fb2-4177-a2f3-a56485e08a4d, 'Comment 1', '2022-11-30 14:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, 663e59ee-3fb2-4177-a2f3-a56485e08a4d, 'Comment 2', '2022-11-30 14:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, 663e59ee-3fb2-4177-a2f3-a56485e08a4d, 'Comment 3', '2022-11-30 14:30:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, 4a02a0d6-d5ab-4922-a75b-645fd660dc70, 'Comment 1', '2022-11-30 14:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, 4a02a0d6-d5ab-4922-a75b-645fd660dc70, 'Comment 2', '2022-11-30 14:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, 4a02a0d6-d5ab-4922-a75b-645fd660dc70, 'Comment 3', '2022-11-30 14:30:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (46901da4-4eed-4256-9f93-653a0892f069, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 'Comment 1', '2022-07-23 14:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 'Comment 2', '2022-07-23 14:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 'Comment 3', '2022-07-23 14:30:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 'Comment 4', '2022-07-23 14:40:00')	
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, 172a2dae-3cce-4243-b7d2-f48dd117d14d, 'Comment 1', '2022-07-30 14:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, 172a2dae-3cce-4243-b7d2-f48dd117d14d, 'Comment 2', '2022-07-30 14:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, 172a2dae-3cce-4243-b7d2-f48dd117d14d, 'Comment 3', '2022-07-30 14:30:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, db5867ef-e11b-4c5e-86e8-ed218e253cc9, 'Comment 1', '2022-07-30 14:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, db5867ef-e11b-4c5e-86e8-ed218e253cc9, 'Comment 2', '2022-07-30 14:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (46901da4-4eed-4256-9f93-653a0892f069, db5867ef-e11b-4c5e-86e8-ed218e253cc9, 'Comment 3', '2022-07-30 14:30:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9, 'Comment 1', '2022-07-10 15:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9, 'Comment 2', '2022-07-10 15:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9, 'Comment 3', '2022-07-10 15:30:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, d969fdeb-b126-401b-8bbb-c37626cc9b12, 'Comment 1', '2022-02-11 10:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, eb4a8ca1-0280-4562-86f1-9b8a285bac30, 'Comment 1', '2022-02-12 10:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, 61d218d0-516f-4855-89dc-6c75247d3f39, 'Comment 1', '2022-02-13 10:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, 61d218d0-516f-4855-89dc-6c75247d3f39, 'Comment 2', '2022-02-13 10:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, a437ecff-0ac8-4e25-a426-059ea7e02296, 'Comment 1', '2022-02-14 10:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (46901da4-4eed-4256-9f93-653a0892f069, a437ecff-0ac8-4e25-a426-059ea7e02296, 'Comment 2', '2022-02-14 10:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, 6be75f07-b1ee-4183-a567-dc30fef5e9bf, 'Comment 1', '2021-12-25 00:10:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, 6be75f07-b1ee-4183-a567-dc30fef5e9bf, 'Comment 2', '2021-12-25 00:20:00')
INSERT INTO videos.comments(user_id, video_id, comment, comment_date) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, 6be75f07-b1ee-4183-a567-dc30fef5e9bf, 'Comment 3', '2021-12-25 00:30:00')
APPLY BATCH;

BEGIN BATCH
INSERT INTO videos.followers(user_id, video_id) VALUES (a16c5dd1-4650-4879-ba44-830365ef7735, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6)
INSERT INTO videos.followers(user_id, video_id) VALUES (a16c5dd1-4650-4879-ba44-830365ef7735, 663e59ee-3fb2-4177-a2f3-a56485e08a4d)
INSERT INTO videos.followers(user_id, video_id) VALUES (a16c5dd1-4650-4879-ba44-830365ef7735, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b)
INSERT INTO videos.followers(user_id, video_id) VALUES (ef700fb5-0a7d-4517-8c37-c11176b93a1e, 663e59ee-3fb2-4177-a2f3-a56485e08a4d)
INSERT INTO videos.followers(user_id, video_id) VALUES (ef700fb5-0a7d-4517-8c37-c11176b93a1e, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b)
INSERT INTO videos.followers(user_id, video_id) VALUES (ef700fb5-0a7d-4517-8c37-c11176b93a1e, 4a02a0d6-d5ab-4922-a75b-645fd660dc70)
INSERT INTO videos.followers(user_id, video_id) VALUES (dc2d21ed-a835-4aa7-8003-fce63c104cc0, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b)
INSERT INTO videos.followers(user_id, video_id) VALUES (dc2d21ed-a835-4aa7-8003-fce63c104cc0, 4a02a0d6-d5ab-4922-a75b-645fd660dc70)
INSERT INTO videos.followers(user_id, video_id) VALUES (dc2d21ed-a835-4aa7-8003-fce63c104cc0, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58)
INSERT INTO videos.followers(user_id, video_id) VALUES (713bef7a-7c82-4fe7-9e35-96b251226950, 4a02a0d6-d5ab-4922-a75b-645fd660dc70)
INSERT INTO videos.followers(user_id, video_id) VALUES (713bef7a-7c82-4fe7-9e35-96b251226950, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58)
INSERT INTO videos.followers(user_id, video_id) VALUES (713bef7a-7c82-4fe7-9e35-96b251226950, 172a2dae-3cce-4243-b7d2-f48dd117d14d)
INSERT INTO videos.followers(user_id, video_id) VALUES (2d8005e0-27c9-4bed-84c6-154746989505, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58)
INSERT INTO videos.followers(user_id, video_id) VALUES (2d8005e0-27c9-4bed-84c6-154746989505, 172a2dae-3cce-4243-b7d2-f48dd117d14d)
INSERT INTO videos.followers(user_id, video_id) VALUES (2d8005e0-27c9-4bed-84c6-154746989505, db5867ef-e11b-4c5e-86e8-ed218e253cc9)
INSERT INTO videos.followers(user_id, video_id) VALUES (944a0a54-0dc3-409f-b10a-f53ea68e62af, 172a2dae-3cce-4243-b7d2-f48dd117d14d)
INSERT INTO videos.followers(user_id, video_id) VALUES (944a0a54-0dc3-409f-b10a-f53ea68e62af, db5867ef-e11b-4c5e-86e8-ed218e253cc9)
INSERT INTO videos.followers(user_id, video_id) VALUES (944a0a54-0dc3-409f-b10a-f53ea68e62af, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9)
INSERT INTO videos.followers(user_id, video_id) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, db5867ef-e11b-4c5e-86e8-ed218e253cc9)
INSERT INTO videos.followers(user_id, video_id) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9)
INSERT INTO videos.followers(user_id, video_id) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, d969fdeb-b126-401b-8bbb-c37626cc9b12)
INSERT INTO videos.followers(user_id, video_id) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9)
INSERT INTO videos.followers(user_id, video_id) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, d969fdeb-b126-401b-8bbb-c37626cc9b12)
INSERT INTO videos.followers(user_id, video_id) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, eb4a8ca1-0280-4562-86f1-9b8a285bac30)
INSERT INTO videos.followers(user_id, video_id) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, d969fdeb-b126-401b-8bbb-c37626cc9b12)
INSERT INTO videos.followers(user_id, video_id) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, eb4a8ca1-0280-4562-86f1-9b8a285bac30)
INSERT INTO videos.followers(user_id, video_id) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, 61d218d0-516f-4855-89dc-6c75247d3f39)
INSERT INTO videos.followers(user_id, video_id) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, eb4a8ca1-0280-4562-86f1-9b8a285bac30)
INSERT INTO videos.followers(user_id, video_id) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, 61d218d0-516f-4855-89dc-6c75247d3f39)
INSERT INTO videos.followers(user_id, video_id) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, a437ecff-0ac8-4e25-a426-059ea7e02296)
INSERT INTO videos.followers(user_id, video_id) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, 61d218d0-516f-4855-89dc-6c75247d3f39)
INSERT INTO videos.followers(user_id, video_id) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, a437ecff-0ac8-4e25-a426-059ea7e02296)
INSERT INTO videos.followers(user_id, video_id) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc)
INSERT INTO videos.followers(user_id, video_id) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, a437ecff-0ac8-4e25-a426-059ea7e02296)
INSERT INTO videos.followers(user_id, video_id) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc)
INSERT INTO videos.followers(user_id, video_id) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, 6be75f07-b1ee-4183-a567-dc30fef5e9bf)
INSERT INTO videos.followers(user_id, video_id) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc)
INSERT INTO videos.followers(user_id, video_id) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, 6be75f07-b1ee-4183-a567-dc30fef5e9bf)
INSERT INTO videos.followers(user_id, video_id) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6)
INSERT INTO videos.followers(user_id, video_id) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, 6be75f07-b1ee-4183-a567-dc30fef5e9bf)
INSERT INTO videos.followers(user_id, video_id) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6)
INSERT INTO videos.followers(user_id, video_id) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, 663e59ee-3fb2-4177-a2f3-a56485e08a4d)
INSERT INTO videos.followers(user_id, video_id) VALUES (9fad9e15-7e9c-48f7-9fb2-d5c869cab383, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6)
INSERT INTO videos.followers(user_id, video_id) VALUES (9fad9e15-7e9c-48f7-9fb2-d5c869cab383, 663e59ee-3fb2-4177-a2f3-a56485e08a4d)
INSERT INTO videos.followers(user_id, video_id) VALUES (9fad9e15-7e9c-48f7-9fb2-d5c869cab383, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b)
INSERT INTO videos.followers(user_id, video_id) VALUES (215ac6bb-4056-463a-be8f-7de28e7c623f, 663e59ee-3fb2-4177-a2f3-a56485e08a4d)
INSERT INTO videos.followers(user_id, video_id) VALUES (215ac6bb-4056-463a-be8f-7de28e7c623f, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b)
INSERT INTO videos.followers(user_id, video_id) VALUES (215ac6bb-4056-463a-be8f-7de28e7c623f, 4a02a0d6-d5ab-4922-a75b-645fd660dc70)
INSERT INTO videos.followers(user_id, video_id) VALUES (b8d6cb90-1302-45cb-86eb-fd4654d47c76, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b)
INSERT INTO videos.followers(user_id, video_id) VALUES (b8d6cb90-1302-45cb-86eb-fd4654d47c76, 4a02a0d6-d5ab-4922-a75b-645fd660dc70)
INSERT INTO videos.followers(user_id, video_id) VALUES (b8d6cb90-1302-45cb-86eb-fd4654d47c76, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58)
INSERT INTO videos.followers(user_id, video_id) VALUES (b0ca19f1-dee5-4778-95ed-52c265b299d0, 4a02a0d6-d5ab-4922-a75b-645fd660dc70)
INSERT INTO videos.followers(user_id, video_id) VALUES (b0ca19f1-dee5-4778-95ed-52c265b299d0, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58)
INSERT INTO videos.followers(user_id, video_id) VALUES (b0ca19f1-dee5-4778-95ed-52c265b299d0, 172a2dae-3cce-4243-b7d2-f48dd117d14d)
INSERT INTO videos.followers(user_id, video_id) VALUES (e5a7b077-e06a-4f90-85fd-4dbfc50d359d, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58)
INSERT INTO videos.followers(user_id, video_id) VALUES (e5a7b077-e06a-4f90-85fd-4dbfc50d359d, 172a2dae-3cce-4243-b7d2-f48dd117d14d)
INSERT INTO videos.followers(user_id, video_id) VALUES (e5a7b077-e06a-4f90-85fd-4dbfc50d359d, db5867ef-e11b-4c5e-86e8-ed218e253cc9)
INSERT INTO videos.followers(user_id, video_id) VALUES (46901da4-4eed-4256-9f93-653a0892f069, 172a2dae-3cce-4243-b7d2-f48dd117d14d)
INSERT INTO videos.followers(user_id, video_id) VALUES (46901da4-4eed-4256-9f93-653a0892f069, db5867ef-e11b-4c5e-86e8-ed218e253cc9)
INSERT INTO videos.followers(user_id, video_id) VALUES (46901da4-4eed-4256-9f93-653a0892f069, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9)
APPLY BATCH;

BEGIN BATCH
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (a16c5dd1-4650-4879-ba44-830365ef7735, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 'play', '2022-11-30 14:20:00', 600)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (a16c5dd1-4650-4879-ba44-830365ef7735, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 'pause', '2022-11-30 14:20:00', 720)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (a16c5dd1-4650-4879-ba44-830365ef7735, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 'stop', '2022-11-30 14:20:00', 1200)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (ef700fb5-0a7d-4517-8c37-c11176b93a1e, 663e59ee-3fb2-4177-a2f3-a56485e08a4d, 'play', '2022-11-30 14:20:00', 601)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (ef700fb5-0a7d-4517-8c37-c11176b93a1e, 663e59ee-3fb2-4177-a2f3-a56485e08a4d, 'pause', '2022-11-30 14:20:00', 721)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (ef700fb5-0a7d-4517-8c37-c11176b93a1e, 663e59ee-3fb2-4177-a2f3-a56485e08a4d, 'stop', '2022-11-30 14:20:00', 1201)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (dc2d21ed-a835-4aa7-8003-fce63c104cc0, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'play', '2022-11-30 14:20:00', 602)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (dc2d21ed-a835-4aa7-8003-fce63c104cc0, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'pause', '2022-11-30 14:20:00', 722)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (dc2d21ed-a835-4aa7-8003-fce63c104cc0, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'stop', '2022-11-30 14:20:00', 1202)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (713bef7a-7c82-4fe7-9e35-96b251226950, 4a02a0d6-d5ab-4922-a75b-645fd660dc70, 'play', '2022-11-30 14:20:00', 603)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (713bef7a-7c82-4fe7-9e35-96b251226950, 4a02a0d6-d5ab-4922-a75b-645fd660dc70, 'pause', '2022-11-30 14:20:00', 723)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (713bef7a-7c82-4fe7-9e35-96b251226950, 4a02a0d6-d5ab-4922-a75b-645fd660dc70, 'stop', '2022-11-30 14:20:00', 1203)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (2d8005e0-27c9-4bed-84c6-154746989505, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 'play', '2022-07-23 14:20:00', 604)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (2d8005e0-27c9-4bed-84c6-154746989505, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 'pause', '2022-07-23 14:20:00', 724)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (2d8005e0-27c9-4bed-84c6-154746989505, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 'stop', '2022-07-23 14:20:00', 1204)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (944a0a54-0dc3-409f-b10a-f53ea68e62af, 172a2dae-3cce-4243-b7d2-f48dd117d14d, 'play', '2022-07-30 14:20:00', 605)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (944a0a54-0dc3-409f-b10a-f53ea68e62af, 172a2dae-3cce-4243-b7d2-f48dd117d14d, 'pause', '2022-07-30 14:20:00', 725)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (944a0a54-0dc3-409f-b10a-f53ea68e62af, 172a2dae-3cce-4243-b7d2-f48dd117d14d, 'stop', '2022-07-30 14:20:00', 1205)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, db5867ef-e11b-4c5e-86e8-ed218e253cc9, 'play', '2022-07-30 14:20:00', 606)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, db5867ef-e11b-4c5e-86e8-ed218e253cc9, 'pause', '2022-07-30 14:20:00', 726)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (7526751f-5926-4bdf-8d9f-8ace1e230645, db5867ef-e11b-4c5e-86e8-ed218e253cc9, 'stop', '2022-07-30 14:20:00', 1206)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9, 'play', '2022-07-10 15:20:00', 607)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9, 'pause', '2022-07-10 15:20:00', 727)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (875a8b52-5f6c-4594-aebe-49814493985f, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9, 'stop', '2022-07-10 15:20:00', 1207)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, d969fdeb-b126-401b-8bbb-c37626cc9b12, 'play', '2022-02-11 10:20:00', 608)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, d969fdeb-b126-401b-8bbb-c37626cc9b12, 'pause', '2022-02-11 10:20:00', 728)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (904b67c3-d751-4487-9aa5-666acef1c434, d969fdeb-b126-401b-8bbb-c37626cc9b12, 'stop', '2022-02-11 10:20:00', 1208)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, eb4a8ca1-0280-4562-86f1-9b8a285bac30, 'play', '2022-02-12 10:20:00', 609)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, eb4a8ca1-0280-4562-86f1-9b8a285bac30, 'pause', '2022-02-12 10:20:00', 729)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (14b93520-fec1-49c1-b4ea-6e5c97cfaef4, eb4a8ca1-0280-4562-86f1-9b8a285bac30, 'stop', '2022-02-12 10:20:00', 1209)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, 61d218d0-516f-4855-89dc-6c75247d3f39, 'play', '2022-02-13 10:20:00', 610)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, 61d218d0-516f-4855-89dc-6c75247d3f39, 'pause', '2022-02-13 10:20:00', 730)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (f12db148-fbac-4202-bcfa-962c684a58f2, 61d218d0-516f-4855-89dc-6c75247d3f39, 'stop', '2022-02-13 10:20:00', 1210)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, a437ecff-0ac8-4e25-a426-059ea7e02296, 'play', '2022-02-14 10:20:00', 611)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, a437ecff-0ac8-4e25-a426-059ea7e02296, 'pause', '2022-02-14 10:20:00', 731)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (1e898e29-7c27-491f-84f3-191f140f4d0a, a437ecff-0ac8-4e25-a426-059ea7e02296, 'stop', '2022-02-14 10:20:00', 1211)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc, 'play', '2022-05-10 10:20:00', 612)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc, 'pause', '2022-05-10 10:20:00', 732)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (3f6ebd5c-b428-453c-ab4b-d97df148c65c, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc, 'stop', '2022-05-10 10:20:00', 1212)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, 6be75f07-b1ee-4183-a567-dc30fef5e9bf, 'play', '2022-12-25 00:20:00', 613)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, 6be75f07-b1ee-4183-a567-dc30fef5e9bf, 'pause', '2022-12-25 00:20:00', 733)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (e480519d-b1e5-4e4d-8180-fd5097e9bbac, 6be75f07-b1ee-4183-a567-dc30fef5e9bf, 'stop', '2022-12-25 00:20:00', 1213)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (9fad9e15-7e9c-48f7-9fb2-d5c869cab383, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 'play', '2022-11-30 14:20:00', 614)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (9fad9e15-7e9c-48f7-9fb2-d5c869cab383, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 'pause', '2022-11-30 14:20:00', 734)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (9fad9e15-7e9c-48f7-9fb2-d5c869cab383, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 'stop', '2022-11-30 14:20:00', 1214)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (215ac6bb-4056-463a-be8f-7de28e7c623f, 663e59ee-3fb2-4177-a2f3-a56485e08a4d, 'play', '2022-11-30 14:20:00', 615)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (215ac6bb-4056-463a-be8f-7de28e7c623f, 663e59ee-3fb2-4177-a2f3-a56485e08a4d, 'pause', '2022-11-30 14:20:00', 735)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (215ac6bb-4056-463a-be8f-7de28e7c623f, 663e59ee-3fb2-4177-a2f3-a56485e08a4d, 'stop', '2022-11-30 14:20:00', 1215)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (b8d6cb90-1302-45cb-86eb-fd4654d47c76, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'play', '2022-11-30 14:20:00', 616)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (b8d6cb90-1302-45cb-86eb-fd4654d47c76, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'pause', '2022-11-30 14:20:00', 736)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (b8d6cb90-1302-45cb-86eb-fd4654d47c76, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 'stop', '2022-11-30 14:20:00', 1216)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (b0ca19f1-dee5-4778-95ed-52c265b299d0, 4a02a0d6-d5ab-4922-a75b-645fd660dc70, 'play', '2022-11-30 14:20:00', 617)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (b0ca19f1-dee5-4778-95ed-52c265b299d0, 4a02a0d6-d5ab-4922-a75b-645fd660dc70, 'pause', '2022-11-30 14:20:00', 737)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (b0ca19f1-dee5-4778-95ed-52c265b299d0, 4a02a0d6-d5ab-4922-a75b-645fd660dc70, 'stop', '2022-11-30 14:20:00', 1217)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (e5a7b077-e06a-4f90-85fd-4dbfc50d359d, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 'play', '2022-07-23 14:20:00', 618)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (e5a7b077-e06a-4f90-85fd-4dbfc50d359d, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 'pause', '2022-07-23 14:20:00', 738)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (e5a7b077-e06a-4f90-85fd-4dbfc50d359d, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 'stop', '2022-07-23 14:20:00', 1218)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (46901da4-4eed-4256-9f93-653a0892f069, 172a2dae-3cce-4243-b7d2-f48dd117d14d, 'play', '2022-07-30 14:20:00', 619)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (46901da4-4eed-4256-9f93-653a0892f069, 172a2dae-3cce-4243-b7d2-f48dd117d14d, 'pause', '2022-07-30 14:20:00', 739)
INSERT INTO videos.events(user_id, video_id, event_type, event_date, video_time) VALUES (46901da4-4eed-4256-9f93-653a0892f069, 172a2dae-3cce-4243-b7d2-f48dd117d14d, 'stop', '2022-07-30 14:20:00', 1219)
APPLY BATCH;

BEGIN BATCH
INSERT INTO videos.ratings(id, video_id, rating) VALUES (85f10a30-b5af-4765-b35b-88706ae4c40b, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 3)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (0d91184a-8aa7-472c-86ed-501ee7d1f22f, 567066fa-a4f5-45fa-a9d7-9b391b6be2a6, 2)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (fd8c01c8-d0f2-4966-8261-0eb28c4f0ab8, 663e59ee-3fb2-4177-a2f3-a56485e08a4d, 2)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (3f15c5a0-df37-4b6e-a258-861f08aaf098, 1d269a9e-01bf-4467-b77f-7bacfba2ad5b, 5)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (66fc7111-7c62-49c7-98f9-2681fba16824, 4a02a0d6-d5ab-4922-a75b-645fd660dc70, 2)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (87025752-6d69-456c-b615-b5d0f3e52fff, 63a96cc6-f59f-490a-8caf-1d1dd1d1ac58, 1)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (79012aa6-ef3e-4d09-aa1a-1979fd067ce7, 172a2dae-3cce-4243-b7d2-f48dd117d14d, 3)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (85472d52-cc14-41ae-863f-d5ca41c5c5bc, db5867ef-e11b-4c5e-86e8-ed218e253cc9, 2)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (b9e0f944-d8fb-4df6-9d61-ddea340939d4, 4614e178-f4b7-4cbb-8ee5-75795a9f41c9, 4)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (5c04c860-080e-4e18-b19c-84b6c8a99ab2, d969fdeb-b126-401b-8bbb-c37626cc9b12, 1)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (4cc3a5ff-4333-41b3-ac96-d73af296aa9c, eb4a8ca1-0280-4562-86f1-9b8a285bac30, 3)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (aebc3957-e713-4332-a5ab-b9a3364c6e80, 61d218d0-516f-4855-89dc-6c75247d3f39, 5)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (8b3c9a9d-8616-4a75-a1d0-94581e83285c, a437ecff-0ac8-4e25-a426-059ea7e02296, 2)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (fba6fa5e-afb1-428e-bef1-d6d8ea829485, a150189a-6aa5-4ee6-aee9-b1f5f2bd7ebc, 3)
INSERT INTO videos.ratings(id, video_id, rating) VALUES (7094bfaf-a26f-47e8-9c9e-692304f45df9, 6be75f07-b1ee-4183-a567-dc30fef5e9bf, 4)
APPLY BATCH;

-- c)

CREATE INDEX videos_per_user ON videos.videos (user_id);
SELECT * FROM videos.videos WHERE user_id = a16c5dd1-4650-4879-ba44-830365ef7735;

CREATE INDEX comments_per_user ON videos.comments (user_id);
SELECT * FROM videos.comments WHERE user_id = 7526751f-5926-4bdf-8d9f-8ace1e230645;

CREATE INDEX comments_per_video ON videos.comments (video_id);
SELECT * FROM videos.comments WHERE video_id = 1d269a9e-01bf-4467-b77f-7bacfba2ad5b;

CREATE INDEX ratings_per_video ON videos.ratings (video_id);
SELECT video_id, AVG(rating) FROM videos.ratings WHERE video_id = 567066fa-a4f5-45fa-a9d7-9b391b6be2a6;

-- d)

-- 1. Os últimos 3 comentários introduzidos para um vídeo;
SELECT * FROM videos.comments WHERE video_id = 1d269a9e-01bf-4467-b77f-7bacfba2ad5b LIMIT 3;

-- 2. Lista das tags de determinado vídeo;
SELECT tags FROM videos.videos WHERE id = 567066fa-a4f5-45fa-a9d7-9b391b6be2a6;

-- 3. Todos os vídeos com a tag Aveiro;
SELECT * FROM videos.videos WHERE tags CONTAINS 'Aveiro' ALLOW FILTERING;

-- 4. Os últimos 5 eventos de determinado vídeo realizados por um utilizador;
SELECT * FROM videos.events WHERE user_id = 46901da4-4eed-4256-9f93-653a0892f069 AND video_id = 172a2dae-3cce-4243-b7d2-f48dd117d14d LIMIT 5;

-- 5. Vídeos partilhados por determinado utilizador (maria1987, por exemplo) num determinado período de tempo (Agosto de 2017, por exemplo);
SELECT * FROM videos.videos WHERE user_id = dc2d21ed-a835-4aa7-8003-fce63c104cc0 AND upload_date > '2022-07-01' AND upload_date < '2022-08-01' ALLOW FILTERING;

-- 6. Os últimos 10 vídeos, ordenado inversamente pela data da partilhada;
SELECT * FROM videos.videos LIMIT 10;
-- Resultado não é igual ao esperado, logo o enunciado desta query não é realisável

-- 7. Todos os seguidores (followers) de determinado vídeo;
SELECT * FROM videos.followers WHERE video_id = 4614e178-f4b7-4cbb-8ee5-75795a9f41c9 ALLOW FILTERING;

-- 8. Todos os comentários (dos vídeos) que determinado utilizador está a seguir (following);
-- O resultado não é possível de ser obtido, pois Cassandra não suporta a operação de Join

-- 9. Os 5 vídeos com maior rating;
SELECT video_id, rating FROM videos.ratings LIMIT 5;

-- 10. Uma query que retorne todos os vídeos e que mostre claramente a forma pela qual estão ordenados;
SELECT * FROM videos.videos;

-- 11. Lista com as Tags existentes e o número de vídeos catalogados com cada uma delas;
-- Não é possível obter o resultado pretendido, pois Cassandra não suporta a operação de Join

-- 12. Listar os utilizadores que partilharam vídeos com a tag “Europe”;
SELECT user_id FROM videos.videos WHERE tags CONTAINS 'Europe' ALLOW FILTERING;

-- 13. ;istar todos os utilizadores que registaram um evento de pause
SELECT user_id FROM videos.events WHERE event_type = 'pause' ALLOW FILTERING;