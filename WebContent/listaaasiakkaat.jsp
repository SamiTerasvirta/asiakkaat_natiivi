<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listaa asiakastiedot</title>
<link rel="stylesheet" type="text/css" href="main.css" />
<link rel="shortcut icon" href="#">
<!-- http://www.webweaver.nu/html-tips/favicon.shtml  -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<table id="asiakasTaulu">
		<thead>
			<tr>
				<th colspan="6" class="hakurivi"><span id="uusiAsiakas">Lisää
						asiakas</span>
			</tr>
			<tr class="hakurivi">
				<th style="color: black">Haku:</th>
				<th colspan="4" style="text-align: left"><input type="text"
					id="hakusana" size="50"></th>
				<th style="text-align: left"><input class="nappula"
					type="button" value="Hae" id="hakunappi" /></th>
			</tr>
			<tr class="otsikkorivi">
				<th>Asiakas ID</th>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<script>
		$(document).ready(function() {
			haeAsiakkaat();

			$("#uusiAsiakas").click(function() {
				document.location = "lisaaasiakas.jsp";
			});

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
						htmlStr += "<tr id='rivi_"+field.asiakas_id+"'>";
						htmlStr += "<td>" + field.asiakas_id + "</td>";
						htmlStr += "<td>" + field.etunimi + "</td>";
						htmlStr += "<td>" + field.sukunimi + "</td>";
						htmlStr += "<td>" + field.puhelin + "</td>";
						htmlStr += "<td>" + field.sposti + "</td>";
						htmlStr += "<td><a href='muutaasiakas.jsp?asiakas_id="
								+ field.asiakas_id + "'>Muuta</a>&nbsp;";
						htmlStr += "<span class='poista' onclick=poista('"
								+ field.asiakas_id + "')>Poista</span></td>";
						htmlStr += "</tr>";
						$("#asiakasTaulu tbody").append(htmlStr);
					});
				}
			});
		};

		function poista(asiakas_id) {
			if (confirm("Poista asiakas: " + asiakas_id + "?")) {
				$.ajax({
					url : "asiakkaat/" + asiakas_id,
					type : "DELETE",
					dataType : "json",
					success : function(result) {
						if (result.response == 0) {
							$("ilmo").html("Asiakkaan poisto epäonnistui");
						} else if (result.response == 1) {
							$("#rivi_" + asiakas_id).css("background-color",
									"red");
							alert("Asiakkaan: " + asiakas_id
									+ " poisto onnistui.");
							haeAsiakkaat();
						}
					}
				});
			}
		}
	</script>
</body>
</html>

