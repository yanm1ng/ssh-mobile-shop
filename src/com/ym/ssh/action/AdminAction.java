package com.ym.ssh.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.ym.ssh.beans.Goods;
import com.ym.ssh.beans.User;
import com.ym.ssh.common.ResultJson;
import com.ym.ssh.service.UserManager;
import com.ym.ssh.service.GoodsManager;
import com.ym.ssh.service.OrderManager;

public class AdminAction extends ActionSupport{

	private static final long serialVersionUID = 1L;
	
	private UserManager userManager;	
	private GoodsManager goodsManager;
	private OrderManager orderManager;
	private String username;
	private String password;
	private String repassword;
	private String userId;
	private String goodsId;
	private String orderId;

	private String goodsName;
	private String goodsPrice;
	private String goodsBrand;
	private String goodsImage;
	private String goodsStock;
	private String goodsDes;
	private String orderStatus;
	
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(String goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	public String getGoodsImage() {
		return goodsImage;
	}
	public void setGoodsImage(String goodsImage) {
		this.goodsImage = goodsImage;
	}
	public OrderManager getOrderManager() {
		return orderManager;
	}
	public void setOrderManager(OrderManager orderManager) {
		this.orderManager = orderManager;
	}
	public String getGoodsStock() {
		return goodsStock;
	}
	public void setGoodsStock(String goodsStock) {
		this.goodsStock = goodsStock;
	}
	public String getGoodsDes() {
		return goodsDes;
	}
	public void setGoodsDes(String goodsDes) {
		this.goodsDes = goodsDes;
	}
	public String getGoodsId() {
		return goodsId;
	}
	public String getGoodsBrand() {
		return goodsBrand;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public void setGoodsBrand(String goodsBrand) {
		this.goodsBrand = goodsBrand;
	}
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	public GoodsManager getGoodsManager() {
		return goodsManager;
	}
	public void setGoodsManager(GoodsManager goodsManager) {
		this.goodsManager = goodsManager;
	}
	public UserManager getUserManager() {
		return userManager;
	}
	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
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
	public String getRepassword() {
		return repassword;
	}
	public void setRepassword(String repassword) {
		this.repassword = repassword;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String login() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(username.equals("admin") && password.equals("admin")){
			session.setAttribute("admin", "admin");
			map.put("status", "success");
			map.put("msg", "登录成功");
		}else{
			map.put("status", "error");
			map.put("msg", "登录失败");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String logout() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", "success");
		map.put("msg", "登录成功");
		session.removeAttribute("admin");
		
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String getAllUser() {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("admin")!=null) {
			List<User> users = userManager.getAll();
			map.put("status","success");
			map.put("data",users);
		} else {
			map.put("status","error");
			map.put("msg","请先进行登录操作");
		}
		
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String deleteUser() {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("admin")!=null) {
			userManager.delete(Integer.parseInt(userId));
			map.put("status","success");
			map.put("msg","删除成功");
		} else {
			map.put("status","error");
			map.put("msg","请先进行登录操作");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String deleteGoods() {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("admin")!=null) {
			
			goodsManager.deleteById(goodsId);
			
			map.put("status","success");
			map.put("msg","删除成功");
		} else {
			map.put("status","error");
			map.put("msg","请先进行登录操作");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String manageUser() {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("admin")!=null) {
			if(password.equals(repassword)){
				userManager.manage(Integer.parseInt(userId), password);
				map.put("status","success");
				map.put("msg","修改成功");
			}else{
				map.put("status","error");
				map.put("msg","修改失败，密码不一致");
			}
		} else {
			map.put("status","error");
			map.put("msg","请先进行登录操作");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String addGoods() {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("admin")!=null) {
			Goods goods = new Goods(goodsName, goodsBrand, Double.parseDouble(goodsPrice), 0, Integer.parseInt(goodsStock), goodsImage, goodsDes);
			goodsManager.addGoods(goods);
			map.put("status","success");
			map.put("msg","添加成功");
		} else {
			map.put("status","error");
			map.put("msg","请先进行登录操作");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String setOrderStatus() {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("admin")!=null) {
			orderManager.setOrderStatus(Integer.parseInt(orderId), orderStatus);
			map.put("status","success");
			map.put("msg","修改成功");
		} else {
			map.put("status","error");
			map.put("msg","请先进行登录操作");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String updateGoods() {
		Map<String, Object> map = new HashMap<String, Object>();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		if(session.getAttribute("admin")!=null) {
			Goods goods = goodsManager.getById(goodsId);
			if(goods != null){
				if(!goodsStock.equals("")){
					goods.setStock(Integer.parseInt(goodsStock));
				}else if(!goodsPrice.equals("")){
					goods.setPrice(Integer.parseInt(goodsPrice));
				}else if(!goodsDes.equals("")){
					goods.setDescription(goodsDes);
				}
				goodsManager.update(goods);
				map.put("status","success");
				map.put("msg","修改成功");
			}else{
				map.put("status","error");
				map.put("msg","没有该商品");
			}
		} else {
			map.put("status","error");
			map.put("msg","请先进行登录操作");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
}
