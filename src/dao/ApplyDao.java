package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.ApplyDto;
import util.ConnLocator;

public class ApplyDao {

	private static ApplyDao single;

	private ApplyDao() {
	}

	public static ApplyDao getInstance() {
		if (single == null) {
			single = new ApplyDao();
		}
		return single;
	}
	
	public int getTotalRows() {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT count(thmup) ");
			sql.append("FROM apply");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				index = 0;
				count = rs.getInt(++index);
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
		
		return count;
	}
	
	public int getMaxNextNo() {
		int result = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT ifnull(MAX(no) +1,1) FROM apply ");

			pstmt = con.prepareStatement(sql.toString());

			rs = pstmt.executeQuery();
			if (rs.next()) {
				int index = 0;
				result = rs.getInt(++index);
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

		return result;
	}
	
	public  ArrayList<ApplyDto> select(int start, int len) {
		ArrayList<ApplyDto> list = new ArrayList<ApplyDto>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT no, id, cmm, thmup ");
			sql.append("FROM apply ");
			sql.append("order by thmup DESC, no desc ");
			sql.append("LIMIT ?,?");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, start);
			pstmt.setInt(++index, len);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				index = 0;
				int Ano = rs.getInt(++index);
				String id = rs.getString(++index);
				String cmm = rs.getString(++index);
				int thmup = rs.getInt(++index);
				list.add(new ApplyDto(Ano,id,cmm,thmup));
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
		
		return list;
	}
	
	public boolean insert(ApplyDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO apply(no, id, cmm, thmup) ");
			sql.append("VALUES(?,?,?,0)");
			
			int index = 0;
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setInt(++index, dto.getNo());
			pstmt.setString(++index,dto.getId());
			pstmt.setString(++index,dto.getCmm());
			
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
	
	public ApplyDto select (int ano) {
		ApplyDto appdto = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT no, id, cmm, thmup ");
			sql.append("FROM apply ");
			sql.append("where no = ?");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, ano);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index = 0;
				int Ano = rs.getInt(++index);
				String id = rs.getString(++index);
				String cmm = rs.getString(++index);
				int thmup = rs.getInt(++index);
				appdto = new ApplyDto(Ano,id,cmm,thmup);
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
		
		return appdto;
		
	}
	
	public boolean update(int ano) {
		boolean isSuccess = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE apply ");
			sql.append("SET thmup = thmup+1 ");
			sql.append("where no = ?");
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, ano);
			
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
	
	public boolean delete(int ano) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM apply ");
			sql.append("WHERE no = ?");
			
			int index = 0;
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setInt(++index, ano);
			
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
}