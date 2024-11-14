import tkinter as tk
from tkinter import messagebox, ttk
# Import backend functions
try:
    from b import (
        add_user_account, get_user_account, get_all_user_account,
        add_employee, get_employee, get_all_employee, get_all_ecn, get_ecn,get_all_waiters,validate_user,menu,add_contact,update_user_account,delete_user,delete_employee,update_employee,get_all_sales,sales,get_all_orders,get_orders,add_sales,delete_sales
    )
except ImportError as e:
    print("Error importing backend functions:", e)

# Initialize Tkinter window
root = tk.Tk()
root.title("Restaurant Inventory Management System")
root.geometry("800x600")  # Adjust these values as needed
root.config()  # Sets the background color of the root window

# Optionally set the minimum size to prevent resizing too small
root.minsize(600, 400) 
# Function Definitions

def admin():
    #root=tk.Toplevel()
    notebook = ttk.Notebook()
    def add_user_account_ui():
        uid = user_uid_entry.get()
        username = username_entry.get()
        password = password_entry.get()
        try:
            add_user_account(uid, username, password)
            messagebox.showinfo("Success", "User account added successfully.")
            get_all_user_account_ui()  # Refresh the table after adding a user account
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def get_user_account_ui():
        uid = user_uid_entry.get()
        try:
            user = get_user_account(uid)
            if user:
                user_account_table.delete(*user_account_table.get_children())  # Clear existing data
                user_account_table.insert("", tk.END, values=(user['uid'], user['username'], user['password']))
            else:
                messagebox.showwarning("No Data", "No user account found with the given User ID.")
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def get_all_user_account_ui():
        # Clear the existing data in the Treeview
        for row in user_account_table.get_children():
            user_account_table.delete(row)
        
        try:
            users = get_all_user_account()
            if users:
                for user in users:
                    user_account_table.insert("", tk.END, values=(user['uid'], user['username'], user['password']))
            else:
                messagebox.showwarning("No Data", "No user accounts found.")
        except Exception as e:
            messagebox.showerror("Error", str(e))
    def change_user():
        uid = user_uid_entry.get()
        username=username_entry.get()
        password=password_entry.get()
        try:
            a=update_user_account(uid,username,password)
            messagebox.showinfo(message=a)
        except Exception as e:
            messagebox.showerror("Error",str(e))
    def remove_user():
        uid = user_uid_entry.get()
        try:
            a=delete_user(uid)
            messagebox.showinfo(message=a)
        except Exception as e:
            messagebox.showerror("Error",str(e))
    def add_employee_ui():
        id = emp_id_entry.get()
        role = role_entry.get()
        fname = fname_entry.get()
        mname = mname_entry.get()
        lname = lname_entry.get()
        email = email_entry.get()
        mid = mid_entry.get()
        uid = emp_uid_entry.get()
        try:
            add_employee(id, role, fname, mname, lname, email, mid, uid)
            messagebox.showinfo("Success", "Employee added successfully.")
            get_all_employee_ui()  # Refresh table after adding an employee
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def get_all_employee_ui():
        # Clear the existing data in the Treeview
        for row in employee_table.get_children():
            employee_table.delete(row)
        
        try:
            employees = get_all_employee()
            if employees:
                for emp in employees:
                    employee_table.insert("", tk.END, values=(emp['id'], emp['role'], emp['fname'], emp['mname'], emp['lname'], emp['email'], emp['mid'], emp['uid']))
            else:
                messagebox.showwarning("No Data", "No employees found.")
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def get_employee_ui():
        emp_id = emp_id_entry.get()
        try:
            employee = get_employee(emp_id)
            if employee:
                employee_table.delete(*employee_table.get_children())  # Clear table before showing the data
                employee_table.insert("", tk.END, values=(employee['id'], employee['role'], employee['fname'], employee['mname'], employee['lname'], employee['email'], employee['mid'], employee['uid']))
            else:
                messagebox.showwarning("No Data", "No employee found with the given ID.")
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def change_employee():
        id = emp_id_entry.get()
        role=role_entry.get()
        fname=fname_entry.get()
        mname=mname_entry.get()
        lname=lname_entry.get()
        email=email_entry.get()
        try:
            a=update_employee(id,role,fname,mname,lname,email)
            messagebox.showinfo(message=a)
        except Exception as e:
            messagebox.showerror("Error",str(e))
    def remove_employee():
        id = emp_id_entry.get()
        try:
            a=delete_employee(id)
            messagebox.showinfo(message=a)
        except Exception as e:
            messagebox.showerror("Error",str(e))
    def get_ecn_ui():
        eid = ecn_eid_entry.get()
        try:
            ecn = get_ecn(eid)
            if ecn:
                ecn_table.delete(*ecn_table.get_children())  # Clear existing data before displaying
                for contact in ecn:
                    ecn_table.insert("", tk.END, values=(contact['eid'], contact['contact']))
            else:
                messagebox.showwarning("No Data", "No contact details found for the given employee ID.")
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def get_all_ecn_ui():
        # Clear the existing data in the Treeview
        for row in ecn_table.get_children():
            ecn_table.delete(row)
        
        try:
            ecn_records = get_all_ecn()
            if ecn_records:
                for contact in ecn_records:
                    ecn_table.insert("", tk.END, values=(contact['eid'], contact['contact']))
            else:
                messagebox.showwarning("No Data", "No employee contact details found.")
        except Exception as e:
            messagebox.showerror("Error", str(e))
    def add_contact_ui():
        eid=ecn_eid_entry.get()
        contact=ecn_contact_entry.get()
        try:
            add_contact(eid,contact)
            messagebox.showinfo("Success", "Employee contact added successfully.")
            get_all_ecn_ui()  # Refresh table after adding an employee
        except Exception as e:
            messagebox.showerror("Error", str(e))
    def get_all_waiters_ui():
        # Clear the existing data in the Treeview
        for row in waiter_table.get_children():
            waiter_table.delete(row)

        try:
            waiters = get_all_waiters()  # Fetch all waiters data
            if waiters:
                for waiter in waiters:
                    waiter_table.insert("", tk.END, values=(waiter['wid']))
            else:
                messagebox.showwarning("No Data", "No waiters found.")
        except Exception as e:
            messagebox.showerror("Error", str(e))
    # Create Frames for each Tab
    user_account_frame = ttk.Frame(notebook)
    employee_frame = ttk.Frame(notebook)
    ecn_frame = ttk.Frame(notebook)
    waiters_frame = ttk.Frame(notebook)
    notebook.add(user_account_frame, text="User Accounts")
    notebook.add(employee_frame, text="Employees")
    notebook.add(ecn_frame, text="Employee Contacts")
    notebook.add(waiters_frame, text="Waiters")
    # Place the notebook in the window
    notebook.pack(fill="both", expand=True)

