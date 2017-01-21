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
		<div class="container" id="cart-container">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>订单编号</th>
						<th>订单时间</th>
						<th>订单总额</th>
						<th>订单状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="order-body"></tbody>
			</table>
		</div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabel">订单详情</h4>
	            </div>
	            <div class="modal-body">
	            	<table class="table">
					   <thead>
					      <tr>
					         <th>商品名</th>
					         <th>商品单价</th>
					         <th>商品数量</th>
					      </tr>
					   </thead>
					   <tbody id="details-body"></tbody>
					</table>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	            </div>
	        </div>
	    </div>
	</div>
</body>
<script>

	function orderList(id, time, sum, status){
		var arr = ["待发货","配送中","待确认 <a style='cursor: pointer;color:red;' onclick='confirmGet("+id+")'>确认收货</a>","已完成"];
		return (
			'<tr>'+
				'<td>'+id+'</td>'+
				'<td>'+time+'</td>'+
				'<td>￥'+sum+'</td>'+
				'<td>'+arr[status]+'</td>'+
				'<td style="width: 20%;"><button class="btn btn-primary" onclick="openDetail('+id+')">查看订单详情</button></td>'+
			'</tr>'
		);
	}
	
	function detailslist(name, price, num){
		return (
			'<tr>'+
				'<td>'+name+'</td>'+
				'<td>￥'+price+'</td>'+
				'<td>'+num+'</td>'+
			'</tr>'
		);
	}
	
	function confirmGet(id){
		var data = {
			orderId: id
		};
		$.post("./orderAction!reciveOrder.action", data, function(res, status){
			if(res.status == "success"){
				alert(res.msg);
				window.location.reload();
			}else{
				alert(res.msg);
			}
		})
	}
	
	function openDetail(id){
		$("#details-body").empty();
		var data = {
			orderId: id	
		};
		$.post("./orderAction!getUserDetails.action", data, function(res, status){
			if(res.status == "success"){
				for(var i=0; i<res.detailslist.length; i++){
					var details = res.detailslist[i];
					var goods = res.goodslist[i];
					$("#details-body").append(detailslist(goods.name, goods.price, details.goodsNum));
				}
			}else{
				$("#details-body").text("该订单没有内容");
			}
			$("#myModal").modal("show");
		})
	}
	
	$(document).ready(function(){
		$.post("./orderAction!getUserOrder.action", {}, function(res, status){
			if(res.status == "success"){
				console.log(res);
				for(var i=0; i<res.data.length; i++){
					var temp = res.data[i];
					$("#order-body").append(orderList(temp.orderId, temp.orderTime, temp.allSum, temp.status));
				}
			}else{
				alert(res.msg);
				window.location.href = './account.jsp';
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