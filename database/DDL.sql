/* 
    Group 123
    Lehui Liao
    Shunan Zhu
    Data Definition Queries
*/ 

-- Disable commits and foreign key checks
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- Create entity tables
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
  customer_id int(11) NOT NULL AUTO_INCREMENT,
  first_name varchar(45) NOT NULL, 
  last_name varchar(45) NOT NULL,
  address varchar(255) NOT NULL,
  phone_number char(15) NOT NULL,
  PRIMARY KEY (customer_id),
  UNIQUE KEY full_name (first_name, last_name)
);

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
  employee_id int(11) NOT NULL AUTO_INCREMENT,
  first_name varchar(45) NOT NULL,
  last_name varchar(45) NOT NULL,
  job_title varchar(45) NOT NULL,
  days_available varchar(45) NOT NULL,
  salary decimal (19,2) NOT NULL,
  PRIMARY KEY (employee_id)
);

DROP TABLE IF EXISTS Items;
CREATE TABLE Items (
  item_id int NOT NULL AUTO_INCREMENT,
  name varchar(50),
  price decimal (19,2) NOT NULL,
  description varchar(5000) NOT NULL,
  PRIMARY KEY (item_id)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  order_id int NOT NULL AUTO_INCREMENT,
  customer_id int NOT NULL,
  date date NOT NULL,
  take_out boolean NOT NULL,
  total_price decimal (19,2) NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (customer_id) REFERENCES Customers (customer_id) ON DELETE CASCADE
);

-- Create intersection tables 
DROP TABLE IF EXISTS Orders_Employees;
CREATE TABLE Orders_Employees (
  order_employee_id int(11) NOT NULL AUTO_INCREMENT,
  order_id int,
  employee_id int,
  PRIMARY KEY (order_employee_id),
  FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE,
  FOREIGN KEY (employee_id) REFERENCES Employees (employee_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Order_Details;
CREATE TABLE Order_Details (
  order_details_id int NOT NULL AUTO_INCREMENT,
  order_id int,
  item_id int,
  qty int NOT NULL,
  line_total decimal (19,2) NOT NULL,
  PRIMARY KEY (order_details_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
  FOREIGN KEY (item_id) REFERENCES Items(item_id) ON DELETE CASCADE
);

-- Populate all tables with sample data
INSERT INTO Customers (customer_id, first_name, last_name, address, phone_number) 
VALUES (1, 'Harry', 'Potter', '101 East St, Austin TX, 78750', '512-777-0347'), (2, 'Ronald', 'Weasley', '111 Sussex Ct, Austin TX, 78750', '512-422-0321'), (3, 'Hermione', 'Granger', '1 University Dr, Austin TX, 78705', '512-671-0003');


INSERT INTO Employees (employee_id, first_name, last_name, job_title, days_available, salary) 
VALUES (1, 'Jon', 'Snow', 'manager', 'M, T, W, Th, F, Sa, Su', 75000), (2, 'Cersei', 'Lannister', 'server', 'M, T, W', 40000), (3, 'Arya', 'Stark', 'server', 'F, Sa, Su', 45000);


INSERT INTO Items (name, price, description)
VALUES ('Kung Pao Chicken', 16.99, 'Kung Pao Chicken (宫保鸡丁 gōngbào jīdīng) is a famous Sichuan-style specialty, popular with both Chinese and foreigners. The major ingredients are diced chicken, dried chili, cucumber, and fried peanuts (or cashews).'),
('Sweet and Sour Pork', 15.99, 'Sweet and Sour Pork (糖醋里脊 tángcù lǐjǐ) has a bright orange-red color, and a delicious sweet and sour taste. At the very beginning there was only sweet and sour pork, but to meet demands, there have been some developments on this dish. Now, the pork can be substituted with other ingredients like chicken, beef, or pork ribs'),
('Ma Po Tofu', 16.99, 'Ma Po Tofu (麻婆豆腐 Mápó dòufǔ ‘Pockmarked Granny beancurd’) is one of the most famous dishes in Chuan Cuisine (Sichuan food) with a history of more than 100 years. It consists of beancurd along with some minced meat (pork or beef) in a spicy sauce. The sauce is made from fermented black beans and chili paste (douban/douchi).'),
('Twice-cooked Pork', 17.99, 'Twice-cooked Pork or double-cooked pork (回锅肉 huíguōròu) is one of the most famous Sichuan pork dishes. Its Chinese name is huiguorou, which means ‘returned-to-the-pot meat’. Pork is boiled in the pot first. Then it is cooked again with other ingredients, including broad bean paste (doubanjiang), fermented black soybeans (douchi), garlic, ginger, and so on.');


INSERT INTO Orders(`customer_id`, `date`, `take_out`, `total_price`)
VALUES ((SELECT customer_id from Customers where first_name = 'Harry' and last_name = 'Potter'), '2023-1-15', False, 16.99),
((SELECT customer_id from Customers where first_name = 'Hermione' and last_name = 'Granger'), '2023-1-15', False, 32.98),
((SELECT customer_id from Customers where first_name = 'Ronald' and last_name = 'Weasley'), '2023-1-15',False, 50.97),
((SELECT customer_id from Customers where first_name = 'Harry' and last_name = 'Potter'), '2023-1-16',True, 16.99);


INSERT INTO Orders_Employees (order_employee_id, order_id, employee_id)
VALUES (1, (SELECT order_id from Orders where customer_id = 1 and date = '2023-1-15'), (SELECT employee_id from Employees where first_name = 'Cersei' and last_name = 'Lannister')),
(2, (SELECT order_id from Orders where customer_id = 3 and date = '2023-1-15'), (SELECT employee_id from Employees where first_name = 'Arya' and last_name = 'Stark')),
(3, (SELECT order_id from Orders where customer_id = 2 and date = '2023-1-15'), (SELECT employee_id from Employees where first_name = 'Cersei' and last_name = 'Lannister'));


INSERT INTO Order_Details (`order_details_id`, `order_id`, `item_id`, `qty`, `line_total`)
VALUES (1, (SELECT order_id from Orders where customer_id = 1 and date = '2023-1-15'), (SELECT item_id from Items where name = 'Kung Pao Chicken'), 2, 20.00),
(2, (SELECT order_id from Orders where customer_id = 2 and date = '2023-1-15'), (SELECT item_id from Items where name = 'Sweet and sour pork'), 1, 30.00),
(3, (SELECT order_id from Orders where customer_id = 3 and date = '2023-1-15'), (SELECT item_id from Items where name = 'Ma Po tofu'), 1, 40.00),
(4, (SELECT order_id from Orders where customer_id = 1 and date = '2023-1-15'), (SELECT item_id from Items where name = 'Twice-cooked pork'), 1, 50.00);

-- Show tables
SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM Items;
SELECT * FROM Orders;
SELECT * FROM Orders_Employees;
SELECT * FROM Order_Details;

-- Enable commits and foreign key checks
SET FOREIGN_KEY_CHECKS=1;
COMMIT;