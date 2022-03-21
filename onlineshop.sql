drop database if exists onlineshop;
create database onlineshop;
use onlineshop;
create table 	ort(
ort_id		integer not null auto_increment,
ort			varchar(30) not null,
plz 		integer not null,
primary key(ort_id)
);
create table kunde(
kunde_id	integer not null auto_increment,
name	varchar(20) not null,
vorname varchar(20) not null,
email	varchar(40) not null,
geburtstag	date not null,
strasse	varchar(40) not null,
ort_id	integer not null,
login	varchar(20) not null unique,
passwort	varchar(20) not null,
primary key(kunde_id),
foreign key(ort_id) references ort(ort_id) on update cascade on delete cascade
);
create table kategorie(
kategorie_id	integer not null auto_increment,
name	varchar(30) not null,
beschreibung	text not null,
primary key(kategorie_id)
);
create table produkte(
produkt_id	integer not null auto_increment,
name	varchar(30) not null,
beschreibung	text not null,
anzahl	integer not null,
preis	decimal(8,2) not null,
kategorie_id	integer not null,
primary key(produkt_id),
foreign key(kategorie_id) references kategorie(kategorie_id) on update cascade on delete cascade
);
create table bestellung(
bestellung_id	integer not null auto_increment,
kunde_id	integer not null,
bestelldatum	datetime not null default current_timestamp,
lieferart	enum('lieferung','abholen') not null default 'abholen',
uebergabedatum	datetime,
bezahldatum	datetime,
primary key(bestellung_id),
foreign key(kunde_id) references kunde(kunde_id) on update cascade on delete cascade
);
create table warenkorb(
warenkorb_id	integer not null auto_increment,
produkt_id	integer not null,
bestellung_id	integer not null,
anzahl integer not null,
primary key(warenkorb_id),
foreign key(produkt_id) references produkte(produkt_id) on update cascade on delete cascade,
foreign key(bestellung_id) references bestellung(bestellung_id) on update cascade on delete cascade
);
#Indexe definieren
CREATE INDEX ort_id_index
ON kunde (ort_id);
CREATE INDEX kategorie_id_index
ON produkte (kategorie_id);
CREATE INDEX kunde_id_index
ON bestellung (kunde_id);
CREATE INDEX produkt_id_index
ON warenkorb (produkt_id);
CREATE INDEX bestellung_id_index
ON warenkorb (bestellung_id);
CREATE INDEX name_kunde_index
ON kunde (name);
CREATE INDEX vorname_kunde_index
ON kunde (vorname);
CREATE INDEX name_produkte_index
ON produkte (name);
CREATE INDEX anzahl_produkte_index
ON produkte (anzahl);
CREATE INDEX preis_produkte_index
ON produkte (preis);
CREATE INDEX name_kategorie_index
ON kategorie (name);