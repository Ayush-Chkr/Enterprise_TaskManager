  Java Project: Ticket Management System

  Project Overview
The Ticket Management System is a comprehensive web application designed to streamline the process of managing tickets, tasks, and roles within an organization. The system is built using Java, HTML, CSS, JavaScript, MySQL, Hibernate, and JDBC. It is a collaborative project developed by a team of two and provides functionality for managing ticket groups, subgroups, admins, and employee assignments.

  Features
-  Role-Based Access Control : Supports login for Super Admin, Admin, and Employees, each with specific functionalities.
-  Dynamic Dropdowns : Group and subgroup dropdowns that dynamically update using AJAX.
-  Ticket Management : Create, assign, and track tickets efficiently.
-  Task Assignment : Assign tasks with attributes such as description, due date, severity, and assignee.
-  Session Management : Uses cookies to store user sessions securely.
-  Dynamic Dashboard Updates : Updates specific sections of the dashboard using AJAX without page reloads.

  Technologies Used
-  Backend : Java, Hibernate, JDBC, MySQL
-  Frontend : HTML, CSS, JavaScript, Bootstrap 5, jQuery
-  Tools : Gradle (build automation), VS Code
-  Other Features : AJAX for asynchronous data updates

  Prerequisites
1.  Java Development Kit (JDK) : Version 11 or higher
2.  MySQL Database : Installed and configured
3.  Gradle : Installed as the build tool
4.  Apache Tomcat : For deploying the web application
5.  Browser : Latest version of Google Chrome, Firefox, or Edge

  Installation and Setup
  Step 1: Clone the Repository
```bash
git clone <repository_url>
cd ticket-management-system
```

  Step 2: Configure the Database
- Import the provided SQL script into MySQL to set up the database schema and initial data.
- Update the database configuration in the `hibernate.cfg.xml` file located in the `src/main/resources` directory.

  Step 3: Build the Project
```bash
gradle build
```

  Step 4: Deploy on Tomcat
- Copy the `WAR` file generated in the `build/libs` directory to the `webapps` directory of your Tomcat installation.
- Start the Tomcat server.

  Step 5: Access the Application
Open a browser and navigate to `http://localhost:8080/ticket-management-system`.

  Project Structure
```
src
├── main
│   ├── java
│   │   └── com.example.ticketmanagement
│   │       ├── controllers
│   │       ├── models
│   │       ├── services
│   │       └── utils
│   ├── resources
│   │   ├── hibernate.cfg.xml
│   │   └── application.properties
│   └── webapp
│       ├── WEB-INF
│       └── static
│           ├── css
│           ├── js
│           └── images
├── test
└── build.gradle
```

  Key Components
-  Servlets : Handle HTTP requests and responses.
-  Hibernate : Manage ORM and database interactions.
-  JSP Files : Render dynamic content on the frontend.
-  AJAX Calls : Improve user experience by reducing page reloads.

  Usage
1.  Super Admin : Manage admins, ticket groups, and subgroups.
2.  Admin : Assign tasks and manage tickets within their group.
3.  Employee : View and update assigned tasks.



