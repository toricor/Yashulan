CREATE TABLE IF NOT EXISTS user (
    id           INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(255) NOT NULL UNIQUE,
    password     VARCHAR(255) NOT NULL,
    created_at   VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS station (
    id              INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS restaurant (
    id              INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(255) NOT NULL UNIQUE,
    station         INTEGER NOT NULL,
    genre           VARCHAR(255) NOT NULL,
    budget_lower    INTEGER default 0,
    budget_upper    INTEGER,
    lunch_or_dinner INTEGER,
    star            FLOAT NOT NULL,
    good            VARCHAR(255),
    tabelog         VARCHAR(255),
    author          INTEGER NOT NULL,
    created_at      VARCHAR(255) NOT NULL,
    updated_at      VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS favorite (
    id            INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id       INTEGER NOT NULL,
    restaurant_id INTEGER NOT NULL,
    created_at    VARCHAR(255) NOT NULL
) ENGINE=InnoDB;
