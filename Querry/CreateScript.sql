/* Create Table Script */
USE MASTER

drop database fletnix
go

create database fletnix
go

USE fletnix
GO

create table Movie(
	movie_id INTEGER NOT NULL,
	title VARCHAR(255) NOT NULL,
	duration INTEGER NOT NULL,
	[description] VARCHAR(255),
	publication_year INTEGER,
	cover_image VARCHAR (255) NOT NULL,
	previous_part INTEGER,
	price NUMERIC(5,2) NOT NULL,
	movie_url VARCHAR(255),

	CONSTRAINT pk_movie PRIMARY KEY (movie_ID)
);

create table Movie_persons(
	person_id INTEGER NOT NULL,
	lastname VARCHAR(50) NOT NULL,
	firstname VARCHAR(50) NOT NULL,
	gender CHAR(1),

	CONSTRAINT pk_person PRIMARY KEY (person_id)
);

create table Movie_cast(
	movie_id INTEGER NOT NULL,
	person_id INTEGER NOT NULL,
	[role] VARCHAR(255) NOT NULL,

	CONSTRAINT pk_cast PRIMARY KEY (movie_id, person_id, [role])
);

create table Movie_directors(
	movie_id INTEGER NOT NULL,
	person_id INTEGER NOT NULL,

	CONSTRAINT pk_directors PRIMARY KEY (movie_id, person_id)
);

create table Movie_genredesc(
	genre_name VARCHAR(255) NOT NULL,
	genre_desc VARCHAR(255) NOT NULL,

	CONSTRAINT pk_genredesc PRIMARY KEY (genre_name)
);

create table Movie_genre(
	movie_id INTEGER NOT NULL,
	genre_name VARCHAR(255) NOT NULL,

	CONSTRAINT pk_movie_genre PRIMARY KEY (movie_id, genre_name)
);

create table Customer_payment(
	payment_method VARCHAR(10) NOT NULL,

	CONSTRAINT pk_payment PRIMARY KEY (payment_method)
);

create table Customer_contract(
	contract_type VARCHAR(10) NOT NULL,
	price_monthly NUMERIC(5,2) NOT NULL,
	discount_percent NUMERIC(2) NOT NULL,

	CONSTRAINT pk_contract PRIMARY KEY (contract_type)
);

create table Customer_country(
	country_name VARCHAR(50) NOT NULL,

	CONSTRAINT pk_country PRIMARY KEY (country_name)
);

create table Customer(
	customer_mail VARCHAR(255) NOT NULL,
	lastname VARCHAR(255) NOT NULL,
	firstname VARCHAR(255) NOT NULL,
	payment_method VARCHAR(10) NOT NULL,
	payment_card_num VARCHAR(30) NOT NULL,
	contract_type VARCHAR(10) NOT NULL,
	subscript_start DATE NOT NULL,
	subscript_end DATE,
	[user_name] VARCHAR(30) NOT NULL,
	[password] VARCHAR(50) NOT NULL,
	country_name VARCHAR(50) NOT NULL,
	gender CHAR(1),
	birth_date DATE,

	CONSTRAINT pk_customer PRIMARY KEY (customer_mail)
);

create table Customer_watched(
	movie_id INTEGER NOT NULL,
	customer_mail VARCHAR(255) NOT NULL,
	watch_date DATE NOT NULL,
	price NUMERIC(5,2) NOT NULL,
	invoiced BIT NOT NULL,

	CONSTRAINT pk_watched PRIMARY KEY (movie_id, customer_mail, watch_date)
);


/* Foreign Keys*/

ALTER TABLE Movie
	ADD CONSTRAINT fk_previousPart_movieID 
	FOREIGN KEY (previous_part) REFERENCES Movie (movie_id);

ALTER TABLE Movie_cast
	ADD 
		CONSTRAINT fk_Cast_Movie
		FOREIGN KEY (movie_id) REFERENCES Movie (movie_id),

		CONSTRAINT fk_Cast_Person
		FOREIGN KEY (person_id) REFERENCES Movie_persons (person_id);

ALTER TABLE Movie_directors
	ADD 
		CONSTRAINT fk_Director_Movie
		FOREIGN KEY (movie_id) REFERENCES Movie (movie_id),

		CONSTRAINT fk_Director_Person
		FOREIGN KEY (person_id) REFERENCES Movie_persons (person_id);

ALTER TABLE Movie_genre
	ADD 
		CONSTRAINT fk_Genre_Movie
		FOREIGN KEY (movie_id) REFERENCES Movie (movie_id),

		CONSTRAINT fk_Genre_GenreDesc
		FOREIGN KEY (genre_name) REFERENCES Movie_genredesc (genre_name);

ALTER TABLE Customer_watched
	ADD 
		CONSTRAINT fk_Watched_Movie
		FOREIGN KEY (movie_id) REFERENCES Movie (movie_id),

		CONSTRAINT fk_Watched_Customer
		FOREIGN KEY (customer_mail) REFERENCES Customer (customer_mail);

ALTER TABLE Customer
	ADD 
		CONSTRAINT fk_Customer_Payment
		FOREIGN KEY (payment_method) REFERENCES Customer_payment (payment_method),

		CONSTRAINT fk_Customer_Contract
		FOREIGN KEY (contract_type) REFERENCES Customer_contract (contract_type),

		CONSTRAINT fk_Customer_Country
		FOREIGN KEY (country_name) REFERENCES Customer_country (country_name);