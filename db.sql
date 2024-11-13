create database if not exists restaurant_inventory_db;
use restaurant_inventory_db;
create table if not exists user_account(
	uid varchar(50) unique not null,
    username varchar(50) not null,
    password varchar(50) not null,
    primary key (uid)
);
create table if not exists employee(
	id varchar(50) unique not null,
    role varchar(50) not null,
    fname varchar(50) not null,
    mname varchar(50),
    lname varchar(50),
    email varchar(50) not null,
    mid varchar(50) null,
    uid varchar(50) unique,
    foreign key (uid) references user_account(uid),
    primary key (id)
);
create table if not exists ecn(
	eid varchar(50) not null,
    contact varchar(50) not null,
    foreign key (eid) references employee(id),
    primary key (eid,contact)
);
create table if not exists waiter(
	wid varchar(50) unique not null,
	foreign key (wid) references employee(id),
    primary key (wid)
);
create table if not exists sales(
	sid varchar(50),
    date date not null,
    wid varchar(50) not null,
    foreign key (wid) references waiter(wid),
    primary key (sid)
);
create table if not exists supplier(
	sid varchar(50) unique not null,
    name varchar(50),
    email varchar(50),
    primary key (sid)
);
create table if not exists ingredients(
	iid varchar(50),
    name varchar(50),
    quantity int,
    cpu int,
    rl int,
    edate date,
    sid varchar(50),
    primary key (iid),
    status varchar(50),
    foreign key (sid) references supplier(sid)
);
create table if not exists dish(
    dname varchar(50) unique not null,
    primary key (dname)
);
create table if not exists orders(
	sid varchar(50),
    dname varchar(50),
    foreign key (sid) references sales(sid),
    foreign key (dname) references dish(dname),
    primary key (sid,dname)
);
create table if not exists recipe(
	dname varchar(50),
    iid varchar(50),
    quantity int,
    foreign key (iid) references ingredients(iid),
    foreign key (dname) references dish(dname),
    primary key (dname,iid)
);
create table if not exists sorder(
	sid varchar(50),
    quantity int,
    ingredient varchar(50),
    od date,
    dd date,
    exp date,
    price float(7,2),
    status varchar(50),
    foreign key (sid) references supplier(sid),
    foreign key (ingredient) references ingredients(iid),
    primary key (sid,ingredient,od)
);
INSERT INTO user_account (uid, username, password) VALUES
(1, 'johndoe', 'johndoe'),
(2, 'alicesmith', 'alicesmith'),
(3, 'robertjohnson', 'robertjohnson'),
(4, 'emilywilliams', 'emilywilliams'),
(5, 'davidbrown', 'davidbrown'),
(6, 'liamdavis', 'liamdavis'),
(7, 'oliviamiller', 'oliviamiller'),
(8, 'noahwilson', 'noahwilson'),
(9, 'emmaMoore', 'emmaMoore'),
(10, 'williamtaylor', 'williamtaylor'),
(11, 'sophiaanderson', 'sophiaanderson'),
(12, 'jamesthomas', 'jamesthomas'),
(13, 'avajackson', 'avajackson'),
(14, 'benjaminharris', 'benjaminharris'),
(15, 'isabellamartin', 'isabellamartin'),
(16, 'masongarcia', 'masongarcia'),
(17, 'ethanmartinez', 'ethanmartinez'),
(18, 'charlotterobinson', 'charlotterobinson'),
(19, 'danielclark', 'danielclark'),
(20, 'sofilewis', 'sofilewis');

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
(2, '3456789012'),
(3, '4567890123'),
(4, '5678901234'),
(5, '6789012345'),
(6, '7890123456'),
(7, '8901234567'),
(8, '9012345678'),
(9, '0123456789'),
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
(20, '2469753081');

INSERT INTO waiter (wid) SELECT id FROM employee WHERE role = 'waiter';
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

