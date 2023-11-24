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
