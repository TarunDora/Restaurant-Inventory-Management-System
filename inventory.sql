
/*CREATE DATABASE IF NOT EXISTS restaurant_inventory_db;
USE restaurant_inventory_db;

CREATE TABLE IF NOT EXISTS user_account(
    uid int UNIQUE NOT NULL,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    PRIMARY KEY (uid)
);

CREATE TABLE IF NOT EXISTS employee(
    id int UNIQUE NOT NULL,
    role VARCHAR(50) NOT NULL,
    fname VARCHAR(50) NOT NULL,
    mname VARCHAR(50) ,
    lname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    mid int ,
    uid int UNIQUE NOT NULL,
    FOREIGN KEY (uid) REFERENCES user_account(uid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (mid) REFERENCES employee(id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS ecn(
    eid int NOT NULL,
    contact VARCHAR(50) NOT NULL,
    FOREIGN KEY (eid) REFERENCES employee(id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (eid, contact)
);

CREATE TABLE IF NOT EXISTS waiter(
    wid int UNIQUE NOT NULL,
    FOREIGN KEY (wid) REFERENCES employee(id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (wid)
);

CREATE TABLE IF NOT EXISTS sales(
    sid int NOT NULL,
    date DATE NOT NULL,
    wid int NOT NULL,
    FOREIGN KEY (wid) REFERENCES waiter(wid) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (sid)
);

CREATE TABLE IF NOT EXISTS supplier(
    sid int UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (sid)
);

CREATE TABLE IF NOT EXISTS ingredients(
    name VARCHAR(50) NOT NULL unique,
    quantity float NOT NULL,
    unit varchar(50) not null,
    cpu INT NOT NULL,
    rl INT NOT NULL,
    edate DATE NOT NULL,
    sid int NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (sid) REFERENCES supplier(sid) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (name)
);

CREATE TABLE IF NOT EXISTS dish(
    dname VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY (dname)
);

CREATE TABLE IF NOT EXISTS orders(
    sid int NOT NULL,
    dname VARCHAR(50) NOT NULL,
    FOREIGN KEY (sid) REFERENCES sales(sid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (dname) REFERENCES dish(dname) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (sid, dname)
);

CREATE TABLE IF NOT EXISTS recipe(
    dname VARCHAR(50) NOT NULL,
    iname VARCHAR(50) NOT NULL,
    quantity float NOT NULL,
    FOREIGN KEY (iname) REFERENCES ingredients(name),
    FOREIGN KEY (dname) REFERENCES dish(dname)
    -- PRIMARY KEY (dname, iname)
);

CREATE TABLE IF NOT EXISTS sorder(
    sid int NOT NULL,
    unit varchar(50) not null,
    quantity float NOT NULL,
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
(1,'a','a'),
(2,'b','b'),
(3,'c','c'),
(4,'d','d'),
(5,'e','e');
INSERT INTO employee (id, role, fname, mname, lname, email, mid,uid) VALUES
(1,'manager','Rahul','Kumar','Tiwari','rahul@gmail.com',NULL,1),
(2,'admin','Shubham',NULL,'Sharma','shubham@gmail.com',NULL,2),
(3,'waiter','Rohit','Raj','Pande','rohit@gmail.com',NULL,3),
(4,'waiter','Rohan','Kumar','Mittal','rohan@gmail.com',NULL,4),
(5,'waiter','Ritwik',NULL,'Verma','ritwik@gmail.com',NULL,5);
INSERT INTO ecn (eid, contact) VALUES
(1,'1234567890'),
(1,'6473849563'),
(2,'2859362788'),
(3,'9425857289'),
(4,'6382958392'),
(5,'2482523947');
-- INSERT INTO waiter (wid)
-- SELECT id FROM employee WHERE role = 'waiter';

INSERT INTO dish(dname) VALUES 
('Aloo Paratha'),
('Chaas'),
('Paneer Sandwich'),
('Roti'),
('Chicken Biryani'),
('Dosa'),
('Idli'),
('Vada'),
('Sambar'),
('Steamed Rice');

INSERT INTO supplier (sid, name, email) VALUES
(1,'kevin','kevin@gmail.com'),
(2,'mohan','mohan@gmail.com'),
(3,'sohan','sohan@gmail.com'),
(4,'ritu','ritu@gmail.com'),
(5,'smita','smita@gmail.com');
INSERT INTO ingredients ( name, quantity,unit, cpu, rl, edate, sid, status) VALUES
('Potato',3,'Kg',20,2,'2024-11-20',1,'normal'),
('Onion',5,'Kg',30,2,'2024-11-20',1,'normal'),
('Wheat Flour',4,'Kg',60,2,'2024-11-20',1,'normal'),
('Butter',6,'Kg',50,2,'2024-11-20',2,'normal'),
('Coriander Leaves',3,'Kg',30,1,'2024-11-20',2,'normal'),
('Salt',3,'Kg',50,2,'2024-11-20',2,'normal'),
('Chilli',3,'Kg',20,1,'2024-11-20',3,'normal');


INSERT INTO recipe (dname, iname, quantity) VALUES
-- Aloo Paratha
('Aloo Paratha', 'Potato', 0.3),
('Aloo Paratha', 'Onion', 0.2),
('Aloo Paratha', 'Wheat Flour', 0.5),
('Aloo Paratha', 'Salt', 0.03),
('Aloo Paratha', 'Butter', 0.05),
('Aloo Paratha', 'Coriander Leaves', 0.02),
('Aloo Paratha', 'Chilli', 0.01);
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
DELIMITER $$

DELIMITER $$

CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE ingredient_name VARCHAR(50);
    DECLARE required_qty FLOAT;
    DECLARE remaining_qty FLOAT;
    DECLARE done INT DEFAULT 0;

    -- Cursor to fetch ingredients and quantities for the dish
    DECLARE ingredient_cursor CURSOR FOR
        SELECT iname, quantity
        FROM recipe
        WHERE dname = NEW.dname;

    -- Handler for when the cursor is done
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN ingredient_cursor;

    ingredient_loop: LOOP
        FETCH ingredient_cursor INTO ingredient_name, required_qty;

        IF done = 1 THEN
            LEAVE ingredient_loop;
        END IF;

        -- Check if the ingredient exists in the ingredients table and has sufficient quantity
        SELECT quantity INTO remaining_qty
        FROM ingredients
        WHERE name = ingredient_name;

        IF remaining_qty < required_qty THEN
            SIGNAL SQLSTATE '45000';
            -- SET MESSAGE_TEXT = CONCAT('Insufficient stock for ingredient: ', ingredient_name);
        END IF;

        -- Deduct the required quantity from the ingredients table
        UPDATE ingredients
        SET quantity = quantity - required_qty
        WHERE name = ingredient_name;
    END LOOP;

    -- Close the cursor
    CLOSE ingredient_cursor;

    

END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER check_reorder_level
BEFORE UPDATE ON ingredients
FOR EACH ROW
BEGIN
    IF NEW.quantity <= NEW.rl THEN
        SET NEW.status = 'low';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE check_expiry(IN input_date DATE)
BEGIN
    UPDATE ingredients
    SET status = 'expired'
    WHERE edate < input_date;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE reset_quantity_for_expired_ingredients()
BEGIN
    -- Update the quantity of all expired ingredients to 0
    UPDATE ingredients
    SET quantity = 0
    WHERE status = 'expired';  -- Check if the status is 'expired'
END$$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE place_sorder(
    IN input_iname VARCHAR(50),
    IN input_quantity FLOAT,
    IN input_order_date DATE,
    IN input_delivery_date DATE,
    IN input_expiry_date DATE
)
BEGIN
    DECLARE ingredient_sid INT;
    DECLARE ingredient_cpu DECIMAL(10, 2);
    DECLARE total_cost DECIMAL(10, 2);
    DECLARE ingredient_quantity FLOAT;
    DECLARE ingredient_unit VARCHAR(50);

    -- Get the SID, CPU (cost per unit), quantity, and unit for the ingredient
    SELECT sid, cpu, quantity, unit
    INTO ingredient_sid, ingredient_cpu, ingredient_quantity, ingredient_unit
    FROM ingredients
    WHERE name = input_iname;

    -- Calculate total cost
    SET total_cost = ingredient_cpu * input_quantity;

    -- Insert the new order into the sorders table with 'placed' status
    INSERT INTO sorder (sid, unit, quantity, ingredient, od, dd, exp, price, status)
    VALUES (ingredient_sid, ingredient_unit, input_quantity, input_iname, input_order_date, input_delivery_date, input_expiry_date, total_cost, 'placed');
    
END$$

DELIMITER ;*/

