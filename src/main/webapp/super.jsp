<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="org.hibernate.cfg.Configuration" %>
<%@ page import="java.util.List" %>
<%@ page import="com.digicode.model.TicketsModel" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Initialize Hibernate SessionFactory
    //testing git
    Configuration configuration = new Configuration().configure();
    SessionFactory sessionFactory = configuration.buildSessionFactory();

    // Open a new Hibernate Session
    Session hibernateSession = sessionFactory.openSession();

    Transaction transaction = null;

    String username = "Guest";
    List<TicketsModel> assignedTickets = new ArrayList<>();
    List<TicketsModel> assignedTickets1 = new ArrayList<>();
    List<TicketsModel> assignedTickets2= new ArrayList<>();
    List<TicketsModel> assignedTickets3 = new ArrayList<>();
    List<TicketsModel> toShow = new ArrayList<>();
   

    try {
        transaction = hibernateSession.beginTransaction();

        // Retrieve username from cookies
        javax.servlet.http.Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (javax.servlet.http.Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    username = cookie.getValue();
                    break;
                }
            }
        }

        // Query tickets assigned to the user
        org.hibernate.Query query = hibernateSession.createQuery("FROM TicketsModel WHERE created_by= 'super_admin' AND status !='Completed' ");
        assignedTickets = query.list();
        toShow= assignedTickets;
        query = hibernateSession.createQuery("FROM TicketsModel WHERE created_by= 'super_admin' AND status !='Completed' AND employee_id= 'A1001' ");
        assignedTickets1 = query.list();
        query = hibernateSession.createQuery("FROM TicketsModel WHERE created_by= 'super_admin' AND status !='Completed' AND employee_id= 'A1002' ");
        assignedTickets2 = query.list();
        query = hibernateSession.createQuery("FROM TicketsModel WHERE created_by= 'super_admin' AND status !='Completed' AND employee_id= 'A1003' ");
        assignedTickets3 = query.list();

        transaction.commit();
    } catch (Exception e) {
        if (transaction != null) {
            transaction.rollback();
        }
        e.printStackTrace();
    } finally {
        // Close Hibernate session
        hibernateSession.close();
        // Close Hibernate SessionFactory (not necessary in simple cases)
        // sessionFactory.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Super Admin Dashboard</title>
    <!-- Include your CSS and other head elements -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Responsive Admin & Dashboard Template based on Bootstrap 5">
    <meta name="author" content="AdminKit">
    <meta name="keywords" content="adminkit, bootstrap, bootstrap 5, admin, dashboard, template, responsive, css, sass, html, theme, front-end, ui kit, web">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="shortcut icon" href="./assets/img/icons/icon-48x48.png" />
    <link rel="canonical" href="https://demo-basic.adminkit.io/" />
    <link href="./assets/css/app.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="./assets/css/ed.css" rel="stylesheet">
    <style>
        .card-equal-height {
            height: 100%;
        }
        .generate-ticket-btn {
            background-color: #4CAF50; /* Green background */
            border: none; /* Remove borders */
            color: white; /* White text */
            padding: 15px 32px; /* Some padding */
            text-align: center; /* Center the text */
            text-decoration: none; /* Remove underline */
            display: inline-block; /* Get the block to flow with other elements */
            font-size: 16px; /* Increase font size */
            margin: 10px 2px; /* Some margin */
            cursor: pointer; /* Pointer/hand icon on hover */
            border-radius: 12px; /* Rounded corners */
        }

        .generate-ticket-btn:hover {
            background-color: #45a049; /* Darker green on hover */
        }
        
    </style>
<style>
    .preloader {
        background: rgba(0, 0, 0, 0.5); /* Semi-transparent black background */
        backdrop-filter: blur(10px); /* Adjust blur radius as needed */
        -webkit-backdrop-filter: blur(10px); /* For Safari */
        height: 100vh; /* Full viewport height */
        width: 100vw; /* Full viewport width */
        position: fixed;
        top: 0;
        left: 0;
        z-index: 100;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .preloader::before {
        content: '';
        background: url("./assets/img/photos/preloader.png") no-repeat center center;
        background-size: 300px;
        width: 300px; /* Fixed width for the preloader image */
        height: 300px; /* Fixed height for the preloader image */
        position: absolute;
        animation: rotate 15s infinite linear; /* Rotation animation */
    }

    @keyframes rotate {
        from {
            transform: rotate(0deg);
        }
        to {
            transform: rotate(360deg);
        }
    }
</style>

</head>


<body>
   <script>
        // JavaScript to hide the preloader after a delay
        document.addEventListener("DOMContentLoaded", function() {
            var loader = document.getElementById("preloader");

            // Add a delay of 1.5 seconds (1500 milliseconds) before hiding the preloader
            setTimeout(function () {
                loader.style.display = "none";
            }, 1500);
        });
    </script>
<div class="preloader" id="preloader"></div>
    <div class="wrapper">
        <jsp:include page="sidebar.jsp"></jsp:include>
        <div class="main">
            <jsp:include page="nav.jsp"></jsp:include>
            <main class="content">
                <div class="container-fluid p-0">
                    <!-- Top Boxes -->
                    <div class="row">
                    	
                        
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2" id="completedCount"></h3>
                                            <p class="mb-0">Completed</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-check-circle text-success fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2" id="pendingTicketsCount"></h3>
                                            <p class="mb-0">Pending Tasks</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-hourglass-half text-warning fa-2x"></i>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2" id="totalTicketsCount"></h3>
                                            <p class="mb-0">Total</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-tasks text-primary fa-2x"></i>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2" id="transferredTicketsCount">0</h3>
                                            <p class="mb-0">Tickets Transfered</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-exchange text-success fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2" id="highSeverityCount"></h3>
                                            <p class="mb-0">High Severity</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-exclamation-triangle text-danger fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2" id="mediumSeverityCount"></h3>
                                            <p class="mb-0">Medium Severity</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-exclamation-circle text-warning fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-grow-1">
                                            <h3 class="mb-2" id="lowSeverityCount"></h3>
                                            <p class="mb-0">Low Severity</p>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <i class="fa fa-info-circle text-info fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-12 col-xxl-12">
							 
							<div class="card flex-fill w-100">
								<div class="card-header">
									<h5 class="card-title">Task Chart</h5>
								</div>
								<div class="card-body">
									<div class="chart">
										<canvas id="chartjs-line"></canvas>
									</div>
								</div>
							</div>
						 
						</div>
						<div class="row">
						<div class="col-12 col-md-6 col-xxl-3 d-flex order-2 order-xxl-3">
							<div class="card flex-fill w-100">
								<div class="card-header">

									<h5 class="card-title mb-0">Total Output</h5>
								</div>
								<div class="card-body d-flex">
									<div class="align-self-center w-100">
										<div class="py-3">
											<div class="chart chart-xs">
												<canvas id="chartjs-dashboard-pie"></canvas>
											</div>
										</div>

										<table class="table mb-0">
											<tbody>
												<tr>
													<td>Plant1</td>
													<td class="text-end">4306</td>
												</tr>
												<tr>
													<td>Plant2</td>
													<td class="text-end">3801</td>
												</tr>
												<tr>
													<td>Plant3</td>
													<td class="text-end">1689</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="col-12 col-md-12 col-xxl-9 d-flex order-3 order-xxl-2">
							<div class="card flex-fill w-100">
								<div class="card-header">

									<h5 class="card-title mb-0">Real-Time</h5>
								</div>
								<div class="card-body px-4">
									<div id="world_map" style="height: 350px;"></div>
								</div>
							</div>
						</div>
                 
                    <!-- Pending Tickets -->
                    <div class="row">
                        <div class="col-xl-12 col-xxl-12 d-flex">
                            <div class="card flex-fill w-100">
                                <div class="card-header">
                                    <h5 class="card-title">Pending Tickets</h5>
                                </div>
                                <div class="card-body">
                                    <table class="table table-hover my-0">
                                        <thead>
                                            <tr>
                                                <th>Ticket Name</th>
                                                <th class="d-none d-xl-table-cell">Ticket Id</th>
                                                <th>Severity</th>
                                                <th class="d-none d-md-table-cell">Remarks </th>
                                                <th class="d-none d-md-table-cell">Assigned By</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (TicketsModel ticket : toShow) { %>
                                                <tr>
                                                    <td><%= ticket.getTicketName() %></td>
                                                    <td class="d-none d-xl-table-cell"><%= ticket.getId() %></td>
                                                    <td><span class="badge bg-danger"><%= ticket.getSeverity() %></span></td>
                                                    <td class="d-none d-md-table-cell"><%= ticket.getRemark() %></td>
                                                    <td class="d-none d-md-table-cell"><%= ticket.getCreatedBy() %></td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
                <!-- <form action="createTicketForm" method="get">
        <button type="submit" class="generate-ticket-btn">Generate New Ticket</button>
    </form> -->
            </main>
            <jsp:include page="footer.jsp"></jsp:include>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script src="./assets/js/app.js"></script>
    <script src="./assets/js/dashboard.js"></script>
    <script>
    $(document).ready(function() {
        // Set the value of the dropdown to 'global'
      //  $('#plant').val('global');

        // Trigger the change event manually
      //  $('#plant').trigger('change');
    });
    
   
    
		document.addEventListener("DOMContentLoaded", function() {
			// Pie chart
			new Chart(document.getElementById("chartjs-dashboard-pie"), {
				type: "pie",
				data: {
					labels: ["Plant1", "Plant2", "Plant3"],
					datasets: [{
						data: [4306, 3801, 1689],
						backgroundColor: [
							window.theme.primary,
							window.theme.warning,
							window.theme.danger
						],
						borderWidth: 5
					}]
				},
				options: {
					responsive: !window.MSInputMethodContext,
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					cutoutPercentage: 75
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// Bar chart
			new Chart(document.getElementById("chartjs-dashboard-bar"), {
				type: "bar",
				data: {
					labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
					datasets: [{
						label: "This year",
						backgroundColor: window.theme.primary,
						borderColor: window.theme.primary,
						hoverBackgroundColor: window.theme.primary,
						hoverBorderColor: window.theme.primary,
						data: [54, 67, 41, 55, 62, 45, 55, 73, 60, 76, 48, 79],
						barPercentage: .75,
						categoryPercentage: .5
					}]
				},
				options: {
					maintainAspectRatio: false,
					legend: {
						display: false
					},
					scales: {
						yAxes: [{
							gridLines: {
								display: false
							},
							stacked: false,
							ticks: {
								stepSize: 20
							}
						}],
						xAxes: [{
							stacked: false,
							gridLines: {
								color: "transparent"
							}
						}]
					}
				}
			});
		});
	 
		document.addEventListener("DOMContentLoaded", function() {
			var markers = [{
					coords: [31.230391, 121.473701],
					name: "Shanghai"
				},
				{
					coords: [28.704060, 77.102493],
					name: "Delhi"
				},
				{
					coords: [6.524379, 3.379206],
					name: "Lagos"
				},
				{
					coords: [35.689487, 139.691711],
					name: "Tokyo"
				},
				{
					coords: [23.129110, 113.264381],
					name: "Guangzhou"
				},
				{
					coords: [40.7127837, -74.0059413],
					name: "New York"
				},
				{
					coords: [34.052235, -118.243683],
					name: "Los Angeles"
				},
				{
					coords: [41.878113, -87.629799],
					name: "Chicago"
				},
				{
					coords: [51.507351, -0.127758],
					name: "London"
				},
				{
					coords: [40.416775, -3.703790],
					name: "Madrid "
				}
			];
			var map = new jsVectorMap({
				map: "world",
				selector: "#world_map",
				zoomButtons: true,
				markers: markers,
				markerStyle: {
					initial: {
						r: 9,
						strokeWidth: 7,
						stokeOpacity: .4,
						fill: window.theme.primary
					},
					hover: {
						fill: window.theme.primary,
						stroke: window.theme.primary
					}
				},
				zoomOnScroll: false
			});
			window.addEventListener("resize", () => {
				map.updateSize();
			});
		});
	 
		document.addEventListener("DOMContentLoaded", function() {
			var date = new Date(Date.now() - 5 * 24 * 60 * 60 * 1000);
			var defaultDate = date.getUTCFullYear() + "-" + (date.getUTCMonth() + 1) + "-" + date.getUTCDate();
			document.getElementById("datetimepicker-dashboard").flatpickr({
				inline: true,
				prevArrow: "<span title=\"Previous month\">&laquo;</span>",
				nextArrow: "<span title=\"Next month\">&raquo;</span>",
				defaultDate: defaultDate
			});
		});
		
	</script>
</body>
</html>