INSERT INTO ingredients (iid, name, quantity, cpu, rl, edate, sid, status) VALUES
(1, 'Tomatoes', 200, 1, 50, '2025-01-01', 1, 'normal'),
(2, 'Onions', 180, 1, 50, '2025-02-15', 1, 'normal'),
(3, 'Garlic', 150, 1, 30, '2025-02-28', 1, 'normal'),
(4, 'Olive Oil', 250, 5, 80, '2025-03-20', 2, 'normal'),
(5, 'Vegetable Oil', 300, 4, 100, '2025-03-15', 2, 'normal'),
(6, 'Carrots', 220, 1, 60, '2025-01-25', 3, 'normal'),
(7, 'Potatoes', 300, 1, 70, '2025-03-05', 3, 'normal'),
(8, 'Bell Peppers', 200, 1, 50, '2025-01-10', 4, 'normal'),
(9, 'Zucchini', 150, 1, 40, '2025-02-05', 4, 'normal'),
(10, 'Broccoli', 180, 1, 50, '2025-02-20', 5, 'normal'),
(11, 'Chicken Breast', 500, 8, 150, '2025-04-15', 6, 'normal'),
(12, 'Ground Beef', 400, 7, 130, '2025-03-10', 6, 'normal'),
(13, 'Pork Chops', 350, 9, 140, '2025-04-20', 7, 'normal'),
(14, 'Salmon Fillet', 200, 12, 100, '2025-05-01', 7, 'normal'),
(15, 'Shrimp', 150, 15, 90, '2025-05-15', 8, 'normal'),
(16, 'Eggs', 300, 3, 70, '2025-01-30', 9, 'normal'),
(17, 'Basil', 100, 1, 20, '2025-02-10', 10, 'normal'),
(18, 'Oregano', 100, 1, 20, '2025-03-15', 10, 'normal'),
(19, 'Cumin', 100, 1, 20, '2025-04-05', 10, 'normal'),
(20, 'Black Pepper', 100, 1, 25, '2025-03-20', 10, 'normal'),
(21, 'Salt', 300, 1, 20, '2025-12-31', 11, 'normal'),
(22, 'Sugar', 200, 2, 30, '2025-06-15', 11, 'normal'),
(23, 'Flour', 500, 2, 50, '2025-09-30', 12, 'normal'),
(24, 'Rice', 400, 2, 60, '2025-10-15', 12, 'normal'),
(25, 'Pasta', 600, 3, 50, '2025-11-01', 12, 'normal'),
(26, 'Lettuce', 150, 1, 20, '2025-02-25', 13, 'normal'),
(27, 'Spinach', 100, 1, 15, '2025-03-10', 13, 'normal'),
(28, 'Cucumber', 200, 1, 30, '2025-02-15', 14, 'normal'),
(29, 'Mushrooms', 180, 2, 30, '2025-04-10', 14, 'normal'),
(30, 'Corn', 220, 1, 30, '2025-04-15', 15, 'normal'),
(31, 'Peas', 250, 1, 40, '2025-03-01', 15, 'normal'),
(32, 'Cabbage', 180, 1, 30, '2025-05-01', 16, 'normal'),
(33, 'Green Beans', 200, 1, 40, '2025-05-15', 16, 'normal'),
(34, 'Herbs Mix', 150, 2, 15, '2025-06-01', 17, 'normal'),
(35, 'Ginger', 120, 1, 20, '2025-07-15', 17, 'normal'),
(36, 'Chili Powder', 100, 1, 15, '2025-08-01', 18, 'normal'),
(37, 'Paprika', 100, 1, 15, '2025-08-15', 18, 'normal'),
(38, 'Honey', 250, 4, 60, '2025-09-30', 19, 'normal'),
(39, 'Soy Sauce', 300, 3, 80, '2025-10-15', 19, 'normal'),
(40, 'Vinegar', 200, 3, 50, '2025-11-01', 20, 'normal'),
(41, 'Ketchup', 250, 3, 50, '2025-11-15', 20, 'normal'),
(42, 'Mustard', 200, 2, 40, '2025-12-01', 21, 'normal'),
(43, 'Mayonnaise', 150, 3, 60, '2025-12-15', 21, 'normal'),
(44, 'Barbecue Sauce', 220, 3, 60, '2025-01-01', 22, 'normal'),
(45, 'Taco Seasoning', 100, 1, 20, '2025-02-01', 22, 'normal'),
(46, 'Pesto', 150, 3, 40, '2025-03-01', 23, 'normal'),
(47, 'Salsa', 250, 3, 50, '2025-04-01', 23, 'normal'),
(48, 'Ranch Dressing', 200, 3, 60, '2025-05-01', 24, 'normal'),
(49, 'Chili Sauce', 150, 3, 50, '2025-06-01', 24, 'normal'),
(50, 'Teriyaki Sauce', 200, 3, 50, '2025-07-01', 25, 'normal'),
(51, 'Tofu', 100, 3, 20, '2025-08-01', 25, 'normal'),
(52, 'Tempeh', 150, 4, 30, '2025-09-01', 26, 'normal'),
(53, 'Seitan', 120, 4, 25, '2025-10-01', 26, 'normal'),
(54, 'Chickpeas', 250, 3, 30, '2025-11-01', 27, 'normal'),
(55, 'Lentils', 300, 3, 40, '2025-12-01', 27, 'normal'),
(56, 'Black Beans', 220, 3, 30, '2025-01-15', 28, 'normal'),
(57, 'Kidney Beans', 200, 3, 30, '2025-02-15', 28, 'normal'),
(58, 'Quinoa', 180, 5, 40, '2025-03-01', 29, 'normal'),
(59, 'Brown Rice', 300, 4, 50, '2025-04-01', 29, 'normal'),
(60, 'Couscous', 150, 3, 30, '2025-05-01', 30, 'normal'),
(61, 'Barley', 200, 4, 30, '2025-06-01', 30, 'normal'),
(62, 'Buckwheat', 180, 3, 20, '2025-07-01', 31, 'normal'),
(63, 'Millet', 150, 3, 20, '2025-08-01', 31, 'normal'),
(64, 'Chia Seeds', 100, 5, 15, '2025-09-01', 32, 'normal'),
(65, 'Flaxseeds', 100, 5, 15, '2025-10-01', 32, 'normal'),
(66, 'Sunflower Seeds', 150, 5, 15, '2025-11-01', 33, 'normal'),
(67, 'Pumpkin Seeds', 200, 5, 15, '2025-12-01', 33, 'normal'),
(68, 'Almonds', 150, 5, 30, '2025-03-01', 34, 'normal'),
(69, 'Walnuts', 150, 5, 30, '2025-04-01', 34, 'normal'),
(70, 'Pecans', 150, 5, 30, '2025-05-01', 35, 'normal'),
(71, 'Hazelnuts', 150, 5, 30, '2025-06-01', 35, 'normal'),
(72, 'Peanut Butter', 200, 4, 50, '2025-07-01', 36, 'normal'),
(73, 'Nutella', 150, 4, 50, '2025-08-01', 36, 'normal'),
(74, 'Dark Chocolate', 200, 6, 80, '2025-09-01', 37, 'normal'),
(75, 'Milk', 300, 2, 40, '2025-01-10', 38, 'normal'),
(76, 'Cream', 200, 3, 60, '2025-01-20', 38, 'normal'),
(77, 'Yogurt', 250, 2, 50, '2025-02-10', 39, 'normal'),
(78, 'Ice Cream', 300, 5, 60, '2025-03-15', 39, 'normal'),
(79, 'Coconut Milk', 200, 3, 50, '2025-04-10', 40, 'normal'),
(80, 'Almond Milk', 250, 4, 50, '2025-05-05', 40, 'normal'),
(81, 'Soy Milk', 200, 4, 50, '2025-06-01', 41, 'normal'),
(82, 'Rice Milk', 250, 4, 50, '2025-07-01', 41, 'normal'),
(83, 'Bread', 500, 1, 100, '2025-10-10', 42, 'normal'),
(84, 'Bagels', 300, 2, 70, '2025-11-01', 42, 'normal'),
(85, 'Croissants', 250, 3, 90, '2025-11-20', 43, 'normal'),
(86, 'Tortillas', 400, 2, 80, '2025-12-01', 43, 'normal'),
(87, 'English Muffins', 300, 2, 60, '2025-12-15', 44, 'normal'),
(88, 'Waffles', 250, 3, 90, '2025-01-01', 44, 'normal'),
(89, 'Pancake Mix', 300, 2, 50, '2025-01-10', 45, 'normal'),
(90, 'Baking Powder', 100, 1, 20, '2025-02-01', 45, 'normal'),
(91, 'Baking Soda', 100, 1, 20, '2025-03-01', 46, 'normal'),
(92, 'Yeast', 100, 1, 20, '2025-04-01', 46, 'normal'),
(93, 'Vanilla Extract', 100, 5, 80, '2025-05-01', 47, 'normal'),
(94, 'Cinnamon', 100, 2, 30, '2025-06-01', 47, 'normal'),
(95, 'Nutmeg', 100, 2, 30, '2025-07-01', 48, 'normal'),
(96, 'Cloves', 100, 2, 30, '2025-08-01', 48, 'normal'),
(97, 'Allspice', 100, 2, 30, '2025-09-01', 49, 'normal'),
(98, 'Cardamom', 100, 2, 30, '2025-10-01', 49, 'normal'),
(99, 'Mace', 100, 2, 30, '2025-11-01', 50, 'normal'),
(100, 'Saffron', 50, 10, 20, '2025-12-01', 50, 'normal'),
(101, 'Cheese', 500, 50, 50, '2025-03-01', 6, 'normal');

