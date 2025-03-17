create database BookStoreExample_SP25;

use BookStoreExample_SP25;

create table PhoneNumber(
	phone_ID int identity(1000, 1) primary key,
	area_code char(3) not null,
	prefix char(3) not null,
	postfix char(4) not null
);

create table Address(
	address_ID int identity(10000, 1) primary key,
	street_number varchar(16) not null,
	street_name varchar(128) not null,
	city varchar(128) not null,
	state_name varchar(64) not null,
	zipcode char(10) not null
);

create table email(
	email_ID int identity(20000, 1) primary key,
	email_address varchar(128) not null,
	domain varchar(128) not null
);

create table Authors(
	Author_ID int identity(30000, 1) primary key,
	LastName varchar(128) not null,
	FirstName varchar(128) not null,
	Biography text
);

create table AuthorPhoneNumber(
	Author_ID int foreign key references Authors(Author_ID),
	Phone_ID int foreign key references PhoneNumber(Phone_ID),
	PrimaryNumber bit,
	Primary key (Author_ID, Phone_ID)
);

create table AuthorAddress(
	Author_ID int foreign key references Authors(Author_ID),
	Address_ID int foreign key references Address(Address_ID),
	PrimaryAddress bit,
	ShippingAddress bit,
	Primary key (Author_ID, Address_ID)
);

create table AuthorEmail(
	Author_ID int foreign key references Authors(Author_ID),
	Email_ID int foreign key references email(Email_ID),
	PrimaryEmail bit,
	Primary key (Author_ID, Email_ID)
);

create table Customers(
	Customer_ID int identity(40000, 1) primary key,
	LastName varchar(128) not null,
	FirstName varchar(128) not null,
);

create table CustomerPhoneNumber(
	Customer_ID int foreign key references Customers(Customer_ID),
	Phone_ID int foreign key references PhoneNumber(Phone_ID),
	PrimaryNumber bit,
	Primary key (Customer_ID, Phone_ID)
);

create table CustomerAddress(
	Customer_ID int foreign key references Customers(Customer_ID),
	Address_ID int foreign key references Address(Address_ID),
	PrimaryAddress bit,
	ShippingAddress bit,
	Primary key (Customer_ID, Address_ID)
);

create table CustomerEmail(
	Customer_ID int foreign key references Customers(Customer_ID),
	Email_ID int foreign key references email(Email_ID),
	PrimaryEmail bit,
	Primary key (Customer_ID, Email_ID)
);

create table PaymentInformation(
	Payment_ID int identity(50000, 1) primary key,
	Customer_ID int foreign key references Customers(Customer_ID),
	PaymentType int not null,
	AccountNumber varchar(128) not null,
	cvv varchar(8),
	ExpriationDate date
);

create table Publishers(
	Publisher_ID int identity(50000, 1) primary key,
	CompanyName varchar(128) not null
);

create table PublisherPhoneNumber(
	Publisher_ID int foreign key references Publishers(Publisher_ID),
	Phone_ID int foreign key references PhoneNumber(Phone_ID),
	PrimaryNumber bit,
	Primary key (Publisher_ID, Phone_ID)
);

create table PublisherAddress(
	Publisher_ID int foreign key references Publishers(Publisher_ID),
	Address_ID int foreign key references Address(Address_ID),
	PrimaryAddress bit,
	ShippingAddress bit,
	Primary key (Publisher_ID, Address_ID)
);

create table PublisherEmail(
	Publisher_ID int foreign key references Publishers(Publisher_ID),
	Email_ID int foreign key references email(Email_ID),
	PrimaryEmail bit,
	Primary key (Publisher_ID, Email_ID)
);

create table Books(
	ISBN char(13) primary key,
	Title varchar(128) not null,
	Price money not null,
	BookDescription text,
	Edition varchar(8)
);

create table Categories(
	Category_ID int identity(60000, 1) primary key,
	CategoryName varchar(128) not null,
	CategoryDescription text
);

create table BookCategories(
	ISBN char(13) foreign key references Books(ISBN),
	Category_ID int foreign key references Categories(Category_ID),
	primary key (ISBN, Category_ID)
);

create table Location(
	Location_ID int identity(70000, 1) primary key
);

create table LocationPhoneNumber(
	Location_ID int foreign key references Location(Location_ID),
	Phone_ID int foreign key references PhoneNumber(Phone_ID),
	PrimaryNumber bit,
	Primary key (Location_ID, Phone_ID)
);

create table LocationAddress(
	Location_ID int foreign key references Location(Location_ID),
	Address_ID int foreign key references Address(Address_ID),
	PrimaryAddress bit,
	ShippingAddress bit,
	Primary key (Location_ID, Address_ID)
);

create table LocationEmail(
	Location_ID int foreign key references Location(Location_ID),
	Email_ID int foreign key references email(Email_ID),
	PrimaryEmail bit,
	Primary key (Location_ID, Email_ID)
);

create table Inventory(
	Inventory_ID int identity(80000, 1) primary key,
	ISBN char(13) foreign key references Books(ISBN),
	Location_ID int foreign key references Location(Location_ID),
	Quantity int not null,
	DateOfRecord date not null
);

