CREATE DATABASE e_commerce_data;
use e_commerce_data;
select * from indian_ecommerce_returns limit 5;

create view  Product_return_rate as (
select Product,Round(sum(Total_Amount),2) as Amount ,count(*) as total_count,
sum(case when order_status="Returned" then 1 else 0 end) as returned_orders,
Round(sum(case when order_status="Returned" then 1 else 0 end )*100/count(*) ,2) as return_rate
from indian_ecommerce_returns
group by Product 
order by return_rate Desc limit 10
);
select * from Product_return_rate;

select Return_reason , count(*) as total_returns , round(sum(Total_amount),2) as total_revenue_lost 
from indian_ecommerce_returns
where Order_Status = 'Returned'
GROUP BY Return_Reason
ORDER BY total_revenue_lost DESC;

select Max(Price) from indian_ecommerce_returns where Order_status='Returned';
select min(Price) from indian_ecommerce_returns where Order_status='Returned';

create view Price_retrun_rate as
(SELECT 
    CASE 
        WHEN Price < 1000 THEN 'Low (Below ₹1000)'
        WHEN Price BETWEEN 1000 AND 7000 THEN 'Medium (₹1000-₹7000)'
        WHEN Price BETWEEN 7000 AND 20000 THEN 'High (₹7000-20000)'
        WHEN Price > 20000 THEN 'Premium (Above ₹20000)'
    END AS Price_Bucket,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS return_rate
FROM indian_ecommerce_returns
GROUP BY Price_Bucket
ORDER BY return_rate DESC);
select * from Price_retrun_rate;

select ROUND(
    SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END) * 100.0 
    / COUNT(*), 2
) AS return_rate from indian_ecommerce_returns;





