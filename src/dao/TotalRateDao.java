package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dto.TotalRateDto;
import util.ConnLocator;

public class TotalRateDao {
	private static TotalRateDao single;

	private TotalRateDao() {

	}

	public static TotalRateDao getInstance() {
		if (single == null) {
			single = new TotalRateDao();
		}
		return single;
	}
	
	public boolean isTotalShopName(String shopName) {
		boolean isThere = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT sname ");
			sql.append("FROM totalrate ");
			sql.append("WHERE sname= ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, shopName);
			
			rs = pstmt.executeQuery();			
			if (rs.next()) {
				isThere = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return isThere;
	}
	
	public boolean update(TotalRateDto dto, String shopName) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE totalrate ");
			sql.append("SET mood=?, light=?, price=?, taste=? ");
			sql.append("WHERE sname = ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setDouble(++index, dto.getMood());
			pstmt.setDouble(++index, dto.getLight());
			pstmt.setDouble(++index, dto.getPrice());
			pstmt.setDouble(++index, dto.getTaste());
			pstmt.setString(++index, shopName);
			
			pstmt.executeUpdate();
			
			isSuccess = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return isSuccess;
		
	}
	
	public boolean insert(TotalRateDto dto, String shopName) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO totalrate(sname, mood, light, price, taste) ");
			sql.append("VALUES (?, ?, ?, ?, ?)");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, shopName);
			pstmt.setDouble(++index, dto.getMood());
			pstmt.setDouble(++index, dto.getLight());
			pstmt.setDouble(++index, dto.getPrice());
			pstmt.setDouble(++index, dto.getTaste());
			
			pstmt.executeUpdate();
			
			isSuccess = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return isSuccess;
	}
	
	public String selectJson(int start, int len, String rate) {
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArray = new JSONArray();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT s.sname, mood, light, price, taste, s.thumb ");
			sql.append("FROM totalrate t, shopinfo s ");
			sql.append("WHERE s.sname = t.sname ");
			sql.append("ORDER BY ");
			sql.append(rate);
			sql.append(" DESC ");
			sql.append("LIMIT ?, ? ");

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;
			pstmt.setInt(++index, start);
			pstmt.setInt(++index, len);
			rs = pstmt.executeQuery();

			JSONObject item = null;

			while (rs.next()) {
				index = 0;
				String sname = rs.getString(++index);
				double mood = rs.getDouble(++index);
				double light = rs.getDouble(++index);
				double price = rs.getDouble(++index);
				double taste = rs.getDouble(++index);
				String thumb = rs.getString(++index);

				item = new JSONObject();
				item.put("sname", sname);
				item.put("mood", mood);
				item.put("light", light);
				item.put("price", price);
				item.put("taste", taste);
				item.put("thumb", thumb);
				jsonArray.add(item);
			}
			jsonObj.put("items", jsonArray);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return jsonObj.toString();
	}
	
	public TotalRateDto select(String shopName) {
		TotalRateDto dto = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT sname, mood, light, price, taste ");
			sql.append("FROM totalrate ");
			sql.append("WHERE sname = ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			pstmt.setString(++index, shopName);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				index = 0;
				String sname = rs.getString(++index);
				double mood = rs.getDouble(++index);
				double light = rs.getDouble(++index);
				double price = rs.getDouble(++index);
				double taste = rs.getDouble(++index);
				
				dto = new TotalRateDto(sname, mood, light, price, taste);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return dto;
	}

	
}
