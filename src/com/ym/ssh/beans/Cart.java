package com.ym.ssh.beans;

public class Cart {
	private int cartId;
	private int userId;
	private int goodsId;
	private int goodsNum;
	
	public Cart(){}
	
	public Cart(int userId, int goodsId, int goodsNum){
		this.userId = userId;
		this.goodsId = goodsId;
		this.goodsNum = goodsNum;
	}
	
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public int getGoodsNum() {
		return goodsNum;
	}
	public void setGoodsNum(int goodsNum) {
		this.goodsNum = goodsNum;
	}

}
