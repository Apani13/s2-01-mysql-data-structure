# S02.01 – SQL Database Modeling

## 🎯 Objectives
- **Learn** how to model SQL databases  
- **Understand** database relationships and constraints  
- **Practice** creating comprehensive schemas for real-world scenarios  

---

## 🔹 Level 1

### 📘 Exercise 1 – Optician **“Cul d’Ampolla”**
An optician wants to computerize customer and glasses sales.

#### Supplier data
- Name  
- Address: street, number, floor, door, city, postal code, country  
- Phone · Fax · NIF  

#### Glasses data
- Brand <sup>(one brand ↔ one supplier)</sup>  
- Graduation (left & right)  
- Frame type: _floating · plastic · metallic_  
- Frame color, Lens color  
- Price  

#### Customer data
- Name, Postal address, Phone, Email  
- Registration date  
- Referrer customer (optional)  
- Which **employee** sold each pair of glasses  

---

### 📘 Exercise 2 – Pizzeria
Design a DB for an online food-delivery site.

#### Customer
- ID, Name, Surname  
- Address, Postal code  
- Location 🔗 table, Province 🔗 table  
- Phone  

#### Order
- ID, Date/time, Delivery / Pickup  
- Product quantities, Total price  
- _1 customer → many orders_

#### Products
- Pizzas (with **categories** that may be renamed)  
- Hamburgers  
- Drinks  
- For each: ID, name, description, image, price  

#### Stores
- ID, Address, Postal code, Location, Province  
- Employees (_cook / delivery_)  

---

## 🛠️ Technologies Used  
- MySQL - Relational Database Management System
- SQL - Structured Query Language
- Tools for database design like MySQL Workbench
- Git - Version Control System
- Markdown for documentation
---

## ⚙️ Installation & Execution

### 📋 Requirements
- MySQL:
-- Version: 8.0 or higher
- MySQL Workbench (optional for visualization and design):
-- Version: 8.0 or higher
- Operating System: Compatible with Windows, macOS, or Linux
- Git:
-- Installed and configured for version control  


### 🛠️ Installation

1. **Clone this repository**

   ```bash
   git clone https://github.com/Apani13/s2-t1-mysql-data-structure.git
   ```

2. **Navigate to the repo**

   ```bash
   cd s2-01-mysql-data-structure
   ```

3. **Open** MySQL Workbench *or* your preferred MySQL client.

4. **Import the SQL scripts**

   Use the `.sql` files in each exercise folder to create the databases.

---

### ▶️ Execution

1. Open your MySQL client / terminal and make sure the server is running.

2. Execute the scripts.

3. Verify tables and relationships via SQL queries or the EER diagram view in Workbench.


### 🌐 Deployment
Models are educational and work in any SQL environment.

---

## 📦 Repository
Version-control your SQL in Git (or any VCS).

---

## ✅ Author Notes
These exercises give hands-on practice with database modeling and relationships.  
After building the schemas, **populate tables with test data** to ensure everything links correctly.

**Happy modeling! 🚀**

