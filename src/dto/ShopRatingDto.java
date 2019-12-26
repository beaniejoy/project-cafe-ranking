package dto;

public class ShopRatingDto {
	private String id;
	private double mood;
	private double light;
	private double price;
	private double taste;
	private String comm;

	public ShopRatingDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ShopRatingDto(String id, double mood, double light, double price, double taste,
			String comm) {
		super();
		this.id = id;
		this.mood = mood;
		this.light = light;
		this.price = price;
		this.taste = taste;
		this.comm = comm;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getComm() {
		return comm;
	}

	public void setComm(String comm) {
		this.comm = comm;
	}

}