# User Account UI
    user_account_label = ttk.Label(user_account_frame, text="User Account Details")
    user_account_label.grid(row=0, column=0, columnspan=2, pady=10)

    user_uid_label = ttk.Label(user_account_frame, text="User ID")
    user_uid_label.grid(row=1, column=0, padx=10, pady=5)
    user_uid_entry = ttk.Entry(user_account_frame)
    user_uid_entry.grid(row=1, column=1, padx=10, pady=5)

    username_label = ttk.Label(user_account_frame, text="Username")
    username_label.grid(row=2, column=0, padx=10, pady=5)
    username_entry = ttk.Entry(user_account_frame)
    username_entry.grid(row=2, column=1, padx=10, pady=5)

    password_label = ttk.Label(user_account_frame, text="Password")
    password_label.grid(row=3, column=0, padx=10, pady=5)
    password_entry = ttk.Entry(user_account_frame)
    password_entry.grid(row=3, column=1, padx=10, pady=5)

    add_user_button = ttk.Button(user_account_frame, text="Add User", command=add_user_account_ui)
    add_user_button.grid(row=4, column=0, columnspan=2, pady=10)
    get_user_button = ttk.Button(user_account_frame, text="Get User", command=get_user_account_ui)
    get_user_button.grid(row=5, column=0, columnspan=2, pady=5)

    get_all_user_button = ttk.Button(user_account_frame, text="Get All Users", command=get_all_user_account_ui)
    get_all_user_button.grid(row=6, column=0, columnspan=2, pady=5)
    update_user = ttk.Button(user_account_frame, text="Update", command=change_user)
    update_user.grid(row=7, column=0, columnspan=2, pady=5)
    delete_user1 = ttk.Button(user_account_frame, text="Delete", command=remove_user)
    delete_user1.grid(row=8, column=0, columnspan=2, pady=5)
    # Create Treeview for displaying User Accounts
    user_account_columns = ('User ID', 'Username', 'Password')
    user_account_table = ttk.Treeview(user_account_frame, columns=user_account_columns, show="headings")
    for col in user_account_columns:
        user_account_table.heading(col, text=col)
    user_account_table.grid(row=9, column=0, columnspan=2, pady=10)

    # Employee UI
    emp_id_label = ttk.Label(employee_frame, text="Employee ID")
    emp_id_label.grid(row=0, column=0, padx=10, pady=5)
    emp_id_entry = ttk.Entry(employee_frame)
    emp_id_entry.grid(row=0, column=1, padx=10, pady=5)

    role_label = ttk.Label(employee_frame, text="Role")
    role_label.grid(row=1, column=0, padx=10, pady=5)
    role_entry = ttk.Entry(employee_frame)
    role_entry.grid(row=1, column=1, padx=10, pady=5)

    fname_label = ttk.Label(employee_frame, text="First Name")
    fname_label.grid(row=2, column=0, padx=10, pady=5)
    fname_entry = ttk.Entry(employee_frame)
    fname_entry.grid(row=2, column=1, padx=10, pady=5)

    mname_label = ttk.Label(employee_frame, text="Middle Name")
    mname_label.grid(row=3, column=0, padx=10, pady=5)
    mname_entry = ttk.Entry(employee_frame)
    mname_entry.grid(row=3, column=1, padx=10, pady=5)

    lname_label = ttk.Label(employee_frame, text="Last Name")
    lname_label.grid(row=4, column=0, padx=10, pady=5)
    lname_entry = ttk.Entry(employee_frame)
    lname_entry.grid(row=4, column=1, padx=10, pady=5)

    email_label = ttk.Label(employee_frame, text="Email")
    email_label.grid(row=5, column=0, padx=10, pady=5)
    email_entry = ttk.Entry(employee_frame)
    email_entry.grid(row=5, column=1, padx=10, pady=5)

    mid_label = ttk.Label(employee_frame, text="Manager ID")
    mid_label.grid(row=6, column=0, padx=10, pady=5)
    mid_entry = ttk.Entry(employee_frame)
    mid_entry.grid(row=6, column=1, padx=10, pady=5)

    emp_uid_label = ttk.Label(employee_frame, text="User ID")
    emp_uid_label.grid(row=7, column=0, padx=10, pady=5)
    emp_uid_entry = ttk.Entry(employee_frame)
    emp_uid_entry.grid(row=7, column=1, padx=10, pady=5)

    add_emp_button = ttk.Button(employee_frame, text="Add Employee", command=add_employee_ui)
    add_emp_button.grid(row=8, column=0, columnspan=2, pady=10)
    get_emp_button = ttk.Button(employee_frame, text="Get Employee", command=get_employee_ui)
    get_emp_button.grid(row=10, column=0, columnspan=2, pady=5)
    get_all_emp_button = ttk.Button(employee_frame, text="Get All Employees", command=get_all_employee_ui)
    get_all_emp_button.grid(row=9, column=0, columnspan=2, pady=5)
    update_emp1 = ttk.Button(employee_frame, text="Update", command=change_employee)
    update_emp1.grid(row=11, column=0, columnspan=2, pady=5)
    delete_emp1 = ttk.Button(employee_frame, text="Delete", command=remove_employee)
    delete_emp1.grid(row=12, column=0, columnspan=2, pady=5)
    # Create Treeview for displaying Employees
    employee_columns = ('Employee ID', 'Role', 'First Name', 'Middle Name', 'Last Name', 'Email', 'Manager ID', 'User ID')
    employee_table = ttk.Treeview(employee_frame, columns=employee_columns, show="headings")

    # Set up the column headings and widths
    for col in employee_columns:
        employee_table.heading(col, text=col)

    # Specify column widths
    employee_table.column('Employee ID', width=100)
    employee_table.column('Role', width=100)
    employee_table.column('First Name', width=100)
    employee_table.column('Middle Name', width=100)
    employee_table.column('Last Name', width=100)
    employee_table.column('Email', width=150)
    employee_table.column('Manager ID', width=100)
    employee_table.column('User ID', width=100)  # Make sure this is visible

    # Place the Treeview widget in the layout
    employee_table.grid(row=13, column=0, columnspan=2, pady=10)

    # Emergency Contact UI
    ecn_eid_label = ttk.Label(ecn_frame, text="Employee ID")
    ecn_eid_label.grid(row=0, column=0, padx=10, pady=5)
    ecn_eid_entry = ttk.Entry(ecn_frame)
    ecn_eid_entry.grid(row=0, column=1, padx=10, pady=5)

    ecn_contact_label = ttk.Label(ecn_frame, text="Contact")
    ecn_contact_label.grid(row=2, column=0, padx=10, pady=5)
    ecn_contact_entry = ttk.Entry(ecn_frame)
    ecn_contact_entry.grid(row=2, column=1, padx=10, pady=5)

    get_ecn_button = ttk.Button(ecn_frame, text="Get Employee Contact", command=get_ecn_ui)
    get_ecn_button.grid(row=4, column=0, columnspan=2, pady=5)
    get_all_ecn_button = ttk.Button(ecn_frame, text="Get All Employee Contacts", command=get_all_ecn_ui)
    get_all_ecn_button.grid(row=3, column=0, columnspan=2, pady=5)
    add_contact1=ttk.Button(ecn_frame,text="Add Employee Contact",command=add_contact_ui)
    add_contact1.grid(row=5, column=0, columnspan=2, pady=5)
    # Create Treeview for displaying Emergency Contacts
    ecn_columns = ('Employee ID', 'Contact')
    ecn_table = ttk.Treeview(ecn_frame, columns=ecn_columns, show="headings")
    for col in ecn_columns:
        ecn_table.heading(col, text=col)
    ecn_table.grid(row=6, column=0, columnspan=2, pady=10)

    waiter_label = ttk.Label(waiters_frame, text="Waiter Details")
    waiter_label.grid(row=0, column=0, columnspan=2, pady=10)

    waiter_id_label = ttk.Label(waiters_frame, text="Waiter ID")
    waiter_id_label.grid(row=1, column=0, padx=10, pady=5)

    get_all_waiter_button = ttk.Button(waiters_frame, text="Get All Waiters", command=get_all_waiters_ui)  # Function to get all waiters
    get_all_waiter_button.grid(row=3, column=0, columnspan=2, pady=5)

    # Create Treeview for displaying Waiters
    waiter_columns = ('Waiter ID',)  # Only one column for Waiter ID
    waiter_table = ttk.Treeview(waiters_frame, columns=waiter_columns, show="headings")

    # Set up the column heading
    waiter_table.heading('Waiter ID', text='Waiter ID')

    # Place the Treeview widget in the layout
    waiter_table.grid(row=4, column=0, columnspan=2, pady=10)
