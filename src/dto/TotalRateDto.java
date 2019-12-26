package dto;

public class TotalRateDto {
	private String sname;
	private double mood;
	private double light;
	private double price;
	private double taste;
	private String imgurl;

	public TotalRateDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TotalRateDto(String sname, double mood, double light, double price, double taste,
			String imgurl) {
		super();
		this.sname = sname;
		this.mood = mood;
		this.light = light;
		this.price = price;
		this.taste = taste;
		this.imgurl = imgurl;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public double getMood() {
		return mood;
	}

	public void setMood(double mood) {
		this.mood = mood;
	}

	public double getLight() {
		return light;
	}

	public void setLight(double light) {
		this.light = light;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getTaste() {
		return taste;
	}

	public void setTaste(double taste) {
		this.taste = taste;
	}

	public String getImgurl() {
		return imgurl;
	}

	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}

}