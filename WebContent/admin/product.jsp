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
				<div id="main-content" class="col-md-12">
					
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="myModalLabel">商品详情</h4>
	            </div>
	            <div class="modal-body">
	            	<p class="bg-danger" style="padding: 6px; display: none;" id="info-msg"></p>
	           		<input type="hidden" id="goods-id">
	           		<div class="form-group">
					    <input class="form-control" type="text" placeholder="库存" id="goods-stock">
					</div>
					<div class="form-group">
					    <div class="input-group">
					      	<div class="input-group-addon">￥</div>
					      	<input class="form-control" type="text" placeholder="单价" id="goods-price">
					    </div>
					</div>
					<div class="form-group">
						<textarea class="form-control" placeholder="商品描述" id="goods-des"></textarea>
					</div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	                <button type="button" class="btn btn-primary" onclick="confirmInfo()">确定修改</button>
	            </div>
	        </div>
	    </div>
	</div>
</body>
<script>
	function goodsDetail(id, name, brand, price, sale, stock, image, description){
		return (
			'<div class="product">'+
				'<div class="col-md-3">'+
					'<div class="image">'+
						'<img src="../'+image+'" />'+
					'</div>'+
				'</div>'+
				'<div class="col-md-9">'+
					'<div class="caption">'+
						'<div class="name"><h3>'+name+'</h3><a style="cursor: pointer;float:right;" onclick="setGoods('+id+')">修改信息</a></div>'+
						'<div class="info">'+
							'<ul>'+
								'<li>品牌：'+brand+'</li>'+
							'</ul>'+
						'</div>'+
						'<div class="price">价格: ￥'+price+'</div>'+
						'<div class="well"><label>销售数量：'+sale+'台</label>，<label>库存数量：'+stock+'台</label></div>'+
						'<a class="btn btn-1" onclick="deleteGoods('+id+')">删除商品</a>'+
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
	
	function setGoods(id){
		$("#goods-id").val(id);
		$("#infoModal").modal("show");
	}
	
	function confirmInfo(){
		var goods_id = $("#goods-id").val();
		var goods_stock = $("#goods-stock").val();
		var goods_price = $("#goods-price").val();
		var goods_des = $("#goods-des").val();
		var data = {
			goodsId: goods_id,
			goodsStock: goods_stock,
			goodsPrice: goods_price,
			goodsDes: goods_des
		};
		
		$.post("./adminAction!updateGoods.action", data, function(res, status){
			if(res.status == "success"){
				$("#info-msg").text(res.msg+",对话框1s后关闭");
				$("#info-msg").show();
				setTimeout(function(){
					$("#infoModal").modal("hide");
					window.location.reload();
				}, 1000);
			}else{
				$("#info-msg").text(res.msg);
				$("#info-msg").show();
			}
		})
	}
	
	function deleteGoods(id){
		var data = {
			goodsId: id
		};
		$.post("./adminAction!deleteGoods.action", data, function(res, status){
			if(res.status == "success"){
				alert(res.msg);
				window.location.href = './index.jsp';
			}else{
				alert(res.msg);
			}
		})
	}

	$(document).ready(function(){
		var code = window.location.search.slice(1);
		var data = {
			goodsId: code
		}
		$.post("./goodsAction!getById.action", data, function(res, status){
			if(res.status == "success"){
				var temp = res.data;
				$("#main-content").append(goodsDetail(temp.goodsId, temp.name, temp.brand, temp.price, temp.sale, temp.stock, temp.image, temp.description));
			}
		})
	});
	
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