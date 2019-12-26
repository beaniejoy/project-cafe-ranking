package dto;

public class ShopInfoDto {
	private String sname;
	private String operTime;
	private String loc;
	private String phone;
	private String menu;
	private String thumb;

	public ShopInfoDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ShopInfoDto(String sname, String operTime, String loc, String phone, String menu,
			String thumb) {
		super();
		this.sname = sname;
		this.operTime = operTime;
		this.loc = loc;
		this.phone = phone;
		this.menu = menu;
		this.thumb = thumb;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public String getOperTime() {
		return operTime;
	}

	public void setOperTime(String operTime) {
		this.operTime = operTime;
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMenu() {
		return menu;
	}

	public void setMenu(String menu) {
		this.menu = menu;
	}

	public String getThumb() {
		return thumb;
	}

	public void setThumb(String thumb) {
		this.thumb = thumb;
	}

}
