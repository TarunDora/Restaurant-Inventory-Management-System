
CREATE DATABASE IF NOT EXISTS restaurant_inventory_db;
USE restaurant_inventory_db;

CREATE TABLE IF NOT EXISTS user_account(
    uid VARCHAR(50) UNIQUE NOT NULL,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    PRIMARY KEY (uid)
);

CREATE TABLE IF NOT EXISTS employee(
    id VARCHAR(50) UNIQUE NOT NULL,
    role VARCHAR(50) NOT NULL,
    fname VARCHAR(50) NOT NULL,
    mname VARCHAR(50) ,
    lname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    mid VARCHAR(50) references employee(id) ON UPDATE CASCADE ON DELETE CASCADE,
    uid VARCHAR(50) UNIQUE NOT NULL,
    FOREIGN KEY (uid) REFERENCES user_account(uid) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS ecn(
    eid VARCHAR(50) NOT NULL,
    contact VARCHAR(50) NOT NULL,
    FOREIGN KEY (eid) REFERENCES employee(id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (eid, contact)
);

CREATE TABLE IF NOT EXISTS waiter(
    wid VARCHAR(50) UNIQUE NOT NULL,
    FOREIGN KEY (wid) REFERENCES employee(id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (wid)
);

CREATE TABLE IF NOT EXISTS sales(
    sid VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    wid VARCHAR(50) NOT NULL,
    FOREIGN KEY (wid) REFERENCES waiter(wid) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (sid)
);

CREATE TABLE IF NOT EXISTS supplier(
    sid VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (sid)
);

CREATE TABLE IF NOT EXISTS ingredients(
    name VARCHAR(50) NOT NULL unique,
    quantity INT NOT NULL,
    unit varchar(50) not null,
    cpu INT NOT NULL,
    rl INT NOT NULL,
    edate DATE NOT NULL,
    sid VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (sid) REFERENCES supplier(sid) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (name)
);

CREATE TABLE IF NOT EXISTS dish(
    dname VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY (dname)
);

CREATE TABLE IF NOT EXISTS orders(
    sid VARCHAR(50) NOT NULL,
    dname VARCHAR(50) NOT NULL,
    status varchar(50) not null default 'placed',
    FOREIGN KEY (sid) REFERENCES sales(sid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (dname) REFERENCES dish(dname) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (sid, dname)
);

CREATE TABLE IF NOT EXISTS recipe(
    dname VARCHAR(50) NOT NULL,
    iname VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (iname) REFERENCES ingredients(name),
    FOREIGN KEY (dname) REFERENCES dish(dname)
    -- PRIMARY KEY (dname, iname)
);

CREATE TABLE IF NOT EXISTS sorder(
    sid VARCHAR(50) NOT NULL,
    unit varchar(50) not null,
    quantity INT NOT NULL,
    ingredient VARCHAR(50) NOT NULL,
    od DATE NOT NULL,
    dd DATE NOT NULL,
    exp DATE NOT NULL,
    price FLOAT(7,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (sid) REFERENCES supplier(sid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ingredient) REFERENCES ingredients(name) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (sid, ingredient, od)
);


INSERT INTO user_account (uid, username, password) VALUES
(1, 'johndoe', 'J0hnD03#2024'),
(2, 'alicesmith', 'Alic3$mith2024'),
(3, 'robertjohnson', 'R0b3rtJ0hn2024'),
(4, 'emilywilliams', 'EmilyW!lliams24'),
(5, 'davidbrown', 'D@vidBrowN2024'),
(6, 'liamdavis', 'L1amD@vis2024'),
(7, 'oliviamiller', '0liviaM!ll24'),
(8, 'noahwilson', 'N0ahW1ls0n24'),
(9, 'emmaMoore', 'Emm@M00re2024'),
(10, 'williamtaylor', 'W1ll!amT@ylor24'),
(11, 'sophiaanderson', 'S0ph!@And3rson24'),
(12, 'jamesthomas', 'JamesTh0m@24'),
(13, 'avajackson', 'AvaJ@cks0n2024'),
(14, 'benjaminharris', 'B3nj@minH@rris24'),
(15, 'isabellamartin', 'Is@b3llaM@rtin24'),
(16, 'masongarcia', 'M@s0nG@rcia24'),
(17, 'ethanmartinez', 'EthanM@rt!nez24'),
(18, 'charlotterobinson', 'Ch@rl0tteR0b!n24'),
(19, 'danielclark', 'D@n!elC!ark2024'),
(20, 'sofilewis', 'Sof!aL3wis24');
INSERT INTO employee (id, role, fname, mname, lname, email, mid,uid) VALUES
(1, 'Manager', 'John', 'Michael', 'Doe', 'john.doe01@example.com', NULL,1),
(2, 'Manager', 'Alice', 'Marie', 'Smith', 'alice.smith02@example.com', NULL,2),
(3, 'Manager', 'Robert', 'Lee', 'Johnson', 'robert.johnson03@example.com', NULL,3),
(4, 'Admin', 'Emily', 'Grace', 'Williams', 'emily.williams04@example.com', NULL,4),
(5, 'Admin', 'David', 'Paul', 'Brown', 'david.brown05@example.com', NULL,5),
(6, 'Waiter', 'Liam', 'James', 'Davis', 'liam.davis06@example.com', 1,6),
(7, 'Waiter', 'Olivia', 'Renee', 'Miller', 'olivia.miller07@example.com', 1,7),
(8, 'Waiter', 'Noah', 'Aaron', 'Wilson', 'noah.wilson08@example.com', 1,8),
(9, 'Waiter', 'Emma', 'Rose', 'Moore', 'emma.moore09@example.com', 2,9),
(10, 'Waiter', 'William', 'Joseph', 'Taylor', 'william.taylor10@example.com', 2,10),
(11, 'Waiter', 'Sophia', 'Claire', 'Anderson', 'sophia.anderson11@example.com', 2,11),
(12, 'Waiter', 'James', 'David', 'Thomas', 'james.thomas12@example.com', 3,12),
(13, 'Waiter', 'Ava', 'Leigh', 'Jackson', 'ava.jackson13@example.com', 3,13),
(14, 'Waiter', 'Benjamin', 'Owen', 'Harris', 'benjamin.harris14@example.com', 3,14),
(15, 'Waiter', 'Isabella', 'Faith', 'Martin', 'isabella.martin15@example.com', 3,15),
(16, 'Waiter', 'Mason', 'Tyler', 'Garcia', 'mason.garcia16@example.com', 1,16),
(17, 'Waiter', 'Ethan', 'Ryan', 'Martinez', 'ethan.martinez17@example.com', 1,17),
(18, 'Waiter', 'Charlotte', 'Alice', 'Robinson', 'charlotte.robinson18@example.com', 2,18),
(19, 'Waiter', 'Daniel', 'Jay', 'Clark', 'daniel.clark19@example.com', 2,19),
(20, 'Waiter', 'Sofia', 'May', 'Lewis', 'sofia.lewis20@example.com', 3,20);
INSERT INTO ecn (eid, contact) VALUES
(1, '1234567890'),
(1, '2345678901'),
(2, '3456789012'),
(3, '4567890123'),
(4, '5678901234'),
(5, '6789012345'),
(6, '7890123456'),
(7, '8901234567'),
(8, '9012345678'),
(9, '0123456789'),
(10, '1357924680'),
(10, '2468135790'),
(11, '3579135790'),
(12, '4680246802'),
(13, '5791357913'),
(14, '6802468024'),
(15, '7913579135'),
(16, '8024680246'),
(17, '9135791357'),
(18, '0246802468'),
(19, '1358642790'),
(20, '2469753081'),
(20, '3578642091'),
(19, '4689753204'),
(18, '5798643210'),
(17, '6843219870');
INSERT INTO waiter (wid)
SELECT id FROM employee WHERE role = 'waiter';
select * from user_account;
select * from employee;
select * from ecn;
select * from waiter;
INSERT INTO sales(sid, date, wid) VALUES 
(1, '2024-11-01', 6), (2, '2024-11-02', 7), (3, '2024-11-03', 8),
(4, '2024-11-04', 9), (5, '2024-11-05', 10), (6, '2024-11-06', 11),
(7, '2024-11-07', 12), (8, '2024-11-08', 13), (9, '2024-11-09', 14),
(10, '2024-11-10', 15), (11, '2024-11-11', 16), (12, '2024-11-12', 17),
(13, '2024-11-13', 18), (14, '2024-11-14', 19), (15, '2024-11-15', 20),
(16, '2024-11-16', 6), (17, '2024-11-17', 7), (18, '2024-11-18', 8),
(19, '2024-11-19', 9), (20, '2024-11-20', 10);
INSERT INTO dish(dname) VALUES 
('Spaghetti Carbonara'), ('Caesar Salad'), ('Margherita Pizza'), ('Chicken Alfredo'),
('BBQ Ribs'), ('Fish and Chips'), ('Grilled Cheese Sandwich'), ('Pasta Primavera'),
('Vegetable Stir Fry'), ('Fried Rice'), ('Stuffed Peppers'), ('Tom Yum Soup'),
('Eggplant Parmesan'), ('Beef Stroganoff'), ('Roast Chicken'), ('Clam Chowder'),
('Shrimp Scampi'), ('Fettuccine Alfredo'), ('Vegetable Lasagna'), ('Chicken Fajitas');
INSERT INTO orders(sid, dname) VALUES
(1, 'BBQ Ribs'), (1, 'Spaghetti Carbonara'),
(2, 'Caesar Salad'), (2, 'Margherita Pizza'),
(3, 'Chicken Alfredo'), (3, 'Fettuccine Alfredo'),
(4, 'Fish and Chips'), (4, 'Grilled Cheese Sandwich'),
(5, 'Pasta Primavera'), (5, 'Vegetable Stir Fry'),
(6, 'Fried Rice'), (6, 'Stuffed Peppers'), (6, 'Eggplant Parmesan'),
(7, 'Tom Yum Soup'), (7, 'Shrimp Scampi'),
(8, 'Beef Stroganoff'), (8, 'Roast Chicken'),
(9, 'Clam Chowder'), (9, 'Chicken Fajitas'),
(10, 'Vegetable Lasagna'), (10, 'Caesar Salad'),
(11, 'BBQ Ribs'), (11, 'Fettuccine Alfredo'),
(12, 'Spaghetti Carbonara'), (12, 'Vegetable Stir Fry'),
(13, 'Stuffed Peppers'), (13, 'Eggplant Parmesan'),
(14, 'Shrimp Scampi'), (14, 'Roast Chicken'),
(15, 'Beef Stroganoff'), (15, 'Clam Chowder'),
(16, 'Vegetable Lasagna'), (16, 'Caesar Salad'),
(17, 'Chicken Fajitas'), (17, 'Tom Yum Soup'),
(18, 'Fish and Chips'), (18, 'Grilled Cheese Sandwich'),
(19, 'Pasta Primavera'), (19, 'Fried Rice'),
(20, 'Stuffed Peppers'), (20, 'Eggplant Parmesan'), (20, 'BBQ Ribs');
select * from sales;
select * from dish;
select * from orders;
INSERT INTO supplier (sid, name, email) VALUES
(1, 'John Smith', 'john.smith@example.com'),
(2, 'Emily Johnson', 'emily.johnson@example.com'),
(3, 'Michael Brown', 'michael.brown@example.com'),
(4, 'Jessica Davis', 'jessica.davis@example.com'),
(5, 'David Wilson', 'david.wilson@example.com'),
(6, 'Sarah Miller', 'sarah.miller@example.com'),
(7, 'James Anderson', 'james.anderson@example.com'),
(8, 'Linda Thomas', 'linda.thomas@example.com'),
(9, 'Robert Jackson', 'robert.jackson@example.com'),
(10, 'Mary White', 'mary.white@example.com'),
(11, 'William Harris', 'william.harris@example.com'),
(12, 'Barbara Martin', 'barbara.martin@example.com'),
(13, 'Joseph Thompson', 'joseph.thompson@example.com'),
(14, 'Patricia Garcia', 'patricia.garcia@example.com'),
(15, 'Charles Martinez', 'charles.martinez@example.com'),
(16, 'Jennifer Robinson', 'jennifer.robinson@example.com'),
(17, 'Thomas Clark', 'thomas.clark@example.com'),
(18, 'Jessica Rodriguez', 'jessica.rodriguez@example.com'),
(19, 'Daniel Lewis', 'daniel.lewis@example.com'),
(20, 'Karen Lee', 'karen.lee@example.com'),
(21, 'Matthew Walker', 'matthew.walker@example.com'),
(22, 'Laura Hall', 'laura.hall@example.com'),
(23, 'Christopher Young', 'christopher.young@example.com'),
(24, 'Samantha Allen', 'samantha.allen@example.com'),
(25, 'Joshua King', 'joshua.king@example.com'),
(26, 'Nancy Wright', 'nancy.wright@example.com'),
(27, 'Anthony Scott', 'anthony.scott@example.com'),
(28, 'Sarah Green', 'sarah.green@example.com'),
(29, 'Charles Adams', 'charles.adams@example.com'),
(30, 'Sandra Nelson', 'sandra.nelson@example.com'),
(31, 'Kevin Carter', 'kevin.carter@example.com'),
(32, 'Helen Mitchell', 'helen.mitchell@example.com'),
(33, 'Stephen Perez', 'stephen.perez@example.com'),
(34, 'Jessica Roberts', 'jessica.roberts@example.com'),
(35, 'Barbara Turner', 'barbara.turner@example.com'),
(36, 'Eric Phillips', 'eric.phillips@example.com'),
(37, 'Emma Campbell', 'emma.campbell@example.com'),
(38, 'Daniel Parker', 'daniel.parker@example.com'),
(39, 'Laura Evans', 'laura.evans@example.com'),
(40, 'Paul Edwards', 'paul.edwards@example.com'),
(41, 'Rebecca Collins', 'rebecca.collins@example.com'),
(42, 'Megan Stewart', 'megan.stewart@example.com'),
(43, 'Lisa Sanchez', 'lisa.sanchez@example.com'),
(44, 'William Morris', 'william.morris@example.com'),
(45, 'Michelle Rogers', 'michelle.rogers@example.com'),
(46, 'Brian Reed', 'brian.reed@example.com'),
(47, 'Kimberly Cook', 'kimberly.cook@example.com'),
(48, 'Angela Morgan', 'angela.morgan@example.com'),
(49, 'Scott Bell', 'scott.bell@example.com'),
(50, 'Jessica Rivera', 'jessica.rivera@example.com');
INSERT INTO ingredients ( name, quantity,unit, cpu, rl, edate, sid, status) VALUES
('Tomatoes', 200, 'Kg',1, 50, '2025-01-01', 1, 'normal'),
('Onions', 180,'Kg', 1, 50, '2025-02-15', 1, 'normal'),
('Garlic', 150,'Kg', 1, 30, '2025-02-28', 1, 'normal'),
('Olive Oil', 250,'L' ,5, 80, '2025-03-20', 2, 'normal'),
( 'Vegetable Oil', 300,'L', 4, 100, '2025-03-15', 2, 'normal'),
( 'Carrots', 220, 'Kg',1, 60, '2025-01-25', 3, 'normal'),
( 'Potatoes', 300,'Kg', 1, 70, '2025-03-05', 3, 'normal'),
( 'Bell Peppers', 200,'Kg', 1, 50, '2025-01-10', 4, 'normal'),
( 'Zucchini', 150,'Kg', 1, 40, '2025-02-05', 4, 'normal'),
( 'Broccoli', 180,'Kg', 1, 50, '2025-02-20', 5, 'normal'),
( 'Chicken Breast', 500,'Kg', 8, 150, '2025-04-15', 6, 'normal'),
( 'Ground Beef', 400, 'Kg',7, 130, '2025-03-10', 6, 'normal'),
( 'Pork Chops', 350,'Kg', 9, 140, '2025-04-20', 7, 'normal'),
( 'Salmon Fillet', 200,'Kg', 12, 100, '2025-05-01', 7, 'normal'),
( 'Shrimp', 150, 'Kg',15, 90, '2025-05-15', 8, 'normal'),
( 'Eggs', 300, 'Kg',3, 70, '2025-01-30', 9, 'normal'),
( 'Basil', 100,'Kg', 1, 20, '2025-02-10', 10, 'normal'),
( 'Oregano', 100,'Kg', 1, 20, '2025-03-15', 10, 'normal'),
( 'Cumin', 100,'Kg', 1, 20, '2025-04-05', 10, 'normal'),
( 'Black Pepper', 100,'Kg', 1, 25, '2025-03-20', 10, 'normal'),
( 'Salt', 300,'Kg', 1, 20, '2025-12-31', 11, 'normal'),
( 'Sugar', 200,'Kg', 2, 30, '2025-06-15', 11, 'normal'),
( 'Flour', 500,'Kg', 2, 50, '2025-09-30', 12, 'normal'),
( 'Rice', 400,'Kg', 2, 60, '2025-10-15', 12, 'normal'),
( 'Pasta', 600,'Kg', 3, 50, '2025-11-01', 12, 'normal'),
( 'Lettuce', 150,'Kg', 1, 20, '2025-02-25', 13, 'normal'),
( 'Spinach', 100,'Kg', 1, 15, '2025-03-10', 13, 'normal'),
( 'Cucumber', 200,'Kg', 1, 30, '2025-02-15', 14, 'normal'),
( 'Mushrooms', 180,'Kg', 2, 30, '2025-04-10', 14, 'normal'),
( 'Corn', 220, 'Kg',1, 30, '2025-04-15', 15, 'normal'),
( 'Peas', 250,'Kg', 1, 40, '2025-03-01', 15, 'normal'),
( 'Cabbage', 180,'Kg', 1, 30, '2025-05-01', 16, 'normal'),
( 'Green Beans', 200,'Kg', 1, 40, '2025-05-15', 16, 'normal'),
( 'Herbs Mix', 150, 'Kg',2, 15, '2025-06-01', 17, 'normal'),
( 'Ginger', 120, 'Kg',1, 20, '2025-07-15', 17, 'normal'),
( 'Chili Powder', 100,'Kg', 1, 15, '2025-08-01', 18, 'normal'),
( 'Paprika', 100, 'Kg',1, 15, '2025-08-15', 18, 'normal'),
( 'Honey', 250,'L', 4, 60, '2025-09-30', 19, 'normal'),
( 'Soy Sauce', 300,'L', 3, 80, '2025-10-15', 19, 'normal'),
( 'Vinegar', 200,'L', 3, 50, '2025-11-01', 20, 'normal'),
( 'Ketchup', 250,'L', 3, 50, '2025-11-15', 20, 'normal'),
( 'Mustard', 200,'Kg', 2, 40, '2025-12-01', 21, 'normal'),
( 'Mayonnaise', 150,'Kg', 3, 60, '2025-12-15', 21, 'normal'),
( 'Barbecue Sauce', 220,'L', 3, 60, '2025-01-01', 22, 'normal'),
( 'Taco Seasoning', 100, 'Kg',1, 20, '2025-02-01', 22, 'normal'),
( 'Pesto', 150, 'Kg',3, 40, '2025-03-01', 23, 'normal'),
( 'Salsa', 250, 'Kg',3, 50, '2025-04-01', 23, 'normal'),
( 'Ranch Dressing', 200,'Kg', 3, 60, '2025-05-01', 24, 'normal'),
( 'Chili Sauce', 150,'Kg', 3, 50, '2025-06-01', 24, 'normal'),
( 'Teriyaki Sauce', 200,'Kg', 3, 50, '2025-07-01', 25, 'normal'),
( 'Tofu', 100,'Kg', 3, 20, '2025-08-01', 25, 'normal'),
( 'Tempeh', 150,'Kg', 4, 30, '2025-09-01', 26, 'normal'),
( 'Seitan', 120,'Kg', 4, 25, '2025-10-01', 26, 'normal'),
( 'Chickpeas', 250,'Kg', 3, 30, '2025-11-01', 27, 'normal'),
( 'Lentils', 300,'Kg', 3, 40, '2025-12-01', 27, 'normal'),
( 'Black Beans', 220,'Kg', 3, 30, '2025-01-15', 28, 'normal'),
( 'Kidney Beans', 200,'Kg', 3, 30, '2025-02-15', 28, 'normal'),
( 'Quinoa', 180, 'Kg',5, 40, '2025-03-01', 29, 'normal'),
( 'Brown Rice', 300,'Kg', 4, 50, '2025-04-01', 29, 'normal'),
( 'Couscous', 150,'Kg', 3, 30, '2025-05-01', 30, 'normal'),
( 'Barley', 200, 'Kg',4, 30, '2025-06-01', 30, 'normal'),
( 'Buckwheat', 180,'Kg', 3, 20, '2025-07-01', 31, 'normal'),
( 'Millet', 150,'Kg', 3, 20, '2025-08-01', 31, 'normal'),
( 'Chia Seeds', 100,'Kg', 5, 15, '2025-09-01', 32, 'normal'),
( 'Flaxseeds', 100, 'Kg',5, 15, '2025-10-01', 32, 'normal'),
( 'Sunflower Seeds', 150,'Kg', 5, 15, '2025-11-01', 33, 'normal'),
( 'Pumpkin Seeds', 200,'Kg', 5, 15, '2025-12-01', 33, 'normal'),
( 'Almonds', 150,'Kg', 5, 30, '2025-03-01', 34, 'normal'),
( 'Walnuts', 150,'Kg', 5, 30, '2025-04-01', 34, 'normal'),
( 'Pecans', 150,'Kg', 5, 30, '2025-05-01', 35, 'normal'),
( 'Hazelnuts', 150, 'Kg',5, 30, '2025-06-01', 35, 'normal'),
( 'Peanut Butter', 200,'Kg', 4, 50, '2025-07-01', 36, 'normal'),
( 'Nutella', 150, 'Kg',4, 50, '2025-08-01', 36, 'normal'),
( 'Dark Chocolate', 200,'Kg', 6, 80, '2025-09-01', 37, 'normal'),
( 'Milk', 300, 'L',2, 40, '2025-01-10', 38, 'normal'),
( 'Cream', 200,'L', 3, 60, '2025-01-20', 38, 'normal'),
( 'Yogurt', 250, 'Kg',2, 50, '2025-02-10', 39, 'normal'),
( 'Ice Cream', 300,'Kg', 5, 60, '2025-03-15', 39, 'normal'),
( 'Coconut Milk', 200,'L', 3, 50, '2025-04-10', 40, 'normal'),
( 'Almond Milk', 250,'L', 4, 50, '2025-05-05', 40, 'normal'),
( 'Soy Milk', 200,'L', 4, 50, '2025-06-01', 41, 'normal'),
( 'Rice Milk', 250,'L', 4, 50, '2025-07-01', 41, 'normal'),
( 'Bread', 500, 'Kg',1, 100, '2025-10-10', 42, 'normal'),
( 'Bagels', 300,'Kg', 2, 70, '2025-11-01', 42, 'normal'),
( 'Croissants', 250,'Kg', 3, 90, '2025-11-20', 43, 'normal'),
( 'Tortillas', 400, 'Kg',2, 80, '2025-12-01', 43, 'normal'),
( 'English Muffins', 300,'Kg', 2, 60, '2025-12-15', 44, 'normal'),
( 'Waffles', 250,'Kg', 3, 90, '2025-01-01', 44, 'normal'),
( 'Pancake Mix', 300,'Kg', 2, 50, '2025-01-10', 45, 'normal'),
( 'Baking Powder', 100,'Kg', 1, 20, '2025-02-01', 45, 'normal'),
( 'Baking Soda', 100,'Kg', 1, 20, '2025-03-01', 46, 'normal'),
( 'Yeast', 100,'Kg', 1, 20, '2025-04-01', 46, 'normal'),
( 'Vanilla Extract', 100,'L', 5, 80, '2025-05-01', 47, 'normal'),
( 'Cinnamon', 100,'Kg', 2, 30, '2025-06-01', 47, 'normal'),
( 'Nutmeg', 100, 'Kg',2, 30, '2025-07-01', 48, 'normal'),
( 'Cloves', 100, 'Kg',2, 30, '2025-08-01', 48, 'normal'),
( 'Allspice', 100,'Kg', 2, 30, '2025-09-01', 49, 'normal'),
( 'Cardamom', 100,'Kg', 2, 30, '2025-10-01', 49, 'normal'),
( 'Mace', 100, 'Kg',2, 30, '2025-11-01', 50, 'normal'),
( 'Saffron', 50, 'Kg',10, 20, '2025-12-01', 50, 'normal'),
( 'Cheese', 500, 'Kg',50, 50, '2025-03-01', 6, 'normal');
select * from supplier;
select * from ingredients;
INSERT INTO sorder (sid, quantity, unit,ingredient, od, dd, exp, price, status) VALUES
(1, 50,'kg', 'Pasta', '2024-11-01', '2024-11-05', '2024-11-20', 50, 'delivered'),
(2, 30,'kg' ,'Potatoes', '2024-11-02', '2024-11-06', '2024-11-18', 45, 'dispatched'),
(3, 20, 'kg' ,'Eggs', '2024-11-03', '2024-11-07', '2024-11-25', 30, 'processing'),
(4, 15,'kg' , 'Salt', '2024-11-04', '2024-11-08', '2024-11-19', 25, 'delivered'),
(5, 40,'kg' , 'Black Pepper', '2024-11-05', '2024-11-09', '2024-11-22', 35, 'placed'),
(6, 25,'kg' , 'Lettuce', '2024-11-06', '2024-11-10', '2024-11-23', 40, 'dispatched'),
(7, 60,'L', 'Olive Oil', '2024-11-07', '2024-11-11', '2024-11-27', 70, 'processing'),
(8, 10, 'kg' ,'Garlic', '2024-11-08', '2024-11-12', '2024-11-18', 20, 'placed'),
(9, 35,'kg' , 'Cheese', '2024-11-09', '2024-11-13', '2024-11-21', 55, 'dispatched'),
(10, 50,'kg' , 'Chicken Breast', '2024-11-10', '2024-11-14', '2024-11-24', 65, 'delivered');
select * from sorder;
INSERT INTO recipe (dname, iname, quantity) VALUES
-- Spaghetti Carbonara
('Spaghetti Carbonara', 'Pasta', 200),
('Spaghetti Carbonara', 'Potatoes', 100),
('Spaghetti Carbonara', 'Eggs', 2),
('Spaghetti Carbonara', 'Salt', 1),
('Spaghetti Carbonara', 'Black Pepper', 1),

-- Caesar Salad
('Caesar Salad', 'Lettuce', 100),
('Caesar Salad', 'Olive Oil', 20),
('Caesar Salad', 'Garlic', 1),
('Caesar Salad', 'Salt', 1),
('Caesar Salad', 'Black Pepper', 1),
('Caesar Salad', 'Cheese', 50),
('Caesar Salad', 'Chicken Breast', 150),

-- Margherita Pizza
('Margherita Pizza', 'Tomatoes', 50),
('Margherita Pizza', 'Flour', 200),
('Margherita Pizza', 'Salt', 1),
('Margherita Pizza', 'Black Pepper', 1),
('Margherita Pizza', 'Basil', 10),

-- Chicken Alfredo
('Chicken Alfredo', 'Chicken Breast', 150),
('Chicken Alfredo', 'Pasta', 200),
('Chicken Alfredo', 'Cream', 50),
('Chicken Alfredo', 'Garlic', 1),
('Chicken Alfredo', 'Salt', 1),
('Chicken Alfredo', 'Black Pepper', 1),

-- BBQ Ribs
('BBQ Ribs', 'Pork Chops', 300),
('BBQ Ribs', 'Barbecue Sauce', 50),
('BBQ Ribs', 'Salt', 1),
('BBQ Ribs', 'Black Pepper', 1),

-- Fish and Chips
('Fish and Chips', 'Salmon Fillet', 200),
('Fish and Chips', 'Potatoes', 150),
('Fish and Chips', 'Salt', 1),
('Fish and Chips', 'Black Pepper', 1),
('Fish and Chips', 'Vegetable Oil', 30),

-- Grilled Cheese Sandwich
('Grilled Cheese Sandwich', 'Bread', 2),
('Grilled Cheese Sandwich', 'Cheese', 100),
('Grilled Cheese Sandwich', 'Vegetable Oil', 10),

-- Pasta Primavera
('Pasta Primavera', 'Pasta', 200),
('Pasta Primavera', 'Bell Peppers', 50),
('Pasta Primavera', 'Carrots', 50),
('Pasta Primavera', 'Rice', 50),
('Pasta Primavera', 'Salt', 1),
('Pasta Primavera', 'Black Pepper', 1),

-- Vegetable Stir Fry
('Vegetable Stir Fry', 'Bell Peppers', 50),
('Vegetable Stir Fry', 'Zucchini', 50),
('Vegetable Stir Fry', 'Mushrooms', 50),
('Vegetable Stir Fry', 'Garlic', 1),
('Vegetable Stir Fry', 'Soy Sauce', 20),

-- Fried Rice
('Fried Rice', 'Rice', 200),
('Fried Rice', 'Carrots', 50),
('Fried Rice', 'Onions', 30),
('Fried Rice', 'Peas', 50),
('Fried Rice', 'Soy Sauce', 20),

-- Stuffed Peppers
('Stuffed Peppers', 'Bell Peppers', 100),
('Stuffed Peppers', 'Chickpeas', 50),
('Stuffed Peppers', 'Rice', 50),
('Stuffed Peppers', 'Garlic', 1),
('Stuffed Peppers', 'Salt', 1),

-- Tom Yum Soup
('Tom Yum Soup', 'Salmon Fillet', 50),
('Tom Yum Soup', 'Garlic', 1),
('Tom Yum Soup', 'Ginger', 10),
('Tom Yum Soup', 'Chili Powder', 5),
('Tom Yum Soup', 'Salt', 1),

-- Eggplant Parmesan
('Eggplant Parmesan', 'Tomatoes', 50),
('Eggplant Parmesan', 'Cheese', 100),
('Eggplant Parmesan', 'Carrots', 50),
('Eggplant Parmesan', 'Salt', 1),

-- Beef Stroganoff
('Beef Stroganoff', 'Ground Beef', 200),
('Beef Stroganoff', 'Pasta', 100),
('Beef Stroganoff', 'Cream', 30),
('Beef Stroganoff', 'Garlic', 1),

-- Roast Chicken
('Roast Chicken', 'Chicken Breast', 300),
('Roast Chicken', 'Olive Oil', 20),
('Roast Chicken', 'Oregano', 5),
('Roast Chicken', 'Salt', 1),

-- Clam Chowder
('Clam Chowder', 'Salmon Fillet', 200),
('Clam Chowder', 'Milk', 100),
('Clam Chowder', 'Cream', 50),
('Clam Chowder', 'Salt', 1),

-- Shrimp Scampi
('Shrimp Scampi', 'Shrimp', 150),
('Shrimp Scampi', 'Olive Oil', 20),
('Shrimp Scampi', 'Garlic', 1),

-- Fettuccine Alfredo
('Fettuccine Alfredo', 'Pasta', 200),
('Fettuccine Alfredo', 'Cream', 100),
('Fettuccine Alfredo', 'Cheese', 50),

-- Vegetable Lasagna
('Vegetable Lasagna', 'Carrots', 50),
('Vegetable Lasagna', 'Zucchini', 50),
('Vegetable Lasagna', 'Spinach', 50),
('Vegetable Lasagna', 'Cheese', 100),

-- Chicken Fajitas
('Chicken Fajitas', 'Chicken Breast', 150),
('Chicken Fajitas', 'Bell Peppers', 50),
('Chicken Fajitas', 'Tortillas', 2),
('Chicken Fajitas', 'Chili Powder', 5),
('Chicken Fajitas', 'Black Pepper', 1),
('Chicken Fajitas', 'Salt', 1);

select * from recipe;

DELIMITER //

CREATE TRIGGER prevent_empty_user_account
BEFORE INSERT ON user_account
FOR EACH ROW
BEGIN
    IF NEW.uid = '' OR NEW.username = '' OR NEW.password = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fields cannot be empty';
    END IF;
END; //

DELIMITER ;




DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    -- Check if the role of the new employee is 'waiter'
    IF NEW.role = 'waiter' THEN
        -- Insert the employee's id into the waiter table
        INSERT INTO waiter (wid) VALUES (NEW.id);
    END IF;
END //

DELIMITER ;