-- Insert sample phone numbers (phone_ID values start at 1000)
INSERT INTO PhoneNumber (area_code, prefix, postfix) VALUES
('212', '555', '1234'),   -- phone_ID = 1000
('310', '555', '5678'),   -- phone_ID = 1001
('415', '555', '9012'),   -- phone_ID = 1002
('202', '555', '3456'),   -- phone_ID = 1003
('646', '555', '7890');   -- phone_ID = 1004

-- Insert sample addresses (address_ID values start at 10000)
INSERT INTO Address (street_number, street_name, city, state_name, zipcode) VALUES
('123', 'Main St', 'New York', 'NY', '10001'),       -- address_ID = 10000
('456', 'Broadway', 'Los Angeles', 'CA', '90001'),     -- address_ID = 10001
('789', 'Market St', 'San Francisco', 'CA', '94103'),  -- address_ID = 10002
('101', 'Penn Ave', 'Philadelphia', 'PA', '19103'),     -- address_ID = 10003
('202', '5th Ave', 'New York', 'NY', '10022');          -- address_ID = 10004

-- Insert sample emails (email_ID values start at 20000)
INSERT INTO email (email_address, domain) VALUES
('jdoe', 'example.com'),       -- email_ID = 20000
('asmith', 'mail.com'),        -- email_ID = 20001
('publisher1', 'books.com'),   -- email_ID = 20002
('customer1', 'gmail.com'),    -- email_ID = 20003
('author2', 'writers.org');    -- email_ID = 20004

-- Insert sample authors (Author_ID values start at 30000)
INSERT INTO Authors (LastName, FirstName, Biography) VALUES
('Doe', 'John', 'John Doe is a prolific author of mystery novels.'),       -- Author_ID = 30000
('Smith', 'Alice', 'Alice Smith writes science fiction stories.');         -- Author_ID = 30001

-- Link authors with phone numbers (using assumed phone_ID values)
INSERT INTO AuthorPhoneNumber (Author_ID, Phone_ID, PrimaryNumber) VALUES
(30000, 1000, 1),
(30001, 1002, 1);

-- Link authors with addresses
INSERT INTO AuthorAddress (Author_ID, Address_ID, PrimaryAddress, ShippingAddress) VALUES
(30000, 10000, 1, 0),   -- John Doe: primary address
(30001, 10001, 1, 1);   -- Alice Smith: primary and shipping address

-- Link authors with emails
INSERT INTO AuthorEmail (Author_ID, Email_ID, PrimaryEmail) VALUES
(30000, 20000, 1),
(30001, 20001, 1);

-- Insert sample customers (Customer_ID values start at 40000)
INSERT INTO Customers (LastName, FirstName) VALUES
('Brown', 'Charlie'),   -- Customer_ID = 40000
('Wilson', 'Emma');      -- Customer_ID = 40001

-- Link customers with phone numbers
INSERT INTO CustomerPhoneNumber (Customer_ID, Phone_ID, PrimaryNumber) VALUES
(40000, 1003, 1),
(40001, 1004, 1);

-- Link customers with addresses (using address_IDs 10002 and 10003)
INSERT INTO CustomerAddress (Customer_ID, Address_ID, PrimaryAddress, ShippingAddress) VALUES
(40000, 10002, 1, 1),
(40001, 10003, 1, 0);

-- Link customers with emails (using email_IDs for customer emails)
INSERT INTO CustomerEmail (Customer_ID, Email_ID, PrimaryEmail) VALUES
(40000, 20003, 1),
(40001, 20004, 1);

-- Insert sample payment information
INSERT INTO PaymentInformation (Customer_ID, PaymentType, AccountNumber, cvv, ExpriationDate) VALUES
(40000, 1, '4111111111111111', '123', '2026-12-31'),
(40001, 2, '5500000000000004', '456', '2027-06-30');

-- Insert sample publishers (Publisher_ID values start at 50000)
INSERT INTO Publishers (CompanyName) VALUES
('Penguin Random House'),   -- Publisher_ID = 50000
('HarperCollins');           -- Publisher_ID = 50001

-- Link publishers with phone numbers
INSERT INTO PublisherPhoneNumber (Publisher_ID, Phone_ID, PrimaryNumber) VALUES
(50000, 1001, 1),
(50001, 1002, 1);

-- Link publishers with addresses
INSERT INTO PublisherAddress (Publisher_ID, Address_ID, PrimaryAddress, ShippingAddress) VALUES
(50000, 10004, 1, 0),
(50001, 10000, 1, 1);

-- Link publishers with emails
INSERT INTO PublisherEmail (Publisher_ID, Email_ID, PrimaryEmail) VALUES
(50000, 20002, 1),
(50001, 20000, 1);

-- Insert sample books (ISBN is the primary key)
INSERT INTO Books (ISBN, Title, Price, BookDescription, Edition) VALUES
('9781234567897', 'Mystery of the Old House', 19.99, 'A thrilling mystery novel.', '1st'),
('9789876543210', 'Space Adventures', 24.99, 'An epic journey through the stars.', '2nd');

-- Insert sample categories (Category_ID values start at 60000)
INSERT INTO Categories (CategoryName, CategoryDescription) VALUES
('Mystery', 'Mystery and thriller novels.'),
('Science Fiction', 'Futuristic and space exploration themes.');

-- Link books with categories
INSERT INTO BookCategories (ISBN, Category_ID) VALUES
('9781234567897', 60000),
('9789876543210', 60001);

-- Insert sample locations (Location_ID values start at 70000)
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70000
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70001

