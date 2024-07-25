CREATE TABLE app_file (
    id INT PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(255) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE app_user (
    id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar_file_id INT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (avatar_file_id) REFERENCES app_file(id)
);

CREATE TABLE country (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genre (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (director_id) REFERENCES person(id),
    FOREIGN KEY (country_id) REFERENCES country(id),
    FOREIGN KEY (poster_file_id) REFERENCES app_file(id),
	FOREIGN KEY (genre_id) REFERENCES genre(id)
);

CREATE TABLE character (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
	role VARCHAR(16) NOT NULL CHECK (role IN ('leading', 'supporting', 'background')),
    movie_id INT NOT NULL,
    actor_id INT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (actor_id) REFERENCES person(id)
);

CREATE TABLE person (
    id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('male', 'female')),
    origin_country_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (origin_country_id) REFERENCES country(id),
    FOREIGN KEY (main_photo_file_id) REFERENCES app_file(id)
);

CREATE TABLE favorite_movies (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES app_user(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id)
);

CREATE TABLE person_photo (
    id INT PRIMARY KEY,
    person_id INT NOT NULL,
    file_id INT NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person(id),
    FOREIGN KEY (file_id) REFERENCES app_file(id)
);