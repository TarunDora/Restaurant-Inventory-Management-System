import tkinter as tk
from tkinter import ttk, messagebox
import mysql.connector
from datetime import datetime

class LoginWindow:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Restaurant Inventory System - Login")
        self.root.geometry("400x300")
        
        # Database connection
        self.db = mysql.connector.connect(
            host="localhost",
            user="root",
            password="0603",
            database="restaurant_inventory_db",
            auth_plugin='mysql_native_password'
        )
        self.cursor = self.db.cursor()
        
        # Login frame
        self.frame = ttk.Frame(self.root, padding="20")
        self.frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Username
        ttk.Label(self.frame, text="Username:").grid(row=0, column=0, pady=5)
        self.username = ttk.Entry(self.frame)
        self.username.grid(row=0, column=1, pady=5)
        
        # Password
        ttk.Label(self.frame, text="Password:").grid(row=1, column=0, pady=5)
        self.password = ttk.Entry(self.frame, show="*")
        self.password.grid(row=1, column=1, pady=5)
        
        # Login button
        ttk.Button(self.frame, text="Login", command=self.login).grid(row=2, column=0, columnspan=2, pady=20)
        
    def login(self):
        username = self.username.get()
        password = self.password.get()
        
        # Check credentials
        self.cursor.execute("SELECT u.uid, e.role, e.fname, e.lname FROM user_account u JOIN employee e ON u.uid = e.uid WHERE u.username = %s AND u.password = %s", (username, password))
        result = self.cursor.fetchone()
        
        if result:
            uid, role, fname, lname = result
            messagebox.showinfo("Welcome", f"Welcome {fname} {lname}!")
            self.root.withdraw()  # Hide login window
            
            # Open appropriate window based on role
            if role.lower() == 'admin':
                AdminWindow(self.db, uid, fname, lname)
            elif role.lower() == 'manager':
                ManagerWindow(self.db, uid, fname, lname)
            elif role.lower() == 'waiter':
                WaiterWindow(self.db, uid, fname, lname)
        else:
            messagebox.showerror("Error", "Invalid credentials!")

    def run(self):
        self.root.mainloop()

class AdminWindow:
    def __init__(self, db, uid, fname, lname):
        self.root = tk.Toplevel()
        self.root.title(f"Admin Panel - {fname} {lname}")
        self.root.geometry("800x600")
        self.db = db
        self.cursor = db.cursor()
        
        # Create notebook for tabs
        self.notebook = ttk.Notebook(self.root)
        self.notebook.pack(expand=True, fill='both')

        logout_btn = ttk.Button(self.root, text="Logout", command=self.logout)
        logout_btn.pack(pady=10)
        
        # Create tabs
        self.tabs = {
            'User Accounts': self.create_user_accounts_tab,
            'Employees': self.create_employees_tab,
            'Employee Contacts': self.create_contacts_tab,
            'Managers': self.create_managers_tab,
            'Waiters': self.create_waiters_tab,
            'Suppliers': self.create_suppliers_tab,
            'Dishes': self.create_dishes_tab,
            'Ingredients': self.create_ingredients_tab,
            'Recipe': self.create_recipe_tab,
            'Sales': self.create_sales_tab,
            'Orders': self.create_orders_tab,
            'Inventory': self.create_inventory_tab
        }
        
        for tab_name, tab_function in self.tabs.items():
            frame = ttk.Frame(self.notebook)
            self.notebook.add(frame, text=tab_name)
            tab_function(frame)

    def create_table_view(self, parent, query, columns):
        # Create treeview
        tree = ttk.Treeview(parent, columns=columns, show='headings')
        
        # Set column headings
        for col in columns:
            tree.heading(col, text=col.title())
            tree.column(col, width=100)
        
        # Add scrollbar
        scrollbar = ttk.Scrollbar(parent, orient='vertical', command=tree.yview)
        tree.configure(yscrollcommand=scrollbar.set)
        
        # Add data
        self.cursor.execute(query)
        for row in self.cursor.fetchall():
            tree.insert('', 'end', values=row)
        
        # Pack widgets
        tree.pack(side='left', fill='both', expand=True)
        scrollbar.pack(side='right', fill='y')
        
        return tree

    def create_user_accounts_tab(self, parent):
        query = "SELECT * FROM user_account"
        columns = ('uid', 'username', 'password')
        self.create_table_view(parent, query, columns)

    def create_employees_tab(self, parent):
        query = "SELECT * FROM employee"
        columns = ('id', 'role', 'fname', 'mname', 'lname', 'email', 'mid', 'uid')
        self.create_table_view(parent, query, columns)

    # Similar methods for other tabs...
    def create_contacts_tab(self, parent):
        query = "SELECT * FROM ecn"
        columns = ('eid', 'contact')
        self.create_table_view(parent, query, columns)

    def create_managers_tab(self, parent):
        query = "SELECT * FROM employee WHERE role = 'Manager'"
        columns = ('id', 'role', 'fname', 'mname', 'lname', 'email', 'mid', 'uid')
        self.create_table_view(parent, query, columns)

    def create_waiters_tab(self, parent):
        query = "SELECT * FROM waiter w JOIN employee e ON w.wid = e.id"
        columns = ('wid', 'fname', 'lname', 'email')
        self.create_table_view(parent, query, columns)

    def create_suppliers_tab(self, parent):
        query = "SELECT * FROM supplier"
        columns = ('sid', 'name', 'email')
        self.create_table_view(parent, query, columns)

    def create_dishes_tab(self, parent):
        query = "SELECT * FROM dish"
        columns = ('dname',)
        self.create_table_view(parent, query, columns)

    def create_ingredients_tab(self, parent):
        query = "SELECT * FROM ingredients"
        columns = ('iid', 'name', 'quantity', 'cpu', 'rl', 'edate', 'sid', 'status')
        self.create_table_view(parent, query, columns)

    def create_recipe_tab(self, parent):
        query = "SELECT * FROM recipe"
        columns = ('dname', 'iid', 'quantity')
        self.create_table_view(parent, query, columns)

    def create_sales_tab(self, parent):
        query = "SELECT * FROM sales"
        columns = ('sid', 'date', 'wid')
        self.create_table_view(parent, query, columns)

    def create_orders_tab(self, parent):
        query = "SELECT * FROM orders"
        columns = ('sid', 'dname')
        self.create_table_view(parent, query, columns)

    def create_inventory_tab(self, parent):
        query = "SELECT * FROM sorder"
        columns = ('sid', 'quantity', 'ingredient', 'od', 'dd', 'exp', 'price', 'status')
        self.create_table_view(parent, query, columns)
    
    def logout(self):
        self.root.destroy()
        login_window = LoginWindow()
        login_window.run()

