-- Code voor het aanmaken van de tabel

DROP TABLE IF EXISTS werknemers, departementen, projecten, werknemer_projecten;

-- Maak de 'werknemers' tabel
CREATE TABLE werknemers (
    werknemer_id INT PRIMARY KEY,
    werknemer_naam VARCHAR(255),
    departement_id INT,
    departementshoofd_id INT,
    FOREIGN KEY (departementshoofd_id) REFERENCES werknemers(werknemer_id)
);

-- Maak de 'departementen' tabel
CREATE TABLE departementen (
    departement_id INT PRIMARY KEY,
    departement_naam VARCHAR(255)
);

-- Voeg data toe aan de 'departementen' tabel (voorbeelddata)
INSERT INTO departementen (departement_id, departement_naam) VALUES
(101, 'IT'),
(102, 'Marketing'),
(103, 'Financiën'),
(104, 'HR'),
(105, 'Poetsdienst');

-- Voeg data toe aan de 'werknemers' tabel
INSERT INTO werknemers (werknemer_id, werknemer_naam, departement_id, departementshoofd_id) VALUES
(1, 'Olivia', 101, NULL),
(2, 'Senne', 102, NULL),
(3, 'Lauren', 103, 1), 
(4, 'Siebe', 102, 2), 
(5, 'Celine', 101, 1),
(6, 'Anne', 104, 2), 
(7, 'Morris', NULL, NULL),
(8, 'Henri', 103, 1), 
(9, 'Eva', 101, 2), 
(10, 'Elke', 102, 1);

-- Maak de 'projecten' tabel
CREATE TABLE projecten (
    project_id INT PRIMARY KEY,
    project_naam VARCHAR(255)
);

-- Voeg data toe aan de 'projecten' tabel
INSERT INTO projecten (project_id, project_naam) VALUES
(201, 'Werknemers databank opzetten'),
(202, 'Website maken'),
(203, 'Financiële analyse'),
(204, 'Marketing campagne');

-- Maak de 'werknemer_projecten' tabel voor de relatie tussen werknemers en projecten
CREATE TABLE werknemer_projecten (
    werknemer_id INT,
    project_id INT,
    PRIMARY KEY (werknemer_id, project_id),
    FOREIGN KEY (werknemer_id) REFERENCES werknemers(werknemer_id),
    FOREIGN KEY (project_id) REFERENCES projecten(project_id)
);

INSERT INTO werknemer_projecten (werknemer_id, project_id) VALUES
(1, 201),
(2, 202),
(3, 201),
(4, 203),
(5, 201),
(6, 204),
(8, 203),
(9, 204),
(10, 202),
(1, 202),
(2, 201),
(4, 204),
(5, 203),
(10, 203);
