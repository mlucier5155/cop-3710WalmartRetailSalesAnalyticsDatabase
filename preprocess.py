''' import oracledb
import streamlit as st

# Path to your extracted Instant Client (Required for FreeSQL/Cloud)
LIB_DIR = r"C:\oracle\instantclient_21_3"

# Your Oracle Credentials
DB_USER = "lvelazquez8474@floridapoly.edu" # or your FreeSQL username
DB_PASS = ""
DB_DSN = "localhost:1521/xe" # or your FreeSQL DSN

oracledb.init_oracle_client(lib_dir=LIB_DIR)

conn = oracledb.connect(user=DB_USER, password=DB_PASS, dsn=DB_DSN)
cursor = conn.cursor()

def create_record(name, email):
    sql = "INSERT INTO students (name, email) VALUES (:1, :2)"
    cursor.execute(sql, [name, email])
    conn.commit()
    print(f"Created record for {name} ")

def read_records():
    print("\n--- Student Directory ---")
    cursor.execute("SELECT name, email FROM students")
    for row in cursor:
        print(f"Name: {row[0]} | Email: {row[1]}")

def update_email(student_email, new_email):
    sql = "UPDATE students SET email = :1 WHERE email = :2"
    cursor.execute(sql, [new_email, student_email])
    conn.commit()

def delete_record(student_email):
    sql = "DELETE FROM students WHERE email = :1"
    cursor.execute(sql, [student_email])
    conn.commit()

# close connection to free up server
cursor.close()
conn.close()
print("Oracle connection closed.")
'''