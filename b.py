import pymysql
def connect_db():
    return pymysql.connect(
        host='localhost',  
        user='root',      
        password='Omsai123', 
        database='restaurant_inventory_db',  
        cursorclass=pymysql.cursors.DictCursor 
    )
#admin
def add_user_account(uid, username, password): 
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "INSERT INTO user_account (uid, username, password) VALUES (%s, %s, %s)"
            cursor.execute(sql, (uid, username, password))
        conn.commit()
    finally:
        conn.close()
def get_user_account(uid):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM user_account WHERE uid = %s"
            cursor.execute(sql, (uid,))
            return cursor.fetchone()
    finally:
        conn.close()
def get_all_user_account():
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM user_account"
            cursor.execute(sql)
            return cursor.fetchall()
    finally:
        conn.close()
def add_employee(id, role, fname, mname, lname, email, mid, uid):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            check_sql = "SELECT 1 FROM user_account WHERE uid = %s"
            cursor.execute(check_sql, (uid,))
            if cursor.fetchone() is None:
                raise ValueError(f"User_account with ID {uid} does not exist.")
            sql = """
            INSERT INTO employee (id, role, fname, mname, lname, email, mid, uid) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(sql, (id, role, fname, mname, lname, email, mid, uid))
        conn.commit()
    finally:
        conn.close()
def get_employee(id):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM employee WHERE id = %s"
            cursor.execute(sql, (id,))
            return cursor.fetchone()  # Fetches only one row
    finally:
        conn.close()
def get_all_employee():
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM employee"
            cursor.execute(sql)
            return cursor.fetchall()  # Fetches only one row
    finally:
        conn.close()
def get_all_ecn():
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM ecn"
            cursor.execute(sql)
            return cursor.fetchall()  # Fetches only one row
    finally:
        conn.close()
def get_ecn(eid):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM ecn where eid=%s"
            cursor.execute(sql,(eid))
            return cursor.fetchall()  # Fetches only one row
    finally:
        conn.close()
def get_all_waiters():
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM waiter"
            cursor.execute(sql)
            return cursor.fetchall()
    finally:
        conn.close()
def validate_user(username, password):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM user_account WHERE username = %s AND password = %s"
            cursor.execute(sql, (username, password))
            user = cursor.fetchone()
            if user:
                # Assuming 'role' is part of the 'employee' table
                sql = "SELECT role FROM employee WHERE uid = %s"
                cursor.execute(sql, (user['uid'],))
                role_data = cursor.fetchone()
                if role_data:
                    user['role'] = role_data['role']
                    return user
            return None
    finally:
        conn.close()