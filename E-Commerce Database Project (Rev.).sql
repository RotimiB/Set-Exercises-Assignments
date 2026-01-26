create database ecommerce_db;


create table suppliers
(supplierID INT primary key auto_increment,
name varchar(60) not null,
contact_name varchar(60),
email varchar(90),
phone varchar(90) );

create table products
(productID INT primary key auto_increment,
supplierID INT not null,
name varchar(90) not null,
description text,
price decimal(10, 2) not null,
quantity_stock int not null,
Foreign key (supplierID) references suppliers(supplierID));

create table categories
(categoryID INT primary key auto_increment,
name varchar(60) not null);

create table product_categories
(product_catID INT primary key auto_increment,
productID INT not null,
categoryID INT not null,
Foreign key (productID) references products(productID),
Foreign key (categoryID) references categories(categoryID),
constraint productcategory unique (productID, categoryID) );

create table customers
(customerID INT primary key auto_increment,
firstname varchar(60) not null,
lastname varchar(60) not null,
email varchar(90) not null unique,
phone varchar(60) not null,
user_password varchar(60) not null);

create table addresses
(addressID INT primary key auto_increment,
customerID INT not null,
address varchar(120) not null,
city varchar(60) not null,
postalcode varchar(60) not null,
state_or_region varchar(60) not null,
country varchar(60) not null,
Foreign key (customerID) references customers(customerID));

create table orders
(orderID INT primary key auto_increment,
customerID INT not null,
total_due decimal(10,2) not null,
bill_address INT references addresses(addressID),
ship_address INT references addresses(addressID),
orderdate timestamp default current_timestamp,
Foreign key (customerID) references customers(customerID));

create table order_items
(order_itemID INT primary key auto_increment,
orderID INT not null,
productID INT not null,
quantity INT not null,
unitprice decimal(10, 2) not null,
Foreign key (orderID) references orders(orderID),
Foreign key (productID) references products(productID));

create table carts
(cartID INT primary key auto_increment,
customerID INT not null,
created_on timestamp default current_timestamp,
Foreign key (customerID) references customers(customerID));

create table cart_items
(cart_itemID INT primary key auto_increment,
cartID INT not null,
productID INT not null,
quantity INT not null,
Foreign key (cartID) references carts(cartID),
Foreign key (productID) references products(productID));

create table payments
(paymentID INT primary key auto_increment,
orderID INT not null,
amount decimal(10, 2) not null,
pay_date timestamp default current_timestamp,
Foreign key (orderID) references orders(orderID));

create table invoices
(invoiceID INT primary key auto_increment,
orderID INT not null,
paymentID INT,
total_due decimal (10, 2) not null,
invoicedate date not null,
Foreign key (orderID) references orders(orderID),
Foreign key (paymentID) references payments(paymentID));

create table returns
(returnID INT primary key auto_increment,
orderID INT not null,
customerID INT not null,
productID INT not null,
return_reason varchar(60) not null,
returndate date not null,
constraint returnID unique (orderID, customerID, productID),
Foreign key (orderID) references orders(orderID),
Foreign key (customerID) references customers(customerID),
Foreign key (productID) references products(productID));

create table shipments
(shipmentID INT primary key auto_increment,
orderID INT not null,
ship_date date not null,
delivery_date date not null,
Foreign key (orderID) references orders(orderID));

create table discounts
(discountID INT primary key auto_increment,
discountcode varchar(60) not null unique,
discount_amount decimal(10, 2) not null,
description varchar(60) not null);

create table order_discounts
(order_discountID INT primary key auto_increment,
orderID INT not null,
discountID INT not null,
discount_applied decimal(10, 2) not null,
constraint order_discountID unique (orderID, discountID),
Foreign key(orderID) references orders(orderID),
Foreign key (discountID) references discounts(discountID));

### ---INSERT TABLE DATA---

