CREATE TABLE app_file (
    id INT PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(255) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL
);

CREATE TABLE app_user (
    id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar_file_id INT,
    FOREIGN KEY (avatar_file_id) REFERENCES app_file(id)
);

CREATE TABLE director (
    id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('male', 'female')),
    main_photo_file_id INT NOT NULL,
    FOREIGN KEY (main_photo_file_id) REFERENCES app_file(id)
);

CREATE TABLE country (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE genre (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE movie (
    id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    budget DECIMAL(15, 2) NOT NULL,
    release_date DATE NOT NULL,
    duration_minutes INT NOT NULL,
    director_id INT NOT NULL,
    country_id INT NOT NULL,
	genre_id INT NOT NULL,
    poster_file_id INT,
    FOREIGN KEY (director_id) REFERENCES director(id),
    FOREIGN KEY (country_id) REFERENCES country(id),
    FOREIGN KEY (poster_file_id) REFERENCES app_file(id),
	FOREIGN KEY (genre_id) REFERENCES genre(id)
);

CREATE TABLE actor (
    id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('male', 'female')),
    main_photo_file_id INT,
    FOREIGN KEY (main_photo_file_id) REFERENCES app_file(id)
);

CREATE TABLE character (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
	role VARCHAR(16) NOT NULL CHECK (role IN ('leading', 'supporting', 'background')),
    movie_id INT NOT NULL,
    actor_id INT,
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (actor_id) REFERENCES Actor(id)
);

CREATE TABLE person (
    id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('male', 'female')),
    main_photo_file_id INT,
    FOREIGN KEY (main_photo_file_id) REFERENCES app_file(id)
);

CREATE TABLE favorite_movies (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES app_user(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id)
);