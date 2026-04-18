import oracledb

USERNAME = "YOUR_USERNAME"
PASSWORD = "YOUR_PASSWORD"
DSN = "localhost/XEPDB1"

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
    for row in rows:
        print(row)
    print()

def menu():
    print("===================================")
    print(" Walmart Retail Analytics Dashboard")
    print("===================================")
    print("1. Weekly Sales")
    print("2. Holiday Sales")
    print("3. Employees by Store")
    print("4. Store Hours by Store")
    print("5. Economic Conditions")
    print("0. Exit")

def main():
    conn = connect_db()
    if conn is None:
        return

    cur = conn.cursor()

    while True:
        menu()
        choice = input("Choose option: ")

        if choice == "1":
            cur.execute("""
                SELECT Date_DD_MM_YYYY, WeeklySales
                FROM STORE_DATE
                ORDER BY Date_DD_MM_YYYY
            """)
            show(cur.fetchall())

        elif choice == "2":
            cur.execute("""
                SELECT Date_DD_MM_YYYY, WeeklySales, Holiday
                FROM STORE_DATE
                WHERE Holiday='Yes'
            """)
            show(cur.fetchall())

        elif choice == "3":
            cur.execute("""
                SELECT e.EmployeeID,
                       e.EmployeePosition,
                       s.StoreID,
                       s.Store_Location
                FROM EMPLOYEE e
                JOIN STORE s
                ON e.StoreID = s.StoreID
            """)
            show(cur.fetchall())

        elif choice == "4":
            cur.execute("""
                SELECT sh.Day_ofWeek,
                       sh.Store_Hours,
                       sh.Pharmacy_Hours,
                       s.Store_Location
                FROM STORE_HOURS sh
                JOIN STORE s
                ON sh.StoreID = s.StoreID
            """)
            show(cur.fetchall())

        elif choice == "5":
            cur.execute("""
                SELECT s.StoreID,
                       s.Store_Location,
                       c.Fuel_Price,
                       c.Unemployment,
                       c.Temperature
                FROM STORE s
                JOIN CIRCUMSTANCE c
                ON s.Store_Location = c.Store_Location
            """)
            show(cur.fetchall())

        elif choice == "0":
            break

    cur.close()
    conn.close()

if __name__ == "__main__":
    main()
