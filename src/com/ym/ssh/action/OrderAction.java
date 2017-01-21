package com.ym.ssh.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.ym.ssh.beans.User;
import com.ym.ssh.common.ResultJson;
import com.ym.ssh.beans.Cart;
import com.ym.ssh.beans.Goods;
import com.ym.ssh.beans.Order;
import com.ym.ssh.beans.OrderDetails;
import com.ym.ssh.service.OrderDetailsManager;
import com.ym.ssh.service.OrderManager;
import com.ym.ssh.service.GoodsManager;
import com.ym.ssh.service.CartManager;

public class OrderAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	
	private String goodsId;
	private String goodsNum;
	private String allSum;
	private String orderId;
	
	private OrderManager orderManager;
	private GoodsManager goodsManager;
	private CartManager cartManager;
	private OrderDetailsManager orderDetailsManager;
	
	public CartManager getCartManager() {
		return cartManager;
	}
	public void setCartManager(CartManager cartManager) {
		this.cartManager = cartManager;
	}
	public GoodsManager getGoodsManager() {
		return goodsManager;
	}
	public void setGoodsManager(GoodsManager goodsManager) {
		this.goodsManager = goodsManager;
	}
	public String getGoodsNum() {
		return goodsNum;
	}
	public void setGoodsNum(String goodsNum) {
		this.goodsNum = goodsNum;
	}
	public OrderDetailsManager getOrderDetailsManager() {
		return orderDetailsManager;
	}
	public void setOrderDetailsManager(OrderDetailsManager orderDetailsManager) {
		this.orderDetailsManager = orderDetailsManager;
	}
	public String getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	public OrderManager getOrderManager() {
		return orderManager;
	}
	public void setOrderManager(OrderManager orderManager) {
		this.orderManager = orderManager;
	}
	public String getAllSum() {
		return allSum;
	}
	public void setAllSum(String allSum) {
		this.allSum = allSum;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	public String addNow() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<OrderDetails> detailslist = new ArrayList<OrderDetails>();
		User user = (User) session.getAttribute("user");
		if(user!=null){
			
			int userId = user.getUserId();
			int goods_id = Integer.parseInt(goodsId);
			int goods_num = Integer.parseInt(goodsNum);
			
			Order order = new Order(userId, Double.parseDouble(allSum));
			Order insertOrder = orderManager.addOrder(order);
			
			detailslist.add(new OrderDetails(insertOrder.getOrderId(), goods_id, goods_num));
			orderDetailsManager.addOrderDetails(detailslist);
			map.put("status","success");
		}else{
			map.put("status","error");
			map.put("msg","购买失败，请先登录");
		}
		
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
	
	public String balanceCart() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		
		User user = (User) session.getAttribute("user");
		if(user!=null) {
			
			int userId = user.getUserId();
			Order order = new Order(userId, Double.parseDouble(allSum));
			Order insertOrder = orderManager.addOrder(order);
			
			List<Cart> carts = cartManager.getUserCart(userId);		
			
			Iterator<Cart> it = carts.iterator();
			List<OrderDetails> detailslist = new ArrayList<OrderDetails>();
			
			while(it.hasNext()) {
				Cart cart = it.next();
				
				int goods_id = cart.getGoodsId();
				int goods_num = cart.getGoodsNum();
				int cart_id = cart.getCartId();
				cartManager.deleteUserCart(cart_id);
				
		    	detailslist.add(new OrderDetails(insertOrder.getOrderId(), goods_id, goods_num));
			}
			
			orderDetailsManager.addOrderDetails(detailslist);
			session.removeAttribute("cart");
			session.removeAttribute("num");
			map.put("status","success");
			
		}else{
			map.put("status","error");
			map.put("msg","购买失败，请先登录");
		}
		
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String getUserOrder() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		
		User user = (User) session.getAttribute("user");
		if(user!=null) {
			
			int userId = user.getUserId();
			List<Order> orders = orderManager.getUserOrder(userId);
			if(orders!=null){
				map.put("status","success");
				map.put("data", orders);
			}else{
				map.put("status","error");
				map.put("msg","你还没有任何订单");
			}
			
		}else{
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
	
	public String getUserDetails() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		
		User user = (User) session.getAttribute("user");
		if(user!=null) {
			
			List<OrderDetails> detailslist = orderDetailsManager.getOrderDetails(Integer.parseInt(orderId));
			List<Goods> goodslist = new ArrayList<Goods>();
			if(detailslist!=null){
				Iterator<OrderDetails> it = detailslist.iterator();
				while(it.hasNext()) {
					OrderDetails details = it.next();
					int goods_id = details.getGoodsId();
					goodslist.add(goodsManager.getById(String.valueOf(goods_id)));
				}
				
				map.put("status","success");
				map.put("detailslist", detailslist);
				map.put("goodslist", goodslist);
			}else{
				map.put("status","error");
				map.put("msg","查找不到订单详情");
			}
		}else{
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
	
	public String getAllOrder() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(session.getAttribute("admin")!=null){
			List<Order> orders = orderManager.getAllOrder();
			
			map.put("status","success");
			map.put("data",orders);
		}else{
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
	
	public String reciveOrder() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		
		User user = (User) session.getAttribute("user");
		if(user!=null) {
			orderManager.setOrderStatus(Integer.parseInt(orderId), "3");
			map.put("status","success");
			map.put("msg","确认收货成功");
		}else{
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
	
	public String getOrderDetails() {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(session.getAttribute("admin")!=null) {
			
			List<OrderDetails> detailslist = orderDetailsManager.getOrderDetails(Integer.parseInt(orderId));
			List<Goods> goodslist = new ArrayList<Goods>();
			if(detailslist!=null){
				Iterator<OrderDetails> it = detailslist.iterator();
				while(it.hasNext()) {
					OrderDetails details = it.next();
					int goods_id = details.getGoodsId();
					goodslist.add(goodsManager.getById(String.valueOf(goods_id)));
				}
				
				map.put("status","success");
				map.put("detailslist", detailslist);
				map.put("goodslist", goodslist);
			}else{
				map.put("status","error");
				map.put("msg","查找不到订单详情");
			}
		}else{
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
