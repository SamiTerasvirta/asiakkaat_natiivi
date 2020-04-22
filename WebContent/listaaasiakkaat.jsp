<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="main.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<table id="asiakasTaulu">
		<thead classname="thead">
			<tr>
				<th>Asiakas ID</th>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<script> 
	$(document).ready(function() {
		$.ajax({
			url:"asiakkaat",
			type:"GET", 
			dataType:"json", 
			success:function(result) { 
				$.each(result.asiakkaat, function(i, field) {
					var htmlStr;
					htmlStr += "<tr>";
					htmlStr += "<td>" + field.asiakas_id + "</td>";
					htmlStr += "<td>" + field.etunimi + "</td>";
					htmlStr += "<td>" + field.sukunimi + "</td>";
					htmlStr += "<td>" + field.puhelin + "</td>";
					htmlStr += "<td>" + field.sposti + "</td></tr>";
					$("#asiakasTaulu tbody").append(htmlStr);
				}) 
			} 
		}); 
	}); 
	</script>
</body>
</html>

