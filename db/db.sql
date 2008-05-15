CREATE TABLE actors (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE directors (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE directors_dvds (
  director_id INTEGER UNSIGNED NOT NULL,
  dvd_id INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(director_id, dvd_id),
  INDEX directors_has_dvds_FKIndex1(director_id),
  INDEX directors_has_dvds_FKIndex2(dvd_id)
);

CREATE TABLE dvds (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  asin VARCHAR(255) NULL,
  details_url TEXT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE dvds_actors (
  actor_id INTEGER UNSIGNED NOT NULL,
  dvd_id INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(actor_id, dvd_id),
  INDEX dvds_has_actors_FKIndex1(dvd_id),
  INDEX dvds_has_actors_FKIndex2(actor_id)
);

CREATE TABLE manufacturers (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE manufacturers_dvds (
  manufacturer_id INTEGER UNSIGNED NOT NULL,
  dvd_id INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(manufacturer_id, dvd_id),
  INDEX manufacturers_has_dvds_FKIndex1(manufacturer_id),
  INDEX manufacturers_has_dvds_FKIndex2(dvd_id)
);


