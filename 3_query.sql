SELECT f.user_id AS "ID", f.movie_id AS "favorite movie IDs", users.username
FROM favorite_movies AS f
JOIN users ON f.user_id = users.id
ORDER BY f.user_id;