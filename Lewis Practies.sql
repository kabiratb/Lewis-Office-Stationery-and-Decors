--How much revenue did we generate from each product category, 
--after considering a 10% discount for products that cost more than $100, 
--and a 5% discount for products that cost between $50 and $100?

select "ProductCategory",
		sum(case
		   		when "Price" > 100 then "Price" * 0.9 * "Quantity"
		   		when "Price" between 50 and 100 then "Price" * 0.95 * "Quantity"
		   		else "Price" * "Quantity"
		   	end) as "dicounted_revenue"
From orders
Join products on orders."ProductID" = products."ProductID"
Group by "ProductCategory";


--What is the total revenue generated, considering that products with a 
--NULL price should be treated as having a default price of $10?

Select sum(coalesce(products."Price", 10) * orders."Quantity") as "Total revenue"
From orders 
Join products on orders."ProductID" = products."ProductID";

--How many orders were placed in the year 2015?

Select count (distinct "OrderID") as "Total_order"
From orders
Where cast("OrderDate" as date) between '2015-01-01' and '2015-12-31';

--What is the name and category of the top-selling product (in terms of quantity) in the year 2015?

Select p."ProductCategory", p."ProductName", count(o."Quantity") as "Total Quantity"
From orders o
join products p on o."ProductID" = p."ProductID"
Where o."OrderDate" between '2015-01-01' and '2015-12-31'
Group By p."ProductName", p."ProductCategory"
limit 5

--What is the average price of products that have never been ordered?
Select avg("Price")
From products
Where "ProductID" Not in (
			Select distinct "ProductID" from orders
)


Select
	coalesce(
		cast(avg("Price") as text),
		'All product where ordered')
From products
where "ProductID" not in (
	select distinct"ProductID" from orders
)