-- Link locations with phone numbers
INSERT INTO LocationPhoneNumber (Location_ID, Phone_ID, PrimaryNumber) VALUES
(70000, 1000, 1),
(70001, 1001, 1);

-- Link locations with addresses (using address_IDs 10003 and 10004)
INSERT INTO LocationAddress (Location_ID, Address_ID, PrimaryAddress, ShippingAddress) VALUES
(70000, 10003, 1, 1),
(70001, 10004, 1, 0);

-- Link locations with emails (using email_IDs 20003 and 20004)
INSERT INTO LocationEmail (Location_ID, Email_ID, PrimaryEmail) VALUES
(70000, 20003, 1),
(70001, 20004, 1);

-- Insert sample inventory records
INSERT INTO Inventory (ISBN, Location_ID, Quantity, DateOfRecord) VALUES
('9781234567897', 70000, 50, '2025-03-01'),
('9789876543210', 70001, 30, '2025-03-02');

------------------------------------------------------------
-- 1. Insert 50 Sample Phone Numbers (phone_ID starts at 1000)
------------------------------------------------------------
INSERT INTO PhoneNumber (area_code, prefix, postfix) VALUES
('212','555','0001'),
('212','555','0002'),
('212','555','0003'),
('212','555','0004'),
('212','555','0005'),
('212','555','0006'),
('212','555','0007'),
('212','555','0008'),
('212','555','0009'),
('212','555','0010'),
('310','555','0011'),
('310','555','0012'),
('310','555','0013'),
('310','555','0014'),
('310','555','0015'),
('310','555','0016'),
('310','555','0017'),
('310','555','0018'),
('310','555','0019'),
('310','555','0020'),
('415','555','0021'),
('415','555','0022'),
('415','555','0023'),
('415','555','0024'),
('415','555','0025'),
('415','555','0026'),
('415','555','0027'),
('415','555','0028'),
('415','555','0029'),
('415','555','0030'),
('202','555','0031'),
('202','555','0032'),
('202','555','0033'),
('202','555','0034'),
('202','555','0035'),
('202','555','0036'),
('202','555','0037'),
('202','555','0038'),
('202','555','0039'),
('202','555','0040'),
('646','555','0041'),
('646','555','0042'),
('646','555','0043'),
('646','555','0044'),
('646','555','0045'),
('646','555','0046'),
('646','555','0047'),
('646','555','0048'),
('646','555','0049'),
('646','555','0050');

------------------------------------------------------------
-- 2. Insert 50 Sample Addresses (address_ID starts at 10000)
------------------------------------------------------------
INSERT INTO Address (street_number, street_name, city, state_name, zipcode) VALUES
('10','Main St','New York','NY','10001'),
('20','Broadway','New York','NY','10002'),
('30','Market St','San Francisco','CA','94103'),
('40','Penn Ave','Philadelphia','PA','19103'),
('50','5th Ave','New York','NY','10003'),
('60','Sunset Blvd','Los Angeles','CA','90001'),
('70','Elm St','Boston','MA','02108'),
('80','Oak St','Chicago','IL','60601'),
('90','Maple Ave','Seattle','WA','98101'),
('100','Pine St','Denver','CO','80203'),
('110','Cedar Ln','Austin','TX','73301'),
('120','Spruce St','Miami','FL','33101'),
('130','Birch Rd','Portland','OR','97201'),
('140','Willow Dr','Nashville','TN','37201'),
('150','Ash St','Detroit','MI','48201'),
('160','Cherry Ln','Atlanta','GA','30301'),
('170','Poplar St','Dallas','TX','75201'),
('180','Fir Rd','San Diego','CA','92101'),
('190','Walnut St','Minneapolis','MN','55401'),
('200','Chestnut St','St. Louis','MO','63101'),
('210','Linden St','Baltimore','MD','21201'),
('220','Hickory St','Charlotte','NC','28201'),
('230','Magnolia Blvd','Houston','TX','77001'),
('240','Dogwood Dr','Orlando','FL','32801'),
('250','Sycamore St','Cleveland','OH','44101'),
('260','Mulberry St','Indianapolis','IN','46201'),
('270','Cypress Ave','Phoenix','AZ','85001'),
('280','Sequoia St','Sacramento','CA','95814'),
('290','Redwood Rd','San Jose','CA','95101'),
('300','Palm Dr','Las Vegas','NV','89101'),
('310','Grove St','Raleigh','NC','27601'),
('320','Highland Ave','Columbus','OH','43215'),
('330','River Rd','Kansas City','MO','64101'),
('340','Valley Rd','Cincinnati','OH','45201'),
('350','Summit Ave','Cleveland','OH','44114'),
('360','Meadow Ln','Milwaukee','WI','53202'),
('370','Forest Dr','Tampa','FL','33601'),
('380','Garden St','Orlando','FL','32803'),
('390','Vine St','Richmond','VA','23219'),
('400','Park Ave','Newark','NJ','07102'),
('410','Liberty St','Philadelphia','PA','19104'),
('420','Union St','Providence','RI','02903'),
('430','Front St','New Haven','CT','06510'),
('440','King St','Savannah','GA','31401'),
('450','Queen St','Baltimore','MD','21202'),
('460','Market Ln','Denver','CO','80204'),
('470','Central Ave','Phoenix','AZ','85002'),
('480','East St','Austin','TX','73344'),
('490','West St','Chicago','IL','60602'),
('500','North St','Seattle','WA','98109');

