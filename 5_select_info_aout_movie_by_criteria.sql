SELECT
    movie.id AS "ID",
    movie.title AS "Title",
    movie.release_date AS "Release date",
    movie.duration_minutes AS "Duration",
    movie.description AS "Description",
    json_build_object(
        'id', app_file.id,
        'file_name', app_file.file_name,
        'mime_type', app_file.mime_type,
        'key', app_file.key,
        'url', app_file.url
    ) AS "Poster",
    json_build_object(
        'id', person.id,
        'first_name', person.first_name,
        'last_name', person.last_name
    ) AS "Director"
FROM
    movie
JOIN
    country ON movie.country_id = country.id
JOIN
    movie_genre ON movie.id = movie_genre.movie_id
JOIN
    genre ON movie_genre.genre_id = genre.id
LEFT JOIN
    app_file ON movie.poster_file_id = app_file.id
LEFT JOIN
    person ON movie.director_id = person.id
WHERE
    country.id = 1
    AND EXTRACT(YEAR FROM movie.release_date) >= 2022
    AND movie.duration_minutes > (2 * 60 + 15)
    AND genre.name IN ('Action', 'Drama');