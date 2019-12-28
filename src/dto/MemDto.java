package dto;

public class MemDto {
	private String id;
	private String password;
	private String phone;
	private String location;

	public MemDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemDto(String id, String password, String phone, String location) {
		super();
		this.id = id;
		this.password = password;
		this.phone = phone;
		this.location = location;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

}