------------------------------------------------------------
-- 3. Insert 50 Sample Emails (email_ID starts at 20000)
------------------------------------------------------------
INSERT INTO email (email_address, domain) VALUES
('user1','example.com'),
('user2','example.com'),
('user3','example.com'),
('user4','example.com'),
('user5','example.com'),
('user6','mail.com'),
('user7','mail.com'),
('user8','mail.com'),
('user9','mail.com'),
('user10','mail.com'),
('contact1','books.com'),
('contact2','books.com'),
('contact3','books.com'),
('contact4','books.com'),
('contact5','books.com'),
('client1','gmail.com'),
('client2','gmail.com'),
('client3','gmail.com'),
('client4','gmail.com'),
('client5','gmail.com'),
('info1','store.com'),
('info2','store.com'),
('info3','store.com'),
('info4','store.com'),
('info5','store.com'),
('author1','writers.org'),
('author2','writers.org'),
('author3','writers.org'),
('author4','writers.org'),
('author5','writers.org'),
('news1','dailynews.com'),
('news2','dailynews.com'),
('news3','dailynews.com'),
('news4','dailynews.com'),
('news5','dailynews.com'),
('service1','service.com'),
('service2','service.com'),
('service3','service.com'),
('service4','service.com'),
('service5','service.com'),
('shop1','onlinestore.com'),
('shop2','onlinestore.com'),
('shop3','onlinestore.com'),
('shop4','onlinestore.com'),
('shop5','onlinestore.com'),
('promo1','promo.com'),
('promo2','promo.com'),
('promo3','promo.com'),
('promo4','promo.com'),
('promo5','promo.com');

------------------------------------------------------------
-- 4. Insert 20 Sample Authors (Author_ID starts at 30000)
------------------------------------------------------------
INSERT INTO Authors (LastName, FirstName, Biography) VALUES
('Anderson','Michael','Michael Anderson writes mystery novels.'),
('Brown','Sarah','Sarah Brown is known for her thrillers.'),
('Clark','David','David Clark has a background in historical fiction.'),
('Davis','Emma','Emma Davis writes science fiction.'),
('Evans','Robert','Robert Evans is a veteran novelist.'),
('Foster','Laura','Laura Foster writes romance and drama.'),
('Garcia','Jose','Jose Garcia is a rising star in horror fiction.'),
('Harris','Olivia','Olivia Harris specializes in children''s books.'),
('Iverson','James','James Iverson is a prolific author of non-fiction.'),
('Jackson','Patricia','Patricia Jackson writes self-help books.'),
('King','William','William King writes epic fantasy sagas.'),
('Lewis','Barbara','Barbara Lewis is a well-known crime novelist.'),
('Martinez','Richard','Richard Martinez writes hardboiled detective stories.'),
('Nelson','Susan','Susan Nelson writes biographical novels.'),
('Ortiz','Charles','Charles Ortiz writes speculative fiction.'),
('Parker','Karen','Karen Parker writes young adult fiction.'),
('Quinn','Steven','Steven Quinn writes philosophical novels.'),
('Roberts','Nancy','Nancy Roberts writes literary fiction.'),
('Smith','Mark','Mark Smith writes adventure novels.'),
('Turner','Linda','Linda Turner writes comedic novels.');

------------------------------------------------------------
-- 5. Insert Sample Author-Contact Data
------------------------------------------------------------
-- Link each author with one phone number, one address and one email (cycling through our sample IDs)
-- For AuthorPhoneNumber (Author_ID from 30000 to 30019, phone_ID chosen from 1000 onward)
INSERT INTO AuthorPhoneNumber (Author_ID, Phone_ID, PrimaryNumber) VALUES
(30000, 1000, 1),
(30001, 1001, 1),
(30002, 1002, 1),
(30003, 1003, 1),
(30004, 1004, 1),
(30005, 1005, 1),
(30006, 1006, 1),
(30007, 1007, 1),
(30008, 1008, 1),
(30009, 1009, 1),
(30010, 1010, 1),
(30011, 1011, 1),
(30012, 1012, 1),
(30013, 1013, 1),
(30014, 1014, 1),
(30015, 1015, 1),
(30016, 1016, 1),
(30017, 1017, 1),
(30018, 1018, 1),
(30019, 1019, 1);

-- Link each author with one address (cycling addresses 10000 upward)
INSERT INTO AuthorAddress (Author_ID, Address_ID, PrimaryAddress, ShippingAddress) VALUES
(30000, 10000, 1, 0),
(30001, 10001, 1, 0),
(30002, 10002, 1, 0),
(30003, 10003, 1, 1),
(30004, 10004, 1, 0),
(30005, 10005, 1, 1),
(30006, 10006, 1, 0),
(30007, 10007, 1, 1),
(30008, 10008, 1, 0),
(30009, 10009, 1, 1),
(30010, 10010, 1, 0),
(30011, 10011, 1, 1),
(30012, 10012, 1, 0),
(30013, 10013, 1, 1),
(30014, 10014, 1, 0),
(30015, 10015, 1, 1),
(30016, 10016, 1, 0),
(30017, 10017, 1, 1),
(30018, 10018, 1, 0),
(30019, 10019, 1, 1);

