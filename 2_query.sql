SELECT movies.id, movies.title, count(movie_characters.person_id) AS "Actors count"
FROM movies
JOIN movie_characters ON movies.id = movie_characters.movie_id
WHERE movies.release_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY movies.id
ORDER BY movies.id;