# Run Tkinter event loop
def waiter():
    notebook = ttk.Notebook()
    
    # Function to retrieve all dishes and display in Treeview
    def get_all_dishes():
        for row in dish_table.get_children():
            dish_table.delete(row)
        
        try:
            # Retrieve all dishes from menu() function
            dishes = menu()
            
            if dishes:
                for dish in dishes:
                    dish_table.insert("", tk.END, values=(dish['dname'],))
            else:
                messagebox.showwarning("No Data", "No dishes found.")
        
        except Exception as e:
            messagebox.showerror("Error", f"Error retrieving dishes: {str(e)}")
            print("Detailed Error:", e)  # Print error details to console for debugging
    def get_all_sales_ui():
        for row in sales_table.get_children():
            sales_table.delete(row)
        
        try:
            # Retrieve all dishes from menu() function
            sales = get_all_sales()
        
            if sales:
                for sale in sales:
                    sales_table.insert("", tk.END, values=(sale['sid'],sale['date'],sale['wid']))
            else:
                messagebox.showwarning("No Data", "No dishes found.")
        
        except Exception as e:
            messagebox.showerror("Error", f"Error retrieving sales: {str(e)}")
            print("Detailed Error:", e)  # Print error details to console for debugging
    def get_sales_ui():
        for row in sales_table.get_children():
            sales_table.delete(row)
        sid=s_id_entry.get()
        try:
            # Retrieve all dishes from menu() function
            sales1 = sales(sid)
            #print(sales1)
            if sales1:
                    sales_table.insert("", tk.END, values=(sales1['sid'], sales1['date'], sales1['wid']))

            else:
                messagebox.showwarning("No Data", "No dishes found.")
        
        except Exception as e:
            messagebox.showerror("Error", f"Error retrieving sales: {str(e)}")
            print("Detailed Error:", e)  # Print error details to console for debugging
    def add_sales_ui():
        sid=s_id_entry.get()
        date=date_entry.get()
        wid=w_entry.get()
        dishes = d_entry.get() 
        try:
            add_sales(sid,date,wid,dishes)
            messagebox.showinfo("Success", "Sales added successfully.")  
        except Exception as e:
            messagebox.showerror("Error", str(e))
    def delete_sales_ui():
        sid=s_id_entry.get()
        try:
            a=delete_sales(sid)
            messagebox.showinfo(message=a)
        except Exception as e:
            messagebox.showerror("Error",str(e))

    '''def get_all_orders_ui():
        for row in orders_table.get_children():
            orders_table.delete(row)
        
        try:
            # Retrieve all dishes from menu() function
            orders = get_all_orders()
        
            if orders:
                for order in orders:
                    orders_table.insert("", tk.END, values=(order['sid'],order['dname']))
            else:
                messagebox.showwarning("No Data", "No dishes found.")
        
        except Exception as e:
            messagebox.showerror("Error", f"Error retrieving sales: {str(e)}")
            print("Detailed Error:", e)'''# Print error details to console for debugging
    # Creating frames for each tab
    dish_frame = ttk.Frame(notebook)
    sales_frame = ttk.Frame(notebook)
    orders_frame = ttk.Frame(notebook)
    notebook.add(dish_frame, text="Menu")
    notebook.add(sales_frame, text="Sales")
    notebook.add(orders_frame, text="Orders")
    
    notebook.pack(fill="both", expand=True)

    dish_label = ttk.Label(dish_frame, text="Dishes")
    dish_label.grid(row=0, column=0, columnspan=2, pady=10)
    
    # Button to load menu
    get_all_dishes_button = ttk.Button(dish_frame, text="Load Menu", command=get_all_dishes)
    get_all_dishes_button.grid(row=1, column=0, columnspan=2, pady=5)
    
    # Treeview for displaying dishes
    dish_columns = ('Dish Name',)
    dish_table = ttk.Treeview(dish_frame, columns=dish_columns, show="headings")
    for col in dish_columns:
        dish_table.heading(col, text=col)
    dish_table.grid(row=3, column=0, columnspan=2, pady=10)
    s_id_label = ttk.Label(sales_frame, text="Sales ID")
    s_id_label.grid(row=0, column=0, padx=10, pady=5)
    s_id_entry = ttk.Entry(sales_frame)
    s_id_entry.grid(row=0, column=1, padx=10, pady=5)

    date_label = ttk.Label(sales_frame, text="Date")
    date_label.grid(row=1, column=0, padx=10, pady=5)
    date_entry = ttk.Entry(sales_frame)
    date_entry.grid(row=1, column=1, padx=10, pady=5)

    w_label = ttk.Label(sales_frame, text="Waiter ID")
    w_label.grid(row=2, column=0, padx=10, pady=5)
    w_entry = ttk.Entry(sales_frame)
    w_entry.grid(row=2, column=1, padx=10, pady=5)
    d_label = ttk.Label(sales_frame, text="Dishes")
    d_label.grid(row=3, column=0, padx=10, pady=5)
    d_entry = ttk.Entry(sales_frame)
    d_entry.grid(row=3, column=1, padx=10, pady=5)
    get_all_sales_button = ttk.Button(sales_frame, text="Get All Sales", command=get_all_sales_ui)
    get_all_sales_button.grid(row=4, column=0, columnspan=2, pady=5)
    get_sales_button = ttk.Button(sales_frame, text="Get Sales", command=get_sales_ui)
    
    get_sales_button.grid(row=5, column=0, columnspan=2, pady=5)
    add_sales_button = ttk.Button(sales_frame, text="Add Sales", command=add_sales_ui)
    add_sales_button.grid(row=6, column=0, columnspan=2, pady=5)
    delete_sales_button = ttk.Button(sales_frame, text="Delete Sales", command=delete_sales_ui)
    delete_sales_button.grid(row=7, column=0, columnspan=2, pady=5)
    sales_columns = ('Sales ID','Date','Waiter ID')
    sales_table = ttk.Treeview(sales_frame, columns=sales_columns, show="headings")
    for col in sales_columns:
        sales_table.heading(col, text=col)
    sales_table.grid(row=8, column=0, columnspan=2, pady=10)
