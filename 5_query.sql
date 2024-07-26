SELECT movies.id, movies.title, movies.release_date, movies.duration, movies.description, 
	json_build_object(
		'id',files.id,  
		'file_name', files.file_name,
        'mime_type', files.mime_type,
        'key', files.key,
        'url', files.url,
        'is_public', files.is_public) as poster, 
	json_build_object(
		'id',persons.id,
		'first name',persons.first_name,
		'last name',persons.last_name) as director
FROM movies
JOIN files ON movies.poster_file_id = files.id
JOIN persons ON movies.director_id = persons.id
JOIN movie_genres ON movies.id = movie_genres.movie_id
JOIN genres ON movie_genres.genre_id = genres.id
WHERE movies.country_id = 1 AND movies.release_date >= '2022-01-01' AND movies.duration >= 135 AND (genres.name = 'Action' OR genres.name = 'Drama')
ORDER BY movies.id;


