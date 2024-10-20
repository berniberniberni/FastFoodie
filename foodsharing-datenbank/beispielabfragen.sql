--  ALGEMEINE ABFRAGEN
--	Welche Gebieten sind gerade von keinem Fahrer gefahren?
SELECT Gebiet.* FROM Gebiet
LEFT JOIN faehrt_in ON Gebiet.PLZ = faehrt_in.PLZ
WHERE faehrt_in.PLZ IS NULL;

--	Wie viele Spenden von JuliaJogurt werden noch nicht abgeholt?
SELECT COUNT(Spende) FROM Spende, Lieferung
WHERE Spende.SpenderName = 'JuliaJogurt'
AND Spende.LieferID = Lieferung.LieferID
AND Lieferung.status = 'neu';

--	Welche Spender befindet sich in Prenzlauer Berg?
SELECT Spender.* FROM Spender, Gebiet
WHERE Spender.SpenderPLZ = Gebiet.PLZ
AND Gebiet.Bezirk = 'Prenzlauer Berg';

--	Wo gibt es momentan Gemüse Spenden?
SELECT Spende.* FROM Spende
WHERE Spende.Kategorie = 'gemuese';

--  FAHRER VIEW
--  Alle aktive Fahrer
SELECT * FROM aktiveKollegen_MaxMueller;

--  Abgeholte Lieferungen
SELECT CONCAT (LieferStrasse, ' ', LieferHausnummer, ', ', LieferPLZ) AS LieferAdresse,
       Menge, Kategorie
FROM meineLieferungen_MaxMueller
WHERE status = 'abgeholt';

--  Neue Lieferungen
SELECT SpenderName,
       CONCAT (SpenderStrasse, ' ', SpenderHausnummer, ', ', SpenderPLZ) AS SpenderAdresse,
       Menge, Kategorie
FROM neueLieferungen_MaxMueller;

--  SPENDER VIEW
SELECT Vorname, Nachname, Handynummer FROM JuliaJogurt;