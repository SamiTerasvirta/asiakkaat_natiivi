<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.17.0/jquery.validate.min.js"></script>
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="main.css" />
<link rel="shortcut icon" href="#">

<meta charset="UTF-8">
<title>Muuta asiakkaan tiedot</title>
</head>
<body>
	<form id="tiedot">
		<table>
			<thead>
				<tr>
					<th colspan="5" class="hakurivi"><span id="takaisin">Takaisin
							listaukseen</span></th>
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
					<td><input type="submit" id="tallenna" value="Hyväksy" /></td>
					<td><input type="hidden" name="asiakas_id" id="asiakas_id" /></td>
				</tr>
			</tbody>
		</table>
	</form>
	<span id="ilmo"></span>

</body>
<script>
	$(document).ready(function() {
		$("#takaisin").click(function() {
			document.location = "listaaasiakkaat.jsp";
		});
		
		var asiakas_id = requestURLParam("asiakas_id");
		
		$.ajax({
			url : "asiakkaat/haeyksi/" + asiakas_id,
			type : "GET",
			dataType : "json",
			success : function(result) {
				$("#asiakas_id").val(result.asiakas_id);
				$("#etunimi").val(result.etunimi);
				$("#sukunimi").val(result.sukunimi);
				$("#puhelin").val(result.puhelin);
				$("#sposti").val(result.sposti);

			}
		});
		
		$("#tiedot").validate({
			rules : {
				etunimi : {
					required : true,
					maxlength : 50
				},
				sukunimi : {
					required : true,
					maxlength : 50
				},
				puhelin : {
					required : false,
					minlength : 5,
					maxlength : 50
				},
				sposti : {
					required : false,
					minlength : 5,
					maxlength : 100
				}
			},
			messages : {
				etunimi : {
					required : "Pakollinen tieto",
					maxlength : "Max 50 merkkiä"
				},
				sukunimi : {
					required : "Pakollinen tieto",
					maxlength : "Max 50 merkkiä"
				},
				puhelin : {
					minlength : "Min 5 merkkiä",
					maxlength : "Max 50 merkkiä"
				},
				sposti : {
					minlength : "Min 5 merkkiä",
					maxlength : "Max 100 merkkiä"
				}
			},
			submitHandler : function(form) {
				paivitaTiedot();
			}

		});
	});

function paivitaTiedot() {
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({
		url : "asiakkaat",
		data : formJsonStr,
		type : "PUT",
		dataType : "json",
		success : function(result) {
			if (result.response == 0) {
				$("#ilmo").html("Asiakkaan päivittäminen epäonnistui.");
			} else if (result.response == 1) {
				$("#ilmo").html("Asiakkaan päivittäminen onnistui.");
				//$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
			}
		}
	});
}
</script>

</html>