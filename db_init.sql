CREATE ROLE dbi WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:Vcvo3GZgX9a0M/lg/h4Iww==$puFi5qmYk1mqoiFyyIs/xGsmOD0ZE5AabxI1nnkuf8A=:7R5OJ9/Gfz5ydyPl5w/cywMtPCrb3TZBNXRTQ+mqF5Y=';

CREATE SCHEMA IF NOT EXISTS dbi
    AUTHORIZATION dbi;
-- Initialisierung der CAP-Beispieldatenbank
-- Schemadefinition und Auffuellen mit Beispieltupel

-- Voraussetzung: SQL-Schema dbi wurde bereits erzeugt mittels
--                create schema dbi;

-- Anlegen der Relationenschemata
create table dbi.customers
(	cid	char(4) not null,
	cname	varchar(13),
	city	varchar(20),
	discnt	dec(4,2),
	primary key (cid)		);

create table dbi.agents
(	aid	char(3) not null,
	aname	varchar(13),
	city	varchar(20),
	percent	int,
	primary key (aid)		);

create table dbi.products
(	pid	char(3) not null,
	pname	varchar(13),
	city	varchar(20),
	quantity int,
	price	dec(10,2),
	primary key (pid)		);

create table dbi.orders
(	ordno	int not null,
	month	char(3),
	cid	char(4),
	aid	char(3),
	pid	char(3),
	qty	int,
	dollars	dec(10,2),
	primary key (ordno),
	foreign key (cid) references dbi.customers,
	foreign key (aid) references dbi.agents,
	foreign key (pid) references dbi.products );

-- Einfuegen aller Tupel aus der Beispieldatenbank
insert into dbi.customers
	values ('c001', 'TipTop', 'Duluth', 10.00);
insert into dbi.customers
	values ('c002', 'Basics', 'Dallas', 12.00);
insert into dbi.customers
	values ('c003', 'Allied', 'Dallas', 8.00);
insert into dbi.customers
	values ('c004', 'ACME', 'Duluth', 8.00);
insert into dbi.customers
	values ('c006', 'ACME', 'Kyoto', 0.00);

insert into dbi.agents
	values ('a01', 'Smith', 'New York', 6);
insert into dbi.agents
	values ('a02', 'Jones', 'Newark', 6);
insert into dbi.agents
	values ('a03', 'Brown', 'Tokyo', 7);
insert into dbi.agents
	values ('a04', 'Gray', 'New York', 6);
insert into dbi.agents
	values ('a05', 'Otasi', 'Duluth', 5);
insert into dbi.agents
	values ('a06', 'Smith', 'Dallas', 5);

insert into dbi.products
	values ('p01', 'comb', 'Dallas', 111400, 0.50);
insert into dbi.products
	values ('p02', 'brush', 'Newark', 203000, 0.50);
insert into dbi.products
	values ('p03', 'razor', 'Duluth', 150600, 1.00);
insert into dbi.products
	values ('p04', 'pen', 'Duluth', 125300, 1.00);
insert into dbi.products
	values ('p05', 'pencil', 'Dallas', 221400, 1.00);
insert into dbi.products
	values ('p06', 'folder', 'Dallas', 123100, 2.0);
insert into dbi.products
	values ('p07', 'case', 'Newark', 100500, 1.00);

insert into dbi.orders
	values (1011, 'jan', 'c001', 'a01', 'p01', 1000, 450.00);
insert into dbi.orders
	values (1012, 'jan', 'c001', 'a01', 'p01', 1000, 450.00);
insert into dbi.orders
	values (1019, 'feb', 'c001', 'a02', 'p02', 400, 180.00);
insert into dbi.orders
	values (1017, 'feb', 'c001', 'a06', 'p03', 600, 540.00);
insert into dbi.orders
	values (1018, 'feb', 'c001', 'a03', 'p04', 600, 540.00);
insert into dbi.orders
	values (1023, 'mar', 'c001', 'a04', 'p05', 500, 450.00);
insert into dbi.orders
	values (1022, 'mar', 'c001', 'a05', 'p06', 400, 720.00);
insert into dbi.orders
	values (1025, 'apr', 'c001', 'a05', 'p07', 800, 720.00);
insert into dbi.orders
	values (1013, 'jan', 'c002', 'a03', 'p03', 1000, 880.00);
insert into dbi.orders
	values (1026, 'may', 'c002', 'a05', 'p03', 800, 704.00);
insert into dbi.orders
	values (1015, 'jan', 'c003', 'a03', 'p05', 1200, 1104.00);
insert into dbi.orders
	values (1014, 'jan', 'c003', 'a03', 'p05', 1200, 1104.00);
insert into dbi.orders
	values (1021, 'feb', 'c004', 'a06', 'p01', 1000, 460.00);
insert into dbi.orders
	values (1016, 'jan', 'c006', 'a01', 'p01', 1000, 500.00);
insert into dbi.orders
	values (1020, 'feb', 'c006', 'a03', 'p07', 600, 600.00);
insert into dbi.orders
	values (1024, 'mar', 'c006', 'a06', 'p01', 800, 400.00);

-- Rechtevergabe an allgemeine Nutzer
grant select on dbi.customers to public;
grant select on dbi.agents    to public;
grant select on dbi.products  to public;
grant select on dbi.orders    to public;

commit;
