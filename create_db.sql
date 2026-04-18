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
    Store_Location      VARCHAR2(50) PRIMARY KEY,
    Temperature         NUMBER(6,2),
    Fuel_Price          NUMBER(6,2),
    Unemployment        NUMBER(6,2)
);

CREATE TABLE STORE (
    StoreID                 NUMBER PRIMARY KEY,
    Store_Location          VARCHAR2(50),
    Location_Temperature    NUMBER(6,2),
    CONSTRAINT fk_store_location
        FOREIGN KEY (Store_Location)
        REFERENCES CIRCUMSTANCE(Store_Location)
);

CREATE TABLE EMPLOYEE (
    EmployeeID          NUMBER PRIMARY KEY,
    EmployeePosition    VARCHAR2(40),
    StoreID             NUMBER,
    CONSTRAINT fk_emp_store
        FOREIGN KEY (StoreID)
        REFERENCES STORE(StoreID)
);

CREATE TABLE STORE_HOURS (
    DayID               NUMBER PRIMARY KEY,
    Day_ofWeek          VARCHAR2(15),
    Store_Hours         VARCHAR2(20),
    Pharmacy_Hours      VARCHAR2(20),
    StoreID             NUMBER,
    CONSTRAINT fk_hours_store
        FOREIGN KEY (StoreID)
        REFERENCES STORE(StoreID)
);

CREATE TABLE STORE_DATE (
    Date_DD_MM_YYYY     DATE PRIMARY KEY,
    Day_ofWeek          VARCHAR2(15),
    Store_Hours         VARCHAR2(20),
    WeeklySales         NUMBER(12,2),
    Holiday             VARCHAR2(20),
    CPI                 NUMBER(8,2)
);
