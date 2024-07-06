<!-- <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sidebar with Feather Icons</title>
    <link rel="stylesheet" href="path/to/bootstrap.min.css">
    <link rel="stylesheet" href="path/to/your/custom.css">
    <style>
        .sidebar-dropdown .sidebar-item {
            padding-left: 20px; /* Indent the sub-options */
            
        }
    </style>
</head>
<body>
    <nav id="sidebar" class="sidebar js-sidebar">
        <div class="sidebar-content js-simplebar">
            <a class="sidebar-brand" href="index.html">
                <span class="align-middle">DigiCode</span>
            </a>

            <ul class="sidebar-nav">
                <li class="sidebar-item active">
                    <a class="sidebar-link" href="super.jsp">
                        <i class="align-middle" data-feather="sliders"></i>
                        <span class="align-middle">Dashboard</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="admins.jsp">
                        <i class="align-middle" data-feather="user"></i>
                        <span class="align-middle">Admins</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a data-bs-target="#tickets-submenu" data-bs-toggle="collapse" class="sidebar-link collapsed">
                        <i class="align-middle" data-feather="log-in"></i>
                        <span class="align-middle">Tickets</span>
                    </a>
                    <ul id="tickets-submenu" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="AddTicketGroup.jsp">
                                <i class="align-middle" data-feather="plus-square"></i>
                                <span class="align-middle">New Ticket</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="createTicketForm">
                                <i class="align-middle" data-feather="file-text"></i>
                                <span class="align-middle">List Tickets</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="task.jsp">
                        <i class="align-middle" data-feather="user-plus"></i>
                        <span class="align-middle">Tasks</span>
                    </a>
                </li>
                <li class="sidebar-header">Settings</li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="#">
                        <i class="align-middle" data-feather="user"></i>
                        <span class="align-middle">Announcement</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="#">
                        <i class="align-middle" data-feather="check-square"></i>
                        <span class="align-middle">Messages</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="profile.jsp">
                        <i class="align-middle" data-feather="grid"></i>
                        <span class="align-middle">Profile</span>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://unpkg.com/feather-icons"></script>
    <script>
        feather.replace();
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/app.js"></script>
</body>
</html>
 -->
 <%@ page import="com.digicode.dao.LoginServiceImpl" %>
<%@ page import="com.digicode.model.EmployeeModel" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%
    // Initialize the username variable
    String username = "Guest";
    
    // Get the cookies from the request
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("username".equals(cookie.getName())) {
                username = cookie.getValue();
                break;
            }
        }
    }
    
    LoginServiceImpl loginService = new LoginServiceImpl();
    EmployeeModel user = loginService.getUserById(username);
    String position = user != null ? user.getPosition() : "user";
%>

<nav id="sidebar" class="sidebar js-sidebar">
    <div class="sidebar-content js-simplebar">
        <a class="sidebar-brand" href="index.html">
            <span class="align-middle">DigiCode</span>
        </a>

        <ul class="sidebar-nav">
            <li class="sidebar-item active">
                
                    <a class="sidebar-link" href="super.jsp">
                        <i class="align-middle" data-feather="sliders"></i>
                        <span class="align-middle">Dashboard</span>
                    </a>
                
            </li>
            <li class="sidebar-item">
                    <a class="sidebar-link" href="admins.jsp">
                        <i class="align-middle" data-feather="user"></i>
                        <span class="align-middle">Admins</span>
                    </a>
                </li>
                
			<li class="sidebar-item">
                    <a data-bs-target="#tickets-submenu" data-bs-toggle="collapse" class="sidebar-link collapsed">
                        <i class="align-middle" data-feather="log-in"></i>
                        <span class="align-middle">Tickets</span>
                    </a>
                    <ul id="tickets-submenu" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="AddTicketGroup.jsp">
                                <i class="align-middle" data-feather="plus-square"></i>
                                <span class="align-middle">New Ticket</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="list_tickets.jsp">
                                <i class="align-middle" data-feather="file-text"></i>
                                <span class="align-middle">List Tickets</span>
                            </a>
                        </li>
                    </ul>
                </li>
            <%-- Conditionally show "Employees" link based on user position --%>
            <% 
                if ("admin".equals(position)) { 
            %>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="employee.jsp">
                        <i class="align-middle" data-feather="user"></i>
                        <span class="align-middle">Employees</span>
                    </a>
                </li>
            <% } %>

            <%-- Conditionally show "Departments" link based on user position --%>
            <% 
                if ("admin".equals(position) || "super_admin".equals(position)) { 
            %>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="#">
                        <i class="align-middle" data-feather="log-in"></i>
                        <span class="align-middle">Departments</span>
                    </a>
                </li>
            <% } %>

            <li class="sidebar-item">
                <a class="sidebar-link" href="task.jsp">
                    <i class="align-middle" data-feather="user-plus"></i>
                    <span class="align-middle">Tasks</span>
                </a>
            </li>

           

            <li class="sidebar-item">
                <a class="sidebar-link" href="#">
                    <i class="align-middle" data-feather="check-square"></i>
                    <span class="align-middle">Messages</span>
                </a>
            </li>

            <li class="sidebar-item">
                <a class="sidebar-link" href="profile.jsp">
                    <i class="align-middle" data-feather="grid"></i>
                    <span class="align-middle">Profile</span>
                </a>
            </li>
        </ul>
    </div>
</nav>