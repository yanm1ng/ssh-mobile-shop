package com.ym.ssh.beans;

public class OrderDetails {
	private int orderDetailsId;
	private int orderId;
	private int goodsId;
	private int goodsNum;
	
	public OrderDetails(){}
	
	public OrderDetails(int orderId, int goodsId, int goodsNum){
		this.orderId = orderId;
		this.goodsId = goodsId;
		this.goodsNum = goodsNum;
	}
	
	public int getOrderDetailsId() {
		return orderDetailsId;
	}
	public void setOrderDetailsId(int orderDetailsId) {
		this.orderDetailsId = orderDetailsId;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
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
