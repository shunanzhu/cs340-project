/* 
    Group 123
    Lehui Liao
    Shunan Zhu
    Data Manipulation Queries
*/ 


/* Menu */
-- browse items table
SELECT * FROM Items;

-- create a new menu item with : used to denote variable with data from backend
INSERT INTO Items (name, price, description)
VALUES (:name_input, :price_input, :description_input); 

-- delete menu item
DELETE FROM Items
WHERE item_id = :item_id_selected_from_browse_menu_page;

-- edit menu item
UPDATE Items
SET name = :name_input, price = :price_input, description = :description_input
WHERE item_id = :item_id_from_edit_form;


/* Customers */
-- browse customers table
SELECT * FROM Customers;

-- Search for a customer by last name
SELECT * FROM Customers WHERE last_name LIKE "${req.query.last_name}%"

-- create a new customer with : used to denote variable with data from backend
INSERT INTO Customers (first_name, last_name, address, phone_number)
VALUES (:first_name_input, :last_name_input, :address_input, :phone_number_input);

-- delete customer
DELETE FROM Customer
WHERE customer_id = :customer_id_selected_from_browse_customers_page;

-- edit customer
UPDATE Customers
SET first_name = :first_name_input, last_name = :last_name_input, address = :address_input, phone_number = :phone_number_input
WHERE customer_id = :customer_id_from_edit_form;


/* Employees */
-- browse employees table
SELECT * FROM Employees;

-- create a new employee with : used to denote variable with data from backend
INSERT INTO Employees (first_name, last_name, job_title, days_available, salary)
VALUES (:first_name_input, :last_name_input, :job_title_input, :days_available_input, :salary_input);

-- delete employee
DELETE FROM Employees
WHERE employee_id = :employee_id_selected_from_browse_employees_page;

-- edit employee
UPDATE Employees
SET first_name = :first_name_input, last_name = :last_name_input, job_title = :job_title_input, days_available = :days_available_input, salary = :salary_input
WHERE employee_id = :employee_id_from_edit_form;


/* Orders */
-- browse orders table, get customer ids/names to populate CustomerID dropdown
SELECT order_id, CONCAT (Customers.customer_id, ". ", Customers.first_name, " ", Customers.last_name) AS CustomerID, date, take_out, total_price
FROM Orders
    JOIN Customers  
        ON Orders.customer_id = Customers.customer_id; 

SELECT CONCAT(customer_id, '. ', first_name, ' ', last_name) as customer_id_name, customer_id FROM Customers;

-- create a new order with : used to denote variable with data from backend
INSERT INTO Orders(customer_id, date, take_out, total_price)
VALUES (:customer_id_input, :date_input, :take_out_input, :total_price_input);

-- delete order
DELETE FROM Orders
WHERE order_id = :order_id_selected_from_browse_orders_page;

-- edit order
UPDATE Orders
SET customer_id = :customer_id_input, date = :date_input, take_out = :take_out_input, total_price = :total_price_input
WHERE order_id = :order_id_from_edit_form;


/* Orders Employees */
-- browse orders employees table, get order ids and employee ids/names to populate Order ID and EmployeeID dropdowns
SELECT order_employee_id AS OrderEmployeeID, Orders.order_id AS OrderID, CONCAT (Employees.employee_id, ". ", Employees.first_name, " ", Employees.last_name) AS EmployeeID
FROM Orders_Employees
    JOIN Orders  
        ON Orders_Employees.order_id = Orders.order_id
    JOIN Employees
        ON Orders_Employees.employee_id = Employees.employee_id;

SELECT * FROM Orders

SELECT CONCAT(employee_id, '. ', first_name, ' ', last_name) as employee_id_name, employee_id FROM Employees; 

-- create a new order_employee entry with : used to denote variable with data from backend
INSERT INTO Orders_Employees (order_id, employee_id)
VALUES (:order_id_input, :employee_id_input);

-- edit order_employee entry
UPDATE Orders_Employees
SET order_id = :order_id_input, employee_id = :employee_id_from_dropdown_input
WHERE orders_employees_id = :orders_employees_id_from_edit_form;


/* Order Details */ 
-- browse order details table, get order ids and item ids/names to populate OrderID and ItemID dropdowns
SELECT order_details_id AS OrderDetailsID, Orders.order_id AS OrderID, CONCAT (Items.item_id, ". ", Items.name) AS ItemID, qty AS Quantity, line_total AS LineTotal
FROM Order_Details
    JOIN Orders  
        ON Order_Details.order_id = Orders.order_id
    JOIN Items
        ON Order_Details.item_id = Items.item_id;

SELECT * FROM Orders;

SELECT CONCAT(item_id, '. ', name) as item_id_name, item_id FROM Items;

-- create a new order_detail with : used to denote variable with data from backend
INSERT INTO Orders_Details (order_id, item_id, qty, line_total)
VALUES (:order_id_input, :item_id_input, :qty_input, :line_total_input);














