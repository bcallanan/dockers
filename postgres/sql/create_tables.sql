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

--CREATE SEQUENCE customer_seq START 1 INCREMENT 1; -- OWNED BY customer.customer_id;
CREATE TABLE IF NOT EXISTS customer (
  customer_id SERIAL,
  name varchar(100) DEFAULT NULL,
  email_address varchar(100) UNIQUE NOT NULL,
  mobile_number varchar(20) DEFAULT NULL,
  pwd varchar(200) NOT NULL,
  role varchar(50) NOT NULL,
  create_date TIMESTAMP(6) DEFAULT NULL,
  PRIMARY KEY (customer_id)
);
CREATE TABLE IF NOT EXISTS accounts (
  customer_id INT NOT NULL,
  account_number SERIAL,
  account_type SMALLINT, --VARCHAR(100) UNIQUE NOT NULL,
  branch_address varchar(200) NOT NULL,
  create_date TIMESTAMP(6) DEFAULT NULL,
  PRIMARY KEY (account_number),
  CONSTRAINT fk_customer_id
      FOREIGN KEY( customer_id )
	  REFERENCES customer( customer_id ) on DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS account_transactions (
  transaction_id SERIAL,
  account_number INT NOT NULL,
  customer_id INT NOT NULL,
  transaction_date TIMESTAMP(6) NOT NULL,
  transaction_summary VARCHAR(200) NOT NULL,
  transaction_type SMALLINT,--VARCHAR(100) NOT NULL,
  transaction_amount INT NOT NULL,
  closing_balance INT NOT NULL,
  create_date TIMESTAMP(6) DEFAULT NULL,
  PRIMARY KEY (transaction_id),
  CONSTRAINT fk_account_number 
      FOREIGN KEY( account_number )
	  REFERENCES accounts ( account_number ) on DELETE CASCADE,
  CONSTRAINT fk_customer_id
      FOREIGN KEY( customer_id )
	  REFERENCES customer ( customer_id ) on DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS cards (
  card_id SERIAL,
  card_number VARCHAR(20) NOT NULL,
  customer_id INT NOT NULL,
  card_type SMALLINT, --VARCHAR(100) NOT NULL,
  card_limit INT NOT NULL,
  amount_outstanding INT NOT NULL,
  amount_available INT NOT NULL,
  create_date TIMESTAMP(6) DEFAULT NULL,
  PRIMARY KEY (card_id),
  CONSTRAINT fk_customer_id
      FOREIGN KEY( customer_id )
	  REFERENCES customer ( customer_id ) on DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS loans (
  loan_number SERIAL,
  customer_id INT NOT NULL,
  start_date TIMESTAMP(6) NOT NULL,
  loan_type SMALLINT, --VARCHAR(100) NOT NULL,
  total_loan_value INT NOT NULL,
  amount_paid INT NOT NULL,
  outstanding_balance INT NOT NULL,
  create_date TIMESTAMP(6) DEFAULT NULL,
  PRIMARY KEY (loan_number),
  CONSTRAINT fk_customer_id
      FOREIGN KEY( customer_id )
	  REFERENCES customer ( customer_id ) on DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS notice_details (
  notice_id SERIAL,
  notice_summary VARCHAR(200) NOT NULL,
  notice_details VARCHAR(500) NOT NULL,
  notice_begin_date TIMESTAMP(6) NOT NULL,
  notice_end_date TIMESTAMP(6) DEFAULT NULL,
  create_date TIMESTAMP(6) DEFAULT NULL,
  update_date TIMESTAMP(6) DEFAULT NULL,
  PRIMARY KEY (notice_id)
);
CREATE TABLE IF NOT EXISTS contact_messages (
  contact_id VARCHAR(100) NOT NULL,
  contact_name VARCHAR(100) NOT NULL,
  contact_email VARCHAR(100) NOT NULL,
  subject VARCHAR(500) NOT NULL,
  message VARCHAR(2000) NOT NULL,
  create_date TIMESTAMP(6) DEFAULT NULL,
  PRIMARY KEY (contact_id)
);

CREATE TABLE IF NOT EXISTS users (
  user_id INT NOT NULL,
  username varchar(50) not null,
  password varchar(500) not null,
  enabled boolean not null,
  PRIMARY KEY (user_id)
);
  
create table authorities (
   authority_id SERIAL,
   customer_id INT not null,
   authority_type_action varchar(50) not null,
   PRIMARY KEY ( authority_id ),
   CONSTRAINT fk_customer_id
      FOREIGN KEY( customer_id )
	  REFERENCES customer ( customer_id )
);

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

CREATE DATABASE pgbatchdb;
\c pgbatchdb;

CREATE TABLE BATCH_JOB_INSTANCE  (
	JOB_INSTANCE_ID BIGINT  NOT NULL PRIMARY KEY ,
	VERSION BIGINT ,
	JOB_NAME VARCHAR(100) NOT NULL,
	JOB_KEY VARCHAR(32) NOT NULL,
	constraint JOB_INST_UN unique (JOB_NAME, JOB_KEY)
) ;

CREATE TABLE BATCH_JOB_EXECUTION  (
	JOB_EXECUTION_ID BIGINT  NOT NULL PRIMARY KEY ,
	VERSION BIGINT  ,
	JOB_INSTANCE_ID BIGINT NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	START_TIME TIMESTAMP DEFAULT NULL ,
	END_TIME TIMESTAMP DEFAULT NULL ,
	STATUS VARCHAR(10) ,
	EXIT_CODE VARCHAR(2500) ,
	EXIT_MESSAGE VARCHAR(2500) ,
	LAST_UPDATED TIMESTAMP,
	constraint JOB_INST_EXEC_FK foreign key (JOB_INSTANCE_ID)
	references BATCH_JOB_INSTANCE(JOB_INSTANCE_ID)
) ;

CREATE TABLE BATCH_JOB_EXECUTION_PARAMS  (
	JOB_EXECUTION_ID BIGINT NOT NULL ,
	PARAMETER_NAME VARCHAR(100) NOT NULL ,
	PARAMETER_TYPE VARCHAR(100) NOT NULL ,
	PARAMETER_VALUE VARCHAR(2500) ,
	IDENTIFYING CHAR(1) NOT NULL ,
	constraint JOB_EXEC_PARAMS_FK foreign key (JOB_EXECUTION_ID)
	references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
) ;

CREATE TABLE BATCH_STEP_EXECUTION  (
	STEP_EXECUTION_ID BIGINT  NOT NULL PRIMARY KEY ,
	VERSION BIGINT NOT NULL,
	STEP_NAME VARCHAR(100) NOT NULL,
	JOB_EXECUTION_ID BIGINT NOT NULL,
	CREATE_TIME TIMESTAMP NOT NULL,
	START_TIME TIMESTAMP DEFAULT NULL ,
	END_TIME TIMESTAMP DEFAULT NULL ,
	STATUS VARCHAR(10) ,
	COMMIT_COUNT BIGINT ,
	READ_COUNT BIGINT ,
	FILTER_COUNT BIGINT ,
	WRITE_COUNT BIGINT ,
	READ_SKIP_COUNT BIGINT ,
	WRITE_SKIP_COUNT BIGINT ,
	PROCESS_SKIP_COUNT BIGINT ,
	ROLLBACK_COUNT BIGINT ,
	EXIT_CODE VARCHAR(2500) ,
	EXIT_MESSAGE VARCHAR(2500) ,
	LAST_UPDATED TIMESTAMP,
	constraint JOB_EXEC_STEP_FK foreign key (JOB_EXECUTION_ID)
	references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
) ;

CREATE TABLE BATCH_STEP_EXECUTION_CONTEXT  (
	STEP_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
	SHORT_CONTEXT VARCHAR(2500) NOT NULL,
	SERIALIZED_CONTEXT TEXT ,
	constraint STEP_EXEC_CTX_FK foreign key (STEP_EXECUTION_ID)
	references BATCH_STEP_EXECUTION(STEP_EXECUTION_ID)
) ;

CREATE TABLE BATCH_JOB_EXECUTION_CONTEXT  (
	JOB_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
	SHORT_CONTEXT VARCHAR(2500) NOT NULL,
	SERIALIZED_CONTEXT TEXT ,
	constraint JOB_EXEC_CTX_FK foreign key (JOB_EXECUTION_ID)
	references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
) ;

CREATE SEQUENCE BATCH_STEP_EXECUTION_SEQ MAXVALUE 9223372036854775807 NO CYCLE;
CREATE SEQUENCE BATCH_JOB_EXECUTION_SEQ MAXVALUE 9223372036854775807 NO CYCLE;
CREATE SEQUENCE BATCH_JOB_SEQ MAXVALUE 9223372036854775807 NO CYCLE;
