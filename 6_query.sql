SELECT movies.id, movies.title, movies.release_date, movies.description, movies.duration, json_build_object(
		'id', files.id,  
		'file_name', files.file_name,
        'mime_type', files.mime_type,
        'key', files.key,
        'url', files.url,
        'is_public', files.is_public) as poster, 
	json_build_object(
		'id',persons.id,
		'first name',persons.first_name,
		'last name',persons.last_name) as director,
	json_agg(
        json_build_object(
            'id', genres.id,
            'name', genres.name
        )
    ) AS genres,
	json_agg(
        json_build_object(
            'id', p.id,
            'first name', p.first_name,
			'last name', p.last_name,
			'photo', json_build_object(
				'id', f.id,  
				'file_name', f.file_name,
		        'mime_type', f.mime_type,
		        'key', f.key,
		        'url', f.url,
		        'is_public', f.is_public
			)
        )
    ) AS actors
FROM movies
JOIN files ON movies.poster_file_id = files.id
JOIN persons ON movies.director_id = persons.id
JOIN movie_genres ON movies.id = movie_genres.movie_id
JOIN genres ON movie_genres.genre_id = genres.id
JOIN movie_characters as ms ON ms.movie_id = movies.id
JOIN persons as p ON ms.person_id = p.id
JOIN files as f ON p.primary_photo_id = f.id
WHERE movies.id = 1
GROUP BY 
    movies.id, 
    files.id, 
    persons.id
ORDER BY 
    movies.id;