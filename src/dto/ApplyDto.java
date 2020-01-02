package dto;

public class ApplyDto {
	
	private int no;
	private String id;
	private String cmm;
	private int thmup;
	
	public ApplyDto() {
		super();
	}


	public ApplyDto(int no, String id, String cmm, int thmup) {
		super();
		this.no = no;
		this.id = id;
		this.cmm = cmm;
		this.thmup = thmup;
	}


	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getCmm() {
		return cmm;
	}


	public void setCmm(String cmm) {
		this.cmm = cmm;
	}


	public int getThmup() {
		return thmup;
	}


	public void setThmup(int thmup) {
		this.thmup = thmup;
	}
	

}
