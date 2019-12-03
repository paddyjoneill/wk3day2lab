DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  price INT,
  bedrooms INT,
  year_built INT,
  buy_let VARCHAR(255),
  square_footage INT,
  building_type VARCHAR(255)
);
