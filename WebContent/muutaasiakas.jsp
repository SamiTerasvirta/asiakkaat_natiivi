<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="main.css" />
<link rel="shortcut icon" href="#">

<meta charset="ISO-8859-1">
<title>Muuta asiakkaan tiedot</title>
</head>
<body onkeydown="tutkiKey(event)">
	<form id="tiedot">
		<table>
			<thead>
				<tr>
					<th colspan="4" id="ilmo"></th>
					<th colspan="2" class="oikealle"><a href="listaaasiakkaat.jsp"
						id="takaisin">Takaisin listaukseen</a></th>
				</tr>
				<tr>
					<th>Etunimi</th>
					<th>Sukunimi</th>
					<th>Puhelin</th>
					<th>Sähköposti</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="etunimi" id="etunimi"
						placeholder="Etunimi (*)"></td>
					<td><input type="text" name="sukunimi" id="sukunimi"
						placeholder="Sukunimi (*)"></td>
					<td><input type="text" name="puhelin" id="puhelin"
						placeholder="Puhelinnumero"></td>
					<td><input type="text" name="sposti" id="sposti"
						placeholder="Sähköposti"></td>
					<td><input type="button" id="tallenna" value="Hyväksy"
						onclick="vieTiedot()" /></td>
					<!-- <td><input type="hidden" name="asiakas_id" id="asiakas_id" /></td>  -->
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="asiakas_id" id="asiakas_id" />
	</form>
	<span id="ilmo"></span>
</body>

<script>
	function tutkiKey(event) {
		if (event.keyCode == 13) {
			vieTiedot();
		}
	}
	
	document.getElementById("etunimi").focus();
	
	let asiakas_id = requestURLParam("asiakas_id");
	console.log(asiakas_id);
	fetch("asiakkaat/haeyksi/" + asiakas_id, {
		method : "GET"
	})
	.then(function (response) {
		return response.json()
	})
	.then(function (responseJson) {
		console.log(responseJson);
		document.getElementById("asiakas_id").value = responseJson.asiakas_id;
		document.getElementById("etunimi").value = responseJson.etunimi;
		document.getElementById("sukunimi").value = responseJson.sukunimi;
		document.getElementById("puhelin").value = responseJson.puhelin;
		document.getElementById("sposti").value = responseJson.sposti;
	});
	
	function vieTiedot() {
		let ilmo = "";
		if (document.getElementById("etunimi").value.length < 1) {
			ilmo = "Anna etunimi."
		} else if (document.getElementById("sukunimi").value.length < 1) {
			ilmo = "Anna sukunimi."
		} else if (document.getElementById("puhelin").value.length < 3) {
			ilmo = "Anna kelvollinen puhelinnumero"
		} else if (document.getElementById("sposti").value.length < 6) {
			ilmo = "Anna kelvollinen sähköpostiosoite"
		}
		if (ilmo != "") {
			document.getElementById("ilmo").innerHTML = ilmo;
			setTimeout(() => {
				document.getElementById("ilmo").innerHTML = "";
			}, 5000);
			return;
		}
		document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
		document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
		document.getElementById("puhelin").value=siivoa(document.getElementById("puhelin").value);
		document.getElementById("sposti").value=siivoa(document.getElementById("sposti").value);	
		
		let formJsonStr=formDataToJSON(document.getElementById("tiedot"));
		fetch("asiakkaat",{
		      method: 'PUT',
		      body:formJsonStr
		    })
		.then(function (response) {		
			return response.json()
		})
		.then(function (responseJson) {
			let vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Tietojen päivitys epäonnistui.";
	      	}else if(vastaus==1){	        	
	      		document.getElementById("ilmo").innerHTML= "Tietojen päivitys onnistui.";			      	
			}
			setTimeout(() => {
				document.getElementById("ilmo").innerHTML = "";
			}, 5000);
		});	
		document.getElementById("tiedot").reset();
	}
	
	
</script>

</html>