select * from supplier;
select * from ingredients;

INSERT INTO sorder (sid, quantity, ingredient, od, dd, exp, price, status) VALUES
(1, 50, 1, '2024-11-01', '2024-11-05', '2024-11-20', 50, 'delivered'),
(2, 30, 2, '2024-11-02', '2024-11-06', '2024-11-18', 45, 'dispatched'),
(3, 20, 3, '2024-11-03', '2024-11-07', '2024-11-25', 30, 'processing'),
(4, 15, 6, '2024-11-04', '2024-11-08', '2024-11-19', 25, 'delivered'),
(5, 40, 7, '2024-11-05', '2024-11-09', '2024-11-22', 35, 'placed'),
(6, 25, 8, '2024-11-06', '2024-11-10', '2024-11-23', 40, 'dispatched'),
(7, 60, 10, '2024-11-07', '2024-11-11', '2024-11-27', 70, 'processing'),
(8, 10, 27, '2024-11-08', '2024-11-12', '2024-11-18', 20, 'placed'),
(9, 35, 29, '2024-11-09', '2024-11-13', '2024-11-21', 55, 'dispatched'),
(10, 50, 9, '2024-11-10', '2024-11-14', '2024-11-24', 65, 'delivered');

select * from sorder;
INSERT INTO recipe (dname, iid, quantity) VALUES
-- Spaghetti Carbonara
('Spaghetti Carbonara', 25, 200),  -- Pasta
('Spaghetti Carbonara', 7, 100),   -- Potatoes (for texture or garnish)
('Spaghetti Carbonara', 16, 2),    -- Eggs
('Spaghetti Carbonara', 21, 1),    -- Salt
('Spaghetti Carbonara', 20, 1),    -- Black Pepper

