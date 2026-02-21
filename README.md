# ComplainX---Complaint-Management-System
The ComplainX - Complaint Management System is a web-based application developed using HTML, CSS, JavaScript, Java Servlets, JSP, and MySQL. The system allows users to register complaints and track their status, while administrators can manage, analyze, and update complaint records.

## 2. SYSTEM ARCHITECTURE
Architecture Type: 3-Tier Architecture
1.	Presentation Layer (Frontend)
o	HTML, CSS, JavaScript
o	JSP pages for dynamic content
2.	Business Logic Layer (Backend)
o	Java Servlets for handling requests and processing logic
3.	Data Layer (Database)
o	MySQL database accessed using JDBC

# 3. DATABASE DESIGN:
Users table:

`
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    `

Admin table:

`
CREATE TABLE admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100)
);
`


Complaints Table:

`
CREATE TABLE complaints (
    complaint_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    status ENUM('Pending','In Progress','Resolved') DEFAULT 'Pending',
    remarks TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
`

Complaint_updates Table:

`
CREATE TABLE complaint_updates (
    update_id INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id INT,
    admin_id INT,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    remarks TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(complaint_id),
    FOREIGN KEY (admin_id) REFERENCES admin(admin_id)
);
`


# 4. MODULE DESCRIPTION
User Module:
Features:
1.	Complaint registration form using HTML & CSS
2.	JavaScript validation for name, email, category, and description
3.	Complaint submission via Servlet
4.	Auto-generated Complaint ID
5.	Complaint status tracking page
   
Admin Module:
Features:
1.	Admin login using Servlet & HTTP Session
2.	Admin dashboard displaying complaints in table format
3.	Complaint status analysis (Pending / In Progress / Resolved)
4.	Update complaint status and remarks
5.	Store all updates securely in MySQL
   
# 5. VALIDATION AND SECURITY MEASURES
Client-Side Validation

•	JavaScript form validation for empty fields, email format, and description length

Server-Side Validation

•	Servlet validation for null values and SQL injection prevention using PreparedStatement

Duplicate Complaint Prevention

•	Unique constraint on user_id, category, and description
•	Backend duplicate check before inserting complaint
•	alter table complaints
•	 add constraint  unique_complaint unique(user_id,category,description);

Session Management

•	Admin authentication using HttpSession
•	Protected admin pages accessible only after login

## 6. WORKFLOW
User Workflow

1.	User registers complaint using complaint-form.html
2.	ComplaintServlet stores complaint in database
3.	Complaint ID is generated and shown to user
4.	User tracks complaint status using trackComplaint.jsp
   
Admin Workflow

1.	Admin logs in using LoginServlet
2.	Session is created for admin
3.	Admin dashboard retrieves complaints from MySQL
4.	Admin updates complaint status and remarks
5.	Updates stored in complaint_updates table

## HTML Files

•	Login.html – Admin login page
•	SignUp.html – User registration page
•	RoleSelection.html – Role selection (User/Admin)
•	complaint-form.html – Complaint registration form

## JSP Files

•	adminDashboard.jsp – Admin dashboard interface
•	userDashboard.jsp – User dashboard
•	trackComplaint.jsp – Complaint tracking page
•	confirmation.jsp – Complaint submission confirmation page

## CSS Folder (CSS/)

•	style.css – Global styling for login and signup pages
•	dashboard.css – Admin and user dashboard UI styling

## JavaScript Folder (JS/)

•	complaint.js – Client-side form validation for complaints
•	dashboard.js – dashboard UI scripts for tracking

## Assets Folder (assets/)

•	admin.png – Admin avatar image
•	dashboard.png – Dashboard logo image
•	user.png – User avatar image

## WEB-INF/classes/com/complaints/

Servlet Files

•	LoginServlet.java – Handles admin login
•	SignupServlet.java – Handles user registration
•	ComplaintServlet.java – Handles complaint submission
•	UpdateComplaintServlet.java – Updates complaint status and remarks
•	LogoutServlet.java – Handles logout functionality

Database Utility

•	DBConnection.java – JDBC database connection configuration

## 8. HOW TO RUN THE PROJECT

Prerequisites

1.	Java JDK installed
2.	Apache Tomcat Server
3.	MySQL Server
4.	VS Code / Eclipse / IntelliJ
   
Steps to Run

1.	Create MySQL database complaint_system
2.	Execute table creation SQL scripts
3.	Update DB credentials in DBConnection.java
4.	Add MySQL JDBC driver (mysql-connector.jar) to WEB-INF/lib
5.	Deploy project on Apache Tomcat
6.	Start Tomcat server
7.	Open browser and run:
http://localhost:8080/ProjectName/Login.html

