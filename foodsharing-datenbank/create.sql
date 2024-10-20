DROP TABLE IF EXISTS Gebiet, Spender, Spende, Lieferung, Fahrer, faehrt_in, liefert;

CREATE TABLE IF NOT EXISTS Gebiet (
    PLZ VARCHAR(7) PRIMARY KEY,
    Bezirk VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Fahrer (
    FahrerID INT PRIMARY KEY,
    Vorname VARCHAR(255) NOT NULL,
    Nachname VARCHAR(255) NOT NULL,
    Handynummer BIGINT NOT NULL,
    Aktiv BOOLEAN NOT NULL
);

CREATE TYPE statusType AS ENUM ('neu','zugeordnet','abgeholt', 'ausgeliefert');
CREATE TABLE IF NOT EXISTS Lieferung (
    LieferID INT PRIMARY KEY,
    Status statusType NOT NULL,
    LieferPLZ VARCHAR(7) NOT NULL REFERENCES Gebiet(PLZ),
    LieferStrasse VARCHAR(255) NOT NULL,
    LieferHausnummer VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Spender (
    SpenderName VARCHAR(255) NOT NULL,
    SpenderStrasse VARCHAR(255) NOT NULL,
    SpenderHausnummer VARCHAR(255) NOT NULL,
    PRIMARY KEY (SpenderName, SpenderStrasse, SpenderHausnummer),
    SpenderPLZ VARCHAR(7) REFERENCES Gebiet(PLZ)
);

CREATE TYPE Kategorien AS ENUM ('gemuese','fleisch','fisch', 'milchprodukte', 'teigwaren', 'getraenke', 'speisereste', 'sonstiges', 'tiefkuehlprodukte');
CREATE TABLE IF NOT EXISTS Spende (
    SpendenID INT PRIMARY KEY,
    Kategorie Kategorien NOT NULL,
    Menge INT NOT NULL,
    CHECK (Menge <= 10 AND Menge > 0),
    LieferID INT REFERENCES Lieferung(LieferID),
    SpenderName VARCHAR(255) NOT NULL,
    SpenderStrasse VARCHAR(255) NOT NULL,
    SpenderHausnummer VARCHAR(255) NOT NULL,
    FOREIGN KEY (SpenderName, SpenderStrasse, SpenderHausnummer) REFERENCES Spender(SpenderName, SpenderStrasse, SpenderHausnummer)
);


CREATE TABLE IF NOT EXISTS faehrt_in (
    FahrerID INT REFERENCES Fahrer(FahrerID),
    PLZ VARCHAR(7) REFERENCES Gebiet(PLZ)
);

CREATE TABLE IF NOT EXISTS liefert (
    FahrerID INT REFERENCES Fahrer(FahrerID),
    LieferID INT REFERENCES Lieferung(LieferID)
);