-- Active: 1747595262099@@127.0.0.1@5432@conservation_db@public
 --step 1
 --create in database
create DATABASE conservation_db;

--step 1.5
--delete tables if they exist
 DROP TABLE IF EXISTS rangers;
 DROP TABLE IF EXISTS species;
 DROP TABLE IF EXISTS sightings;


--step 2 
--create table rangers
 create Table rangers(
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  region VARCHAR(50) NOT NULL
  );

 
--step 3 
--insert data for table rangers
INSERT INTO rangers ( name, region) VALUES
( 'Alice Green', 'Northern Hills'),
( 'Bob White', 'River Delta'),
( 'Carol King', 'Mountain Range');



--step 4
--create table for species
 create Table species(
  species_id SERIAL PRIMARY KEY,
 common_name VARCHAR(50) NOT NULL,
 scientific_name VARCHAR(50) NOT NULL,
 discovery_date TIMESTAMP NOT NULL,
 conservation_status VARCHAR(20) NOT NULL check(conservation_status IN ('Endangered','Vulnerable','Historic'))
 );

 --step 4.5
 --insert data into species
 INSERT INTO species (species_id,common_name, scientific_name, discovery_date, conservation_status) VALUES
(1,'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2,'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3,'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4,'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


 --step 5
--create table for sightings
  create Table sightings(
  sighting_id SERIAL PRIMARY KEY,
  ranger_id INTEGER REFERENCES rangers(ranger_id) ON DELETE CASCADE,
  species_id INTEGER REFERENCES species(species_id) ON DELETE CASCADE,
  sighting_time TIMESTAMP NOT NULL,
  location VARCHAR(255) NOT NULL,
   notes TEXT
   );
   --step 5.5
 --insert data into sightings
 INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);



-- SELECT * from rangers;
-- SELECT * from species;
 SELECT * from sightings;


-- #Problem  solving

--Problem 1
--1️⃣ Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'

SELECT * FROM rangers;
INSERT INTO rangers(name,region)
VALUES('Derek Fox','Coastal Plains');


 --Problem 2
--2️⃣ Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) AS  unique_species_count FROM sightings;

 
  --Problem 3
--3️⃣ Find all sightings where the location includes "Pass".
 SELECT * FROM  sightings
 where location ILIKE '%Pass%';
 

   --Problem 4
--4️⃣ List each ranger's name and their total number of sightings.
SELECT r.name , COUNT(s.sighting_id) 
AS total_sightings
FROM rangers  r  
LEFT JOIN sightings s
ON r.ranger_id = s.ranger_id
GROUP BY r.name
ORDER BY r.name;

 --Problem 5
--5️⃣ List species that have never been sighted.

SELECT common_name FROM species 
WHERE species_id NOT IN (SELECT DISTINCT species_id FROM sightings);

 --Problem 6
--6️⃣ Show the most recent 2 sightings.
 SELECT sp.common_name,s.sighting_time,r.name 
 FROM sightings AS s 
  JOIN 
 species AS sp 
 ON
  s.species_id=sp.species_id 

  JOIN
 rangers AS r
 ON
  s.ranger_id = r.ranger_id 
 ORDER BY s.sighting_time DESC LIMIT 2;

 


  --Problem 7
--7️⃣ Update all species discovered before year 1800 to have status 'Historic'.


 UPDATE species 
 SET conservation_status='Historic'
 WHERE discovery_date < '1800/01/01';
 SELECT * FROM species;



  --Problem 8
--8️⃣ Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT * FROM sightings;

SELECT sighting_id,
CASE 
  WHEN EXTRACT (HOUR FROM sighting_time)< 12 THEN  'Morning'
  WHEN EXTRACT (HOUR FROM  sighting_time ) BETWEEN 12 AND 17 THEN  'Afternoon'
  ELSE  'Evening'
END
AS time_of_day
FROM sightings
ORDER BY sighting_id;

  --Problem 9
--9️⃣ Delete rangers who have never sighted any species

DELETE FROM rangers
WHERE  ranger_id
NOT IN (SELECT DISTINCT ranger_id FROM sightings);

 