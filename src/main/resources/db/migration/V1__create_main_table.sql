CREATE TABLE animes
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    description VARCHAR(1500)
);

INSERT INTO animes (name, description)
VALUES ('Code Geass', 'Enjoy the best anime ever!');

INSERT INTO animes (name, description)
VALUES ('Steins Gate', 'Time travel adventures');

