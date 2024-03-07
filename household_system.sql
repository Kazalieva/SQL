CREATE DATABASE IF NOT EXISTS household_system;
USE household_system;

CREATE TABLE IF NOT EXISTS tasks(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
description VARCHAR(255) NOT NULL,
due_date DATETIME DEFAULT NULL NULL,
completed BOOL DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS family_members(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
egn VARCHAR(10) UNIQUE NOT NULL,
name VARCHAR(100) NOT NULL,
gender CHAR NOT NULL,
address VARCHAR(100) NOT NULL,
email VARCHAR(100) DEFAULT NULL NULL,
phone VARCHAR (10) NOT NULL,
income_month DOUBLE NOT NULL
);

CREATE TABLE IF NOT EXISTS income(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
amount DOUBLE NOT NULL,
income_data DATETIME NOT NULL,
month ENUM('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'),
description VARCHAR(255) NOT NULL,
family_income INT NOT NULL,
CONSTRAINT FOREIGN KEY (family_income) REFERENCES family_members(id)
);

CREATE TABLE IF NOT EXISTS expense(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
amount DOUBLE NOT NULL,
expense_data DATETIME NOT NULL,
month ENUM('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'),
description VARCHAR(255) NOT NULL,
family_expense INT NOT NULL,
CONSTRAINT FOREIGN KEY (family_expense) REFERENCES family_members(id)
);

CREATE TABLE IF NOT EXISTS family_member_task(
member_id INT NOT NULL,
task_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(member_id) REFERENCES family_members(id),
CONSTRAINT FOREIGN KEY(task_id) REFERENCES tasks(id)
);

CREATE TABLE IF NOT EXISTS shops(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
address VARCHAR(100) NOT NULL, 
town VARCHAR(100) NOT NULL,
phone VARCHAR(10) NOT NULL,
email VARCHAR(100) NULL DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS manufacturers(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
address VARCHAR(100) NOT NULL, 
town VARCHAR(100) NULL DEFAULT NULL,
phone VARCHAR(10) NOT NULL,
email VARCHAR(100) NULL DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS categories(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
description VARCHAR(255) NULL DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS repairs(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
description VARCHAR(255) NOT NULL, 
data_start DATETIME NOT NULL,
status ENUM ('Ready', 'In process') NOT NULL
);


CREATE TABLE IF NOT EXISTS belongings(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
data_buying DATETIME NOT NULL,
is_Appliance BOOL NOT NULL,
price_one DECIMAL(9,2) NOT NULL,
family_member INT NOT NULL,
shop_id INT NOT NULL,
manufacturer_id INT NOT NULL,
repair_id INT NULL DEFAULT NULL,
category_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (family_member) REFERENCES family_members(id),
CONSTRAINT FOREIGN KEY (shop_id) REFERENCES shops(id),
CONSTRAINT FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id),
CONSTRAINT FOREIGN KEY (repair_id) REFERENCES repairs(id),
CONSTRAINT FOREIGN KEY (category_id) REFERENCES categories(id)
);


-- tasks
INSERT INTO tasks (name, description, due_date, completed)
VALUES 
('Clean the garage', 'Organize tools and equipment', '2023-04-10 18:00:00', 0),
('Pay bills', 'Utilities and credit cards', '2023-04-15 23:59:59', 0),
('Buy groceries', 'Milk, bread, eggs, etc.', '2023-04-06 12:00:00', 1),
('Take the car to the shop', 'Replace brake pads', NULL, 0);

-- family_members
INSERT INTO family_members (egn, name, gender, address, email, phone, income_month)
VALUES 
('1234567894', 'John Smith', 'M', '123 Main St, Los Angeles USA', 'johnsmith@gmail.com', '555-1234', 5000),
('2345678907', 'Jane Smith', 'F',  '123 Main St, Sofia', 'janesmith@gmail.com', '555-5678', 5000),
('3456789017', 'Bob Smith', 'M',  '123 Main St, Sofia', NULL, '555-9012', 2000),
('4567890124', 'Sara Smith', 'F', '123 Main St, Sofia', 'sara.smith@yahoo.com', '555-3456', 2000),
('1234567454', 'Ahmed Grosh', 'M', '123 Main St, Dubai', 'ahmed@gmail.com', '555-1235', 6000),
('0115678907', 'Aleks Stan', 'M', '123 Main St, Sofia', 'stan@gmail.com', '335-5678', 6000),
('0515678907', 'Veselin Ivanov', 'M', 'Nicola Gabrovski 1, Sofia', 'veso@gmail.com', '445-5678', 0);

-- income
INSERT INTO income (amount, income_data, month, description, family_income) 
VALUES (1500.00, '2022-01-05', 'January', 'Salary', 1),
       (200.50, '2022-02-10', 'February', 'Bonus', 1),
       (300.00, '2022-02-15', 'February', 'Freelance', 1),
       (1600.00, '2022-03-01', 'March', 'Salary', 1),
       (1600.00, '2022-04-01', 'April', 'Salary', 1),
       (1600.00, '2022-05-01', 'May', 'Salary', 1),
       (1600.00, '2022-06-01', 'June', 'Salary', 1),
       (1600.00, '2022-07-01', 'July', 'Salary', 1),
       (1700.00, '2022-08-01', 'August', 'Salary', 1),
       (1600.00, '2022-09-01', 'October', 'Salary', 1),
       (1600.00, '2022-10-01', 'November', 'Salary', 1),
       (1600.00, '2022-11-01', 'December', 'Salary', 1),
       (200.50, '2022-12-10', 'December', 'Bonus', 1),
       (400.50, '2022-02-10', 'February', 'Bonus', 3),
       (300.50, '2022-02-10', 'February', 'Bonus', 5);
       
-- expense
INSERT INTO expense (amount, expense_data, month, description, family_expense) 
VALUES (50.00, '2022-01-02', 'January', 'Groceries', 1),
       (80.00, '2022-02-20', 'February', 'Clothes', 1),
       (30.00, '2022-03-07', 'March', 'Transport', 1),
       (100.00, '2022-03-22', 'March', 'Entertainment', 1),
       (100.00, '2022-04-02', 'April', 'Groceries', 1),
	   (100.00, '2022-05-02', 'May', 'Groceries', 1),
       (100.00, '2022-06-02', 'June', 'Groceries', 1),
       (100.00, '2022-07-02', 'July', 'Groceries', 1),
       (100.00, '2022-08-02', 'August', 'Groceries', 1),
       (100.00, '2022-09-02', 'September', 'Groceries', 1),
       (100.00, '2022-09-02', 'September', 'Vacantion', 1),
       (100.00, '2022-10-02', 'October', 'Groceries', 1),
       (100.00, '2022-11-02', 'November', 'Groceries', 1),
       (100.00, '2022-11-02', 'November', 'Medicines', 1),
       (100.00, '2022-12-02', 'December', 'Groceries', 1),
       (1100.00, '2022-12-02', 'December', 'Vacantion', 1),
       (150.00, '2022-04-02', 'April', 'Groceries', 3),
       (80.00, '2022-04-02', 'April', 'Groceries', 4);
       
-- family_member_task
INSERT INTO family_member_task (member_id, task_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 3);

-- shops
INSERT INTO shops (name, address, town, phone, email)
VALUES 
('Walmart', 'Mladost 12', 'Sofia', '555-1000', NULL),
('Target', 'Industrialna 14', 'Plovdiv', '555-2000', NULL),
('Kroger', 'Kliment Ohridski', 'Sofia', '555-3044', NULL),
('Douglas', 'bul Vitosha', 'Sofia', '555-1234', NULL),
('HM', 'Sveti Georgi', 'Plovdiv', '555-2000', NULL),
('IKEA', 'Tsar Osvoboditel', 'Sofia', '555-3000', NULL),
('Cross', 'ul. "Gotse Delchev" 34','Sofia', '094601555', 'cross@crosscycle.com');

-- manufacturers
INSERT INTO manufacturers (name, address, town, phone, email)
VALUES 
('Samsung', 'Seoul 12', 'South Korea', '080011131', 'contact@samsung.com'),
('Furniture Yavor', 'bul. Slivnica 125 ', 'Sofia', '555-4567', 'contact@yavor.com'),
('Bosch', 'Tsarigradsko shose Blvd. Sofia Tech Park', 'Sofia', '0888569890', 'contact@bosch.com'),
('Asus', 'Tsarigradsko shose Blvd. Mladost', 'Sofia', '0888457890', 'contact@asus.com'),
('Rowenta', 'www.rowenta.bg', NULL, '0888569897', 'contact@rowenta.com'),
('Cross', 'ul. "Industrialna" 34','Montana', '094601045', 'cross@crosscycle.com');

-- categories
INSERT INTO categories (name, description)
VALUES 
('Electronics', 'TVs, computers, phones, etc.'),
('Appliances', 'Ovens, refrigerators, washing machines, etc.'),
('Furniture', 'Chairs, tables, beds, etc.'),
('Moving', 'Car,bicycle, etc.');

-- repairs
INSERT INTO repairs (name, description, data_start, status)
VALUES 
('Replace oven heating element', 'Oven not heating up properly', '2023-03-20 09:00:00', 'In process'),
('Fix refrigerator compressor', 'Not cooling properly', '2023-02-15 13:00:00', 'Ready'),
('Replace laptop screen', 'Cracked screen', '2023-04-01 10:00:00', 'In process'),
('Replace washing machine belt', 'Machine not spinning', '2023-03-01 16','Ready');

-- belongings
INSERT INTO belongings (name, data_buying, is_Appliance, price_one, family_member, shop_id, manufacturer_id, repair_id, category_id)
VALUES
('Combination double wall oven', '2022-01-01 10:00:00', 1, 1000.00, 1, 1, 3, 1, 2),
('Laptop L23', '2021-06-15 14:30:00', 1, 1500.99, 3, 2, 1, 3, 1),
('Washing machine', '2020-05-10 09:00:00', 0, 500.00, 2, 6, 3, 4, 2),
('Table model S1','2023-03-24 17:30:00', 0, 150.00, 4, 6, 2, NULL, 3),
('Laptop', '2021-08-15 14:30:00', 1, 1200.00, 5, 1, 1, NULL, 1),
('Bicycle', '2021-06-10 09:00:00', 0, 799.00, 7, 7, 6, NULL, 4);


