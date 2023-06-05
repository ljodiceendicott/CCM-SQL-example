DROP TABLE IF EXISTS 
        Worker,
	        Worker_history,
                    Manager,
                    Department,
                    Department_Staff,
                    Product_Sold,
                    Product_Ingredient,
                    Prod_Shipped_in,
                    Prod_Homemade;

CREATE TABLE Worker(
    worker_id   INT             NOT NULL,
    worker_name	tinytext        NOT NULL,
    pay_rate    Double(5,2)     NOT NULL,
    PRIMARY KEY (worker_id)
);

CREATE TABLE Worker_History(
    worker_id   INT             NOT NULL,
    job_title	tinytext        NOT NULL,
    start_date	date			NOT NULL,
    end_date	date			,
    foreign key (worker_id) References Worker (worker_id) ON DELETE CASCADE
    );

CREATE TABLE Manager(
    manager_id   		INT             NOT NULL,
    worker_id	 		INT 		    NOT NULL,
    management_type		tinytext		NOT NULL,
    PRIMARY KEY (manager_id),
	Foreign key (worker_id) References Worker (worker_id) ON DELETE CASCADE
    );

CREATE TABLE Department (
	dept_name 		tinytext	NOT NULL,
    dept_code		char(5)		NOT NULL,
    dept_manager 	int			NOT NULL,
    primary key (dept_name),
    unique key (dept_code),
    foreign key (dept_manager) references Manager (manager_id) ON DELETE CASCADE
    );

CREATE TABLE Department_Staff(
	dept_name	tinytext NOT NULL,
    worker_id	int		 NOT NULL,
    Foreign key (worker_id) References Worker (worker_id) ON DELETE CASCADE,
	Foreign key (dept_name) References Department (department_id) ON DELETE CASCADE
);

CREATE TABLE Product_Sold(
	product_name	tinytext 		NOT NULL,
    product_made	enum ('H','S')  NOT NULL
);

Create Table Product_Ingredient(
	ingredient_name		tinytext	NOT NULL,
    product_name		tinytext	NOT NULL,
    is_common_allergen	boolean		NOT NULL,
    primary key	(ingredient_name),
    foreign key (product_name) References Product_Sold (product_name) ON DELETE CASCADE
);

Create Table Prod_Shipped_In(
	product_name	tinytext		NOT NULL,
    bulk_price		double(5,2) 	NOT NULL,
    bulk_amount		varchar(15)		NOT NULL,
    brand_name		tinytext		NOT NULL,
    Dist_name		tinytext		NOT NULL, #Distributer Name
	foreign key (product_name) References Product_Sold (product_name) ON DELETE CASCADE
);

Create Table Prod_Homemade(
	product_name	tinytext	NOT NULL,
    dept_made_in	tinytext	NOT NULL,
    package_desc	tinytext	NOT NULL,
    foreign key (product_name) References Product_Sold (product_name) ON DELETE CASCADE,
    foreign key (dept_made_in) References Department (department_name) ON DELETE CASCADE
);

Data entered
Insert INTO Worker Values
(0819,"Luke Jodice","StoreFront",15.00),
(0301,"Vincent Jodice","StoreFront",25.00),
(0201,"Ethan Henry", "Mail-Order", 27.00),
(0023, "Frank Williams", "Kitchen", 14.00),
(0024, "Jonathan Armstrong","Kitchen",16.00),
(0027, "Ron Mantly","Kitchen",30.00),
(2134,"Kim Marsh", "Kitchen",30.00),
(0000,"Robbie C", "Owner", 99.99);

Insert INTO Worker_History Values
(0819, "StoreFront Clerk",3/14/16),
(0201, "Junior General Manager",2/7/14),
(0201, "Junior General Manager",8/16/14),
(0023, "Chocolate Dipper", 4/24/17),
(0024, "Kitchen Assistant", 12/15/16),
(0027, "Head-Cook",7/5/10),
(2134, "Kitchen-Lead", 6/1/94),
(0301, "ShipmentManager",4/20/13);


Insert INTO Manager Values
(011,0301,"gen-man"),
(002,2134,"kitchen-man"),
(001,0000,"Owner");

Insert INTO Department Values
("Mail-Order","MA-O",0010),
("Management", "MGMNT",0001),
("StoreFront",'ST-FR',0301),
("Kitchen",'KTCHN',2134);

