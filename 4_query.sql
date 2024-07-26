SELECT m.director_id AS "Director ID", CONCAT(persons.first_name, ' ', persons.last_name) AS "Director name", AVG(m.budget) AS "Average budget" 
FROM movies AS m
JOIN persons ON persons.id = m.director_id
GROUP BY m.director_id, persons.first_name, persons.last_name
ORDER BY m.director_id;