-- Link each author with one email (using email_IDs starting at 20000)
INSERT INTO AuthorEmail (Author_ID, Email_ID, PrimaryEmail) VALUES
(30000, 20000, 1),
(30001, 20001, 1),
(30002, 20002, 1),
(30003, 20003, 1),
(30004, 20004, 1),
(30005, 20005, 1),
(30006, 20006, 1),
(30007, 20007, 1),
(30008, 20008, 1),
(30009, 20009, 1),
(30010, 20010, 1),
(30011, 20011, 1),
(30012, 20012, 1),
(30013, 20013, 1),
(30014, 20014, 1),
(30015, 20015, 1),
(30016, 20016, 1),
(30017, 20017, 1),
(30018, 20018, 1),
(30019, 20019, 1);

------------------------------------------------------------
-- 6. Insert 20 Sample Customers (Customer_ID starts at 40000)
------------------------------------------------------------
INSERT INTO Customers (LastName, FirstName) VALUES
('Miller','James'),
('Wilson','Patricia'),
('Moore','Robert'),
('Taylor','Linda'),
('Anderson','Michael'),
('Thomas','Barbara'),
('Jackson','William'),
('White','Elizabeth'),
('Harris','David'),
('Martin','Jennifer'),
('Thompson','Richard'),
('Garcia','Maria'),
('Martinez','Joseph'),
('Robinson','Susan'),
('Clark','Charles'),
('Rodriguez','Margaret'),
('Lewis','Christopher'),
('Lee','Karen'),
('Walker','Daniel'),
('Hall','Nancy');

------------------------------------------------------------
-- 7. Insert Sample Customer-Contact Data
------------------------------------------------------------
-- Link customers with phone numbers (assigning phone_IDs from 1020 upward)
INSERT INTO CustomerPhoneNumber (Customer_ID, Phone_ID, PrimaryNumber) VALUES
(40000, 1020, 1),
(40001, 1021, 1),
(40002, 1022, 1),
(40003, 1023, 1),
(40004, 1024, 1),
(40005, 1025, 1),
(40006, 1026, 1),
(40007, 1027, 1),
(40008, 1028, 1),
(40009, 1029, 1),
(40010, 1030, 1),
(40011, 1031, 1),
(40012, 1032, 1),
(40013, 1033, 1),
(40014, 1034, 1),
(40015, 1035, 1),
(40016, 1036, 1),
(40017, 1037, 1),
(40018, 1038, 1),
(40019, 1039, 1);

-- Link customers with addresses (using address_IDs 10020 upward)
INSERT INTO CustomerAddress (Customer_ID, Address_ID, PrimaryAddress, ShippingAddress) VALUES
(40000, 10020, 1, 1),
(40001, 10021, 1, 0),
(40002, 10022, 1, 1),
(40003, 10023, 1, 0),
(40004, 10024, 1, 1),
(40005, 10025, 1, 0),
(40006, 10026, 1, 1),
(40007, 10027, 1, 0),
(40008, 10028, 1, 1),
(40009, 10029, 1, 0),
(40010, 10030, 1, 1),
(40011, 10031, 1, 0),
(40012, 10032, 1, 1),
(40013, 10033, 1, 0),
(40014, 10034, 1, 1),
(40015, 10035, 1, 0),
(40016, 10036, 1, 1),
(40017, 10037, 1, 0),
(40018, 10038, 1, 1),
(40019, 10039, 1, 0);

-- Link customers with emails (using email_IDs 2020 upward)
INSERT INTO CustomerEmail (Customer_ID, Email_ID, PrimaryEmail) VALUES
(40000, 2020, 1),
(40001, 2021, 1),
(40002, 2022, 1),
(40003, 2023, 1),
(40004, 2024, 1),
(40005, 2025, 1),
(40006, 2026, 1),
(40007, 2027, 1),
(40008, 2028, 1),
(40009, 2029, 1),
(40010, 2030, 1),
(40011, 2031, 1),
(40012, 2032, 1),
(40013, 2033, 1),
(40014, 2034, 1),
(40015, 2035, 1),
(40016, 2036, 1),
(40017, 2037, 1),
(40018, 2038, 1),
(40019, 2039, 1);

------------------------------------------------------------
-- 8. Insert 20 Sample Payment Information Records
------------------------------------------------------------
INSERT INTO PaymentInformation (Customer_ID, PaymentType, AccountNumber, cvv, ExpriationDate) VALUES
(40000, 1, '4111111111111111', '111', '2026-12-31'),
(40001, 2, '5500000000000004', '222', '2027-06-30'),
(40002, 1, '4111111111111122', '333', '2025-11-30'),
(40003, 2, '5500000000000011', '444', '2026-10-31'),
(40004, 1, '4111111111111133', '555', '2027-05-31'),
(40005, 2, '5500000000000022', '666', '2026-09-30'),
(40006, 1, '4111111111111144', '777', '2027-08-31'),
(40007, 2, '5500000000000033', '888', '2026-07-31'),
(40008, 1, '4111111111111155', '999', '2027-04-30'),
(40009, 2, '5500000000000044', '000', '2026-06-30'),
(40010, 1, '4111111111111166', '123', '2027-03-31'),
(40011, 2, '5500000000000055', '234', '2026-12-31'),
(40012, 1, '4111111111111177', '345', '2027-02-28'),
(40013, 2, '5500000000000066', '456', '2026-08-31'),
(40014, 1, '4111111111111188', '567', '2027-01-31'),
(40015, 2, '5500000000000077', '678', '2026-05-31'),
(40016, 1, '4111111111111199', '789', '2027-07-31'),
(40017, 2, '5500000000000088', '890', '2026-11-30'),
(40018, 1, '4111111111111200', '901', '2027-09-30'),
(40019, 2, '5500000000000099', '012', '2026-10-31');

