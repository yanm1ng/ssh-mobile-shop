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
	<div id="page-content" class="home-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
						<ol class="carousel-indicators hidden-xs">
							<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
							<li data-target="#carousel-example-generic" data-slide-to="1"></li>
							<li data-target="#carousel-example-generic" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner">
							<div class="item active">
								<img src="images/main-banner1-1903x600.jpg" alt="First slide">
								<div class="header-text hidden-xs">
									<div class="col-md-12 text-center">
									</div>
								</div>
							</div>
							<div class="item">
								<img src="images/main-banner2-1903x600.jpg" alt="Second slide">
								<div class="header-text hidden-xs">
									<div class="col-md-12 text-center">
									</div>
								</div>
							</div>
							<div class="item">
								<img src="images/main-banner3-1903x600.jpg" alt="Third slide">
								<div class="header-text hidden-xs">
									<div class="col-md-12 text-center">
									</div>
								</div>
							</div>
						</div>
						<a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
							<span class="glyphicon glyphicon-chevron-left"></span>
						</a>
						<a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
							<span class="glyphicon glyphicon-chevron-right"></span>
						</a>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="banner">
					<div class="col-sm-4">
						<img src="images/sub-banner1.png" />
					</div>
					<div class="col-sm-4">
						<img src="images/sub-banner2.png" />
					</div>
					<div class="col-sm-4">
						<img src="images/sub-banner3.png" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="heading"><h2>热卖商品</h2></div>
					<div class="products">
						
					</div>
				</div>
			</div>
			<div class="row">
				<div class="banner">
					<div class="col-sm-6">
						<img src="images/sub-banner4.jpg" />
					</div>
					<div class="col-sm-6">
						<img src="images/sub-banner5.png" />
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	function productCard(id, name, price, image){
		return (
			'<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">'+
				'<div class="product">'+
					'<div class="image"><a href="product.jsp?'+id+'"><img src="'+image+'"/></a></div>'+
					'<div class="buttons">'+
						'<a class="btn cart" onclick="addCart('+id+')" style="margin-right: 12px;"><span class="glyphicon glyphicon-shopping-cart"></span></a>'+
						'<a class="btn compare" href="product.jsp?'+id+'"><span class="glyphicon glyphicon-transfer"></span></a>'+
					'</div>'+
					'<div class="caption">'+
						'<div class="name"><h3><a href="product.jsp?'+id+'">'+name+'</a></h3></div>'+
						'<div class="price">￥'+price+'</div>'+
					'</div>'+	
				'</div>'+
			'</div>'
		);
	}
	function addCart(id){
		//alert(id)
		var data = {
			goodsId: id,
			goodsNum: 1
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
	$(document).ready(function(){
		$.post("./goodsAction!getAll.action", {}, function(res, status){
			if(res.status == "success"){
				console.log(res);
				for(var i=0; i < res.data.length; i++){
					var temp = res.data[i];
					$(".products").append(productCard(temp.goodsId, temp.name, temp.price, temp.image));
				}
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
