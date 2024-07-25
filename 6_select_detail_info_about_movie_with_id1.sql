SELECT
    movie.id AS "ID",
    movie.title AS "Title",
    movie.release_date AS "Release date",
    movie.duration_minutes AS "Duration",
    movie.description AS "Description",
    JSON_BUILD_OBJECT(
        'id', app_file.id,
        'file_name', app_file.file_name,
        'mime_type', app_file.mime_type,
        'key', app_file.key,
        'url', app_file.url
    ) AS "Poster",
    JSON_BUILD_OBJECT(
        'id', director.id,
        'first_name', director.first_name,
        'last_name', director.last_name,
        'photo', JSON_BUILD_OBJECT(
            'id', director_photo.id,
            'file_name', director_file.file_name,
            'mime_type', director_file.mime_type,
            'key', director_file.key,
            'url', director_file.url
        )
    ) AS "Director",
    (
        SELECT JSON_AGG(actor_info)
        FROM (
            SELECT DISTINCT ON (actor.id)
                JSON_BUILD_OBJECT(
                    'id', actor.id,
                    'first_name', actor.first_name,
                    'last_name', actor.last_name,
                    'photo', JSON_BUILD_OBJECT(
                        'id', actor_file.id,
                        'file_name', actor_file.file_name,
                        'mime_type', actor_file.mime_type,
                        'key', actor_file.key,
                        'url', actor_file.url
                    )
                ) AS actor_info
            FROM
                character
            INNER JOIN
                person AS actor ON character.actor_id = actor.id
            LEFT JOIN
                person_photo AS actor_photo ON actor.id = actor_photo.person_id AND actor_photo.is_primary = TRUE
            LEFT JOIN
                app_file AS actor_file ON actor_photo.file_id = actor_file.id
            WHERE
                character.movie_id = movie.id
            ORDER BY
                actor.id, actor_photo.id
        ) AS actors
    ) AS "Actors",
    (
        SELECT JSON_AGG(genre_info)
        FROM (
            SELECT DISTINCT ON (genre.id)
                JSON_BUILD_OBJECT(
                    'id', genre.id,
                    'name', genre.name
                ) AS genre_info
            FROM
                movie_genre
            INNER JOIN
                genre ON movie_genre.genre_id = genre.id
            WHERE
                movie_genre.movie_id = movie.id
            ORDER BY
                genre.id
        ) AS genres
    ) AS "Genres"
FROM
    movie
LEFT JOIN
    app_file ON movie.poster_file_id = app_file.id
LEFT JOIN
    person AS director ON movie.director_id = director.id
LEFT JOIN
    person_photo AS director_photo ON director.id = director_photo.person_id AND director_photo.is_primary = TRUE
LEFT JOIN
    app_file AS director_file ON director_photo.file_id = director_file.id
WHERE
    movie.id = 1
GROUP BY
    movie.id, app_file.id, director.id, director_photo.id, director_file.id;
