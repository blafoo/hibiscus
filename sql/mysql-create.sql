CREATE TABLE konto (
       id int(10) AUTO_INCREMENT
     , kontonummer VARCHAR(15) NOT NULL
     , blz VARCHAR(15) NOT NULL
     , name VARCHAR(255) NOT NULL
     , bezeichnung VARCHAR(255)
     , kundennummer VARCHAR(255) NOT NULL
     , waehrung VARCHAR(6) NOT NULL
     , passport_class TEXT NOT NULL
     , saldo DOUBLE
     , saldo_datum DATE
     , synchronize int(10)
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE lastschrift (
       id int(10) AUTO_INCREMENT
     , konto_id int(10) NOT NULL
     , empfaenger_konto VARCHAR(15) NOT NULL
     , empfaenger_blz VARCHAR(15) NOT NULL
     , empfaenger_name VARCHAR(255)
     , betrag DOUBLE NOT NULL
     , zweck VARCHAR(27) NOT NULL
     , zweck2 VARCHAR(27)
     , termin DATE NOT NULL
     , ausgefuehrt int(10) NOT NULL
     , typ VARCHAR(2)
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE systemnachricht (
       id int(10) AUTO_INCREMENT
     , blz VARCHAR(15) NOT NULL
     , nachricht TEXT NOT NULL
     , datum DATE NOT NULL
     , gelesen int(10) NOT NULL
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE turnus (
       id int(10) AUTO_INCREMENT
     , zeiteinheit int(10) NOT NULL
     , intervall int(10) NOT NULL
     , tag int(10) NOT NULL
     , initial int(10)
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE empfaenger (
       id int(10) AUTO_INCREMENT
     , kontonummer VARCHAR(15) NOT NULL
     , blz VARCHAR(15) NOT NULL
     , name VARCHAR(27) NOT NULL
     , kommentar TEXT
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE sueberweisung (
       id int(10) AUTO_INCREMENT
     , konto_id int(10) NOT NULL
     , bezeichnung VARCHAR(255) NOT NULL
     , termin DATE NOT NULL
     , ausgefuehrt int(10) NOT NULL
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE umsatztyp (
       id int(10) AUTO_INCREMENT
     , name VARCHAR(255) NOT NULL
     , nummer VARCHAR(5)
     , pattern VARCHAR(255)
     , isregex int(10)
     , iseinnahme int(10)
     , parent_id int(10)
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE slastschrift (
       id int(10) AUTO_INCREMENT
     , konto_id int(10) NOT NULL
     , bezeichnung VARCHAR(255) NOT NULL
     , termin DATE NOT NULL
     , ausgefuehrt int(10) NOT NULL
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE protokoll (
       id int(10) AUTO_INCREMENT
     , konto_id int(10) NOT NULL
     , kommentar VARCHAR(1000) NOT NULL
     , datum DATE NOT NULL
     , typ int(10) NOT NULL
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE slastbuchung (
       id int(10) AUTO_INCREMENT
     , slastschrift_id int(10) NOT NULL
     , gegenkonto_nr VARCHAR(15) NOT NULL
     , gegenkonto_blz VARCHAR(15) NOT NULL
     , gegenkonto_name VARCHAR(255)
     , betrag DOUBLE NOT NULL
     , zweck VARCHAR(27) NOT NULL
     , zweck2 VARCHAR(27)
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE sueberweisungbuchung (
       id int(10) AUTO_INCREMENT
     , sueberweisung_id int(10) NOT NULL
     , gegenkonto_nr VARCHAR(15) NOT NULL
     , gegenkonto_blz VARCHAR(15) NOT NULL
     , gegenkonto_name VARCHAR(255)
     , betrag DOUBLE NOT NULL
     , zweck VARCHAR(27) NOT NULL
     , zweck2 VARCHAR(27)
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE ueberweisung (
       id int(10) AUTO_INCREMENT
     , konto_id int(10) NOT NULL
     , empfaenger_konto VARCHAR(15) NOT NULL
     , empfaenger_blz VARCHAR(15) NOT NULL
     , empfaenger_name VARCHAR(255)
     , betrag DOUBLE NOT NULL
     , zweck VARCHAR(27) NOT NULL
     , zweck2 VARCHAR(27)
     , termin DATE NOT NULL
     , banktermin int(10)
     , ausgefuehrt int(10) NOT NULL
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE umsatz (
       id int(10) AUTO_INCREMENT
     , konto_id int(10) NOT NULL
     , empfaenger_konto VARCHAR(15)
     , empfaenger_blz VARCHAR(15)
     , empfaenger_name VARCHAR(255)
     , betrag DOUBLE NOT NULL
     , zweck VARCHAR(35)
     , zweck2 VARCHAR(35)
     , datum DATE NOT NULL
     , valuta DATE NOT NULL
     , saldo DOUBLE
     , primanota VARCHAR(100)
     , art VARCHAR(100)
     , customerref VARCHAR(100)
     , kommentar TEXT
     , checksum int(10)
     , umsatztyp_id int(10)
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE TABLE dauerauftrag (
       id int(10) AUTO_INCREMENT
     , konto_id int(10) NOT NULL
     , empfaenger_konto VARCHAR(15) NOT NULL
     , empfaenger_blz VARCHAR(15) NOT NULL
     , empfaenger_name VARCHAR(255)
     , betrag DOUBLE NOT NULL
     , zweck VARCHAR(27) NOT NULL
     , zweck2 VARCHAR(27)
     , erste_zahlung DATE NOT NULL
     , letzte_zahlung DATE
     , orderid VARCHAR(20)
     , zeiteinheit int(10) NOT NULL
     , intervall int(10) NOT NULL
     , tag int(10) NOT NULL
     , UNIQUE (id)
     , PRIMARY KEY (id)
)TYPE=InnoDB;

CREATE INDEX idx_lastschrift_konto ON lastschrift(konto_id);
CREATE INDEX idx_sueberweisung_konto ON sueberweisung(konto_id);
CREATE INDEX idx_umsatztyp_umsatztyp ON umsatztyp(parent_id);
CREATE INDEX idx_slastschrift_konto ON slastschrift(konto_id);
CREATE INDEX idx_protokoll_konto ON protokoll(konto_id);
CREATE INDEX idx_slastbuchung_slastschrift ON slastbuchung(slastschrift_id);
CREATE INDEX idx_sueberweisungbuchung_sueberweisung ON sueberweisungbuchung(sueberweisung_id);
CREATE INDEX idx_ueberweisung_konto ON ueberweisung(konto_id);
CREATE INDEX idx_umsatz_konto ON umsatz(konto_id);
CREATE INDEX idx_umsatz_umsatztyp ON umsatz(umsatztyp_id);
CREATE INDEX idx_dauerauftrag_konto ON dauerauftrag(konto_id);

ALTER TABLE lastschrift ADD CONSTRAINT fk_lastschrift_konto FOREIGN KEY (konto_id) REFERENCES konto (id);
ALTER TABLE sueberweisung ADD CONSTRAINT fk_sueberweisung_konto FOREIGN KEY (konto_id) REFERENCES konto (id);
ALTER TABLE umsatztyp ADD CONSTRAINT fk_umsatztyp_umsatztyp FOREIGN KEY (parent_id) REFERENCES umsatztyp (id);
ALTER TABLE slastschrift ADD CONSTRAINT fk_slastschrift_konto FOREIGN KEY (konto_id) REFERENCES konto (id);
ALTER TABLE protokoll ADD CONSTRAINT fk_protokoll_konto FOREIGN KEY (konto_id) REFERENCES konto (id);
ALTER TABLE slastbuchung ADD CONSTRAINT fk_slastbuchung_slastschrift FOREIGN KEY (slastschrift_id) REFERENCES slastschrift (id);
ALTER TABLE sueberweisungbuchung ADD CONSTRAINT fk_sueberweisungbuchung_sueberweisung FOREIGN KEY (sueberweisung_id) REFERENCES sueberweisung (id);
ALTER TABLE ueberweisung ADD CONSTRAINT fk_ueberweisung_konto FOREIGN KEY (konto_id) REFERENCES konto (id);
ALTER TABLE umsatz ADD CONSTRAINT fk_umsatz_konto FOREIGN KEY (konto_id) REFERENCES konto (id);
ALTER TABLE umsatz ADD CONSTRAINT fk_umsatz_umsatztyp FOREIGN KEY (umsatztyp_id) REFERENCES umsatztyp (id);
ALTER TABLE dauerauftrag ADD CONSTRAINT fk_dauerauftrag_konto FOREIGN KEY (konto_id) REFERENCES konto (id);

-- Indizes fuer grosse Datenmengen
ALTER TABLE umsatz ADD INDEX (datum);
ALTER TABLE umsatz ADD INDEX (valuta);
ALTER TABLE protokoll ADD INDEX (datum);
ALTER TABLE ueberweisung ADD INDEX (termin);
ALTER TABLE lastschrift ADD INDEX (termin);