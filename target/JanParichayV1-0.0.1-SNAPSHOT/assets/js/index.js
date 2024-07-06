var baseURL = "http://localhost:8081/BookStoreRestHibernate/"

function checkCredientials() {
	alert("checkCredientials");
	var userName = $("#username").val();
	var password = $("#password").val();
	if (userName == "") {
		alert("Username can't be empty");
		location.href = baseURL;
		return;
	}
	if (password == "") {
		alert("Password can't be empty");
		location.href = baseURL;
		return;
	}

	var url = baseURL + "api/login/check/credientials";
	alert(url);

	$.ajax({
		url : url,
		type : "POST",
		data : {
			userName : userName,
			password : password,
		},
		
		success : function(result, status, xhr) {
			result = JSON.parse(result);
			alert("Result: " + result);
			return;
		}
	});
}