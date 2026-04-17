-- ==========================================
-- Walmart Retail Sales Analytics Queries
-- Part E Features
-- ==========================================

-- Feature 1: Weekly Sales by Date Range
SELECT SalesDate, Weekly_Sales
FROM STORE_DATE
WHERE SalesDate BETWEEN DATE '2024-01-01' AND DATE '2024-02-01'
ORDER BY SalesDate;

-- Feature 2: Holiday Sales
SELECT SalesDate, Weekly_Sales, Holiday_Events
FROM STORE_DATE
WHERE Holiday_Flag = 'Yes';

-- Feature 3: Employees by Store (JOIN)
SELECT e.EmployeeID,
       e.EmployeeName,
       e.EmployeePosition,
       s.StoreID,
       s.Location
FROM EMPLOYEE e
JOIN STORE s
ON e.StoreID = s.StoreID
ORDER BY s.StoreID;

-- Feature 4: Sales + Store Hours (JOIN)
SELECT sd.SalesDate,
       sd.Weekly_Sales,
       sh.Store_Hours,
       sh.Pharmacy_Hours
FROM STORE_DATE sd
JOIN STORE_HOURS sh
ON sd.Day_ofWeek = sh.Day_ofWeek
ORDER BY sd.SalesDate;

-- Feature 5: Economic Conditions by Store (JOIN)
SELECT s.StoreID,
       s.Location,
       c.Fuel_Price,
       c.Unemployment,
       c.Temperature
FROM STORE s
JOIN CIRCUMSTANCE c
ON s.Location = c.Location
ORDER BY s.StoreID;

-- Bonus Feature 6: Highest Weekly Sale
SELECT *
FROM STORE_DATE
ORDER BY Weekly_Sales DESC
FETCH FIRST 1 ROW ONLY;