Insert into suppliers (name, contact_name, email, phone) Values
("China South Industries", "Cass Ballenger", "c.ballenger@chinasouth.co", "333-456-9876"),
("Honeywell", "Neil Abercrombie", "neil.a@honeywell.co", "999-321-6547"),
("Oracle Co.", "Jim Chapman", "j.chapman@oracle.net", "222-777-3214"),
("Magna International", "Pat Swindall", "pat.s@magna.co", "444-888-6868"),
("Pegatron", "Mac Sweeney", "m.sweeney@pegatron.net", "111-777-8789"),
("Denso Unlimited", "Michael Strang", "michael.s@denso.co", "888-636-4545"),
("Lenovo", " Bob Smith", "b.smith@lenovo@net", "444-686-2352"),
("Cisco Systems", "John Rowland", "john.r@cisco.co", "666-747-1252");

Insert into categories (name) Values
("Electronics"),
("Home Goods"),
("Clothing & Apparel"),
("Furniture"),
("Hardware"),
("Food & Drinks"),
("Shoes");

Insert into products (name, description, price, quantity_stock, supplierID) Values
("Cisco DP-9861 IP Phone", "black VoIP Phone with Wifi and Bluetooth support", 285.00, 50, 8),
("Denso DEA09046 Fan", "air conditioning condenser fan", 47.50, 40, 6),
("Honeywell HYF290 QuietSet Tower", "8-speed oscillating fan", 105.50, 95, 2),
("Honeywell HJ1 Sunturalux", "LED office desk lamp", 110.00, 150, 2),
("Lenovo ThinkCentre M720S", "1TB Business Office Computer Windows 11 64-bit", 400.00, 70, 7),
("Lenovo ThinkPad T14 Gen 1", "256GB Notebook Computer 16GB Memory", 325.00, 50, 7),
("Honeywell HT-900E", "turbo ventilation fan", 25.00, 120, 2);

Insert into product_categories (productID, categoryID) Values
(1, 1),
(1, 5),
(2, 1),
(2, 5),
(3, 1),
(3, 2),
(4, 1 ),
(4, 2 ),
(5, 1),
(5, 5),
(6, 1),
(6, 5),
(7, 1),
(7, 2);

Insert into customers (firstname, lastname, email, phone, user_password) Values
("David", "Monson", "d.monson@gmail.com", "+49 174 6516845", "*g^980H79tgi"),
("Jan", "Meyers", "jan.meyers@outlook.com", "+49 177 3949615", "64*/-56489gnk"),
("Jim", "Lightfoot", "jim.lightfoot@gmail.com", "+49 174 1682365", "bj4yy**668"),
("Jim", "Kolbe", "j.kolbe@outlook.com", "+49 177 1568486", "bj3$^@hu9"),
("Paul", "Henry", "paul.henry@outlook.com", "+49 176 5684683", "*85hdf89**hube"),
("Donna", "Perkins", "d.perkins@gmail.com", "+49 177 3597835", "Vjygu&^Ri"),
("Helen", "Bentley", "h.bentley@outlook.com", "+49 174 1351689", "JYF8kgl*%Nkuh"),
("Jerry", "Kleczka", "j.kleczka@gmail.com", "+49 174 1366933", "kUg876tlvU"),
("Lindsay", "Thomas", "lindsay.thom@gmail.com", "+49 177 5669357", "BK89y*(^&"),
("Esteban", "Torres", "esteban.torres@outlook.com", "+49 174 2636598", "biYF^&*bhvJy");

Insert into addresses (customerID, address, city, postalcode, state_or_region, country) Values
(1, "Theaterplatz 2", "Dresden", "01067", "Saxony", "Germany"),
(2, "Prenzlauer Allee 24", "Berlin", "10405", "Berlin", "Germany"),
(3, "Lise-Meitner-Strasse 7", "Munich", "80000", "Bavaria", "Germany"),
(4, "Hauptstrasse 45", "Munich", "80331", "Bavaria", "Germany"),
(5, "Augustusplatz 8", "Leipzig", "04109", "Saxony", "Germany"),
(6, "Hauptwache 1", "Frankfurt am Main", "60311", "Hessen", "Germany"),
(7, "Karlsplatz 5", "Munich", "80335", "Bavaria", "Germany"),
(8, "Am Hauptbanhof 12", "Hanover", "30159", "Lower Saxony", "Germany"),
(9, "Marienplatz 1", "Munich", "80331", "Bavaria", "Germany"),
(10, "Binnenalster 1", "Hamburg", "20095", "Hamburg", "Germany");