-- Caesar Salad
('Caesar Salad', 26, 100),         -- Lettuce
('Caesar Salad', 4, 20),           -- Olive Oil
('Caesar Salad', 3, 1),            -- Garlic
('Caesar Salad', 21, 1),           -- Salt
('Caesar Salad', 20, 1),           -- Black Pepper
('Caesar Salad', 101, 50),         -- Cheese
('Caesar Salad', 11, 150),         -- Chicken Breast

-- Margherita Pizza
('Margherita Pizza', 1, 50),       -- Tomatoes
('Margherita Pizza', 25, 200),     -- Flour
('Margherita Pizza', 21, 1),       -- Salt
('Margherita Pizza', 20, 1),       -- Black Pepper
('Margherita Pizza', 17, 10),      -- Basil

-- Chicken Alfredo
('Chicken Alfredo', 11, 150),      -- Chicken Breast
('Chicken Alfredo', 25, 200),      -- Pasta
('Chicken Alfredo', 76, 50),       -- Cream
('Chicken Alfredo', 3, 1),         -- Garlic
('Chicken Alfredo', 21, 1),        -- Salt
('Chicken Alfredo', 20, 1),        -- Black Pepper

-- BBQ Ribs
('BBQ Ribs', 13, 300),             -- Pork Chops
('BBQ Ribs', 44, 50),              -- Barbecue Sauce
('BBQ Ribs', 21, 1),               -- Salt
('BBQ Ribs', 20, 1),               -- Black Pepper

-- Fish and Chips
('Fish and Chips', 14, 200),       -- Salmon Fillet
('Fish and Chips', 7, 150),        -- Potatoes
('Fish and Chips', 21, 1),         -- Salt
('Fish and Chips', 20, 1),         -- Black Pepper
('Fish and Chips', 5, 30),         -- Vegetable Oil

