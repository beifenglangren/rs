<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>订餐系统</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="../js/jquery.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">订餐系统</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    ${user.userName}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="../user/info">查看个人信息</a></dd>
                    <dd><a href="../user/toeditinfo">修改个人信息</a></dd>
                    <dd><a href="../user/tochangepassword">修改密码</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="../user/logout">退出</a></li>
        </ul>
    </div>
    <c:if test="${user.userIdentity==1}">
        <div class="layui-side layui-bg-black">
            <div class="layui-side-scroll">
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                    <li class="layui-nav-item"><a href="../user/shopindex">首页</a></li>
                    <li class="layui-nav-item"><a href="../shop/toapply">申请创建商家</a></li>
                    <li class="layui-nav-item"><a href="../shop/selfshops">我的商家</a></li>
                    <li class="layui-nav-item"><a href="../order/towaitorder">待处理订单</a></li>
                    <li class="layui-nav-item"><a href="../order/shopordershow">历史订单</a></li>
                    <li class="layui-nav-item"><a href="../review/toreplyreview">待回复评价</a></li>
                    <li class="layui-nav-item"><a href="../review/toshopreview">历史评价</a></li>
                </ul>
            </div>
        </div>
    </c:if>
    <c:if test="${user.userIdentity==2}">
        <div class="layui-side layui-bg-black">
            <div class="layui-side-scroll">
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                    <li class="layui-nav-item"><a href="../user/adminindex">首页</a></li>
                    <li class="layui-nav-item"><a href="../shop/tocheck">审批店家</a></li>
                    <li class="layui-nav-item"><a href="../shop/adminshops">管理商家信息</a></li>
                    <li class="layui-nav-item"><a href="../user/usermgt">管理用户信息</a></li>
                    <li class="layui-nav-item"><a href="../category/categorymastermgt">管理店家分类</a></li>
                    <li class="layui-nav-item"><a href="../order/ordermgt">订单管理</a></li>
                    <li class="layui-nav-item"><a href="../review/reviewmgt">评价管理</a></li>
                    <li class="layui-nav-item"><a href="../shop/shopcollectmgt">收藏管理</a></li>
                    <li class="layui-nav-item"><a href="../product/zanmgt">点赞管理</a></li>
                </ul>
            </div>
        </div>
    </c:if>
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 20px">
            <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px;margin-bottom: 20px">
                管理店内餐品
            </div>
            <form class="layui-form" action="../product/search" method="post">
                <div class="layui-form-item">
                    <label class="layui-form-label">搜索</label>
                    <div class="layui-input-block">
                        <input type="hidden" value="${shopId}" id="shopId2" name="shopId2">
                        <input type="text" name="keyword" id="keyword" placeholder="餐品" autocomplete="off" class="layui-input">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">搜索</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>
            <button style="margin-top: 10px" class="layui-btn layui-btn-warm" id="add">新增</button>
            <button style="margin-top: 10px" class="layui-btn layui-btn-warm" onclick="databasebackup();">商品数据备份</button>
            <input type="hidden" value="${shopId}" id="backupid" name="backupid">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <span class="layui-breadcrumb" lay-separator="|">
                 <a href="../product/productmgt?shopId=${shopId}">全部</a>
                <c:forEach items="${categorylist}" var="category">
  <a href="../product/productbycategory?categoryId=${category.categoryId}&shopId=${category.shopId}">${category.categoryName}</a>
                </c:forEach>
