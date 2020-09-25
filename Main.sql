--
-- Dfinition of popularity = the most items bought - e.g. not the frequency :) --
--

    1). The most popular product sold on a specific date.
	
SELECT ProductName, Quantity
FROM (SELECT sum(s.Quantity) as Quantity, s.ProductID, s.DateOfSale, p.ProductName
FROM shop.sales s, Product p
where s.ProductID = p.ProductID
group by s.ProductID) sales
WHERE Quantity >= (select MAX(sales.Quantity) as Quantity from (
SELECT sum(s.Quantity) as Quantity, s.ProductID as ID
FROM shop.sales s
group by s.ProductID) as sales)
and DateOfSale = "2020-08-01";

    2. The most popular product sold last week. 

SELECT ProductName, Quantity
FROM (SELECT sum(s.Quantity) as Quantity, s.ProductID, s.DateOfSale, p.ProductName
FROM shop.sales s, Product p
where YEARWEEK(DateOfSale) = YEARWEEK(NOW() - INTERVAL 1 WEEK)
group by s.ProductID) sales
WHERE Quantity >= (select MAX(sales.Quantity) as Quantity from (
SELECT sum(s.Quantity) as Quantity, s.ProductID as ID
FROM shop.sales s
where YEARWEEK(DateOfSale) = YEARWEEK(NOW() - INTERVAL 1 WEEK)
group by s.ProductID) as sales);

    3. The most popular product sold on a specific month.

SELECT ProductName, Quantity
FROM (SELECT sum(s.Quantity) as Quantity, s.ProductID, s.DateOfSale, p.ProductName
FROM shop.sales s, shop.product p
where  s.ProductID = p.ProductID
and YEAR(DateOfSale) = YEAR(NOW())
and MONTH(DateOfSale) = 8
group by s.ProductID) sales
WHERE Quantity >= (select MAX(sales.Quantity) as Quantity from (
SELECT sum(s.Quantity) as Quantity, s.ProductID as ID
FROM shop.sales s
where YEAR(DateOfSale) = YEAR(NOW())
and MONTH(DateOfSale) = 8
group by s.ProductID) as sales);

    4. The most popular subcategory for a specific date.

select QuantityBySubCategory,  SubCategoryID, SubCategoryName from (
select sum(Quantity) as QuantityBySubCategory ,SubCategoryID , SubCategoryName from (
select Quantity, sales.ProductID, sales.ProductName, sales.SubCategoryID, sub.SubCategoryName from(
SELECT sum(s.Quantity) as Quantity, s.ProductID, s.DateOfSale, p.ProductName, p.SubCategoryID
FROM shop.sales s, Product p
where s.ProductID = p.ProductID
and DateOfSale = "2020-08-01"
group by s.ProductID) as sales
left join shop.subcategory as sub
on sales.SubCategoryID = sub.SubCategoryID) subCat
group by SubCategoryID) as subCat
where QuantityBySubCategory >= (select max(QuantityBySubCategory) from (
select sum(Quantity) as QuantityBySubCategory ,SubCategoryID , SubCategoryName from (
select Quantity, sales.ProductID, sales.ProductName, sales.SubCategoryID, sub.SubCategoryName from(
SELECT sum(s.Quantity) as Quantity, s.ProductID, s.DateOfSale, p.ProductName, p.SubCategoryID
FROM shop.sales s, Product p
where s.ProductID = p.ProductID
and DateOfSale = "2020-08-01"
group by s.ProductID) as sales
left join shop.subcategory as sub
on sales.SubCategoryID = sub.SubCategoryID) subCat
group by SubCategoryID) maxSubCat);

    5. The most popular subcategory for last week.

select QuantityBySubCategory,  SubCategoryID, SubCategoryName from (
select sum(Quantity) as QuantityBySubCategory ,SubCategoryID , SubCategoryName from (
select Quantity, sales.ProductID, sales.ProductName, sales.SubCategoryID, sub.SubCategoryName from(
SELECT sum(s.Quantity) as Quantity, s.ProductID, s.DateOfSale, p.ProductName, p.SubCategoryID
FROM shop.sales s, Product p
where s.ProductID = p.ProductID
and YEARWEEK(s.DateOfSale) = YEARWEEK(NOW() - INTERVAL 1 WEEK)
group by s.ProductID) as sales
left join shop.subcategory as sub
on sales.SubCategoryID = sub.SubCategoryID) subCat
group by SubCategoryID) as subCat
where QuantityBySubCategory >= (select max(QuantityBySubCategory) from (
select sum(Quantity) as QuantityBySubCategory ,SubCategoryID , SubCategoryName from (
select Quantity, sales.ProductID, sales.ProductName, sales.SubCategoryID, sub.SubCategoryName from(
SELECT sum(s.Quantity) as Quantity, s.ProductID, s.DateOfSale, p.ProductName, p.SubCategoryID
FROM shop.sales s, Product p
where s.ProductID = p.ProductID
and YEARWEEK(s.DateOfSale) = YEARWEEK(NOW() - INTERVAL 1 WEEK)
group by s.ProductID) as sales
left join shop.subcategory as sub
on sales.SubCategoryID = sub.SubCategoryID) subCat
group by SubCategoryID) maxSubCat);

    6. The most popular subcategory for a specific month.

select QuantityBySubCategory,  SubCategoryID, SubCategoryName from (
select sum(Quantity) as QuantityBySubCategory ,SubCategoryID , SubCategoryName from (
select Quantity, sales.ProductID, sales.ProductName, sales.SubCategoryID, sub.SubCategoryName from(
SELECT sum(s.Quantity) as Quantity, s.ProductID, s.DateOfSale, p.ProductName, p.SubCategoryID
FROM shop.sales s, Product p
where s.ProductID = p.ProductID
and YEAR(DateOfSale) = YEAR(NOW())
and MONTH(DateOfSale) = 8
group by s.ProductID) as sales
left join shop.subcategory as sub
on sales.SubCategoryID = sub.SubCategoryID) subCat
group by SubCategoryID) as subCat
where QuantityBySubCategory >= (select max(QuantityBySubCategory) from (
select sum(Quantity) as QuantityBySubCategory ,SubCategoryID , SubCategoryName from (
select Quantity, sales.ProductID, sales.ProductName, sales.SubCategoryID, sub.SubCategoryName from(
SELECT sum(s.Quantity) as Quantity, s.ProductID, s.DateOfSale, p.ProductName, p.SubCategoryID
FROM shop.sales s, Product p
where s.ProductID = p.ProductID
and YEAR(DateOfSale) = YEAR(NOW())
and MONTH(DateOfSale) = 8
group by s.ProductID) as sales
left join shop.subcategory as sub
on sales.SubCategoryID = sub.SubCategoryID) subCat
group by SubCategoryID) maxSubCat);