class ManagerWindow:
    def __init__(self, db, uid, fname, lname):
        self.root = tk.Toplevel()
        self.root.title(f"Manager Panel - {fname} {lname}")
        self.root.geometry("800x600")
        self.db = db
        self.cursor = db.cursor()
        
        # Create notebook for tabs
        self.notebook = ttk.Notebook(self.root)
        self.notebook.pack(expand=True, fill='both', pady=10)
        
        # Create tabs
        self.tabs = {
            'Waiters': self.create_waiters_tab,
            'Sales': self.create_sales_tab,
            'Dishes': self.create_dishes_tab,
            'Ingredients': self.create_ingredients_tab,
            'Recipe': self.create_recipe_tab,
            'Inventory': self.create_inventory_tab,
            'Suppliers': self.create_suppliers_tab,
            'Orders': self.create_orders_tab
        }
        
        for tab_name, tab_function in self.tabs.items():
            frame = ttk.Frame(self.notebook)
            self.notebook.add(frame, text=tab_name)
            tab_function(frame)
            
        # Add logout button
        logout_btn = ttk.Button(self.root, text="Logout", command=self.logout)
        logout_btn.pack(pady=10)

    def create_table_view(self, parent, query, columns):
        tree = ttk.Treeview(parent, columns=columns, show='headings')
        for col in columns:
            tree.heading(col, text=col.title())
            tree.column(col, width=100)
        
        scrollbar = ttk.Scrollbar(parent, orient='vertical', command=tree.yview)
        tree.configure(yscrollcommand=scrollbar.set)
        
        self.cursor.execute(query)
        for row in self.cursor.fetchall():
            tree.insert('', 'end', values=row)
        
        tree.pack(side='left', fill='both', expand=True)
        scrollbar.pack(side='right', fill='y')
        return tree

    def create_waiters_tab(self, parent):
        query = """
        SELECT w.wid, e.fname, e.lname, e.email, e.role 
        FROM waiter w 
        JOIN employee e ON w.wid = e.id
        """
        columns = ('ID', 'First Name', 'Last Name', 'Email', 'Role')
        self.create_table_view(parent, query, columns)

    def create_sales_tab(self, parent):
        query = """
        SELECT s.sid, s.date, e.fname, e.lname, d.dname 
        FROM sales s 
        JOIN employee e ON s.wid = e.id 
        JOIN orders o ON s.sid = o.sid 
        JOIN dish d ON o.dname = d.dname
        """
        columns = ('Sale ID', 'Date', 'Waiter First Name', 'Waiter Last Name', 'Dish')
        self.create_table_view(parent, query, columns)

    def create_dishes_tab(self, parent):
        query = "SELECT * FROM dish"
        columns = ('Dish Name',)
        self.create_table_view(parent, query, columns)

    def create_ingredients_tab(self, parent):
        query = """
        SELECT i.iid, i.name, i.quantity, i.cpu, i.rl, i.edate, s.name as supplier, i.status 
        FROM ingredients i 
        JOIN supplier s ON i.sid = s.sid
        """
        columns = ('ID', 'Name', 'Quantity', 'Cost Per Unit', 'Reorder Level', 'Expiry Date', 'Supplier', 'Status')
        self.create_table_view(parent, query, columns)

    def create_recipe_tab(self, parent):
        query = """
        SELECT r.dname, i.name, r.quantity 
        FROM recipe r 
        JOIN ingredients i ON r.iid = i.iid
        """
        columns = ('Dish Name', 'Ingredient', 'Quantity')
        self.create_table_view(parent, query, columns)

    def create_inventory_tab(self, parent):
        query = """
        SELECT s.sid, s.quantity, i.name as ingredient, s.od, s.dd, s.exp, s.price, s.status 
        FROM sorder s 
        JOIN ingredients i ON s.ingredient = i.iid
        """
        columns = ('Order ID', 'Quantity', 'Ingredient', 'Order Date', 'Delivery Date', 'Expiry', 'Price', 'Status')
        self.create_table_view(parent, query, columns)

    def create_suppliers_tab(self, parent):
        query = "SELECT * FROM supplier"
        columns = ('Supplier ID', 'Name', 'Email')
        self.create_table_view(parent, query, columns)

    def create_orders_tab(self, parent):
        query = """
        SELECT o.sid, o.dname, s.date, e.fname, e.lname 
        FROM orders o 
        JOIN sales s ON o.sid = s.sid 
        JOIN employee e ON s.wid = e.id
        """
        columns = ('Sale ID', 'Dish Name', 'Date', 'Waiter First Name', 'Waiter Last Name')
        self.create_table_view(parent, query, columns)

    def logout(self):
        self.root.destroy()
        login_window = LoginWindow()
        login_window.run()

        
