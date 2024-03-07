USE films_projections;


CREATE TABLE IF NOT EXISTS films(
nameFilm VARCHAR(100) NOT NULL,
yearName DATETIME NOT NULL,
country VARCHAR(50),
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE IF NOT EXISTS cinema(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nameCinema VARCHAR(100) NOT NULL,
hallsCinema INT NOT NULL
);

CREATE TABLE IF NOT EXISTS halls(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nameHall VARCHAR(50) NOT NULL,
statusHall VARCHAR(50) NOT NULL,
cinema_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(cinema_id) REFERENCES cinema(id)
);

CREATE TABLE IF NOT EXISTS projections(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
timeProjection DATETIME NOT NULL,
people INT NOT NULL,
film_id INT NOT NULL,
hall_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (film_id) REFERENCES films(id),
CONSTRAINT FOREIGN KEY(hall_id) REFERENCES halls(id)
);

#2
SELECT c.name AS cinema_name, h.hall_status, p.broadcasting_time
FROM cinemas AS c
INNER JOIN halls AS h ON c.id = h.cinema_id
INNER JOIN projections AS p ON h.id = p.hall_id
INNER JOIN films AS f ON p.film_id = f.id
WHERE (h.hall_status = 'VIP' OR h.hall_status = 'Deluxe') AND f.name = 'Final Destinaton 7'
ORDER BY c.name, h.cinema_id;

#3
SELECT sum(p.audience) AS total_audience
FROM cinemas AS c
INNER JOIN halls AS h ON c.id = h.cinema_id
INNER JOIN projections AS p ON h.id = p.hall_id
INNER JOIN films AS f ON p.film_id = f.id
WHERE h.hall_status = 'VIP' AND f.name = 'Final Destinaton 7' AND c.name = 'Arena Mladost';

#4
SELECT s1.name AS student1, s2.name AS student2, sg.location, sg.dayOfWeek, sg.hourOfTraining
FROM student_sport AS ss1
JOIN student_sport AS ss2 ON ss1.sportGroup_id = ss2.sportGroup_id AND ss1.student_id < ss2.student_id
JOIN students s1 ON s1.id = ss1.student_id
JOIN students s2 ON s2.id = ss2.student_id
JOIN sportGroups sg ON sg.id = ss1.sportGroup_id
ORDER BY sg.location, sg.dayOfWeek, sg.hourOfTraining;

#5
CREATE VIEW sp (Student_name, Class, Location, Coach_name) AS
SELECT students.name, students.class, sportGroups.location, coaches.name 
FROM students 
JOIN student_sport ON students.id = student_sport.student_id 
JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id 
JOIN coaches ON sportGroups.coach_id = coaches.id 
WHERE sportGroups.hourOfTraining = '08:00:00';

SELECT * FROM sp;

#6
SELECT s.name AS sport, count(DISTINCT student_sport.student_id) AS number_of_students
FROM sports AS s
LEFT JOIN sportGroups ON s.id = sportGroups.sport_id
LEFT JOIN student_sport ON sportGroups.id = student_sport.sportGroup_id
GROUP BY s.name;



SELECT films.nameFilm, halls.id,projections.timeProject 
FROM films
INNER JOIN halls ON halls.cinema_id = cinema.id
INNER JOIN projections ON projections.hall_id = halls.id
INNER JOIN films ON projections.film_id = films.id
WHERE films.nameFilm = 'Final Destination'
AND (halls.statusHall = 'VIP' OR halss.statusHall = 'DELUX')
ORDER BY cinema.nameCinema, halls.id;

SELECT COUNT(people) 
FROM projections
INNER JOIN