-- Grilled Cheese Sandwich
('Grilled Cheese Sandwich', 83, 2), -- Bread
('Grilled Cheese Sandwich', 101, 100), -- Cheese
('Grilled Cheese Sandwich', 5, 10),  -- Vegetable Oil

-- Pasta Primavera
('Pasta Primavera', 25, 200),      -- Pasta
('Pasta Primavera', 8, 50),        -- Bell Peppers
('Pasta Primavera', 6, 50),        -- Carrots
('Pasta Primavera', 24, 50),       -- Rice
('Pasta Primavera', 21, 1),        -- Salt
('Pasta Primavera', 20, 1),        -- Black Pepper

-- Vegetable Stir Fry
('Vegetable Stir Fry', 8, 50),     -- Bell Peppers
('Vegetable Stir Fry', 9, 50),     -- Zucchini
('Vegetable Stir Fry', 29, 50),    -- Mushrooms
('Vegetable Stir Fry', 3, 1),      -- Garlic
('Vegetable Stir Fry', 39, 20),    -- Soy Sauce

-- Fried Rice
('Fried Rice', 24, 200),           -- Rice
('Fried Rice', 6, 50),             -- Carrots
('Fried Rice', 2, 30),             -- Onions
('Fried Rice', 31, 50),            -- Peas
('Fried Rice', 39, 20),            -- Soy Sauce

-- Stuffed Peppers
('Stuffed Peppers', 8, 100),       -- Bell Peppers
('Stuffed Peppers', 54, 50),       -- Chickpeas
('Stuffed Peppers', 24, 50),       -- Rice
('Stuffed Peppers', 3, 1),         -- Garlic
('Stuffed Peppers', 21, 1),        -- Salt

-- Tom Yum Soup
('Tom Yum Soup', 14, 50),          -- Salmon Fillet
('Tom Yum Soup', 3, 1),            -- Garlic
('Tom Yum Soup', 35, 10),          -- Ginger
('Tom Yum Soup', 36, 5),           -- Chili Powder
('Tom Yum Soup', 21, 1),           -- Salt

-- Eggplant Parmesan
('Eggplant Parmesan', 1, 50),      -- Tomatoes
('Eggplant Parmesan', 101, 100),   -- Cheese
('Eggplant Parmesan', 6, 50),      -- Carrots
('Eggplant Parmesan', 21, 1),      -- Salt

-- Beef Stroganoff
('Beef Stroganoff', 12, 200),      -- Ground Beef
('Beef Stroganoff', 25, 100),      -- Pasta
('Beef Stroganoff', 76, 30),       -- Cream
('Beef Stroganoff', 3, 1),         -- Garlic

-- Roast Chicken
('Roast Chicken', 11, 300),        -- Chicken Breast
('Roast Chicken', 4, 20),          -- Olive Oil
('Roast Chicken', 18, 5),          -- Oregano
('Roast Chicken', 21, 1),          -- Salt

-- Clam Chowder
('Clam Chowder', 14, 200),         -- Salmon Fillet
('Clam Chowder', 75, 100),         -- Milk
('Clam Chowder', 76, 50),          -- Cream
('Clam Chowder', 21, 1),           -- Salt

-- Shrimp Scampi
('Shrimp Scampi', 15, 150),        -- Shrimp
('Shrimp Scampi', 4, 20),          -- Olive Oil
('Shrimp Scampi', 3, 1),           -- Garlic

-- Fettuccine Alfredo
('Fettuccine Alfredo', 25, 200),   -- Pasta
('Fettuccine Alfredo', 76, 100),   -- Cream
('Fettuccine Alfredo', 101, 50),   -- Cheese

-- Vegetable Lasagna
('Vegetable Lasagna', 6, 50),      -- Carrots
('Vegetable Lasagna', 9, 50),      -- Zucchini
('Vegetable Lasagna', 27, 50),     -- Spinach
('Vegetable Lasagna', 101, 100),   -- Cheese

-- Chicken Fajitas
('Chicken Fajitas', 11, 150),      -- Chicken Breast
('Chicken Fajitas', 8, 50),        -- Bell Peppers
('Chicken Fajitas', 86, 2),        -- Tortillas
('Chicken Fajitas', 36, 5),        -- Chili Powder
('Chicken Fajitas', 20, 1),        -- Black Pepper
('Chicken Fajitas', 21, 1);        -- Salt