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
    <link rel="stylesheet" href="../css/bootstrap.min.css"  type="text/css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../font-awesome/css/font-awesome.min.css"  type="text/css">
    <link rel="stylesheet" href="../fonts/font-slider.css" type="text/css">
	<script src="../js/jquery-2.1.1.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</head>
<body>
	<nav id="top">
		<div class="container">
			<div class="row">
				<div class="col-xs-12">
					<ul class="top-link">
						 <s:if test="%{#session.admin==null}"> 
						     <li><a href="account.jsp"><span class="glyphicon glyphicon-user"></span> 管理员登录</a></li>
						 </s:if>
						 <s:elseif test="%{#session.admin!=null}"> 
						     <li><span class="glyphicon glyphicon-user"></span> 欢迎你, <s:property value="#session.admin"/><a onclick="logout()" style="cursor: pointer;"> 退出登录</a></li>
						 </s:elseif>
					</ul>
				</div>
			</div>
		</div>
	</nav>
	<header class="container">
		<div class="row">
			<div class="col-md-4">
				<div id="logo"><img src="../images/logo.png" /></div>
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
					<li><a href="index.jsp">全部商品</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">商品管理</a>
						<div class="dropdown-menu">
							<div class="dropdown-inner">
								<ul class="list-unstyled">
									<li><a href="add.jsp">添加商品</a></li>
									<li><a href="category.jsp?Apple">苹果</a></li>
									<li><a href="category.jsp?Samsung">三星</a></li>
									<li><a href="category.jsp?Xiaomi">小米</a></li>
									<li><a href="category.jsp?Meizu">魅族</a></li>
									<li><a href="category.jsp?Huawei">华为</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li><a href="users.jsp">用户管理</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">订单管理</a>
						<div class="dropdown-menu">
							<div class="dropdown-inner">
								<ul class="list-unstyled">
									<li><a href="orderlist.jsp">所有订单</a></li>
									<li><a href="orderchart.jsp">订单图表</a></li>
								</ul>
							</div>
						</div>
					</li>
					<li><a href="view.jsp">查看留言</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div id="page-content" class="single-page">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<div class="heading"><h2>商品信息</h2></div>
					<div>
						<p class="bg-danger" style="padding: 6px; display: none;" id="add-msg"></p>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="商品名" id="name">
						</div>
						<div class="form-group">
							<select class="form-control" id="brand">
								<option value="Apple">苹果</option>
							  	<option value="Meizu">魅族</option>
							  	<option value="Huawei">华为</option>
							 	<option value="Xiaomi">小米</option>
							 	<option value="Samsung">三星</option>
							</select>
						</div>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="商品价格" id="price">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="商品图片链接" id="image">
						</div>
						<button class="btn btn-2" onclick="addGoods()">立即添加</button>
					</div>
				</div>
				<div class="col-md-6" style="margin-top: 103px;">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="商品库存" id="stock">
					</div>
					<div class="form-group">
						<textarea rows="" cols="" class="form-control" placeholder="商品描述" id="description"></textarea>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	function addGoods(){
		var goodsName = $("#name").val();
		var goodsBrand = $("#brand").val();
		var goodsPrice = $("#price").val();
		var goodsImage = $("#image").val();
		var goodsStock = $("#stock").val();
		var goodsDes = $("#description").val();
		var data = {
			goodsName: goodsName,
			goodsBrand: goodsBrand,
			goodsPrice: goodsPrice,
			goodsImage: goodsImage,
			goodsStock: goodsStock,
			goodsDes: goodsDes
		};
		console.log(data);
		$.post("./adminAction!addGoods.action", data, function(res, status){
			$("#add-msg").text(res.msg);
			$("#add-msg").show();
		})
	}
	function logout(){
		$.post("./adminAction!logout.action", {}, function(res, status){
			if(res.status == "success"){
				alert("你已成功退出登录");
				window.location.href = "./index.jsp";
			}
		})
	}
</script>
</html>