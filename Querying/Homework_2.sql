USE TSQLV4
/*
Question 1: Return orders placed in June 2015. Tables involved: TSQLV4 database,Sales.Orders table. The output should look similar to:
*/
SELECT orderid, orderdate, custid, empid FROM Sales.Orders
WHERE YEAR(orderdate) = 2015 AND MONTH(orderdate) = 06
/*
Question 2: Calculate the total value for each order (hint--multiple qty*unitprice first, then group by each orderid) and then select just those that have total value greater than 10000. Please sort by total value. Tables involved: Sales.OrderDetails. The output should look similar to:  
*/
SELECT orderid, SUM(unitprice*qty) AS totalvalue FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(unitprice*qty) > 10000
ORDER BY totalvalue DESC
/*
Question 3: Return the three ship countries with the highest average freight for orders placed in 2015 Tables involved: Sales.Orders table. The output should look similar to: 
*/
SELECT shipcountry, AVG(freight) AS avgfreight FROM Sales.Orders
WHERE YEAR(orderdate) = 2015
GROUP BY shipcountry
ORDER BY avgfreight DESC, shipcountry ASC
/*
Question 4: Write a query that returns employees who did not place orders on or after May 1st, 2016. Tables involved: TSQLV4 database, Employees and Orders tables.
*/
SELECT H.empid, H.firstname AS Firstname, H.lastname
FROM HR.Employees AS H LEFT JOIN Sales.Orders AS S ON H.empid = S.empid
WHERE S.orderdate !> '05/01/2016'
/*
Question 5: Write a query statement that generates 5 copies out of each employee row- Tables involved: TSQLV4 database, Employees and Nums tables.  Yes, I am asking to duplicate the data for each employee, five times. The output should look similar to: 
*/
SELECT E.empid, E.lastname, E.firstname, N.n 
FROM HR.Employees AS E CROSS JOIN dbo.Nums AS N 
WHERE n <=5 
ORDER BY n
/*
Question 6: Explain the difference between “IN” and “EXISTS.”
 For EXIST you cannot compare othe values between the sub-queries and the parent queries, however for IN it will compare the values between the sub-queries and the parent queris. 
 Also for IN's output when ran will output True, NULL, and False. 
 But compared to EXIST the output can either be True or False no in between. 
 Finally, when doing the EXIST statement if the sub-queries are suppose to return a large result than the EXIST statement is best than use this instead of the IN as it is much fdaster. 
 As for the IN statement it is slower generating result than the EXIST statement. 
*/
/*
Question 7: Use a SELECT INTO statement to create and populate a new table Sales.Order14To16 with orders from the Sales.Orders that were placed in the years 2014 through 2016.
*/
SELECT * INTO Sales.Order14To16 
FROM Sales.Orders
WHERE YEAR(orderdate) BETWEEN '2014' AND '2016'
/*
Question 8: Alter the table in step 7 to add an integer column called ‘FiscalYear.’ Use an UPDATE statement to set the value of FiscalYear column to equal the year the order was placed except that if the month is October, November, or December you will add one year to the year.  Include the SQL Queries for both (one to alter the table and the second to update the value).
*/
ALTER TABLE Sales.Order14To16
ADD FiscalYear INT

UPDATE Sales.Order14To16
SET FiscalYear = 
CASE
	WHEN MONTH(orderdate) in (10,11,12) THEN YEAR(FiscalYear)+1
	ELSE YEAR(orderdate)
END

SELECT * FROM Sales.Order14To16
/*
Question 9: Optional Extra Credit Question: Return all customers, and for each return a Yes/No value depending on whether the customer placed an order on Feb 12, 2016. Tables involved: TSQLV4 database, Customers and Orders tables. The output should look similar to:  
*/
SELECT * FROM Sales.Customers
SELECT * FROM Sales.Orders

SELECT DISTINCT C.custid, C.companyname,
CASE 
	WHEN O.orderdate='2016-02-12' THEN 'YES' 
	ELSE 'NO'
END	AS HasOrderOn20160212
FROM Sales.Customers AS C 
JOIN Sales.Orders AS O ON C.custid = O.custid