------------------------------------------------------------
-- 9. Insert 10 Sample Publishers (Publisher_ID starts at 50000)
------------------------------------------------------------
INSERT INTO Publishers (CompanyName) VALUES
('Penguin Random House'),
('HarperCollins'),
('Simon & Schuster'),
('Hachette Book Group'),
('Macmillan Publishers'),
('Scholastic'),
('Wiley'),
('Oxford University Press'),
('Cengage'),
('Pearson');

------------------------------------------------------------
-- 10. Insert Sample Publisher-Contact Data
------------------------------------------------------------
-- Link each publisher with one phone number, one address, and one email.
INSERT INTO PublisherPhoneNumber (Publisher_ID, Phone_ID, PrimaryNumber) VALUES
(50000, 1040, 1),
(50001, 1041, 1),
(50002, 1042, 1),
(50003, 1043, 1),
(50004, 1044, 1),
(50005, 1045, 1),
(50006, 1046, 1),
(50007, 1047, 1),
(50008, 1048, 1),
(50009, 1049, 1);

INSERT INTO PublisherAddress (Publisher_ID, Address_ID, PrimaryAddress, ShippingAddress) VALUES
(50000, 10040, 1, 0),
(50001, 10041, 1, 1),
(50002, 10042, 1, 0),
(50003, 10043, 1, 1),
(50004, 10044, 1, 0),
(50005, 10045, 1, 1),
(50006, 10046, 1, 0),
(50007, 10047, 1, 1),
(50008, 10048, 1, 0),
(50009, 10049, 1, 1);

INSERT INTO PublisherEmail (Publisher_ID, Email_ID, PrimaryEmail) VALUES
(50000, 2040, 1),
(50001, 2041, 1),
(50002, 2042, 1),
(50003, 2043, 1),
(50004, 2044, 1),
(50005, 2045, 1),
(50006, 2046, 1),
(50007, 2047, 1),
(50008, 2048, 1),
(50009, 2049, 1);

------------------------------------------------------------
-- 11. Insert 20 Sample Books (ISBN is primary key)
------------------------------------------------------------
INSERT INTO Books (ISBN, Title, Price, BookDescription, Edition) VALUES
('9780000000001', 'Mystery of the Abandoned Manor', 14.99, 'A spine-tingling mystery.', '1st'),
('9780000000002', 'Secrets of the Lost City', 16.99, 'An adventure full of secrets.', '1st'),
('9780000000003', 'Journey Through the Stars', 19.99, 'Epic science fiction adventure.', '2nd'),
('9780000000004', 'The Forgotten Realm', 12.99, 'A tale of magic and mystery.', '1st'),
('9780000000005', 'Under the Moonlight', 11.99, 'A romantic story set in Paris.', '1st'),
('9780000000006', 'The Last Detective', 15.99, 'A detective novel with twists.', '2nd'),
('9780000000007', 'Time Travelers', 18.99, 'A journey through time.', '1st'),
('9780000000008', 'The Hidden Treasure', 13.99, 'Adventure and mystery combine.', '1st'),
('9780000000009', 'Echoes of the Past', 17.99, 'Historical fiction with mystery.', '2nd'),
('9780000000010', 'The Galactic War', 21.99, 'Science fiction at its best.', '1st'),
('9780000000011', 'Whispers in the Dark', 14.49, 'A chilling horror mystery.', '1st'),
('9780000000012', 'Legends of Tomorrow', 19.49, 'Fantasy meets futuristic tales.', '2nd'),
('9780000000013', 'The Secret Garden', 10.99, 'A heartwarming tale.', '1st'),
('9780000000014', 'Shadows of Betrayal', 16.49, 'A story of intrigue and betrayal.', '1st'),
('9780000000015', 'Rise of the Phoenix', 18.49, 'An epic fantasy adventure.', '2nd'),
('9780000000016', 'The Enigma Code', 15.49, 'A modern mystery thriller.', '1st'),
('9780000000017', 'Beyond the Horizon', 20.99, 'Science fiction adventure.', '2nd'),
('9780000000018', 'The Silent Witness', 13.49, 'A courtroom drama with mystery.', '1st'),
('9780000000019', 'Edge of Reality', 17.49, 'A mind-bending science fiction tale.', '1st'),
('9780000000020', 'The Last Kingdom', 22.99, 'Historical fiction with epic battles.', '1st');

------------------------------------------------------------
-- 12. Insert 10 Sample Categories (Category_ID starts at 60000)
------------------------------------------------------------
INSERT INTO Categories (CategoryName, CategoryDescription) VALUES
('Mystery', 'Mystery and thriller novels.'),
('Science Fiction', 'Futuristic and space exploration themes.'),
('Fantasy', 'Epic tales of magic and adventure.'),
('Romance', 'Love stories and romantic novels.'),
('Horror', 'Scary and suspenseful stories.'),
('Historical', 'Novels based on historical events.'),
('Adventure', 'Action-packed adventure stories.'),
('Drama', 'Intense dramatic narratives.'),
('Non-Fiction', 'Educational and factual content.'),
('Young Adult', 'Stories aimed at younger readers.');

