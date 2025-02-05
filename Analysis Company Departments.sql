
-- Structuur van de tabellen bekijken
SELECT *
FROM werknemers;

SELECT *
FROM departementen;


-- Haal de namen van werknemers op en het departement waaraan ze zijn toegewezen
-- exclusief werknemers zonder departement.
SELECT d.departement_naam, w.werknemer_naam
FROM departementen d
JOIN werknemers w
ON w.departement_id = d.departement_id;

-- Haal de namen op van alle werknemers en de naam van het departement waaraan ze zijn toegewezen, 
-- inclusief werknemers zonder toegewezen departement.
SELECT d.departement_naam, w.werknemer_naam
FROM werknemers w
LEFT JOIN departementen d
ON w.departement_id = d.departement_id;


-- Haal de namen op van departementen zonder werknemers.
SELECT d.departement_naam
FROM departementen d
LEFT JOIN werknemers w
ON w.departement_id = d.departement_id
WHERE w.werknemer_id IS NULL;


-- Haal de namen van werknemers en de namen van hun leidinggevende (departementshoofden) op.
	-- SELF JOIN => gebruik dit om elke werknemer te linken aan elke leidinggevende
SELECT w.werknemer_naam AS werknemer, 
	   dh.werknemer_naam AS leidinggevende,
       d.departement_naam
FROM werknemers w
JOIN werknemers dh
ON w.departementshoofd_id = dh.werknemer_id  -- => w.departementshoofd_id = leiding_id van de werknemer //  dh.werknemer_id = werknemer_id van de leidinggevende
LEFT JOIN departementen d
ON w.departement_id = d.departement_id

ORDER BY departement_naam;

-- EXTRA: haal nu de namen van werknemers zonder departementshoofd
SELECT werknemer_naam AS werknemer_zonder_dh
FROM werknemers 
WHERE departementshoofd_id IS NULL;


-- Maak een lijst met de unieke namen van alle departementshoofden.
SELECT DISTINCT dh.werknemer_naam AS leidinggevende
FROM werknemers w
JOIN werknemers dh
ON w.departementshoofd_id = dh.werknemer_id;


-- Maak een lijst van alle projecten 
-- met een lijst van de namen van werknemers die aan deze projecten werken.
SELECT p.project_naam AS project,
	   w.werknemer_naam AS werknemer
FROM werknemer_projecten wp
LEFT JOIN projecten p
ON wp.project_id = p.project_id
LEFT JOIN werknemers w
ON wp.werknemer_id = w.werknemer_id
ORDER BY p.project_id, w.werknemer_naam;

-- ALTERNATIEF met GROUP_CONCAT()
SELECT p.project_naam AS project,
	   GROUP_CONCAT(w.werknemer_naam) AS werknemers  -- Als we een lijst van waardes in 1 enkel veld willen zien (niet meer mogelijk om met dit resultaat verder te analyseren)
FROM werknemer_projecten wp
LEFT JOIN projecten p
ON wp.project_id = p.project_id
LEFT JOIN werknemers w
ON wp.werknemer_id = w.werknemer_id
GROUP BY p.project_id
ORDER BY p.project_id;



-- Maak een lijst met alle projecten 
-- en de unieke departementen van werknemers die aan het project meewerken.

SELECT departement_naam AS departementen,
	   GROUP_CONCAT(DISTINCT p.project_naam) AS projecten,  -- DISTINCT => anders voorkomen we dat een project naam dubbel voorkomt als er 2 werknemers in werken
	   GROUP_CONCAT(w.werknemer_naam) AS werknemers  
FROM werknemer_projecten wp
LEFT JOIN projecten p
ON wp.project_id = p.project_id
LEFT JOIN werknemers w
ON wp.werknemer_id = w.werknemer_id
LEFT JOIN departementen d
ON w.departement_id = d.departement_id
GROUP BY d.departement_id, p.project_id
ORDER BY d.departement_id;
