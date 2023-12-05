-- Creation of product table
CREATE TABLE IF NOT EXISTS product (
  product_id INT NOT NULL,
  name varchar(250) NOT NULL,
  PRIMARY KEY (product_id)
);

-- Creation of country table
CREATE TABLE IF NOT EXISTS country (
  country_id INT NOT NULL,
  country_name varchar(450) NOT NULL,
  PRIMARY KEY (country_id)
);

-- Creation of city table
CREATE TABLE IF NOT EXISTS city (
  city_id INT NOT NULL,
  city_name varchar(450) NOT NULL,
  country_id INT NOT NULL,
  PRIMARY KEY (city_id),
  CONSTRAINT fk_country
      FOREIGN KEY(country_id) 
	  REFERENCES country(country_id)
);

-- Creation of store table
CREATE TABLE IF NOT EXISTS store (
  store_id INT NOT NULL,
  name varchar(250) NOT NULL,
  city_id INT NOT NULL,
  PRIMARY KEY (store_id),
  CONSTRAINT fk_city
      FOREIGN KEY(city_id) 
	  REFERENCES city(city_id)
);

CREATE SEQUENCE customer_seq START 1 INCREMENT 1; -- OWNED BY customer.customer_id;
CREATE TABLE IF NOT EXISTS customer (
  customer_id SERIAL,-- INT NOT NULL,
  email_address varchar(50) UNIQUE not null,
  pwd varchar(200) not null,
  role varchar(45) not null,
  PRIMARY KEY (customer_id)
);
CREATE TABLE IF NOT EXISTS card (
  card_id INT NOT NULL,
  card_name varchar(50) not null,
  PRIMARY KEY (card_id)
);

CREATE TABLE IF NOT EXISTS users (
  user_id INT NOT NULL,
  username varchar(50) not null,
  password varchar(500) not null,
  enabled boolean not null,
  PRIMARY KEY (user_id)
);
  
create table authorities (
   user_id INT NOT NULL primary key,
   username varchar(50) not null,
   authority varchar(50) not null,
   constraint fk_authorities_users foreign key(user_id) references users(user_id));
CREATE UNIQUE INDEX ix_auth_username ON authorities (user_id,authority);

-- Creation of user table
--CREATE TABLE IF NOT EXISTS users (
--  user_id INT NOT NULL,
--  name varchar(250) NOT NULL,
--  PRIMARY KEY (user_id)
--);

-- Creation of status_name table
CREATE TABLE IF NOT EXISTS status_name (
  status_name_id INT NOT NULL,
  status_name varchar(450) NOT NULL,
  PRIMARY KEY (status_name_id)
);

-- Creation of sale table
CREATE TABLE IF NOT EXISTS sale (
  sale_id varchar(200) NOT NULL,
  amount DECIMAL(20,3) NOT NULL,
  date_sale TIMESTAMP,
  product_id INT NOT NULL,
  user_id INT NOT NULL,
  store_id INT NOT NULL, 
  PRIMARY KEY (sale_id),
  CONSTRAINT fk_product
      FOREIGN KEY(product_id) 
	  REFERENCES product(product_id),
  CONSTRAINT fk_user
      FOREIGN KEY( user_id ) 
	  REFERENCES users( user_id),
  CONSTRAINT fk_store
      FOREIGN KEY(store_id) 
	  REFERENCES store(store_id)	  
);

-- Creation of order_status table
CREATE TABLE IF NOT EXISTS order_status (
  order_status_id varchar(200) NOT NULL,
  update_at TIMESTAMP,
  sale_id varchar(200) NOT NULL,
  status_name_id INT NOT NULL,
  PRIMARY KEY (order_status_id),
  CONSTRAINT fk_sale
      FOREIGN KEY(sale_id) 
	  REFERENCES sale(sale_id),
  CONSTRAINT fk_status_name
      FOREIGN KEY(status_name_id) 
	  REFERENCES status_name(status_name_id)  
);

