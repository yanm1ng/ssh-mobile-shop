package com.ym.ssh.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.ym.ssh.beans.Goods;
import com.ym.ssh.common.ResultJson;
import com.ym.ssh.service.GoodsManager;

public class GoodsAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	
	private String goodsId;
	private String brand;

	private GoodsManager goodsManager;
	
	public GoodsManager getGoodsManager() {
		return goodsManager;
	}

	public void setGoodsManager(GoodsManager goodsManager) {
		this.goodsManager = goodsManager;
	}
	
	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getAll() {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<Goods> goods = goodsManager.getAll();
		map.put("status", "success");
		map.put("data", goods);
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String getById() {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Goods goods = goodsManager.getById(goodsId);
		map.put("status", "success");
		map.put("data", goods);
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String getByBrand() {
		Map<String, Object> map = new HashMap<String, Object>();

		List<Goods> goods = goodsManager.getByBrand(brand);
		map.put("status", "success");
		map.put("data", goods);
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
}