DELIMITER $$

CREATE PROCEDURE update_ingredient_on_delivery(input_date DATE)
BEGIN
    DECLARE ingredient_name VARCHAR(50);
    DECLARE ordered_quantity FLOAT;
    DECLARE ingredient_quantity FLOAT;
    DECLARE expiry_date DATE;
    DECLARE delivery_date DATE;  -- Add delivery_date variable

    -- Declare a cursor to fetch all orders with status 'placed' and where the input date is greater than the delivery date (dd)
    DECLARE order_cursor CURSOR FOR
        SELECT ingredient, quantity, dd, exp
        FROM sorder
        WHERE status = 'placed' AND input_date >= dd; -- Check if the input date is greater than the delivery date (dd)

    -- Handler for when the cursor is done (if no matching records are found)
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET ingredient_name = NULL;

    -- Open the cursor
    OPEN order_cursor;

    -- Loop through each order
    order_loop: LOOP
        FETCH order_cursor INTO ingredient_name, ordered_quantity, delivery_date, expiry_date; -- Match the columns with the cursor

        -- If no more rows are found, exit the loop
        IF ingredient_name IS NULL THEN
            LEAVE order_loop;
        END IF;

        -- Get the current quantity of the ingredient from the ingredients table
        SELECT quantity INTO ingredient_quantity
        FROM ingredients
        WHERE name = ingredient_name;

        -- If the ingredient exists, update its quantity, status, and expiry date
        IF ingredient_quantity IS NOT NULL THEN
            -- Update the quantity, status, and expiry date in the ingredients table
            UPDATE ingredients
            SET quantity = quantity + ordered_quantity, 
                status = 'normal',
                edate = expiry_date  -- Update the expiry date from the sorder table
            WHERE name = ingredient_name;

            -- Update the status in the sorder table to 'delivered'
            UPDATE sorder
            SET status = 'delivered'
            WHERE ingredient = ingredient_name AND dd = delivery_date AND exp = expiry_date AND status = 'placed'; -- Ensure the status is 'placed'
        END IF;

    END LOOP;

    -- Close the cursor
    CLOSE order_cursor;

END$$

DELIMITER ;



