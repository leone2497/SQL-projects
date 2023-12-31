-- Database downloaded by kaggle. The dataset is one of the historical sales of supermarket company which has recorded in 3 different branches for 3 months data. Predictive data analytics methods are easy to apply with this dataset.# SQL-projects Code written in MYSQL environment



-- we want to see the sum of total income for branch, city and gender in desc order
SELECT City, Branch, Gender, sum(gross_income) as Sum_income  FROM new_schema.`supermarket_sales - sheet1` GROUP BY City, Branch, Gender order by sum_income desc;
-- count how many rows for city do you have in your database
SELECT Branch, count(City) as Count FROM new_schema.`supermarket_sales - sheet1` group by Branch, City;
-- let's see the  distribution of method of payment in the different cities
SELECT City, Payment, count(payment) as Payment_method_numbers, row_number() over (partition by city order by count(payment) desc) as indice FROM new_schema.`supermarket_sales - sheet1` GROUP BY City, Payment;
-- select the max(payment_method_numbers) in each city to do that we need a CTE
WITH PaymentCounts AS (
    SELECT
        City,
        Payment,
        COUNT(Payment) AS Payment_method_numbers,
        ROW_NUMBER() OVER (PARTITION BY City ORDER BY COUNT(Payment) DESC) AS indice
    FROM
        new_schema.`supermarket_sales - sheet1`
    GROUP BY
        City,
        Payment
)

SELECT
    City,
    Payment,
    Payment_method_numbers,
    Indice
FROM
    PaymentCounts
WHERE
    Indice = 1;
-- the most sold product by city and gender
with bestseller as 
(SELECT
        City,
        gender,
        product_line,
        sum(quantity) as sum_quantity,
		ROW_NUMBER() OVER (PARTITION by City, gender  ORDER BY sum(quantity) DESC) AS indice
    FROM
        new_schema.`supermarket_sales - sheet1`
    group by
        city,
        gender,
        product_line)
	select
        City,
        gender,
        product_line,
        indice
	from bestseller
    where indice= 1;

-- select last product sold by city, gender
with last_sold as 
(SELECT
        City,
        gender,
        product_line,
        date_time,
		ROW_NUMBER() OVER (PARTITION by City, gender  ORDER BY date_time DESC) AS indice
    FROM
        new_schema.`supermarket_sales - sheet1`
    group by
        city,
        gender,
        product_line,
        date_time)
select
city, gender, product_line, date_time, indice
from last_sold 
where indice= 1
