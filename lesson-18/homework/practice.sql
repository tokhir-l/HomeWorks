-- Level 1: Basic Subqueries

-- Find Employees with Minimum Salary
SELECT * FROM employees 
WHERE salary = (SELECT MIN(salary) FROM employees);

-- Find Products Above Average Price
SELECT * FROM products 
WHERE price > (SELECT AVG(price) FROM products);

-- Level 2: Nested Subqueries with Conditions

-- Find Employees in Sales Department
SELECT * FROM employees 
WHERE department_id = (SELECT id FROM departments WHERE department_name = 'Sales');

-- Find Customers with No Orders
SELECT * FROM customers 
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

-- Level 3: Aggregation and Grouping in Subqueries

-- Find Products with Max Price in Each Category
SELECT * FROM products p
WHERE price = (SELECT MAX(price) FROM products WHERE category_id = p.category_id);

-- Find Employees in Department with Highest Average Salary
SELECT * FROM employees 
WHERE department_id = (SELECT department_id FROM employees 
                       GROUP BY department_id
                       ORDER BY AVG(salary) DESC 
                       LIMIT 1);

-- Level 4: Correlated Subqueries

-- Find Employees Earning Above Department Average
SELECT * FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

-- Find Students with Highest Grade per Course
SELECT * FROM students s
WHERE EXISTS (SELECT 1 FROM grades g WHERE g.student_id = s.student_id AND 
              g.grade = (SELECT MAX(grade) FROM grades WHERE course_id = g.course_id));

-- Level 5: Subqueries with Ranking and Complex Conditions

-- Find Third-Highest Price per Category
SELECT * FROM products p1
WHERE 2 = (SELECT COUNT(DISTINCT price) FROM products p2 
           WHERE p2.category_id = p1.category_id AND p2.price > p1.price);

-- Find Employees Between Company Average and Department Max Salary
SELECT * FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees) 
AND salary < (SELECT MAX(salary) FROM employees WHERE department_id = e.department_id);
