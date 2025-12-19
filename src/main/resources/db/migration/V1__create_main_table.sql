CREATE TABLE animes
(
    id          INT PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    description VARCHAR(1500)
);

INSERT INTO animes (id, name, description)
VALUES (1, 'Code Geass', 'Enjoy the best anime ever!');

INSERT INTO animes (id, name, description)
VALUES (2, 'Steins Gate', 'Time travel adventures');

