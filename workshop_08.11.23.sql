Select * from products;
--Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
SELECT product_name, quantity_per_unit from products;

--Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
SELECT product_id, product_name 
FROM products
WHERE discontinued = 0;

--Durdurulan Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
SELECT product_id,product_name 
FROM products 
WHERE discontinued = 1;

--Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price < 20 ORDER BY unit_price;

--Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
SELECT product_id,product_name,unit_price
FROM products
WHERE unit_price >= 15 AND unit_price <=25 ORDER BY unit_price;

--Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
SELECT product_name, units_on_order,units_in_stock
FROM products
WHERE units_in_stock < units_on_order;

--İsmi `a` ile başlayan ürünleri listeleyeniz.
SELECT product_name
FROM products
WHERE LOWER(product_name) LIKE 'a%'; 

--İsmi `i` ile biten ürünleri listeleyeniz.
SELECT product_name
FROM products
WHERE LOWER(product_name) LIKE '%i'; 

--Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
SELECT product_name, unit_price, CAST(unit_price * 1.18 AS NUMERIC(10,2)) AS unit_price_tax
FROM products;

--Fiyatı 30 dan büyük kaç ürün var?
SELECT COUNT(*) AS product_count
FROM products
WHERE unit_price > 30;

--Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
SELECT LOWER(product_name)
FROM products
ORDER BY unit_price DESC;

--Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır.
Select * from employees;
SELECT CONCAT(first_name,' ', last_name) AS full_name
FROM employees;

--Region alanı NULL olan kaç tedarikçim var?
Select * from suppliers;
SELECT COUNT(*) AS null_region
FROM suppliers
WHERE region is null;

--Region alanı NULL olmayan kaç tedarikçim var?
SELECT COUNT(*) AS null_region
FROM suppliers
WHERE region is not null;

--Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
SELECT UPPER(CONCAT('TR-', product_name)) AS updated_product_name
FROM products;

--a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
SELECT CONCAT('TR-', product_name), unit_price FROM products
WHERE unit_price < 20 ORDER BY unit_price;

--En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 1;

--En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 10;

--Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY unit_price;

--Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
SELECT SUM(units_in_stock * unit_price) AS stock_price
FROM products;

-- Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
select * from products;
SELECT discontinued, COUNT(*) 
FROM products
GROUP BY discontinued;

--Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
SELECT p.product_name, c.category_name 
FROM products p
JOIN categories c 
ON p.category_id = c.category_id;

--Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
SELECT c.category_name, AVG(p.unit_price) AS avg_price 
FROM products p
JOIN categories c
ON p.category_id = c.category_id
GROUP BY c.category_name;

--En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
SELECT p.product_name, p.unit_price, c.category_name 
FROM products p
JOIN categories c 
ON p.category_id = c.category_id
ORDER BY p.unit_price DESC
LIMIT 1;

--En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
SELECT p.product_name, c.category_name, s.company_name, od.total_quantity AS total_sold
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN suppliers s ON p.supplier_id = s.supplier_id
JOIN (SELECT product_id, SUM(quantity) AS total_quantity
	 FROM order_details
	 GROUP BY product_id) od ON p.product_id = od.product_id
ORDER BY od.total_quantity DESC
LIMIT 1;










