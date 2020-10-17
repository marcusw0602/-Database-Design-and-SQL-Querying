/*
Exercise 1: Write a query that returns all orders placed on the last day of activity that can be found in the Orders.
*/
select orderid, orderdate, custid, empid
from sales.Orders 
where orderdate = 
	(select MAX(O.orderdate)
	 from Sales.Orders as O)
/*
Exercise 2: Write a query that returns all orders placed by the customer(s) who placed the highest number of orders.
*/
select o.custid, o.orderid, o.orderdate, o.empid
from Sales.Orders as o
where exists 
	(select max(o1.orderid)
	 from Sales.Orders as o1
	 where o.orderid = o1.orderid)
and custid = 71  and orderid between 10324 and 11064
/*
Exercise 3: Write a query that returns employees who did not place orders on or after May 1,2016.
*/
select empid, FirstName, lastname
from hr.Employees
where empid not in 
	(select O.empid
	 from Sales.Orders as O
	 where O.orderdate >= '20160501')
/*
Exercise 4: Write a query that returns countries where there are customers but not employees.
*/
select Distinct country
from Sales.Customers
where country not in 
	(select c.country 
	 from hr.Employees as c
	 where c.country in ('USA','UK'))
/*
Exercise 5: Write a query that returns for each customer all orders placed on the customer's last day of activity. 
*/
select custid, orderid, orderdate, empid
from Sales.Orders as O
where orderdate = 
	(select max(O1.orderdate) 
	 from Sales.Orders as O1
	 where O1.custid = O.custid)
order by custid
/*
Exercise 6: Write a query that returns customers who placed orders in 2015 but not in 2016.
*/
select C.custid, C.companyname
from Sales.Customers as C
where exists 
	(select O.custid 
	 from Sales.Orders as O
	 where O.custid = C.custid 
		and O.orderdate >= '20150101'
		and O.orderdate < '20160101')
	 AND NOT EXISTS
	 (select O.custid 
	 from Sales.Orders as O
	 where O.custid = C.custid 
		and O.orderdate >= '20160101' 
		and O.orderdate < '20170101')
/*
Execrise 7: Write a query that returns customers who ordered product 12.
*/
select custid, companyname
from Sales.Customers as sc
where exists
	(select so.custid 
	 from sales.Orders as so
	 where so.custid = sc.custid
		and exists
			(select sod.orderid
			 from Sales.OrderDetails as sod
			 where sod.orderid = so.orderid
				and sod.productid = 12))
order by custid
/*
Execrise 8: Write a query that calculates a running total quanity for each customer and month 
*/
select custid, ordermonth, qty, 
	(select sum(O2.qty)
	 from TSQLV4.Sales.CustOrders as O2
	 where O2.ordermonth <= CO.ordermonth AND O2.custid <= CO.custid) as numqty 
from TSQLV4.Sales.CustOrders as CO
order by custid
