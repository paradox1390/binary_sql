SELECT persons.id AS "ID", persons.first_name, persons.last_name, SUM(movies.budget) AS "Total movies budget"
	FROM movie_characters
JOIN movies ON movies.id = movie_characters.movie_id
JOIN persons ON persons.id = movie_characters.person_id
GROUP BY 
    persons.id, persons.first_name, persons.last_name
ORDER BY persons.id;


