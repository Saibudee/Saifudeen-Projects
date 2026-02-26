CREATE DATABASE PROJECT;

USE PROJECT;

SELECT * FROM logistics;

-- Checking overall dataset size to understand shipment volume
SELECT COUNT(*) AS total_shipments
FROM logistics;

-- Identifying all vendors involved in logistics operations
SELECT DISTINCT Vendor
FROM logistics;

-- Filtering heavy shipments for operational analysis
SELECT *
FROM logistics
WHERE Weight_kg > 20;


-- Calculating total revenue from all shipments
SELECT SUM(Selling_Price) AS total_revenue
FROM logistics;

-- Analyzing delivery efficiency across different transport modes
SELECT Transport_Mode, AVG(Delivery_Time_Calc) AS avg_delivery_days
FROM logistics
GROUP BY Transport_Mode;

-- Top 5 cities with highest shipment count
SELECT Source_City, COUNT(*) AS total_shipments
FROM logistics
GROUP BY Source_City
ORDER BY total_shipments DESC
LIMIT 5;

--  Identifying shipments that were delayed
SELECT *
FROM logistics
WHERE Delivery_Status = 'Delayed';

-- Calculating Return Rate
SELECT 
AVG(Delivery_Status = 'Returned') * 100 AS return_rate_percentage
FROM logistics;

-- Identifying the most profitable shipment route
SELECT Source_City, Destination_City, SUM(Selling_Price - Cost) AS total_profit
FROM logistics
GROUP BY Source_City, Destination_City
ORDER BY total_profit DESC
LIMIT 1;

-- Evaluating vendor profitability performance
SELECT Vendor, ROUND(AVG(Selling_Price - Cost),1) AS avg_profit
FROM logistics
GROUP BY Vendor
ORDER BY avg_profit DESC;

-- Transport Mode vs Delivery Status matrix
SELECT Transport_Mode, Delivery_Status, COUNT(*) AS shipment_count
FROM logistics
GROUP BY Transport_Mode, Delivery_Status
ORDER BY Transport_Mode;

-- Ranking drivers based on performance ratings
SELECT Driver_Rating, 
DENSE_RANK() OVER (ORDER BY Driver_Rating DESC) AS driver_rank
FROM logistics;

-- Tracking cumulative shipment growth over time
SELECT Shipment_Date, COUNT(*) AS daily_shipments,
SUM(COUNT(*)) OVER (ORDER BY Shipment_Date) AS running_total_shipments
FROM logistics
GROUP BY Shipment_Date
ORDER BY Shipment_Date;

--  Calculating contribution of each city to total shipments
SELECT Source_City,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),2) AS Shipment_Percentage
FROM logistics
GROUP BY Source_City;

-- Filtering shipments returned due to damage
SELECT *
FROM logistics
WHERE Return_Reason = 'Damaged';

--  Identifying incorrect fuel consumption values for data cleaning
SELECT *
FROM logistics
WHERE Fuel_Consumption_Litres < 0;











