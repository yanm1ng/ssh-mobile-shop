<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mobile Shop</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"  type="text/css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css"  type="text/css">
    <link rel="stylesheet" href="fonts/font-slider.css" type="text/css">
	<script src="js/jquery-2.1.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
</head>
<body>
	<nav id="top">
		<div class="container">
			<div class="row">
				<div class="col-xs-12">
					<ul class="top-link">
						 <s:if test="%{#session.user==null}"> 
						     <li><a href="account.jsp"><span class="glyphicon glyphicon-user"></span> 登录/注册</a></li>
						 </s:if>
						 <s:elseif test="%{#session.user!=null}"> 
						     <li><span class="glyphicon glyphicon-user"></span> 欢迎你, <s:property value="#session.user.username"/><a onclick="logout()" style="cursor: pointer;"> 退出登录</a></li>
						     <li><a href="account.jsp"><span class="glyphicon glyphicon-star"></span> 设置</a></li>
						 </s:elseif>
						 <li><a href="contact.jsp"><span class="glyphicon glyphicon-envelope"></span> 联系我们</a></li>
					</ul>
					<li><a href="order.jsp">我的订单</a></li>
				</div>
			</div>
		</div>
	</nav>
	<header class="container">
		<div class="row">
			<div class="col-md-4">
				<div id="logo"><img src="images/logo.png" /></div>
			</div>
			<div class="col-md-8">
				<s:if test="%{#session.num==null}"> 
					<div id="cart"><a class="btn btn-1" href="cart.jsp" style="padding: 5px 16px;"><span class="glyphicon glyphicon-shopping-cart"></span> 0 ITEM</a></div>
				</s:if>
				<s:elseif test="%{#session.num!=null}">
					<div id="cart"><a class="btn btn-1" href="cart.jsp" style="padding: 5px 16px;"><span class="glyphicon glyphicon-shopping-cart"></span> <span id="cart-num"><s:property value="#session.num"/> ITEM</span></a></div>
				</s:elseif>
			</div>
		</div>
	</header>
   <nav id="menu" class="navbar">
		<div class="container">
			<div class="navbar-header"><span id="heading" class="visible-xs">菜单</span>
			  <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
			</div>
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav">
					<li><a href="index.jsp">首页</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">手机分类</a>
						<div class="dropdown-menu">
							<div class="dropdown-inner">
								<ul class="list-unstyled">
									<li><a href="category.jsp?Apple">苹果</a></li>
									<li><a href="category.jsp?Samsung">三星</a></li>
									<li><a href="category.jsp?Xiaomi">小米</a></li>
									<li><a href="category.jsp?Meizu">魅族</a></li>
									<li><a href="category.jsp?Huawei">华为</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li><a href="order.jsp">我的订单</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div id="page-content" class="single-page">
		<div class="container" id="cart-container">
			<div class="row">
				<div class="col-md-4 col-md-offset-8 ">
					<center><a href="index.jsp" class="btn btn-1">继续购物</a></center>
				</div>
			</div>
			<div class="row">
				<div class="pricedetails">
					<div class="col-md-4 col-md-offset-8">
						<table>
							<h6>价格明细</h6>
							<tr id="pricedetails">
								<td>商品名</td>
								<td>单价</td>
								<td>数量</td>
							</tr>
						</table>
						<input type="hidden" id="all-sum" value="" />
						<center><a class="btn btn-1" onclick="balance()">购买</a></center>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	function priceDetails(carts, goodslist){
		var html = '';
		var sum = 0;
		for(var i=0; i<carts.length; i++){
			var cart = carts[i];
			var goods = goodslist[i];
			html += '<tr>'+
						'<td>'+goods.name+'</td>'+
						'<td>￥'+goods.price+'</td>'+
						'<td>'+cart.goodsNum+'台</td>'+
					'</tr>';
			sum += cart.goodsNum * goods.price;
		}
		html += '<tr style="border-top: 1px solid #333"><td><h5>总价</h5></td><td></td><td>￥'+sum+'</td></tr>';
		$("#all-sum").val(sum);
		return html;
	}
	
	function cartList(cartId, goodsId, name, brand, price, num, image){
		return (
			'<div class="row" id="cart'+cartId+'">'+
				'<div class="product well">'+
					'<div class="col-md-3">'+
						'<div class="image">'+
							'<img src="'+image+'" />'+
						'</div>'+
					'</div>'+
					'<div class="col-md-9">'+
						'<div class="caption">'+
							'<div class="name"><h3><a href="product.jsp?'+goodsId+'">'+name+'</a></h3></div>'+
							'<div class="info">'+
								'<ul>'+
									'<li>品牌: '+brand+'</li>'+
								'</ul>'+
							'</div>'+
							'<div class="price">￥'+price+'</div>'+
							'<label>数量: </label>'+num+'台， <input class="form-inline quantity" type="number" id="cartNum'+cartId+'"><a onclick="changeNum('+cartId+','+goodsId+')" class="btn btn-2">更改数量</a>'+
							'<hr>'+
							'<a class="btn btn-default pull-right" onclick="removeCart('+cartId+')">移除</a>'+
						'</div>'+
					'</div>'+
					'<div class="clear"></div>'+
				'</div>'+
			'</div>'
		)
	}
	
	function balance(){
		var data = {
			allSum: $("#all-sum").val(),
		}
		$.post("./orderAction!balanceCart.action", data, function(res, status){
			if(res.status == "success"){
				alert('购买成功');
				window.location.reload();
			}else{
				alert(res.msg);
			}
		})
	}
	
	function removeCart(id){
		var data = {
			cartId: id
		}
		$.post("./cartAction!deleteCart.action", data, function(res, status){
			if(res.status == "success"){
				$("#cart"+id).remove();
				$("#cart-num").text(res.data+" ITEM");
				alert("删除成功");
			}else{
				alert(res.msg);
			}
		})
	}
	
	function changeNum(cartId, goodsId){
		var goodsNum = $("#cartNum"+cartId).val();
		if(goodsNum < 1){
			alert("请选择购买数量");
		}else{
			var data = {
				goodsId: goodsId,
				goodsNum: goodsNum
			};
			console.log(data)
			$.post("./cartAction!updateCart.action", data, function(res, status){
				if(res.status == "success"){
					alert("更改购物车信息成功");
					window.location.reload();
				}else{
					alert(res.msg);
				}
			})	
		}
	}
	
	$(document).ready(function(){
		$.post("./cartAction!getCartDetail.action", {}, function(res, status){
			console.log(res);
			if(res.status == "success"){
				for(var i=0; i<res.carts.length; i++){
					var cart = res.carts[i];
					var goods = res.goodslist[i];
					$("#cart-container").prepend(cartList(cart.cartId, goods.goodsId, goods.name, goods.brand, goods.price, cart.goodsNum, goods.image));
				}
				$("#pricedetails").after(priceDetails(res.carts, res.goodslist));
			}else{
				alert(res.msg);
				window.location.href = './account.jsp';
			}
		})
	})
	
	function logout(){
		$.post("./userAction!logout.action", {}, function(res, status){
			if(res.status == "success"){
				alert("你已成功退出登录");
				window.location.href = "./index.jsp";
			}
		})
	}
</script>
</html>