------------------------------------------------------------
-- 13. Insert Sample Book-Category Data (BookCategories)
------------------------------------------------------------
-- Assign each book one category (cycling through category_IDs 60000 to 60009)
INSERT INTO BookCategories (ISBN, Category_ID) VALUES
('9780000000001', 60000),
('9780000000002', 60007),
('9780000000003', 60001),
('9780000000004', 60002),
('9780000000005', 60003),
('9780000000006', 60000),
('9780000000007', 60001),
('9780000000008', 60007),
('9780000000009', 60006),
('9780000000010', 60001),
('9780000000011', 60004),
('9780000000012', 60002),
('9780000000013', 60003),
('9780000000014', 60000),
('9780000000015', 60002),
('9780000000016', 60000),
('9780000000017', 60001),
('9780000000018', 60007),
('9780000000019', 60001),
('9780000000020', 60005);

------------------------------------------------------------
-- 14. Insert 10 Sample Locations (Location_ID starts at 70000)
------------------------------------------------------------
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70000
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70001
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70002
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70003
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70004
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70005
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70006
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70007
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70008
INSERT INTO Location DEFAULT VALUES;  -- Location_ID = 70009

------------------------------------------------------------
-- 15. Insert Sample Location-Contact Data
------------------------------------------------------------
-- Link each location with one phone number (using phone_IDs from 1050 upward)
INSERT INTO LocationPhoneNumber (Location_ID, Phone_ID, PrimaryNumber) VALUES
(70000, 1050, 1),
(70001, 1051, 1),
(70002, 1052, 1),
(70003, 1053, 1),
(70004, 1054, 1),
(70005, 1055, 1),
(70006, 1056, 1),
(70007, 1057, 1),
(70008, 1058, 1),
(70009, 1059, 1);

-- Link each location with one address (using address_IDs from 10050 upward)
INSERT INTO LocationAddress (Location_ID, Address_ID, PrimaryAddress, ShippingAddress) VALUES
(70000, 10050, 1, 1),
(70001, 10051, 1, 0),
(70002, 10052, 1, 1),
(70003, 10053, 1, 0),
(70004, 10054, 1, 1),
(70005, 10055, 1, 0),
(70006, 10056, 1, 1),
(70007, 10057, 1, 0),
(70008, 10058, 1, 1),
(70009, 10059, 1, 0);

-- Link each location with one email (using email_IDs from 2050 upward)
INSERT INTO LocationEmail (Location_ID, Email_ID, PrimaryEmail) VALUES
(70000, 2050, 1),
(70001, 2051, 1),
(70002, 2052, 1),
(70003, 2053, 1),
(70004, 2054, 1),
(70005, 2055, 1),
(70006, 2056, 1),
(70007, 2057, 1),
(70008, 2058, 1),
(70009, 2059, 1);

------------------------------------------------------------
-- 16. Insert 20 Sample Inventory Records
------------------------------------------------------------
-- For each sample book (20 books) assign a quantity at one of the 10 locations (cycling locations)
INSERT INTO Inventory (ISBN, Location_ID, Quantity, DateOfRecord) VALUES
('9780000000001', 70000, 100, '2025-03-01'),
('9780000000002', 70001, 75, '2025-03-02'),
('9780000000003', 70002, 50, '2025-03-03'),
('9780000000004', 70003, 120, '2025-03-04'),
('9780000000005', 70004, 90, '2025-03-05'),
('9780000000006', 70005, 60, '2025-03-06'),
('9780000000007', 70006, 80, '2025-03-07'),
('9780000000008', 70007, 110, '2025-03-08'),
('9780000000009', 70008, 95, '2025-03-09'),
('9780000000010', 70009, 85, '2025-03-10'),
('9780000000011', 70000, 130, '2025-03-11'),
('9780000000012', 70001, 70, '2025-03-12'),
('9780000000013', 70002, 105, '2025-03-13'),
('9780000000014', 70003, 65, '2025-03-14'),
('9780000000015', 70004, 115, '2025-03-15'),
('9780000000016', 70005, 90, '2025-03-16'),
('9780000000017', 70006, 80, '2025-03-17'),
('9780000000018', 70007, 100, '2025-03-18'),
('9780000000019', 70008, 75, '2025-03-19'),
('9780000000020', 70009, 95, '2025-03-20');

select * from Customers;

select LastName from Customers;

create table Orders(
	Order_ID int identity(110000, 1) primary key,
	Customer_ID int foreign key references Customers(Customer_ID),
	Order_Date date not null,
	Total_Amount money not null,
	Order_Status int not null
);

create table OrderItems (
	OrderItem_ID int identity(100000, 1) primary key,
	Order_ID int foreign key references Orders(Order_ID),
	Book_ID char(13) foreign key references Books(ISBN),
	Quantity int not null, 
	Unit_Price money not null
);