Insert into orders (customerID, total_due, bill_address, ship_address) Values
(1, 361.00, 1, 1),
(2, 350.00, 2, 2),
(3, 1185.00, 3, 3),
(4, 1775.00, 4, 4),
(5, 510.00, 5, 5),
(6, 285.00, 6, 6),
(7, 633.00, 7, 7),
(8, 1200.00, 8, 8),
(9, 325.00, 9, 9),
(10, 110.00, 10, 10);

Insert into order_items (orderID, productID, quantity, unitprice) Values
(1, 3, 2, 105.50), 
(1, 7, 6, 25.00),
(2, 7, 1, 25.00),
(2, 6, 1, 325.00),
(3, 4, 3, 110.00),
(3, 1, 3, 285.00),
(4, 5, 2, 400.00),
(4, 6, 3, 325.00),
(5, 4, 1, 110.00),
(5, 5, 1, 400.00),
(6, 1, 1, 285.00),
(7, 3, 6, 105.50),
(8, 5, 3, 400.00),
(9, 6, 1, 325.00),
(10, 4, 1, 110.00);

Insert into carts (customerID) Values
(3),
(5),
(7),
(4),
(1), 
(6);

Insert into cart_items (cartID, productID, quantity) Values
(1, 6, 1),
(2, 1, 1),
(3, 4, 2),
(4, 6, 2),
(5, 3, 1),
(6, 4, 1);

Insert into payments (orderID, amount) Values
(2, 350.00),
(4, 887.50),
(4, 887.50),
(1, 361.00),
(3, 1185.00),
(7, 633.00),
(5, 510.00),
(8, 400.00),
(6, 285.00),
(9, 325.00),
(10, 110.00);

Insert into invoices (orderID, paymentID, total_due, invoicedate) Values
(2, 1, 350.00, "2026-01-17"),
(4, 2, 887.50, "2026-01-17"),
(4, 3, 887.50, "2026-01-17"),
(1, 4, 361.00, "2026-01-17"),
(3, 5, 1185.00, "2026-01-17"),
(7, 6, 633.00, "2026-01-17"),
(5, 7, 510.00, "2026-01-17"),
(8, 8, 400.00, "2026-01-17"),
(6, 9, 285.00, "2026-01-17"),
(9, 10, 325.00, "2026-01-17"),
(10, 11, 110.00, "2026-01-17");

Insert into returns (orderID, customerID, productID, return_reason, returndate) Values
(3, 3, 4, "Items no longer needed/wanted", "2026-01-18"),
(5, 5, 5, "Incorrect item", "2026-01-18"),
(8, 8, 5, "Items no longer needed/wanted", "2026-01-18"),
(2, 2, 6, "Incorrect item", "2026-01-18"),
(7, 7, 3, "Items no longer needed/wanted", "2026-01-18");

Insert into discounts (discountcode, discount_amount, description) Values
("FIRST10", 10.00, "10 Euros off first order"),
("NEWUSER10", 10.00, "10 Euros off for new customers"),
("BLACKFRI25", 25.00, "25 Euros off Black Friday orders"),
("WINTER30", 30.00, "30 Euros off orders over 100 Euros"),
("WINTER50", 50.00, "50 Euros off orders over 200 Euros");

Insert into shipments (orderID, ship_date, delivery_date) Values
(1, "2026-01-17", "2026-01-30"),
(2, "2026-01-17", "2026-01-30"),
(3, "2026-01-17", "2026-01-30"),
(4, "2026-01-17", "2026-01-30"),
(5, "2026-01-17", "2026-01-30"),
(6, "2026-01-17", "2026-01-30"),
(7, "2026-01-17", "2026-01-30"),
(8, "2026-01-17", "2026-01-30"),
(9, "2026-01-17", "2026-01-30"),
(10, "2026-01-17", "2026-01-30");

Insert into order_discounts (orderID, discountID, discount_applied) Values
(1, 1, 10.00),
(2, 2, 10.00),
(3, 1, 10.00),
(4, 2, 10.00),
(5, 1, 10.00);

