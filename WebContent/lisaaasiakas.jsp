<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="main.css" />
<title>Lisää asiakastiedot</title>
</head>
<body onkeydown="tutkiKey(event)">
	<form id="tiedot">
		<table>
			<thead>
				<tr>
					<th colspan="4" id="ilmo"></th>
					<th colspan="3" class="oikealle"><a href="listaaasiakkaat.jsp"
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
					<td><input type="button" id="nappi" value="Lisää"
						onclick="lisaaTiedot()" /></td>
				</tr>
			</tbody>
		</table>
	</form>
	<span>* = pakollinen tieto</span>
	<br />
	<span id="ilmo"></span>
</body>
<script>
	document.getElementById("etunimi").focus();
	const tutkiKey = event => { if (event.keyCode == 13) { lisaaTiedot() } }

	const lisaaTiedot = () => {
		var ilmo = "";
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
		      method: 'POST',
		      body:formJsonStr
		    })
		.then(function (response) {		
			return response.json()
		})
		.then(function (responseJson) {
			let vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Asiakkaan lisääminen epäonnistui.";
	      	}else if(vastaus==1){	        	
	      		document.getElementById("ilmo").innerHTML= "Asiakkaan lisääminen onnistui.";			      	
			}
			setTimeout(() => {
				document.getElementById("ilmo").innerHTML = "";
			}, 5000);
		});	
		document.getElementById("tiedot").reset();
		document.getElementById("etunimi").focus();
	}
	
</script>
</html>