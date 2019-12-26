package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
