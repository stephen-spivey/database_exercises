-- Use the albums_db database.
USE albums_db;

-- What is the primary key for the albums table?
-- id

-- What does the column named 'name' represent?
-- name of album

-- What do you think the sales column represents?
-- millions of copied sold

-- Find the name of all albums by Pink Floyd.
SELECT name FROM albums WHERE artist = 'Pink Floyd';

-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper/s Lonely Hearts Club Band'; 
-- What is the genre for the album Nevermind? 
SELECT genre FROM albums WHERE name = 'Nevermind';

-- Which albums were released in the 1990s?
SELECT * FROM albums WHERE release_date >= 1990 AND release_date <= 1999;
-- Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name AS low_selling_albums
FROM albums 
WHERE sales < 20.0;


SELECT albums RENAME COLUMN old_column_name TO new_column_name;