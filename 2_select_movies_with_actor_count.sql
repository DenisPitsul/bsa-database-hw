SELECT
    movie.id AS ID,
    movie.title AS Title,
    COUNT(character.actor_id) AS "Actors count"
FROM
    movie
JOIN
    character ON movie.id = character.movie_id
WHERE
    movie.release_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY
    movie.id, movie.title;
