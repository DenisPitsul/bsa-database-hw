SELECT
    app_user.id AS ID,
    app_user.username AS Username,
    ARRAY_AGG(favorite_movies.movie_id) AS "Favorite movie IDs"
FROM
    app_user
LEFT JOIN
    favorite_movies ON app_user.id = favorite_movies.user_id
GROUP BY
    app_user.id, app_user.username;
