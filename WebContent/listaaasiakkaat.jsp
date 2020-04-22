<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="main.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<table id="asiakasTaulu">
		<thead>
			<tr class="hakurivi">
				<th class="oikealle">Haku:</th>
				<th colspan="3"><input type="text" id="hakusana"></th>
				<th><input class="nappula" type="button" value="Hae" id="hakunappi" /></th>
			</tr>
			<tr class="otsikkorivi">
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
			haeAsiakkaat();
			$("#hakunappi").click(function() {
				haeAsiakkaat();
			});
			$(document.body).on("keydown", function(event) {
				if (event.which == 13) {
					haeAsiakkaat();
				}
			});
		});

		function haeAsiakkaat() {
			$("#asiakasTaulu tbody").empty();
			$("#hakusana").focus();
			$.ajax({
				url : "asiakkaat/" + $("#hakusana").val(),
				type : "GET",
				dataType : "json",
				success : function(result) {
					$.each(result.asiakkaat, function(i, field) {
						var htmlStr;
						htmlStr += "<tr>";
						htmlStr += "<td class='keskelle'>" + field.asiakas_id
								+ "</td>";
						htmlStr += "<td>" + field.etunimi + "</td>";
						htmlStr += "<td>" + field.sukunimi + "</td>";
						htmlStr += "<td>" + field.puhelin + "</td>";
						htmlStr += "<td>" + field.sposti + "</td></tr>";
						$("#asiakasTaulu tbody").append(htmlStr);
					});
				}
			});
		};
	</script>
</body>
</html>