Insert INTO Department_Staff
(“Storefront”,0819),
(“Storefront”, 0301),
(“Kitchen”, 0201),
(“Kitchen”,0023),
(“Kitchen”, 0024),
(“Kitchen”, 0027),
(“Kitchen”, 2134),
(“Mail-Order”,0301);

Insert INTO Product_Sold Values
("Chocolate Fudge", 'H'),
("PeanutButter Fudge", 'H'),
("Chocolate Walnut Fudge", 'H'),
("Swedish Fish", 'S'),
("Sour Patch Kids",'S'),
("Gummy Worms", 'S'),
("Gummy Bears", 'S'),
("Chocolate Cranberries", 'S'),
("Sea Salt Caramels", 'H'),
("Carmels", 'H'),
("Plain Truffles", 'H'),
("Chocolate covered Apricots", 'H'),
("Milk Chocolate", 'H'),
("White Chocolate", 'H'),
("Dark Chocolate", 'H');

Insert INTO Prod_Homemade
("Chocolate Fudge", "StoreFront", "Sold in Fudge Boxes from 1/4# to 1# increments"),
("PeanutButter Fudge", "StoreFront", "Sold in Fudge Boxes from 1/4# to 1# increments"),
("Chocolate Walnut Fudge", "StoreFront", "Sold in Fudge Boxes from 1/4# to 1# increments"),
("Sea Salt Caramels", "Kitchen", "Sold anywhere from one piece to a 2# box"),
("Carmels", "Kitchen", "Sold anywhere from one piece to a 2# box"),
("Plain Truffles","Kitchen", "Sold anywhere from one piece to a 2# box"),
("Chocolate Covered Apricots, "Kitchen", "Sold anywhere from one piece to a 2# box"),
("White Chocolate","Kitchen", "Sold anywhere from one piece to a 2# box"),

Insert INTO Prod_Shipped_In
("Swedish Fish", 12.00, "5lbs","Swedish Fish", "Bobrow Confections"),
("Sour Patch Kids", 12.00, "5lbs","Sour Patch", "Bobrow Confections"),
("Gummy Worms", 12.00, "5lbs","Albanese", "Bobrow Confections"),
("Gummy Bears", 12.00, "5lbs","Haribo", "Bobrow Confections"),
("Chocolate Cranberries", 25.00, "40lbs", "Wilbur's","Bobrow Confections");

Insert INTO Product_Ingredient
("Chocolate", "Chocolate Fudge", false),
("Chocolate", "Chocolate Walnut Fudge", false),
("Chocolate", "Chocolate Cranberries", false),
("Walnuts", "Chocolate Walnut Fudge", true),
("Peanut Butter", "PeanutButter Fudge", 
("Granulated Sugar", "Chocolate Fudge", false),
("HF Corn Syrup", "Chocolate Fudge", false),
("Granulated Sugar", "PeanutButter Fudge", false),
("HF Corn Syrup", "PeanutButter Fudge", false),
("Granulated Sugar","Chocolate Walnut Fudge", false),
("HF Corn Syrup", "Chocolate Walnut Fudge", false),
("HF Corn Syrup", "Swedish Fish", false),
("HF Corn Syrup", "Sour Patch Kids", false),
("HF Corn Syrup", "Gummy Worms", false),
("HF Corn Syrup", "Gummy Bears", false),
("Dried Cranberries", "Chocolate Cranberries", false),
("HF Corn Syrup", "Sea Salt Caramels", false),
("Granulated Sugar","Sea Salt Caramels", false),
("HF Corn Syrup", "Carmels", false),
("Granulated Sugar","Carmels", false),
("Sea Salt", "Sea Salt Caramels", false),
("Cream", "Chocolate Fudge", true),
("Cream", "Chocolate Walnut Fudge", true),
("Cream", "PeanutButter Fudge", true),
("Cream", "Carmels", true),
("Cream", "Sea Salt Caramels", true),
("Cream", "Milk Chocolate", true),
("Cream", "White Chocolate", true),
("Cacao", "Milk Chocolate", false),
("Cacao", "Dark Chocolate", false);

SELECT * FROM Worker_History
ORDER BY start_date;


SELECT * FROM Product_Ingredient.is_common_allergen
ORDER BY Product_Ingredient.product_name;
