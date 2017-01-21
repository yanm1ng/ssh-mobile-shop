package com.ym.ssh.beans;

public class Goods {
	private int goodsId;
	private String name;
	private String brand;
	private double price;
	private int sale; //销量
	private int stock; //库存
	private String image; //图片链接
	private String description;

	public Goods(){}
	
	public Goods(String name, String brand, double price, int sale, int stock, String image, String description) {
		this.name = name;
		this.brand = brand;
		this.price = price;
		this.sale = sale;
		this.stock = stock;
		this.image = image;
		this.description = description;
	}

	public int getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getSale() {
		return sale;
	}

	public void setSale(int sale) {
		this.sale = sale;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
}
