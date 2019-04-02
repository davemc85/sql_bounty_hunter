DROP TABLE IF EXISTS space_cowboys;

CREATE TABLE space_cowboys(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  bounty_value INT,
  last_known_location VARCHAR(255),
  favourite_weapon VARCHAR(255)
);
  
