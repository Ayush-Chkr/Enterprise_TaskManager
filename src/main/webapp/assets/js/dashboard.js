/**
 *  Dashbaoard js
 */

var plant1Data ;
var plant2Data ;
var plant3Data ;

$(document).ready(function() {

	var selectedPlant = $("#plant").val();

	fetchChartData();

	var dataset;
	fetchTicketCount(selectedPlant);


	$('#plant').change(function() {
		debugger;

		selectedPlant = $("#plant").val();
		console.log('Selected Plant:', selectedPlant); // For testing in console
		// Perform actions based on selected plant value

		fetchTicketCount(selectedPlant);

		if (selectedPlant === "Plant 1") {

			plotChart(plant1Data, null, null);

		}
		else if (selectedPlant === "Plant 2") {

			plotChart(null, plant2Data, null);
		}
		else if (selectedPlant === "Plant 3") {

			plotChart(null, null, plant3Data);
		}
		else if (selectedPlant === "global") {

			fetchChartData();
		}


	})
});



function fetchTicketCount(selectedPlant) {

	//Fetch Ticket COunt
	$.ajax({
		url: 'fetchTicketCounts',
		type: 'GET',
		data: {
			plantName: selectedPlant // Replace with the actual plant name parameter
		},
		dataType: 'json',
		success: function(response) {
			console.log(response);

			// Handle the ticket counts
			var highSeverityCount = response.highSeverityCount;
			var mediumSeverityCount = response.mediumSeverityCount;
			var lowSeverityCount = response.lowSeverityCount;
			var completedCount = response.completedCount;
			var totalTicketsCount = response.totalTicketsCount;
			var pendingTicketsCount = response.pendingTicketsCount;
			console.log(totalTicketsCount);

			// Update the UI with the ticket counts
			$('#highSeverityCount').text(highSeverityCount);
			$('#mediumSeverityCount').text(mediumSeverityCount);
			$('#lowSeverityCount').text(lowSeverityCount);
			$('#completedCount').text(completedCount);
			$('#totalTicketsCount').text(totalTicketsCount);
			$('#pendingTicketsCount').text(pendingTicketsCount);
		},
		error: function(xhr, status, error) {
			alert('Error: ' + status + ' - ' + error);
			console.error('Error:', status, error);
		}
	});
}

function fetchChartData() {

	$.ajax({
		url: 'fetchChartData',
		type: 'GET',
		dataType: 'json',
		success: function(response) {
			dataset = response;
			alert(response["Plant 1"])
			plant1Data = response["Plant 1"];
			plant2Data = response["Plant 2"];
			plant3Data = response["Plant 3"];
			plotChart(plant1Data, plant2Data, plant3Data);

		},
		error: function(xhr, status, error) {
			alert('Error: ' + status + ' - ' + error);
			console.error('Error:', status, error);
		}
	});
}

// Line chart
var chartInstance; // Store the chart instance
function plotChart(plant1Data, plant2Data, plant3Data) {

	debugger;

	if (chartInstance) {
		chartInstance.destroy();
	}

	chartInstance = new Chart(document.getElementById("chartjs-line"), {
		type: "line",
		data: {
			labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
			datasets: [{
				label: "Plant 1",
				fill: true,
				backgroundColor: "transparent",
				borderColor: window.theme.success,
				data: plant1Data
			}, {
				label: "Plant 2",
				fill: true,
				backgroundColor: "transparent",
				borderColor: window.theme.danger,
				borderDash: [4, 0],
				data: plant2Data
			}, {
				label: "Plant 3",
				fill: true,
				backgroundColor: "transparent",
				borderColor: window.theme.primary,
				borderDash: [4, 0],
				data: plant3Data
			}]
		},
		options: {
			maintainAspectRatio: false,
			legend: {
				display: false
			},
			tooltips: {
				intersect: false
			},
			hover: {
				intersect: true
			},
			plugins: {
				filler: {
					propagate: false
				}
			},
			scales: {
				xAxes: [{
					reverse: true,
					gridLines: {
						color: "rgba(0,0,0,0.05)"
					}
				}],
				yAxes: [{
					ticks: {
						stepSize: 500
					},
					display: true,
					borderDash: [5, 5],
					gridLines: {
						color: "rgba(0,0,0,0)",
						fontColor: "#fff"
					}
				}]
			}
		}
	});
}

