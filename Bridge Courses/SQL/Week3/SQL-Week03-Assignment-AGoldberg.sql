DROP TABLE IF EXISTS videos;
CREATE TABLE videos (
vidId serial PRIMARY KEY NOT NULL,
title VARCHAR NOT NULL,
length INTERVAL NOT NULL,
url VARCHAR NOT NULL
);

DROP TABLE IF EXISTS reviewers;
CREATE TABLE reviewers (
reviewerId serial PRIMARY KEY NOT NULL,
vidId INT REFERENCES videos(vidId) NOT NULL,
userName VARCHAR NOT NULL,
rating VARCHAR,
shortReview VARCHAR NOT NULL
);

INSERT INTO videos (title, length, url)
	VALUES ('C# - C Sharp html data collecting', '00:15:14', 'https://www.youtube.com/watch?v=rru3G7PLVjw'),
		('Web data tutorial: Retrieving and displaying XML data | lynda.com', '00:13:24', 'https://www.youtube.com/watch?v=ppzYGd0wi_c'),
		('Querying Web Page Source Code and Extracting Data from a Site (Part 3 of 4)', '00:13:19', 'https://www.youtube.com/watch?v=xaW6jeZYVvA');		 ;

INSERT INTO reviewers (vidId, userName, rating, shortReview)
	VALUES (1, 'Steve', 'down', 'missing key, important parts, I am confused'),
		(1, 'Ellen', 'up', 'very thorough and easy to follow'),
		(2, 'Isabel', 'down', 'too flashy'),
		(2, 'Bill', 'up', 'the graphics made the presentation very intuitive'),
		(3, 'Monisha', 'up', 'a comprehensive explaination of scouring webpages for data');

SELECT v.title, v.length, v.url, r.userName, r.rating, r.shortReview
  FROM videos v, reviewers r
 WHERE v.vidId = r.vidId;