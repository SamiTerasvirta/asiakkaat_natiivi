package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Asiakas;

public class Dao {
	private Connection con = null;
	private ResultSet rs = null;
	private PreparedStatement stmtPrep = null;
	private String db = "Myynti.sqlite";
	private String sql;

	private Connection yhdista() {
		Connection con = null;
		String path = System.getProperty("catalina.base");
		path = path.substring(0, path.indexOf(".metadata")).replace("\\", "");
		String url = "jdbc:sqlite:" + path + db;
		System.out.println(url);
		try {

			Class.forName("org.sqlite.JDBC");
			System.out.println("Dao.yhdista() -- after Class.forName");
			con = DriverManager.getConnection(url);
			System.out.println("Dao.yhdista() -- Yhteys avattu");
		} catch (Exception e) {
			System.out.println("Dao.yhdista() -- Yhteyden avaaminen ei onnistunut");
			e.printStackTrace();
		}
		return con;
	}

	/*
	 * private Connection yhdista() { Connection con = null; String path =
	 * System.getProperty("catalina.base"); path = path.substring(0,
	 * path.indexOf(".metadata")).replace("\\", "/"); // Eclipsessa // path +=
	 * "/webapps/"; //Tuotannossa. Laita tietokanta webapps-kansioon String url =
	 * "jdbc:sqlite:" + path + db; try { Class.forName("org.sqlite.JDBC"); con =
	 * DriverManager.getConnection(url); System.out.println("Yhteys avattu."); }
	 * catch (Exception e) { System.out.println("Yhteyden avaus epäonnistui.");
	 * e.printStackTrace(); } return con; }
	 */

	public ArrayList<Asiakas> listaaKaikki() {
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "SELECT * FROM asiakkaat";
		try {
			con = yhdista();
			if (con != null) {
				System.out.println("Dao.listaaKaikki() -- Tietokantaan saatiin yhteys");
				stmtPrep = con.prepareStatement(sql);
				rs = stmtPrep.executeQuery();
				if (rs != null) {
					System.out.println("Dao.listaaKaikki() -- Result Set haki taulun");
					while (rs.next()) {
						Asiakas asiakas = new Asiakas();
						asiakas.setAsiakas_id(rs.getInt(1));
						asiakas.setEtunimi(rs.getString(2));
						asiakas.setSukunimi(rs.getString(3));
						asiakas.setPuhelin(rs.getString(4));
						asiakas.setSposti(rs.getString(5));
						asiakkaat.add(asiakas);
						
					}
				}

			}
			con.close();
		} catch (Exception e) {
			System.out.println("Dao.listaaKaikki() -- Tietokannan lukeminen ei onnistunut");
		}

		return asiakkaat;
	}

	/*
	 * public ArrayList<Asiakas> listaaKaikki() { ArrayList<Asiakas> asiakkaat = new
	 * ArrayList<Asiakas>(); sql = "SELECT * FROM asiakkaat"; try { con = yhdista();
	 * if (con != null) { // jos yhteys onnistui stmtPrep =
	 * con.prepareStatement(sql); rs = stmtPrep.executeQuery(); if (rs != null) { //
	 * jos kysely onnistui // con.close(); while (rs.next()) { Asiakas asiakas = new
	 * Asiakas(); asiakas.setAsiakas_id(rs.getInt(1));
	 * asiakas.setEtunimi(rs.getString(2)); asiakas.setSukunimi(rs.getString(3));
	 * asiakas.setPuhelin(rs.getString(4)); asiakas.setSposti(rs.getString(5));
	 * asiakkaat.add(asiakas); System.out.println(asiakkaat); } } } con.close(); }
	 * catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return asiakkaat; }
	 */

	public Dao() {

	}

}
