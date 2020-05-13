package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import model.Asiakas;
import model.dao.Dao;

@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Asiakkaat() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		String hakusana = "";
		if (pathInfo != null) {
			hakusana = pathInfo.replace("/", "");
		}
		Dao dao = new Dao();
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki(hakusana);
		String strJSON = "";
		if (pathInfo == null) {
			asiakkaat = dao.listaaKaikki();
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		} else if (pathInfo.indexOf("haeyksi") != -1) {
			String asiakas_id = pathInfo.replace("/haeyksi/", "");
			Asiakas asiakas = dao.etsiAsiakas(asiakas_id);
			if (asiakas == null) {
				strJSON = "{}";
			} else {
				JSONObject JSON = new JSONObject();
				JSON.put("asiakas_id", asiakas.getAsiakas_id());
				JSON.put("etunimi", asiakas.getEtunimi());
				JSON.put("sukunimi", asiakas.getSukunimi());
				JSON.put("puhelin", asiakas.getPuhelin());
				JSON.put("sposti", asiakas.getSposti());
				strJSON = JSON.toString();
			}
		} else {
			hakusana = pathInfo.replace("/", "");
			asiakkaat = dao.listaaKaikki(hakusana);
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		}
		response.setContentType("application/json;charset=ISO-8859-1");
		PrintWriter out = response.getWriter();
		out.println(strJSON);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json;charset=ISO-8859-1");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if (dao.lisaaasiakas(asiakas)) {
			out.println("{\"response\":1}");
		} else {
			out.println("{\"response\":0}");
		}

	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		Dao dao = new Dao();
		int asiakas_id = Integer.parseInt(jsonObj.getString("asiakas_id"));
		Asiakas asiakas = dao.etsiAsiakas(jsonObj.getString("asiakas_id"));
		asiakas.setAsiakas_id(asiakas_id);
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json;charset=ISO-8859-1");
		PrintWriter out = response.getWriter();
		if (dao.muutaAsiakas(asiakas, asiakas_id)) {
			out.println("{\"response\":1}");
		} else {
			out.println("{\"response\":0}");
		}
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		String poistettavaAsiakasStr = "";
		PrintWriter out = response.getWriter();
		if (pathInfo != null) {
			poistettavaAsiakasStr = pathInfo.replace("/", "");

		}
		int poistettavaAsiakasID = Integer.parseInt(poistettavaAsiakasStr);
		Dao dao = new Dao();
		if (dao.poistaAsiakas(poistettavaAsiakasID)) {
			out.println("{\"response\" : 1}");
		} else {
			out.println("{\"response\" : 0}");
		}
	}
}
