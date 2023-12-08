-- Set params
set session my.number_of_sales = '100';
set session my.number_of_users = '100';
set session my.number_of_products = '100';
set session my.number_of_stores = '100';
set session my.number_of_coutries = '100';
set session my.number_of_cities = '30';
set session my.status_names = '5';
set session my.start_date = '2019-01-01 00:00:00';
set session my.end_date = '2020-02-01 00:00:00';
set session my.password = 'password';

-- load the pgcrypto extension to gen_random_uuid ()
CREATE EXTENSION pgcrypto;

-- Filling of products
INSERT INTO product
select id, concat('Product ', id) 
FROM GENERATE_SERIES(1, current_setting('my.number_of_products')::int) as id;

-- Filling of countries
INSERT INTO country
select id, concat('Country ', id) 
FROM GENERATE_SERIES(1, current_setting('my.number_of_coutries')::int) as id;

-- Filling of cities
INSERT INTO city
select id
	, concat('City ', id)
	, floor(random() * (current_setting('my.number_of_coutries')::int) + 1)::int
FROM GENERATE_SERIES(1, current_setting('my.number_of_cities')::int) as id;

-- Filling of stores
INSERT INTO store
select id
	, concat('Store ', id)
	, floor(random() * (current_setting('my.number_of_cities')::int) + 1)::int
FROM GENERATE_SERIES(1, current_setting('my.number_of_stores')::int) as id;

-- Filling of users
INSERT INTO users VALUES (1, 'brian', 'password', '1');


--INSERT INTO customer VALUES ( NEXTVAL('customer_seq'), 'callanankids@gmail.com', 'password', 'admin');
INSERT INTO authorities VALUES (1, 'brian', 'admin');

select id, concat('User ', id), current_setting('my.password'), '1'
FROM GENERATE_SERIES(2, current_setting('my.number_of_users')::int) as id;
INSERT INTO users
select id,
	 concat('User ', id),
 	 current_setting('my.password'),
	 '1'
FROM GENERATE_SERIES(2, current_setting('my.number_of_users')::int) as id;

-- Filling of status
INSERT INTO status_name
select status_name_id
	, concat('Status Name ', status_name_id)
FROM GENERATE_SERIES(1, current_setting('my.status_names')::int) as status_name_id;

-- Filling of sales  
INSERT INTO sale
select gen_random_uuid ()
	, round(CAST(float8 (random() * 10000) as numeric), 3)
	, TO_TIMESTAMP(start_date, 'YYYY-MM-DD HH24:MI:SS') +
		random()* (TO_TIMESTAMP(end_date, 'YYYY-MM-DD HH24:MI:SS') 
							- TO_TIMESTAMP(start_date, 'YYYY-MM-DD HH24:MI:SS'))
	, floor(random() * (current_setting('my.number_of_products')::int) + 1)::int
	, floor(random() * (current_setting('my.number_of_users')::int) + 1)::int
	, floor(random() * (current_setting('my.number_of_stores')::int) + 1)::int
FROM GENERATE_SERIES(1, current_setting('my.number_of_sales')::int) as id
	, current_setting('my.start_date') as start_date
	, current_setting('my.end_date') as end_date;

-- Filling of order_status  
INSERT INTO order_status
select gen_random_uuid ()
	, date_sale + random()* (date_sale + '5 days' - date_sale)
	, sale_id
	, floor(random() * (current_setting('my.status_names')::int) + 1)::int
from sale;

INSERT INTO notice_details ( notice_summary, notice_details, notice_begin_date, notice_end_date, create_date, update_date)
VALUES ('Home Loan Interest rates reduced', 'Home loan interest rates are reduced as per the goverment guidelines. The updated rates will be effective immediately',
NOW() - INTERVAL '30 DAY', NOW() + INTERVAL '30 DAY', NOW(), null);

INSERT INTO notice_details ( notice_summary, notice_details, notice_begin_date, notice_end_date, create_date, update_date)
VALUES ('Net Banking Offers', 'Customers who will opt for Internet banking while opening a saving account will get a $50 amazon voucher',
NOW() - INTERVAL '30 DAY', NOW() + INTERVAL '30 DAY', NOW(), null);

INSERT INTO notice_details ( notice_summary, notice_details, notice_begin_date, notice_end_date, create_date, update_date)
VALUES ('Mobile App Downtime', 'The mobile application of the EazyBank will be down from 2AM-5AM on 12/05/2020 due to maintenance activities',
NOW() - INTERVAL '30 DAY', NOW() + INTERVAL '30 DAY', NOW(), null);

INSERT INTO notice_details ( notice_summary, notice_details, notice_begin_date, notice_end_date, create_date, update_date)
VALUES ('E Auction notice', 'There will be a e-auction on 12/08/2020 on the Bank website for all the stubborn arrears.Interested parties can participate in the e-auction',
NOW() - INTERVAL '30 DAY', NOW() + INTERVAL '30 DAY', NOW(), null);

INSERT INTO notice_details ( notice_summary, notice_details, notice_begin_date, notice_end_date, create_date, update_date)
VALUES ('Launch of Millennia Cards', 'Millennia Credit Cards are launched for the premium customers of EazyBank. With these cards, you will get 5% cashback for each purchase',
NOW() - INTERVAL '30 DAY', NOW() + INTERVAL '30 DAY', NOW(), null);

INSERT INTO notice_details ( notice_summary, notice_details, notice_begin_date, notice_end_date, create_date, update_date)
VALUES ('COVID-19 Insurance', 'EazyBank launched an insurance policy which will cover COVID-19 expenses. Please reach out to the branch for more details',
NOW() - INTERVAL '30 DAY', NOW() + INTERVAL '30 DAY', NOW(), null);
