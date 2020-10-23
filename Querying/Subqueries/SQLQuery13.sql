/****** Script for SelectTopNRows command from SSMS  ******/
select * from HR.Employees
select * from Sales.Orders
select * from Sales.Customers
select * from Production.Products

select orderid, orderdate, custid, empid
from Sales.Orders
where EXISTS
	(select MAX(orderdate)
	 from Sales.Orders)

select empid, Firstname, lastname
from HR.Employees
where empid NOT IN
	(select empid
	 from Sales.Orders
	 where orderdate >= '20160501')

select distinct country
from Sales.Customers
where country NOT IN
	(select e.country
	 from HR.Employees as e)
order by country

select custid,orderid,orderdate,empid
from sales.Orders as o
where o.orderdate =  
	(select max(o1.orderdate)
	 from Sales.Orders as o1
	 where o1.custid = o.custid)
order by custid

select custid, companyname
from sales.Customers as c
where EXISTS
	(select o.orderdate
	 from sales.Orders o
	 where o.custid = c.custid
	 AND o.orderdate >= '20150101'
	 AND o.orderdate < '20160101')
		AND NOT EXISTS 
			(select o.orderdate
			 from sales.Orders as o
			 where o.custid = c.custid
			 AND o.orderdate >='20160101'
			 AND o.orderdate < '20170101')

select custid, companyname
from sales.Customers as c
where EXISTS 
	(select *
	 from sales.Orders as o 
	 where c.custid = o.custid
	 AND EXISTS 
		(select *
		 from sales.OrderDetails as od
		 where od.orderid =  o.orderid
		 AND od.productid = 12))

select custid, ordermonth, qty, 
	(select sum(qty)
	 from sales.CustOrders as c1
	 where c1.custid = c.custid
	 AND c.ordermonth >= c1.ordermonth
	) AS runqty
from sales.CustOrders as c
order by custid

select * from HR.Employees
select * from Sales.Orders
select * from Sales.Customers
select * from Production.Products

select custid, companyname, country
from Sales.Customers as c
where c.country LIKE N'S%' OR c.country LIKE N'F%'
	AND EXISTS 
	(select *
	 from Sales.Orders as o
	 where o.custid = c.custid)

