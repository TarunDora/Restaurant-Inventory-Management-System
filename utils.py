import pymysql
def connect_db():
    return pymysql.connect(
        host='localhost',  
        user='root',      
        password='omsai', 
        database='rims',  
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
def update_user_account(uid, username=None, password=None):
    conn = connect_db()
    
    try:
        # Prepare the list of updates dynamically
        updates = []
        values = []
        
        # Check each field and add to the update query if specified
        if username:
            updates.append("username = %s")
            values.append(username)
        
        if password:
            updates.append("password = %s")
            values.append(password)
        
        
        # Check if there are updates; if not, exit early
        if not updates:
            return "No fields to update"
        
        # Prepare the full SQL command
        updates_str = ", ".join(updates)
        values.append(uid)  # Original uid as the last parameter for the WHERE clause
        
        sql = f"UPDATE user_account SET {updates_str} WHERE uid = %s"
        
        # Execute the query
        with conn.cursor() as cursor:
            cursor.execute(sql, tuple(values))
        
        conn.commit()
        return "Update successful"
    
    finally:
        conn.close()
def delete_user(uid):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "DELETE FROM user_account WHERE uid = %s"
            cursor.execute(sql, (uid,))  # Note the comma to make it a tuple
        conn.commit()  # Ensure changes are committed to the database
        return "User deleted successfully"
    except Exception as e:
        return f"Error deleting user: {e}"
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
def update_employee(id, role=None, fname=None,mname=None,lname=None,email=None):
    conn = connect_db()
    
    try:
        # Prepare the list of updates dynamically
        updates = []
        values = []
        
        # Check each field and add to the update query if specified
        if role:
            updates.append("role = %s")
            values.append(role)
        
        if fname:
            updates.append("fname = %s")
            values.append(fname)
        if mname:
            updates.append("mname = %s")
            values.append(mname)
        if lname:
            updates.append("lname = %s")
            values.append(lname)
        if email:
            updates.append("email = %s")
            values.append(email)
        
        
        # Check if there are updates; if not, exit early
        if not updates:
            return "No fields to update"
        
        # Prepare the full SQL command
        updates_str = ", ".join(updates)
        values.append(id)  # Original uid as the last parameter for the WHERE clause
        
        sql = f"UPDATE employee SET {updates_str} WHERE uid = %s"
        
        # Execute the query
        with conn.cursor() as cursor:
            cursor.execute(sql, tuple(values))
        
        conn.commit()
        return "Update successful"
    
    finally:
        conn.close()
def delete_employee(id):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            a="select role from employee where id=%s"
            b=cursor.execute(a, (id,))
            if b=='manager':
                w="update employee set mid=NULL where mid=%s"
                cursor.execute(w, (id,))
            sql = "DELETE FROM employee WHERE id = %s"
            cursor.execute(sql, (id,))  # Note the comma to make it a tuple
        conn.commit()  # Ensure changes are committed to the database
        return "employee deleted successfully"
    except Exception as e:
        return f"Error deleting employee: {e}"
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
def menu():
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM dish"  # Adjust to match your actual column name
            cursor.execute(sql)
            result = cursor.fetchall()
            return result  # Assuming 'dname' is the first column
            
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_all_dishes()
        
    finally:
        conn.close()
def get_all_sales():
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM sales"  # Adjust to match your actual column name
            cursor.execute(sql)
            result = cursor.fetchall()
            return result  # Assuming 'dname' is the first column
            
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_all_dishes()
        
    finally:
        conn.close()
def sales(sid):
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT sid, date, wid FROM sales WHERE sid=%s"
            cursor.execute(sql, (sid,))
            result = cursor.fetchone()  # Only fetch one entry
            #print(result)
            # Return the tuple directly
            return result
    
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_sales_ui()
    
    finally:
        conn.close()


def add_contact(eid,contact): 
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "INSERT INTO ecn (eid,contact) VALUES (%s, %s)"
            cursor.execute(sql, (eid,contact))
        conn.commit()
    finally:
        conn.close()
def get_all_orders():
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM orders"  # Adjust to match your actual column name
            cursor.execute(sql)
            result = cursor.fetchall()
            return result  # Assuming 'dname' is the first column
            
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_all_dishes()
        
    finally:
        conn.close()
def get_orders(sid):
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM orders WHERE sid=%s"
            cursor.execute(sql, (sid,))
            result = cursor.fetchall()  # Only fetch one entry
            #print(result)
            # Return the tuple directly
            return result
    
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_sales_ui()
    
    finally:
        conn.close()
def add_sales(sid, date, wid, dishes):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            # Insert the sale into the sales table
            sql_sales = "INSERT INTO sales (sid, date, wid) VALUES (%s, %s, %s)"
            cursor.execute(sql_sales, (sid, date, wid))
            
            # Split the comma-separated dishes into a list
            dish_list = [dish.strip() for dish in dishes.split(',')]
            
            # Insert each dish into the orders table with the sales ID
            sql_orders = "INSERT INTO orders (sid, dname) VALUES (%s, %s)"
            for dish in dish_list:
                cursor.execute(sql_orders, (sid, dish))
        
        conn.commit()  # Commit both inserts to the database
    except Exception as e:
        conn.rollback()  # Rollback in case of error
        print("Database error:", e)
        raise e
    finally:
        conn.close()

def delete_sales(sid):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "DELETE FROM sales WHERE sid = %s"
            cursor.execute(sql, (sid,))  # Note the comma to make it a tuple
        conn.commit()  # Ensure changes are committed to the database
        return "Sales deleted successfully"
    except Exception as e:
        return f"Error deleting employee: {e}"
    finally:
        conn.close()
def get_all_ingredients():
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM ingredients"  # Adjust to match your actual column name
            cursor.execute(sql)
            result = cursor.fetchall()
            return result  # Assuming 'dname' is the first column
            
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_all_dishes()
        
    finally:
        conn.close()
def get_ingredient(name):
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM ingredients where name=%s"  # Adjust to match your actual column name
            cursor.execute(sql,(name,))
            result = cursor.fetchone()
            return result  # Assuming 'dname' is the first column
            
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_all_dishes()
        
    finally:
        conn.close()
def get_all_recipe():
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM recipe"  # Adjust to match your actual column name
            cursor.execute(sql)
            result = cursor.fetchall()
            return result  # Assuming 'dname' is the first column
            
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_all_dishes()
        
    finally:
        conn.close()
def get_recipe(dname):
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM recipe where dname=%s"  # Adjust to match your actual column name
            cursor.execute(sql,(dname,))
            result = cursor.fetchall()
            return result  # Assuming 'dname' is the first column
            
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_all_dishes()
        
    finally:
        conn.close()
def get_supplier():
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM supplier"  # Adjust to match your actual column name
            cursor.execute(sql)
            result = cursor.fetchall()
            return result  # Assuming 'dname' is the first column
            
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_all_dishes()
        
    finally:
        conn.close()
def get_sorder():
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM sorder"  # Adjust to match your actual column name
            cursor.execute(sql)
            result = cursor.fetchall()
            return result  # Assuming 'dname' is the first column
            
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_all_dishes()
        
    finally:
        conn.close()
def add_supplier(sid, name,email):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            # Insert the sale into the sales table
            sql = "INSERT INTO supplier (sid, name,email) VALUES (%s, %s, %s)"
            cursor.execute(sql, (sid,name,email))
            
        
        conn.commit()  # Commit both inserts to the database
    except Exception as e:
        conn.rollback()  # Rollback in case of error
        print("Database error:", e)
        raise e
    finally:
        conn.close()
def update_supplier(sid, name=None, email=None):
    conn = connect_db()
    
    try:
        # Prepare the list of updates dynamically
        updates = []
        values = []
        
        # Check each field and add to the update query if specified
        if name:
            updates.append("name = %s")
            values.append(name)
        
        if email:
            updates.append("email = %s")
            values.append(email)
        
        
        
        # Check if there are updates; if not, exit early
        if not updates:
            return "No fields to update"
        
        # Prepare the full SQL command
        updates_str = ", ".join(updates)
        values.append(sid)  # Original uid as the last parameter for the WHERE clause
        
        sql = f"UPDATE supplier SET {updates_str} WHERE sid = %s"
        
        # Execute the query
        with conn.cursor() as cursor:
            cursor.execute(sql, tuple(values))
        
        conn.commit()
        return "Update successful"
    
    finally:
        conn.close()
def delete_supplier(sid):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "DELETE FROM supplier WHERE sid = %s"
            cursor.execute(sql, (sid,))  # Note the comma to make it a tuple
        conn.commit()  # Ensure changes are committed to the database
        return "supplier deleted successfully"
    except Exception as e:
        return f"Error deleting supplier: {e}"
    finally:
        conn.close()
def add_sorder(quantity,ingredient,od,dd,exp):
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            # Insert the sale into the sales table
            
            cursor.execute("call place_sorder(%s,%s,%s,%s,%s)",(ingredient,quantity,od,dd,exp))
            
        
        conn.commit()  # Commit both inserts to the database
    except Exception as e:
        conn.rollback()  # Rollback in case of error
        print("Database error:", e)
        raise e
    finally:
        conn.close()
def expiry(input):
    conn=connect_db()
    cursor=conn.cursor()
    cursor.execute("CALL check_expiry(%s)", (input,))
    conn.commit()
    conn.close()
def delivery(input):
    conn=connect_db()
    cursor=conn.cursor()
    cursor.execute("call update_ingredient_on_delivery(%s)", (input,))
    conn.commit()
    conn.close()
def remove():
    conn=connect_db()
    cursor=conn.cursor()
    cursor.execute("CALL reset_quantity_for_expired_ingredients()")
    conn.commit()
    conn.close()
def get_critical_ingredients():
    try:
        conn = connect_db()  # Ensure connect_db() is defined and correct
        with conn.cursor() as cursor:
            sql = "SELECT * FROM ingredients where status<>'normal'"  # Adjust to match your actual column name
            cursor.execute(sql)
            result = cursor.fetchall()
            return result  # Assuming 'dname' is the first column
            
    except Exception as e:
        print("Database error:", e)  # Log error details for debugging
        raise e  # Reraise the exception for handling in get_all_dishes()
        
    finally:
        conn.close()
#--------------------
#aggregate query
#--------------------
def fetch_order_data():
    connection = connect_db()
    cursor = connection.cursor()

    query = "SELECT od, SUM(price) AS total_order_sum FROM sorder GROUP BY od"
    cursor.execute(query)

    # Fetch all results
    results = cursor.fetchall()

    cursor.close()
    connection.close()

    return results
#-------------------
#join query
#-------------------
def join_supplier():
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT s.name AS Supplier, i.name AS Ingredient FROM supplier s JOIN ingredients i ON s.sid = i.sid;"

            cursor.execute(sql)  # Note the comma to make it a tuple
            result =cursor.fetchall()
            return result
    except Exception as e:
        return f"Error joining supplier: {e}"
    finally:
        conn.close()
#------------------
#nested query
#------------------
def nested():
    conn = connect_db()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT w.wid AS Waiter_ID, (SELECT COUNT(s.sid) FROM sales s WHERE s.wid = w.wid) AS Total_Sales FROM waiter w;"


            cursor.execute(sql)  # Note the comma to make it a tuple
            result =cursor.fetchall()
            return result
    except Exception as e:
        return f"Error nesting waiters: {e}"
    finally:
        conn.close()