CREATE SEQUENCE id_seq;
CREATE TABLE Store (
    PRIMARY KEY StoreID varchar2(5),
    Store_Location varchar2(50)
);

CREATE TABLE Store_Hours (
    PRIMARY KEY DayID varchar2(5),
    Day_ofWeek date,
    Store_Hours varchar2(20),
    Pharmacy_Hours varchar2(20)
);

ALTER TABLE Store_Hours
ADD CONSTRAINT fk_store_hours
FOREIGN KEY (StoreID) REFERENCES Store(StoreID);

CREATE TABLE Employee (
    PRIMARY KEY EmployeeID varchar2(5),
    Employee_Position varchar2(20)
);

ALTER TABLE Employee
ADD CONSTRAINT fk_employee
FOREIGN KEY (StoreID) REFERENCES Store(StoreID);

CREATE TABLE Store_Date (
    PRIMARY KEY Date_DD-MM-YYYY date,
    Day_ofWeek varchar2(10),
    WeeklySales varchar2(10),
    Holiday varchar2(20),
    CPI varchar2(10)
);

ALTER TABLE Store_Date
ADD CONSTRAINT fk_store_date
FOREIGN KEY (Day_ofWeek) REFERENCES Store_Hours(Day_ofWeek);

CREATE TABLE Circumstance (
    Store_Location varchar2(50),
    Fuel_Price float(5),
    Unemployment float(5),
    Location_Temperature float(5)
)

ALTER TABLE Store
ADD CONSTRAINT fk_temperature
FOREIGN KEY (Location_Temperature) REFERENCES Circumstance(Location_Temperature);