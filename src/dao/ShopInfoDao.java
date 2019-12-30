package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.ShopInfoDto;
import util.ConnLocator;

public class ShopInfoDao {
	private static ShopInfoDao single;

	private ShopInfoDao() {

	}

	public static ShopInfoDao getInstance() {
		if (single == null) {
			single = new ShopInfoDao();
		}
		return single;
	}
	
	public int getTotalRows(){
		int rows = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(sname) FROM shopinfo ");
			
			pstmt = con.prepareStatement(sql.toString());			
			rs = pstmt.executeQuery();
	
			int index = 0;
			while (rs.next()) {
				rows = rs.getInt(++index);
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
		
		return rows;
	}
	
	public int getTotalRows(String nameKeyword){
		int rows = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(sname) FROM shopinfo ");
			sql.append("WHERE sname REGEXP '[");
			sql.append(nameKeyword);
			sql.append("]' ");
			
			pstmt = con.prepareStatement(sql.toString());		
			rs = pstmt.executeQuery();
	
			int index = 0;			
			while (rs.next()) {
				rows = rs.getInt(++index);
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
		
		return rows;
	}
	
	// search에서 keyword만 가지고 관련 검색어 전부 출력해야함(ex '스타벅스 을지로점' <= '스벅'으로도 검색 가능하게)
	public ArrayList<ShopInfoDto> search(int start, int len, String nameKeyword){
		ArrayList<ShopInfoDto> list = new ArrayList<ShopInfoDto>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT sname, opertime, loc, phone, menu, thumb ");
			sql.append("FROM shopinfo ");
			sql.append("WHERE sname REGEXP '[");
			sql.append(nameKeyword);
			sql.append("]' ");
			sql.append("ORDER BY sname ");
			sql.append("LIMIT ?, ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			pstmt.setInt(++index, start);
			pstmt.setInt(++index, len);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				index = 0;
				String sname = rs.getString(++index);
				String opertime = rs.getString(++index);
				String loc = rs.getString(++index);
				String phone = rs.getString(++index);
				String menu = rs.getString(++index);
				String thumb = rs.getString(++index);
				
				list.add(new ShopInfoDto(sname, opertime, loc, phone, menu, thumb));
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
	
	public ArrayList<ShopInfoDto> search(int start, int len){
		ArrayList<ShopInfoDto> list = new ArrayList<ShopInfoDto>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT sname, opertime, loc, phone, menu, thumb ");
			sql.append("FROM shopinfo ");
			sql.append("ORDER BY sname ");
			sql.append("LIMIT ?, ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			pstmt.setInt(++index, start);
			pstmt.setInt(++index, len);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				index = 0;
				String sname = rs.getString(++index);
				String opertime = rs.getString(++index);
				String loc = rs.getString(++index);
				String phone = rs.getString(++index);
				String menu = rs.getString(++index);
				String thumb = rs.getString(++index);
				
				list.add(new ShopInfoDto(sname, opertime, loc, phone, menu, thumb));
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
	
	public ShopInfoDto select(String shopName) {
		ShopInfoDto dto = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT sname, opertime, loc, phone, menu, thumb ");
			sql.append("FROM shopinfo ");
			sql.append("WHERE sname = ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			
			int index = 0;
			pstmt.setString(++index, shopName);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				index = 0;
				String sname = rs.getString(++index);
				String opertime = rs.getString(++index);
				String loc = rs.getString(++index);
				String phone = rs.getString(++index);
				String menu = rs.getString(++index);
				String imgurl = rs.getString(++index);
				
				dto = new ShopInfoDto(sname, opertime, loc, phone, menu, imgurl);
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
