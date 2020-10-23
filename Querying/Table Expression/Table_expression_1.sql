select year(orderdate) as orderyear, count(Distinct custid) as numcusts
from sales.Orders
group by orderyear 

select orderyear, count(distinct custid) as numcusts
from (select year(orderdate) as orderyear, custid
	  from sales.Orders) as D
group by orderyear

Select orderyear, numcusts
from (select orderyear, Count(distinct custid) as numcusts
		from(select year(orderdate) as orderyear, custid
			 from sales.Orders) as D2
		group by orderyear) as D1
where numcusts > 70

select year(orderdate) as orderyear, count(distinct custid) as numcusts
from sales.orders
group by year(orderdate)
having count(distinct custid) > 70

Select cur.orderyear, cur.numcusts as curnumcusts, prv.numcusts as prvnumcusts, cur.numcusts - prv.numcusts as growth
from (select year(orderdate) as orderyear, 
		count(distinct custid) as numcusts
	  from sales.Orders
	  group by year(orderdate)) as cur
	left outer join
	  (select year(orderdate) as orderyear,
	    count(distinct custid) as numcusts
	   from sales.Orders
	   group by year(orderdate)) as prv
	on cur.orderyear = prv.orderyear + 1


with c1 as 
(
	select year(orderdate) as orderyear, custid
	from sales.Orders
),
c2 as 
(
 	select orderyear, count(distinct custid) as numcusts
	from c1
	group by orderyear
)
select orderyear, numcusts
from c2
where numcusts > 70


with yearlycount as 
(
	select year(orderdate) as orderyear, count(distinct custid) as numcusts
	from sales.Orders
	group by year(orderdate)
)
select cur.orderyear, cur.numcusts as curnumcusts, prv.numcusts as prvnumcusts,
	cur.numcusts - prv.numcusts as growth
from yearlycount as cur 
	left outer join yearlycount as prv on cur.orderyear=prv.orderyear+1

with empcte as 
(
	select empid, mgrid, firstname, lastname
	from hr.Employees
	where empid = 2

	UNION ALL

	select C.empid, C.mgrid, C.firstname, C.lastname
	from empcte as P
		inner join Hr.Employees as C 
			on C.empid = P.empid
)
select empid, mgrid, firstname, lastname
from empcte


select orderid,sum(unitprice*qty) as TotalPrice 
from Sales.OrderDetails
group by orderid

select empid, MAX(orderdate) as maxorderdate 
from sales.Orders
group by empid

select O.empid, O.orderdate, O.orderid, O.custid
from sales.orders as O
inner join (select empid, max(orderdate) as maxorderdate
	  from sales.Orders
	  group by empid) as D 
on O.empid = D.empid and O.orderdate = D.maxorderdate

select orderid, orderdate, custid, empid,
	ROW_NUMBER() OVER(ORDER BY orderid, orderdate) as rownumber
from sales.Orders

with O as 
(
	select orderid, orderdate, custid, empid,
		ROW_NUMBER() OVER(ORDER BY orderid, orderdate) as rownumber
	from sales.Orders
)
select * from O 
where rownumber between 11 and 20
