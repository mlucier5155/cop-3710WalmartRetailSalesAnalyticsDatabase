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

BEGIN EXECUTE IMMEDIATE 'DROP TABLE STORE_DATE CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE STORE_HOURS CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE EMPLOYEE CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE STORE CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE CIRCUMSTANCE CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE CIRCUMSTANCE (
    Location VARCHAR2(50) PRIMARY KEY,
    Fuel_Price NUMBER(5,2),
    Unemployment NUMBER(5,2),
    Temperature NUMBER(5,2)
);

CREATE TABLE STORE (
    StoreID VARCHAR2(5) PRIMARY KEY,
    Location VARCHAR2(50) REFERENCES CIRCUMSTANCE(Location)
);

CREATE TABLE EMPLOYEE (
    EmployeeID VARCHAR2(5) PRIMARY KEY,
    EmployeeName VARCHAR2(50),
    EmployeePosition VARCHAR2(30),
    StoreID VARCHAR2(5) REFERENCES STORE(StoreID)
);

CREATE TABLE STORE_HOURS (
    Day_ofWeek VARCHAR2(15) PRIMARY KEY,
    StoreID VARCHAR2(5) REFERENCES STORE(StoreID),
    Store_Hours VARCHAR2(20),
    Pharmacy_Hours VARCHAR2(20)
);

CREATE TABLE STORE_DATE (
    DateID VARCHAR2(5) PRIMARY KEY,
    SalesDate DATE,
    Day_ofWeek VARCHAR2(15) REFERENCES STORE_HOURS(Day_ofWeek),
    Weekly_Sales NUMBER(12,2),
    Holiday_Flag VARCHAR2(10),
    Holiday_Events VARCHAR2(30),
    CPI NUMBER(8,2)
);
