<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.17.0/jquery.validate.min.js"></script>
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="main.css" />
<title>Lisää asiakastiedot</title>
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
					<td><input type="submit" id="tallenna" value="Lisää" /></td>
				</tr>
			</tbody>
		</table>
	</form>
	<span>* = pakollinen tieto</span>
	<br />
	<span id="ilmo"></span>
</body>
<script>
	$(document).ready(function() {
		$("#takaisin").click(function() {
			document.location = "listaaasiakkaat.jsp";
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
				lisaaTiedot();
			}

		});
	});

	function lisaaTiedot() {
		var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
		$.ajax({
			url : "asiakkaat",
			data : formJsonStr,
			type : "POST",
			dataType : "json",
			success : function(result) {
				if (result.response == 0) {
					$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
				} else if (result.response == 1) {
					$("#ilmo").html("Asiakkaan lisääminen onnistui.");
					$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
				}
			}
		});
	}
</script>
</html>