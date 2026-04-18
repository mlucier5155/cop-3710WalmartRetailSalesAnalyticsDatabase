
-- Feature 1: Weekly Sales Report
SELECT Date_DD_MM_YYYY, WeeklySales
FROM STORE_DATE
ORDER BY Date_DD_MM_YYYY;

-- Feature 2: Holiday Sales
SELECT Date_DD_MM_YYYY, WeeklySales, Holiday
FROM STORE_DATE
WHERE Holiday = 'Yes';

-- Feature 3: Employees by Store (JOIN)
SELECT e.EmployeeID,
       e.EmployeePosition,
       s.StoreID,
       s.Store_Location
FROM EMPLOYEE e
JOIN STORE s
ON e.StoreID = s.StoreID
ORDER BY s.StoreID;

-- Feature 4: Store Hours by Store (JOIN)
SELECT sh.Day_ofWeek,
       sh.Store_Hours,
       sh.Pharmacy_Hours,
       s.Store_Location
FROM STORE_HOURS sh
JOIN STORE s
ON sh.StoreID = s.StoreID
ORDER BY sh.DayID;

-- Feature 5: Economic Conditions by Store (JOIN)
SELECT s.StoreID,
       s.Store_Location,
       c.Fuel_Price,
       c.Unemployment,
       c.Temperature
FROM STORE s
JOIN CIRCUMSTANCE c
ON s.Store_Location = c.Store_Location
ORDER BY s.StoreID;