------------------------------------------------------------
-- 1. Insert Sample Orders (Order_ID starts at 110000)
------------------------------------------------------------
INSERT INTO Orders (Customer_ID, Order_Date, Total_Amount, Order_Status) VALUES
(40000, '2025-03-15', 48.97, 1),
(40001, '2025-03-16', 32.98, 2),
(40002, '2025-03-17', 39.97, 1),
(40003, '2025-03-18', 46.97, 3),
(40004, '2025-03-19', 53.97, 1),
(40005, '2025-03-20', 36.48, 2),
(40006, '2025-03-21', 41.47, 3),
(40007, '2025-03-22', 34.98, 1),
(40008, '2025-03-23', 51.97, 3),
(40009, '2025-03-24', 48.47, 2),
(40010, '2025-03-25', 68.97, 1),
(40011, '2025-03-26', 49.97, 3),
(40012, '2025-03-27', 41.97, 1),
(40013, '2025-03-28', 31.98, 2),
(40014, '2025-03-29', 46.97, 1),
(40015, '2025-03-30', 57.97, 3),
(40016, '2025-03-31', 33.98, 1),
(40017, '2025-04-01', 38.47, 2),
(40018, '2025-04-02', 54.97, 1),
(40019, '2025-04-03', 48.47, 3);

------------------------------------------------------------
-- 2. Insert Sample Order Items (OrderItem_ID starts at 100000)
------------------------------------------------------------

-- Order 110000 for Customer 40000
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110000, '9780000000001', 1, 14.99),
(110000, '9780000000002', 2, 16.99);
-- Total: 14.99 + (2 * 16.99) = 48.97

-- Order 110001 for Customer 40001
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110001, '9780000000003', 1, 19.99),
(110001, '9780000000004', 1, 12.99);
-- Total: 19.99 + 12.99 = 32.98

-- Order 110002 for Customer 40002
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110002, '9780000000005', 2, 11.99),
(110002, '9780000000006', 1, 15.99);
-- Total: (2 * 11.99) + 15.99 = 39.97

-- Order 110003 for Customer 40003
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110003, '9780000000007', 1, 18.99),
(110003, '9780000000008', 2, 13.99);
-- Total: 18.99 + (2 * 13.99) = 46.97

-- Order 110004 for Customer 40004
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110004, '9780000000009', 3, 17.99);
-- Total: 3 * 17.99 = 53.97

-- Order 110005 for Customer 40005
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110005, '9780000000010', 1, 21.99),
(110005, '9780000000011', 1, 14.49);
-- Total: 21.99 + 14.49 = 36.48

-- Order 110006 for Customer 40006
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110006, '9780000000012', 1, 19.49),
(110006, '9780000000013', 2, 10.99);
-- Total: 19.49 + (2 * 10.99) = 41.47

-- Order 110007 for Customer 40007
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110007, '9780000000014', 1, 16.49),
(110007, '9780000000015', 1, 18.49);
-- Total: 16.49 + 18.49 = 34.98

-- Order 110008 for Customer 40008
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110008, '9780000000016', 2, 15.49),
(110008, '9780000000017', 1, 20.99);
-- Total: (2 * 15.49) + 20.99 = 51.97

-- Order 110009 for Customer 40009
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110009, '9780000000018', 1, 13.49),
(110009, '9780000000019', 2, 17.49);
-- Total: 13.49 + (2 * 17.49) = 48.47

-- Order 110010 for Customer 40010
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110010, '9780000000020', 3, 22.99);
-- Total: 3 * 22.99 = 68.97

-- Order 110011 for Customer 40011
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110011, '9780000000001', 2, 14.99),
(110011, '9780000000003', 1, 19.99);
-- Total: (2 * 14.99) + 19.99 = 49.97

-- Order 110012 for Customer 40012
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110012, '9780000000002', 1, 16.99),
(110012, '9780000000004', 1, 12.99),
(110012, '9780000000005', 1, 11.99);
-- Total: 16.99 + 12.99 + 11.99 = 41.97

-- Order 110013 for Customer 40013
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110013, '9780000000006', 2, 15.99);
-- Total: 2 * 15.99 = 31.98

-- Order 110014 for Customer 40014
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110014, '9780000000007', 1, 18.99),
(110014, '9780000000008', 2, 13.99);
-- Total: 18.99 + (2 * 13.99) = 46.97

-- Order 110015 for Customer 40015
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110015, '9780000000009', 2, 17.99),
(110015, '9780000000010', 1, 21.99);
-- Total: (2 * 17.99) + 21.99 = 57.97

-- Order 110016 for Customer 40016
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110016, '9780000000011', 1, 14.49),
(110016, '9780000000012', 1, 19.49);
-- Total: 14.49 + 19.49 = 33.98

-- Order 110017 for Customer 40017
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110017, '9780000000013', 2, 10.99),
(110017, '9780000000014', 1, 16.49);
-- Total: (2 * 10.99) + 16.49 = 38.47

-- Order 110018 for Customer 40018
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110018, '9780000000015', 1, 18.49),
(110018, '9780000000016', 1, 15.49),
(110018, '9780000000017', 1, 20.99);
-- Total: 18.49 + 15.49 + 20.99 = 54.97

-- Order 110019 for Customer 40019
INSERT INTO OrderItems (Order_ID, Book_ID, Quantity, Unit_Price) VALUES
(110019, '9780000000018', 1, 13.49),
(110019, '9780000000019', 2, 17.49);
-- Total: 13.49 + (2 * 17.49) = 48.47

select * from Customers;

select * from Orders;

select *, Quantity*Unit_Price as Total from OrderItems;

select * from Customers where LastName > 'M';

select * from Customers where LastName > 'M' and FirstName < 'J';

select * from Customers where LastName > 'M' or FirstName < 'J';

select * from Customers where not LastName > 'M';