import oracledb

USERNAME = "mlucier7527@floridapoly.edu"
PASSWORD = "Razer5151!"
DSN = "localhost/XEPDB1"   # Replace if needed

def connect_db():
    try:
        return oracledb.connect(
            user=USERNAME,
            password=PASSWORD,
            dsn=DSN
        )
    except Exception as e:
        print("Connection failed:")
        print(e)
        return None

def show(rows):
    if not rows:
        print("No rows found.\n")
        return
    for row in rows:
        print(row)
    print()

def menu():
    print("====================================")
    print(" Walmart Retail Analytics Dashboard ")
    print("====================================")
    print("1. Weekly Sales by Date Range")
    print("2. Holiday Sales")
    print("3. Employees by Store")
    print("4. Sales + Store Hours")
    print("5. Economic Conditions")
    print("0. Exit")

def main():
    conn = connect_db()

    if conn is None:
        print("Use Oracle Worksheet if direct connection unavailable.")
        return

    cur = conn.cursor()

    while True:
        menu()
        choice = input("Choose option: ")

        if choice == "1":
            start = input("Enter start date (YYYY-MM-DD): ")
            end = input("Enter end date (YYYY-MM-DD): ")

            cur.execute(f"""
                SELECT SalesDate, Weekly_Sales
                FROM STORE_DATE
                WHERE SalesDate BETWEEN DATE '{start}' AND DATE '{end}'
                ORDER BY SalesDate
            """)
            show(cur.fetchall())

        elif choice == "2":
            cur.execute("""
                SELECT SalesDate, Weekly_Sales, Holiday_Events
                FROM STORE_DATE
                WHERE Holiday_Flag='Yes'
            """)
            show(cur.fetchall())

        elif choice == "3":
            cur.execute("""
                SELECT e.EmployeeName, e.EmployeePosition, s.Location
                FROM EMPLOYEE e
                JOIN STORE s
                ON e.StoreID = s.StoreID
            """)
            show(cur.fetchall())

        elif choice == "4":
            cur.execute("""
                SELECT sd.SalesDate, sd.Weekly_Sales,
                       sh.Store_Hours, sh.Pharmacy_Hours
                FROM STORE_DATE sd
                JOIN STORE_HOURS sh
                ON sd.Day_ofWeek = sh.Day_ofWeek
            """)
            show(cur.fetchall())

        elif choice == "5":
            cur.execute("""
                SELECT s.StoreID, s.Location,
                       c.Fuel_Price, c.Unemployment, c.Temperature
                FROM STORE s
                JOIN CIRCUMSTANCE c
                ON s.Location = c.Location
            """)
            show(cur.fetchall())

        elif choice == "0":
            break

    cur.close()
    conn.close()

if __name__ == "__main__":
    main()