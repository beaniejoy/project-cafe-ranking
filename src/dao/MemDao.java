package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.MemDto;
import util.ConnLocator;

public class MemDao {
	private static MemDao single;

	private MemDao() {

	}

	public static MemDao getInstance() {
		if (single == null) {
			single = new MemDao();
		}
		return single;
	}
	
	public MemDto select(String id) {
		MemDto dto = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT id, phone, loc ");
			sql.append("FROM member ");
			sql.append("WHERE id = ?");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index = 0;
				id = rs.getString(++index);
				String phone = rs.getString(++index);
				String loc = rs.getString(++index);
				dto = new MemDto(id, null,phone,loc);
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
				e.printStackTrace();
			}
		}
		
		return dto;
	}
	
	public MemDto selectByPhone(String phone) {
		MemDto dto = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT id, phone, loc ");
			sql.append("FROM member ");
			sql.append("WHERE phone = ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, phone);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index = 0;
				String id = rs.getString(++index);
				phone = rs.getString(++index);
				String loc = rs.getString(++index);
				dto = new MemDto(id, null,phone,loc);
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
				e.printStackTrace();
			}
		}
		
		return dto;
	}
	
	public boolean insert(MemDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO member(id, pwd, phone, loc) ");
			sql.append("VALUES(?, PASSWORD(?), ?, ?) ");
			
			int index = 0;
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setString(++index,dto.getId());
			pstmt.setString(++index,dto.getPassword());
			pstmt.setString(++index,dto.getPhone());
			pstmt.setString(++index,dto.getLocation());
			
			pstmt.executeUpdate();
			
			isSuccess = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return isSuccess;
		
	}
	
	public MemDto getMember(MemDto dto){
		MemDto mdto = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT id, phone, loc ");
			sql.append("FROM member ");
			sql.append("WHERE id = ? AND pwd = PASSWORD(?) ");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, dto.getId());
			pstmt.setString(++index, dto.getPassword());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index = 0;
				String id = rs.getString(++index);
				String phone = rs.getString(++index);
				String loc = rs.getString(++index);
				mdto = new MemDto(id, null, phone, loc);
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
				e.printStackTrace();
			}
		}
		
		return mdto;
	}
}