class WaiterWindow:
    def __init__(self, db, uid, fname, lname):
        self.root = tk.Toplevel()
        self.root.title(f"Waiter Panel - {fname} {lname}")
        self.root.geometry("600x400")
        self.db = db
        self.cursor = db.cursor()
        self.uid = uid
        
        # Create main frame
        main_frame = ttk.Frame(self.root, padding="20")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Display waiter information
        ttk.Label(main_frame, text=f"Name: {fname} {lname}").grid(row=0, column=0, pady=5)
        
        # Get waiter ID
        self.cursor.execute("SELECT id FROM employee WHERE uid = %s", (uid,))
        self.wid = self.cursor.fetchone()[0]
        
        # Create order frame
        order_frame = ttk.LabelFrame(main_frame, text="New Order", padding="10")
        order_frame.grid(row=1, column=0, pady=20)
        
        # Dish selection
        ttk.Label(order_frame, text="Select Dish:").grid(row=0, column=0, pady=5)
        self.dish_var = tk.StringVar()
        self.cursor.execute("SELECT dname FROM dish")
        dishes = [row[0] for row in self.cursor.fetchall()]
        dish_combo = ttk.Combobox(order_frame, textvariable=self.dish_var, values=dishes)
        dish_combo.grid(row=0, column=1, pady=5)
        
        # Add order button
        ttk.Button(order_frame, text="Add Order", command=self.add_order).grid(row=1, column=0, columnspan=2, pady=10)
        
        # Show current orders
        ttk.Label(main_frame, text="Today's Orders:").grid(row=2, column=0, pady=5)
        self.create_orders_view(main_frame)

        # Add logout button
        logout_btn = ttk.Button(main_frame, text="Logout", command=self.logout)
        logout_btn.grid(row=4, column=0, pady=10)

    def create_orders_view(self, parent):
        # Create treeview for orders
        columns = ('Sale ID', 'Dish Name', 'Date')
        tree = ttk.Treeview(parent, columns=columns, show='headings')
        
        for col in columns:
            tree.heading(col, text=col)
            tree.column(col, width=150)
        
        # Get today's orders
        query = """
        SELECT s.sid, o.dname, s.date
        FROM sales s
        JOIN orders o ON s.sid = o.sid
        WHERE s.wid = %s AND DATE(s.date) = CURDATE()
        """
        self.cursor.execute(query, (self.wid,))
        
        for row in self.cursor.fetchall():
            tree.insert('', 'end', values=row)
        
        tree.grid(row=3, column=0, pady=10)

    def add_order(self):
        if not self.dish_var.get():
            messagebox.showerror("Error", "Please select a dish!")
            return
        
        try:
            # Create new sale
            sale_query = "INSERT INTO sales (date, wid) VALUES (NOW(), %s)"
            self.cursor.execute(sale_query, (self.wid,))
            
            # Get the sale ID
            self.cursor.execute("SELECT LAST_INSERT_ID()")
            sale_id = self.cursor.fetchone()[0]
            
            # Create order
            order_query = "INSERT INTO orders (sid, dname) VALUES (%s, %s)"
            self.cursor.execute(order_query, (sale_id, self.dish_var.get()))
            
            self.db.commit()
            messagebox.showinfo("Success", "Order added successfully!")
            
            # Refresh orders view
            self.create_orders_view(self.root)
            
        except mysql.connector.Error as err:
            messagebox.showerror("Error", f"Failed to add order: {err}")
            self.db.rollback()

    def logout(self):
        self.root.destroy()
        login_window = LoginWindow()
        login_window.run()

if __name__ == "__main__":
    app = LoginWindow()
    app.run()