def manager():
    pass
def verify_login(login_username,login_password):
    """Verify username and password and proceed based on role."""
    username = login_username.get()
    password = login_password.get()
    
    # Attempt to validate the user
    user_data = validate_user(username, password)
    
    if user_data:
        if user_data['role']=='Admin':
            messagebox.showinfo("Login Successful", f"Welcome, {user_data['role'].capitalize()}")
            root.destroy()
            admin()
        elif user_data['role']=='Waiter':
            messagebox.showinfo("Login Successful", f"Welcome, {user_data['role'].capitalize()}")
            root.destroy()
            waiter()
        elif user_data['role']=='Manager':
            messagebox.showinfo("Login Successful", f"Welcome, {user_data['role'].capitalize()}")
            root.destroy()
            manager()
        else:
            messagebox.showinfo("Login Failed")
            root.destroy()  # Close the login window
        
        # Display the main application sections
    else:
        messagebox.showerror("Login Failed", "Invalid username or password")

def show_login(root):
    """Login screen for username and password."""
    #login_window = tk.Toplevel(root)
    #root.title("Login")
    
    tk.Label(root, text="Username:", fg="black", font=("Arial", 18)).grid(row=0, column=0, pady=20, padx=20, sticky="e")

# Label for Password
    tk.Label(root, text="Password:", fg="black", font=("Arial", 18)).grid(row=1, column=0, pady=20, padx=20, sticky="e")

    # Entry for Username
    login_username = tk.Entry(root, fg="black", font=("Arial", 18), width=30)
    login_username.grid(row=0, column=1, pady=20, padx=20)

    # Entry for Password
    login_password = tk.Entry(root, fg="black", font=("Arial", 18), width=30)
    login_password.grid(row=1, column=1, pady=20, padx=20)

    # Button to login
    tk.Button(root, text="Login", fg="black", font=("Arial", 16), width=20,command=lambda: verify_login(login_username, login_password)).grid(row=2, column=0, columnspan=2, pady=30)

show_login(root)   
# Create Tabbed interface (Notebook)

root.mainloop()