CREATE TYPE gender AS ENUM ('female', 'male');
CREATE TYPE role AS ENUM ('leading', 'supporting', 'background');

CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE files (
	id SERIAL PRIMARY KEY,
	file_name VARCHAR(255)  NOT NULL UNIQUE,
	mime_type VARCHAR(255) NOT NULL,
	key VARCHAR(255)  NOT NULL,
	url VARCHAR(255) NOT NULL UNIQUE,
	is_public BOOLEAN  NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE persons (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(80) NOT NULL,
	biography TEXT,
	birthdate DATE,
	gender gender,
	country_id INT NOT NULL,
	primary_photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT country_id_fk FOREIGN KEY (country_id) REFERENCES countries (id) ON DELETE SET NULL,
	CONSTRAINT primary_photo_id_fk FOREIGN KEY (primary_photo_id) REFERENCES files (id) ON DELETE SET NULL
);

CREATE TABLE movies (
	id SERIAL PRIMARY KEY,
	title VARCHAR NOT NULL,
	description TEXT,
	budget BIGINT,
	release_date DATE NOT NULL,
	duration INT NOT NULL,
	country_id INT NOT NULL,
	director_id INT NOT NULL,
	poster_file_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT country_id_fk FOREIGN KEY (country_id) REFERENCES countries (id) ON DELETE SET NULL,
	CONSTRAINT director_id_fk FOREIGN KEY (director_id) REFERENCES persons (id) ON DELETE SET NULL,
	CONSTRAINT poster_file_id_fk FOREIGN KEY (poster_file_id) REFERENCES files (id) ON DELETE SET NULL
	);

CREATE TABLE characters (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE,
	description TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE movie_characters (
	id SERIAL PRIMARY KEY,
	movie_id INT,
    person_id INT,
    character_id INT ,
    role role,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT movie_id_fk FOREIGN KEY (movie_id ) REFERENCES movies (id) ON DELETE SET NULL,
	CONSTRAINT person_id_fk FOREIGN KEY (person_id) REFERENCES persons (id) ON DELETE SET NULL,
	CONSTRAINT character_id_fk FOREIGN KEY (character_id) REFERENCES characters (id) ON DELETE SET NULL
);

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	username VARCHAR(50) NOT NULL UNIQUE,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(80) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	password VARCHAR(50) NOT NULL,
	avatar_file_id INT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT avatar_file_id_fk FOREIGN KEY (avatar_file_id) REFERENCES files (id) ON DELETE SET NULL
);

CREATE TABLE favorite_movies (
	movie_id INT NOT NULL,
	user_id INT NOT NULL,
	CONSTRAINT movie_id_fk FOREIGN KEY (movie_id ) REFERENCES movies (id) ON DELETE CASCADE,
	CONSTRAINT user_id_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
	);

CREATE TABLE movie_genres (
	movie_id INT NOT NULL,
	genre_id INT NOT NULL,
	CONSTRAINT movie_id_fk FOREIGN KEY (movie_id ) REFERENCES movies (id) ON DELETE CASCADE,
	CONSTRAINT genre_id_fk FOREIGN KEY (genre_id ) REFERENCES genres (id) ON DELETE CASCADE
);

CREATE TABLE person_albums (
	person_id INT NOT NULL,
	photo_id INT NOT NULL,
	CONSTRAINT person_id_fk FOREIGN KEY (person_id) REFERENCES persons (id) ON DELETE CASCADE,
	CONSTRAINT photo_id_fk FOREIGN KEY (photo_id) REFERENCES files (id) ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_country_updated_at
BEFORE UPDATE ON countries
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_genre_updated_at
BEFORE UPDATE ON genres
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_file_updated_at
BEFORE UPDATE ON files
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_person_updated_at
BEFORE UPDATE ON persons
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_movie_updated_at
BEFORE UPDATE ON movies
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_character_updated_at
BEFORE UPDATE ON characters
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_movie_character_updated_at
BEFORE UPDATE ON movie_characters
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_movie_user_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();