### ---VIEW CREATION 1: Sales Summary ---

Create view SalesbyCity As
Select A.city, A.state_or_region, A.country, 
Count(distinct O.orderID) as totalorders,
Sum(O.total_due) as totalsales_of_city
From orders O
Join addresses A on O.ship_address = A.addressID
Group by A.city, A.state_or_region, A.country
Order by totalsales_of_city DESC;

Select * From SalesbyCity; 

### ---VIEW CREATION 2: Sales Trend ---

Create view MonthlyRevenue as
Select date_format(orderdate, "%Y-%m") as rev_month,
		sum(total_due) as monthly_revenue,
        count(orderID) as orders_total,
        avg(total_due) as average_order
From orders
Group by rev_month;

Select * From monthlyrevenue;



### ---Inserting Additional Data for Query Testing --- ###

Insert into orders (customerID, total_due, bill_address, ship_address) Values
(3, 325.00, 3, 3);

Insert into order_items (orderID, productID, quantity, unitprice) Values
(11, 6, 1, 325.00);

Insert into invoices (orderID, total_due, invoicedate) Values
(11, 325.00, "2026-01-17");

Insert into addresses (customerID, address, city, postalcode, state_or_region, country) Values
(10, "Theaterplatz 4", "Dresden", "01067", "Saxony", "Germany");

### ---SQL QUERY 1: Identifying Unpaid Invoices ---

Select I.orderID, I.invoiceID, I.total_due, I.invoicedate
From Invoices I 
Left Join Payments P on I.orderID = P.orderID
Where P.paymentID Is Null;

### ---SQL QUERY 2: Retrieving Customer History ---

Delimiter //
Create Procedure GetCustomerOrders(In Customer_ID INT)
Begin
	Select O.orderID, O.orderdate, I.quantity, I.unitprice, P.name, S.ship_date, S.delivery_date
	From orders O
	Join order_items I on O.orderID = I.orderID
	Join products P on I.productID = P.productID
	Left Join shipments S on O.orderID = S.orderID
	Where O.customerID = Customer_ID 
	Order By O.orderdate Desc;
    End //
    Delimiter ;
    
### ---SQL QUERY 3: Finding Customers w. Multiple Shipping Addresses ---

Select C.firstname, C.lastname, C.email, 
Count(A.addressID) as Num_of_Addresses
From customers C 
Join addresses A on C.customerID = A.customerID
Group by C.customerID, C.email
Having Count(A.addressID) > 1
Order by Num_of_Addresses Desc;


### ---SQL QUERY 4: Ranking Suppliers by Goods Supplied---

Select supplierID, Supplier, Total_cost_of_goods_supplied,
Rank() over (Order by Total_cost_of_goods_supplied Desc) as ranking
From (
Select S.supplierID, S.name as Supplier,
Sum(P.quantity_stock * P.price) as Total_cost_of_goods_supplied
From suppliers S
Join Products P on S.supplierID = P.supplierID
Group by S.supplierID, S.name) as R
Order by ranking;

### ---SQL QUERY 5: Most Sold Products---

Select P.name as Product,
C.name as Category,
Sum(I.quantity) as TotalItemsSold,
Sum(I.quantity * I.unitprice) as TotalProductRevenue
From order_items as I
Join products P on I.productID = P.productID
Join product_categories B on P.productID = B.productID
Join categories C on B.categoryID = C.categoryID
Group by Product, Category
Order by TotalItemsSold Desc;

### ---OPTIMIZED SQL QUERY 5: Most Sold Products---

CREATE INDEX index_order_items
ON order_items (productID, quantity, unitprice);

CREATE INDEX index_products
ON products (productID);

CREATE INDEX index_categories
ON categories (categoryID);

CREATE INDEX index_product_categories
ON product_categories (productID, categoryID);

Select P.name as Product,
C.name as Category,
Sum(I.quantity) as TotalItemsSold,
Sum(I.quantity * I.unitprice) as TotalProductRevenue
From order_items as I
Join products P on I.productID = P.productID
Join product_categories B on P.productID = B.productID
Join categories C on B.categoryID = C.categoryID
Group by P.name, C.name
Order by TotalItemsSold Desc;