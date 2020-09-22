<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>订餐系统</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
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
    <div class="layui-body">
        <div style="padding: 15px;">
            <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px;margin-bottom: 20px">
                申请店家
            </div>
        <form class="layui-form" id="form1" method="post" onsubmit="return check();" action="../shop/apply" enctype="multipart/form-data">
            <div class="layui-form-item">
                <label class="layui-form-label">店名</label>
                <div class="layui-input-block">
                    <input type="text" id="shopName" name="shopName" placeholder="长度为1-40字符" autocomplete="off" class="layui-input" required  lay-verify="required">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">地址</label>
                <div class="layui-input-block">
                    <input type="text" name="shopAddress" id="shopAddress" placeholder="模板：泉州市" autocomplete="off" class="layui-input" required  lay-verify="required">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">叙述</label>
                <div class="layui-input-block">
                    <input type="text" name="shopDesc" id="shopDesc" autocomplete="off" class="layui-input" placeholder="可为空，最大长度为18">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">人均</label>
                <div class="layui-input-block">
                    <input type="text" name="shopPrice" id="shopPrice" autocomplete="off" class="layui-input" required  lay-verify="required">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">联系手机</label>
                <div class="layui-input-block">
                    <input type="text" name="shopPhone" id="shopPhone" autocomplete="off" class="layui-input" required  lay-verify="required">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">店家照片</label>
                <div class="layui-input-block">
                    <input name="shopImg" id="shopImg" class="file-loading"
                           type="file" multiple accept=".jpg,.jpeg,.png" data-min-file-count="1"
                           data-show-preview="true" required  lay-verify="required">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">分类</label>
                <div class="layui-input-block">
                    <select name="categoryId" id="categoryId">
                        <option value=""></option>
                            <c:forEach items="${categorymaster}" var="category">
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
    layui.use('element', function(){
        var element = layui.element;

    });
    layui.use('form', function(){
        var form = layui.form;
    });
    layui.use('carousel', function(){
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#test1'
            ,width: '100%' //设置容器宽度
            ,arrow: 'always' //始终显示箭头
            ,height:'200px'
            //,anim: 'updown' //切换动画方式
        });
    });
    layui.use('element', function(){
        var element = layui.element;

        //…
    });
    document.onreadystatechange=function () {
        if(document.readyState=="complete"){
            var e="${msg}";
            if(e!=""&&e!=null){
                alert(e);
            }
        }
    }
    function checkshopname() {
        var shopname=document.getElementById("shopName").value.trim();
        if(shopname.length<1||shopname.length>40){
            alert("店名不符合要求！请重新输入！");
            document.getElementById("shopName").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function checkdesc() {
        var shopname=document.getElementById("shopDesc").value.trim();
        if(shopname.length>18){
            alert("商家描述过长！请重新输入！");
            document.getElementById("shopDesc").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function checkPhone() {
        var phone=document.getElementById("shopPhone").value.trim();
        if(!(/^1[34578]\d{9}$/.test(phone))){
            alert("手机号码有误，请重填");
            document.getElementById("shopPhone").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function check() {
        if(checkshopname()&&checkPhone()&&checkdesc()){
            return true;
        }
        else {
            return false;
        }
    }
</script>