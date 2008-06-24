CREATE TABLE actors (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE club_topics (
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
  dvd_category_id INTEGER UNSIGNED NOT NULL,
  format_id INTEGER UNSIGNED NOT NULL,
  dvd_club_id INTEGER UNSIGNED NOT NULL,
  asin VARCHAR(255) NULL,
  details_url TEXT NULL,
  subscription_status VARCHAR(255) NULL,
  created_at TIMESTAMP NULL,
  owner_id INTEGER UNSIGNED NULL,
  title VARCHAR(255) NULL,
  logo VARCHAR(255) NULL,
  description TEXT NULL,
  PRIMARY KEY(id),
  INDEX dvds_FKIndex1(dvd_club_id),
  INDEX dvds_FKIndex2(format_id),
  INDEX dvds_FKIndex3(dvd_category_id)
);

CREATE TABLE dvds_actors (
  actor_id INTEGER UNSIGNED NOT NULL,
  dvd_id INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(actor_id, dvd_id),
  INDEX dvds_has_actors_FKIndex1(dvd_id),
  INDEX dvds_has_actors_FKIndex2(actor_id)
);

CREATE TABLE dvd_categories (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE dvd_clubs (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  club_topic_id INTEGER UNSIGNED NOT NULL,
  name VARCHAR(255) NULL,
  description TEXT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  owner_id INTEGER UNSIGNED NULL,
  PRIMARY KEY(id),
  INDEX dvd_clubs_FKIndex1(club_topic_id)
);

CREATE TABLE formats (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NULL,
  PRIMARY KEY(id)
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

CREATE TABLE users (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  login VARCHAR(255) NULL,
  email VARCHAR(255) NULL,
  crypted_password VARCHAR(40) NULL,
  salt VARCHAR(40) NULL,
  remember_token VARCHAR(255) NULL,
  created_at TIMESTAMP NULL,
  updated_at  TIMESTAMP NULL,
  remember_token_expires_at DATETIME NULL,
  deleted_at TIMESTAMP NULL,
  PRIMARY KEY(id)
);

CREATE TABLE user_dvd_clubs (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  dvd_club_id INTEGER UNSIGNED NOT NULL,
  user_id INTEGER UNSIGNED NOT NULL,
  subscription_status VARCHAR(255) NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  PRIMARY KEY(id),
  INDEX user_dvd_clubs_FKIndex1(user_id),
  INDEX user_dvd_clubs_FKIndex2(dvd_club_id)
);

CREATE TABLE waiting_lists (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INTEGER UNSIGNED NOT NULL,
  dvd_id INTEGER UNSIGNED NOT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  PRIMARY KEY(id),
  INDEX waiting_lists_FKIndex1(dvd_id),
  INDEX waiting_lists_FKIndex2(user_id)
);


