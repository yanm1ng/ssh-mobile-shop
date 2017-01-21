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
		<div class="container">
			<div class="row">
				<div id="main-content" class="col-md-12">
					
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	function goodsDetail(id, name, brand, price, image, description){
		return (
			'<div class="product">'+
				'<div class="col-md-3">'+
					'<div class="image">'+
						'<img src="'+image+'" />'+
					'</div>'+
				'</div>'+
				'<div class="col-md-9">'+
					'<div class="caption">'+
						'<div class="name"><h3>'+name+'</h3></div>'+
						'<div class="info">'+
							'<ul>'+
								'<li>品牌：'+brand+'</li>'+
							'</ul>'+
						'</div>'+
						'<div class="price">价格: ￥'+price+'</div>'+
						'<div class="well"><label>数量：</label> <input class="form-inline quantity" type="number" value="1" id="number"><a onclick="addCart('+id+')" class="btn btn-2">添加到购物车</a></div>'+
						'<a class="btn btn-1" onclick="buyNow('+id+','+price+')">立即购买</a>'+
					'</div>'+
				'</div>'+
				'<div class="clear"></div>'+
			'</div>'+
			'<div class="product-desc">'+
				'<ul class="nav nav-tabs">'+
					'<li class="active"><a href="#description">产品描述</a></li>'+
				'</ul>'+
				'<div class="tab-content">'+
					'<div id="description" class="tab-pane fade in active">'+
						'<p>'+description+'</p>'+
					'</div>'+
				'</div>'+
			'</div>'
		);
	}
	
	function buyNow(id, price){
		var goodsNum = $("#number").val();
		if(goodsNum < 1){
			alert("请选择购买数量");
		}else{
			var data = {
				goodsId: id,
				allSum: price * goodsNum,
				goodsNum: goodsNum
			}
			$.post("./orderAction!addNow.action", data, function(res, status){
				if(res.status == "success"){
					alert('购买成功');
				}else{
					alert(res.msg);
				}
			})
		}
	}
	
	function addCart(id){
		var goodsNum = $("#number").val();
		if(goodsNum < 1){
			alert("请选择购买数量");
		}else{
			var data = {
				goodsId: id,
				goodsNum: goodsNum
			};
			$.post("./cartAction!addCart.action", data, function(res, status){
				if(res.status == "success"){
					$("#cart-num").text(res.data+" ITEM");
					alert("添加到购物车成功");
				}else{
					alert(res.msg);
				}
			})
		}
	}
	
	$(document).ready(function(){
		var code = window.location.search.slice(1);
		var data = {
			goodsId: code
		}
		$.post("./goodsAction!getById.action", data, function(res, status){
			if(res.status == "success"){
				var temp = res.data;
				$("#main-content").append(goodsDetail(temp.goodsId, temp.name, temp.brand, temp.price, temp.image, temp.description));
			}
		})
	});
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