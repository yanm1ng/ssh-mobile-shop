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
import com.ym.ssh.beans.Cart;
import com.ym.ssh.beans.Goods;
import com.ym.ssh.beans.User;
import com.ym.ssh.common.ResultJson;
import com.ym.ssh.service.CartManager;
import com.ym.ssh.service.GoodsManager;

public class CartAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	
	private CartManager cartManager;
	private GoodsManager goodsManager;
	private String cartId;
	private String goodsId;
	private String goodsNum;

	public String getCartId() {
		return cartId;
	}
	public void setCartId(String cartId) {
		this.cartId = cartId;
	}
	public String getGoodsNum() {
		return goodsNum;
	}
	public void setGoodsNum(String goodsNum) {
		this.goodsNum = goodsNum;
	}
	public CartManager getCartManager() {
		return cartManager;
	}
	public void setCartManager(CartManager cartManager) {
		this.cartManager = cartManager;
	}
	public String getGoodsId() {
		return goodsId;
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
	
	public String getCartDetail(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("status","error");
			map.put("msg", "请先进行登录操作");
		}else{
			int userId = user.getUserId();
			
			List<Cart> carts = cartManager.getUserCart(userId);
			Iterator<Cart> it = carts.iterator();
			ArrayList<Goods> goodslist = new ArrayList<Goods>();
			
		    while(it.hasNext()){
		    	Cart cart = it.next();
		    	int good_id = cart.getGoodsId();
		    	Goods goods = goodsManager.getById(String.valueOf(good_id));
		    	goodslist.add(goods);
		    }
			map.put("status","success");
			map.put("carts", carts);
			map.put("goodslist", goodslist);
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String addCart(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("status","error");
			map.put("msg", "请先进行登录操作");
		}else{
			int userId = user.getUserId();
			int good_id = Integer.parseInt(goodsId);
			int good_num = Integer.parseInt(goodsNum);
			
			Cart cart = new Cart(userId, good_id, good_num);
			
			cartManager.addUserCart(cart);
			
			List<Cart> carts = cartManager.getUserCart(userId);
			session.setAttribute("cart", carts);
			session.setAttribute("num", carts.size());
			
			map.put("status","success");
			map.put("data", carts.size());
			map.put("msg", "添加成功");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String updateCart(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("status","error");
			map.put("msg", "请先进行登录操作");
		}else{
			int userId = user.getUserId();
			int good_id = Integer.parseInt(goodsId);
			int good_num = Integer.parseInt(goodsNum);
			
			Cart cart = new Cart(userId, good_id, good_num);
			
			cartManager.updateUserCart(cart);
			
			List<Cart> carts = cartManager.getUserCart(userId);
			session.setAttribute("cart", carts);
			session.setAttribute("num", carts.size());
			
			map.put("status","success");
			map.put("data", carts.size());
			map.put("msg", "更新成功");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	
	public String deleteCart(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) session.getAttribute("user");
		if(user == null){
			map.put("status","error");
			map.put("msg", "请先进行登录操作");
		}else{
			int userId = user.getUserId();
			int cart_id = Integer.parseInt(cartId);
						
			cartManager.deleteUserCart(cart_id);
			
			List<Cart> carts = cartManager.getUserCart(userId);
			
			session.setAttribute("cart", carts);
			session.setAttribute("num", carts.size());
			map.put("status","success");
			map.put("data", carts.size());
			map.put("msg", "删除成功");
		}
		try {
			ResultJson.toJson(ServletActionContext.getResponse(), map);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
}
