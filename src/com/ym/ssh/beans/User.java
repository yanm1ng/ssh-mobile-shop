package com.ym.ssh.beans;

public class User {

	private int userId;
	private String username;
	private String password;
	private String phone;
	private String address;

	public User(){}
	
	public User(String username, String password, String phone, String address){
		this.username = username;
		this.password = password;
		this.phone = phone;
		this.address = address;
	}
	
	public User(String username, String password){
		this.username = username;
		this.password = password;
	}
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
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

}