</span>
            <table class="layui-table">
                <colgroup>
                    <col width="150">
                    <col width="200">
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th>名称</th>
                    <th>图片</th>
                    <th>分类</th>
                    <th>描述</th>
                    <th>价格</th>
                    <th>库存</th>
                    <th>销量</th>
                    <th>点赞</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${productlist}" var="product">
                <tr>
                    <td>${product.productName}</td>
                    <td><img src="../img/${product.productImg}" width="50px" height="50px"></td>
                    <td>${product.category.categoryName}</td>
                    <td>${product.productDesc}</td>
                    <td>${product.productPrice}</td>
                    <td>${product.productStock}</td>
                    <td>${product.saleCount}</td>
                    <td>${product.productZan}</td>
                    <td>
                        <a href="../product/toeditproduct?productId=${product.productId}&shopId=${product.shopId}" class="layui-btn layui-btn-warm">编辑</a>
                        <a href="../product/deleteproduct?productId=${product.productId}" class="layui-btn layui-btn-warm" onclick="return confirm('确定将此餐品删除？')">删除</a>
                    </td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="page">
                <%@include file="adminPage.jsp" %>
            </div>
            <div style="display: none" id="div1">
                <form class="layui-form" action="../product/addproduct" method="post" enctype="multipart/form-data" onsubmit="return checkname();">
                    <input type="hidden" value="${shopId}" name="shopId" id="shopId">
                    <div class="layui-form-item">
                        <label class="layui-form-label">名称</label>
                        <div class="layui-input-block">
                            <input type="text" id="productName" name="productName" autocomplete="off" class="layui-input" required  lay-verify="required">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">描述</label>
                        <div class="layui-input-block">
                            <input type="text" id="productDesc" name="productDesc" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">价格</label>
                        <div class="layui-input-block">
                            <input type="text" id="productPrice" name="productPrice" autocomplete="off" class="layui-input" required  lay-verify="required">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">库存</label>
                        <div class="layui-input-block">
                            <input type="text" id="productStock" name="productStock" autocomplete="off" class="layui-input" required  lay-verify="required">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">餐品照片</label>
                        <div class="layui-input-block">
                            <input name="productImg" id="productImg" class="file-loading"
                                   type="file" multiple accept=".jpg,.jpeg,.png" data-min-file-count="1"
                                   data-show-preview="true">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">分类</label>
                        <div class="layui-input-block">
                            <select name="categoryId" id="categoryId">
                                <option value=""></option>
                                <c:forEach items="${categorylist}" var="category">
                                    <option value="${category.categoryId}">${category.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        网上订餐系统
    </div>
</div>
</body>
</html>
<script src="../layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;

    });
    layui.use('form', function () {
        var form = layui.form;
    });
    layui.use('carousel', function () {
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#test1'
            , width: '100%' //设置容器宽度
            , arrow: 'always' //始终显示箭头
            , height: '200px'
            //,anim: 'updown' //切换动画方式
        });
    });
    document.onreadystatechange=function () {
        if(document.readyState=="complete"){
            var e="${msg}";
            if(e!=""&&e!=null){
                alert(e);
            }
        }
    }
    $("#add").click(function () {
        var div=document.getElementById("div1");
        if(div.style.display=='none'){
            div.setAttribute("style","display");
        }
        else {
            div.setAttribute("style","display:none");
        }
    })
    function check(){
        var name=$("#productName").val();
        var shopId=$("#shopId").val();
        var a;
        $.ajaxSetup({async:false});
        $.get(
            "http://localhost:8080/rs/product/checkname",
            {"name":name,"shopId":shopId},
            function (result) {
                if("success"==result){
                    a=0;
                }
                else {
                    a=1;
                    alert("您添加的商品名已经存在！请重新添加！");
                }
            }
        );
        if(a==0){
            return true;
        }
        else {
            return false;
        }
    }
    function checkname() {
        if(check()&&checkstock()&&checkprice()){
            return true;
        }
        else {
            return false;
        }
    }
    function checkstock() {
        var stock=$("#productStock").val();
        var a = /^\d+$/;
        if(!a.test(stock)){
            alert("请输入正常的库存！");
            return false;
        }
        else {
            return true;
        }
    }
    function checkprice() {
        var price=$("#productPrice").val();
        if(price<=0){
            alert("请输入正常的人均价格！");
            return false;
        }
        else {
            return true;
        }
    }
    var backupid=$("#backupid").val();
    function databasebackup() { $.ajax({
        url: "${pageContext.request.contextPath}/product/databasebackup",
        type: "post",
        data: {shopId:backupid},
        datatype: "json",
        success: function(result)
        { if(result=="success")
        { alert('Success','数据库备份成功！'); }
        else{alert('Error','数据库备份失败！'); } } }) }
</script>

