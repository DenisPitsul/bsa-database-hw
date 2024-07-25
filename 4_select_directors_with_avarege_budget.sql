SELECT
    person.id AS "Director ID",
    CONCAT(person.first_name, ' ', person.last_name) AS "Director name",
    AVG(movie.budget) AS "Average budget"
FROM
    person
JOIN
    movie ON person.id = movie.director_id
GROUP BY
    person.id, person.first_name, person.last_name;
