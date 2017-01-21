package com.ym.ssh.beans;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Order {
	private int orderId;
	private int userId;
	private String orderTime;
	private double allSum;
	private String status;
	public Order(){}
	
	public Order(int userId, double allSum){
		Date date = new Date();
		DateFormat formate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = formate.format(date);
		this.userId = userId;
		this.orderTime = time;
		this.allSum = allSum;
		this.status = "0";
	}
	
	public double getAllSum() {
		return allSum;
	}
	public void setAllSum(double allSum) {
		this.allSum = allSum;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
