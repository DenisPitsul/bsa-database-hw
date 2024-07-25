SELECT
    person.id AS ID,
    person.first_name AS "First name",
    person.last_name AS "Last name",
    SUM(movie.budget) AS "Total movies budget"
FROM
    person
JOIN
    character ON person.id = character.actor_id
JOIN
    movie ON character.movie_id = movie.id
GROUP BY
    person.id, person.first_name, person.last_name