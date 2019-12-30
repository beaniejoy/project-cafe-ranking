package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.ShopRatingDto;
import dto.TotalRateDto;
import util.ConnLocator;

public class ShopRatingDao {
	private static ShopRatingDao single;

	private ShopRatingDao() {

	}

	public static ShopRatingDao getInstance() {
		if (single == null) {
			single = new ShopRatingDao();
		}
		return single;
	}
	
	public boolean isShopName(String shopName) {
		boolean isThere = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(id)");
			sql.append("FROM ");
			sql.append(shopName);
			
			pstmt = con.prepareStatement(sql.toString());
	
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
	
	public boolean create(String shopName) {
		boolean isSuccess = false;

		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("CREATE TABLE ");
			sql.append(shopName + "( ");
			sql.append("	id VARCHAR(20) NOT NULL, ");
			sql.append("	mood DOUBLE NOT NULL, ");
			sql.append("	light DOUBLE NOT NULL, ");
			sql.append("	price DOUBLE NOT NULL, ");
			sql.append("	taste DOUBLE NOT NULL, ");
			sql.append("	comm VARCHAR(300) NOT NULL, ");
			sql.append("	PRIMARY KEY (id) ");
			sql.append(") ");
			sql.append("COLLATE='utf8_general_ci' ");

			pstmt = con.prepareStatement(sql.toString());

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
	
	public ShopRatingDto select(String shopName, String id) {
		ShopRatingDto dto = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT id, mood, light, price, taste, comm ");
			sql.append("FROM ");
			sql.append(shopName);
			sql.append(" WHERE id = ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			pstmt.setString(++index, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				index = 0;
				id = rs.getString(++index);
				Double mood = rs.getDouble(++index);
				Double light = rs.getDouble(++index);
				Double price = rs.getDouble(++index);
				Double taste = rs.getDouble(++index);
				String comm = rs.getString(++index);
				
				dto = new ShopRatingDto(id, mood, light, price, taste, comm);
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
	
	public ArrayList<ShopRatingDto> select(String shopName){
		ArrayList<ShopRatingDto> list = new ArrayList<ShopRatingDto>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT id, mood, light, price, taste, comm ");
			sql.append("FROM ");
			sql.append(shopName);
			
			
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				index = 0;
				String id = rs.getString(++index);
				double mood = rs.getDouble(++index);
				double light = rs.getDouble(++index);
				double price = rs.getDouble(++index);
				double taste = rs.getDouble(++index);
				String comm = rs.getString(++index);
				list.add(new ShopRatingDto(id, mood, light, price, taste, comm));
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
		
		return list;
		
	}
	
	public boolean insert(ShopRatingDto dto, String shopName) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO ");
			sql.append(shopName);
			sql.append("(id, mood, light, price, taste, comm) ");
			sql.append("VALUES (?, ?, ?, ?, ?, ?) ");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, dto.getId());
			pstmt.setDouble(++index, dto.getMood());
			pstmt.setDouble(++index, dto.getLight());
			pstmt.setDouble(++index, dto.getPrice());
			pstmt.setDouble(++index, dto.getTaste());
			pstmt.setString(++index, dto.getComm());
			
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
	
	public boolean update(ShopRatingDto dto, String shopName, String id) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE  ");
			sql.append(shopName);
			sql.append(" SET mood = ?, light = ?, price = ?, taste = ?, comm = ? ");
			sql.append("WHERE id = ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setDouble(++index, dto.getMood());
			pstmt.setDouble(++index, dto.getLight());
			pstmt.setDouble(++index, dto.getPrice());
			pstmt.setDouble(++index, dto.getTaste());
			pstmt.setString(++index, dto.getComm());
			pstmt.setString(++index, id);
			
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
	
	public TotalRateDto average(String shopName) {
		TotalRateDto dto = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT AVG(mood), AVG(light), AVG(price), AVG(taste) ");
			sql.append("FROM ");
			sql.append(shopName);
			
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
		
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				index = 0;
				double mood = rs.getDouble(++index);
				double light = rs.getDouble(++index);
				double price = rs.getDouble(++index);
				double taste = rs.getDouble(++index);
				
				dto = new TotalRateDto(shopName, mood, light, price, taste, null);
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
	
	public boolean isAlreadyRated(String shopName, String id) {
		boolean isSuccess = false;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT id ");
			sql.append("FROM ");
			sql.append(shopName);
			sql.append(" WHERE id = ? ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, id);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				isSuccess = true;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
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

		return isSuccess;
	}
}
