/****** Script for SelectTopNRows command fro+m SSMS  ******/
USE TSQLV4
SET CONCAT_NULL_YIELDS_NULL ON 
select * from ProductOrder
select *, CONCAT(companyname,' ',contactname,' ',contacttitle,' ',address,' ',city,' ',region,' ',postalcode) as 'Mailing list' from ProductOrder

SELECT TOP (5) PERCENT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid

select top (5) with ties orderid, orderdate, custid, empid
from Sales.Orders
order by orderdate desc

select orderid,custid,val,
case 
	when val < 1000.00 then 'less than 1000'
	when val between 1000.00 and 3000.00 then 'between 1000 and 3000'
	when val > 3000.00 then 'more than 3000'
	else 'Unknown'
end as ValueCategory
from Sales.OrderValues

select SUBSTRING(title,0,5) from HR.Employees
select LEN(title) from HR.Employees
select empid, lastname from HR.Employees
select empid, lastname, len(lastname) - len(REPLACE(lastname,'e','')) as numbers from HR.Employees

select empid, firstname, lastname, titleofcourtesy, 
CASE
	when titleofcourtesy = 'Ms.' then 'Female'
	when titleofcourtesy = 'Mr.' then 'Male'
	when titleofcourtesy = 'Dr.' then 'Unknown'
	when titleofcourtesy = 'Mrs.' then 'Female'
END AS Gender
from HR.Employees

select custid, region 
from Sales.Customers
order by 
	case 
		when region is null then 1 
		else 0
	end, region
 
 select c.custid, E.empid 
 from Sales.Customers as C
 cross join HR.Employees as E

select  orderid,custid,orderdate,empid 
from Sales.Orders
where orderid = (select MAX(O.orderid)from Sales.Orders as O)

Select orderid,empid
from Sales.Orders
where empid = (select E.empid from HR.Employees as E where E.lastname like N'C%')

SELECT custid,companyname,contactname 
FROM Sales.Customers 
WHERE EXISTS
(SELECT custid FROM Sales.Orders
WHERE YEAR(orderdate) = 2015)

SELECT orderid, c.custid, orderdate 
FROM Sales.Customers c inner join sales.Orders o on c.custid = o.custid
WHERE o.orderid = 
(SELECT MAX(o2.orderid) FROM Sales.Orders o2 WHERE o2.custid = o.custid)

select custid, orderid, orderdate, empid
from Sales.Orders
where custid IN (select C.custid
from Sales.Customers as C
where country = N'USA')
order by custid, orderdate

Use TSQLV4
drop table if exists dbo.Orders
create table dbo.Orders(
orderid int not null 
constraint pk_Orders primary key)

insert into dbo.Orders(orderid)
	select orderid 
	from Sales.Orders
	where orderid % 2 = 0

select * from dbo.Orders

Select n
from dbo.Nums
where n between (select min(O.orderid) from dbo.Orders as O)
		and (select max(O.orderid) from dbo.Orders as O)
	and n not in (select O.orderid from dbo.Orders as O)
drop table if exists dbo.Orders

select custid, orderid, orderdate, empid
from sales.Orders as O1
Where orderid = (select max(O2.orderid)
				 from Sales.Orders as O2
				 where O2.custid = O1.custid)
order by custid

select custid, companyname from Sales.Customers as C
Where country = N'Spain' and not exists 
	(select * from Sales.Orders as O
	 where O.custid = C.custid)

select custid, companyname from Sales.Customers as C
Where country = N'Spain' and exists 
	(select * from Sales.Orders as O
	 where O.custid = C.custid)

select orderid, orderdate, empid, custid,
	(select min(O2.orderid)
	 from Sales.Orders as O2
	 where O2.orderid > O1.orderid) as Next_ID
from Sales.Orders as O1

select orderid, orderdate, empid, custid,
	(select max(O2.orderid)
	 from Sales.Orders as O2
	 where O2.orderid < O1.orderid) as Next_ID
from Sales.Orders as O1

select orderyear, qty, 
	(select sum(O2.qty)
	 from Sales.OrderTotalsByYear as O2
	 where O2.orderyear <= O1.orderyear) as rumqty
from sales.OrderTotalsByYear as O1
order by qty DESC

select custid, companyname
from sales.Customers
where custid not in (select o.custid 
					 from sales.Orders as o 
					 where o.custid is not null)

select custid, companyname 
from sales.Customers as c 
where not exists (select * from sales.Orders as o
				  where o.custid = c.custid)

drop table if exists Sales.Myshippers
create table Sales.Myshippers
(
	shipper_id INT NOT NULL,
	companyname NVARCHAR(40) NOT NULL,
	phone NVARCHAR(24) NOT NULL,
	CONSTRAINT PK_Myshippers PRIMARY KEY(shipper_id)
)
insert into Sales.Myshippers(shipper_id,companyname,phone)
values(1,N'Shipper GVSUA',N'(506)900-567'),
	  (2,N'Shipper ETYNR',N'(506)934-587'),
	  (3,N'Shipper ZHISN',N'(506)780-590')

select shipper_id, companyname 
from Sales.Myshippers
where shipper_id IN (select shipperid 
					 from Sales.Orders
					 where custid = 43)
