<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Listaa asiakastiedot</title>
<link rel="stylesheet" type="text/css" href="main.css" />
<link rel="shortcut icon" href="#">
<!-- http://www.webweaver.nu/html-tips/favicon.shtml  -->
<script src="scripts/main.js"></script>
</head>
<body onkeydown="tutkiKey(event)">
	<table id="listaus">
		<thead>
			<tr>
				<th colspan="5" id ="ilmo"></th>
				<th><a id="uusiAsiakas" href="lisaaasiakas.jsp">Lisää uusi asiakas</a></th>
			</tr>
			<tr>
				<th class="oikealle">Hakusana:</th>
				<th colspan="4"><input type="text" id="hakusana"></th>
				<th><input type="button" value="hae" id="hakunappi" onclick="haeTiedot()"></th>
			</tr>
			<tr>
				<th>Asiakas ID</th>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
	</table>
	<script>
		const tutkiKey = (event) => {
			if (event.keyCode == 13) {
				haeTiedot()
			}
		}
		
		const haeTiedot = () => {
			document.getElementById("tbody").innerHTML = "";
			fetch("asiakkaat/" + document.getElementById("hakusana").value,{
				method : "GET"
			})
			.then(function (response) {
				return response.json()
			})
			.then(function (responseJson) {
				let asiakkaat = responseJson.asiakkaat;
				let htmlStr = "";
				for (var i = 0; i < asiakkaat.length; i++) {
					htmlStr += "<tr>";
					htmlStr += "<td>" + asiakkaat[i].asiakas_id + "</td>";
					htmlStr += "<td>" + asiakkaat[i].etunimi + "</td>";
					htmlStr += "<td>" + asiakkaat[i].sukunimi + "</td>";
					htmlStr += "<td>" + asiakkaat[i].puhelin + "</td>";
					htmlStr += "<td>" + asiakkaat[i].sposti + "</td>";
					htmlStr += "<td><a href='muutaasiakas.jsp?asiakas_id=" + asiakkaat[i].asiakas_id + "'>Muuta</a>&nbsp;";
					htmlStr += "<span class='poista' onclick=poista('" + asiakkaat[i].asiakas_id + "')>Poista</span></td>";
					htmlStr += "</tr>";
				}
				document.getElementById("tbody").innerHTML = htmlStr;
			})
		}
		
		const poista = asiakas_id => {
			if (confirm("Poista asiakas " + asiakas_id + "?")) {
				fetch("asiakkaat/" + asiakas_id, {
					method : 'DELETE'
				})
				.then(function (response) {
					return response.json()
				})
				.then(function (responseJson) {
					let vastaus = responseJson.response;
					if (vastaus == 0) {
						document.getElementById("ilmo").innerHTML = "Asiakkaan poisto epäonnistui.";
					} else if (vastaus == 1) {
						document.getElementById("ilmo").innerHTML = "Asiakkaan " + asiakas_id + " poisto onnistui.";
						haeTiedot();
					}
					setTimeout(() => {
						document.getElementById("ilmo").innerHTML = "";
					}, 5000);
				})
				
			}
		}
		haeTiedot();
		document.getElementById("hakusana").focus();
	</script>
</body>
</html>

