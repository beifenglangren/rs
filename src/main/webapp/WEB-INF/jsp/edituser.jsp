<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>订餐系统</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
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
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">
            <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px;margin-bottom: 20px">
                编辑用户
            </div>
            <form class="layui-form" id="form2" action="../user/edituser" method="post" onsubmit="return check();">
                <input type="hidden" id="userId" name="userId" value="${userinfo.userId}">
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block">
                        <input type="text" id="userUsername" name="userUsername" value="${userinfo.userUsername}" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-block">
                        <input type="text" id="userPassword" name="userPassword" value="${userinfo.userPassword}" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">身份</label>
                    <div class="layui-input-block">
                        <select name="userIdentity">
                          <c:if test="${userinfo.userIdentity==0}">
                              <option value="0" selected="selected">顾客</option>
                              <option value="1">店家</option>
                          </c:if>
                            <c:if test="${userinfo.userIdentity==1}">
                                <option value="1" selected="selected">店家</option>
                                <option value="0">顾客</option>
                            </c:if>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">年龄</label>
                    <div class="layui-input-block">
                        <input type="text" name="userAge" id="userAge" value="${userinfo.userAge}" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">姓名</label>
                    <div class="layui-input-block">
                        <input type="text" name="userName" id="userName" value="${userinfo.userName}"  autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">手机</label>
                    <div class="layui-input-block">
                        <input type="text" name="userPhone" id="userPhone" value="${userinfo.userPhone}"  autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">地址</label>
                    <div class="layui-input-block">
                        <input type="text" name="userAddress" id="userAddress" value="${userinfo.userAddress}" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <c:if test="${userinfo.userSex=='女'}">
                        <input type="radio" name="userSex"  value="男" title="男">
                        <input type="radio" name="userSex"  value="女" title="女" checked>
                    </c:if>
                    <c:if test="${userinfo.userSex!='女'}">
                        <input type="radio" name="userSex"  value="男" title="男" checked>
                        <input type="radio" name="userSex"  value="女" title="女">
                    </c:if>
                </div>
            </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">修改</button>
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
    function checkAge() {
        var result=document.getElementById("userAge").value.trim();
        var age=parseInt(result);
        if(age<1||age>120){
            alert("请输入正常的年龄！");
            document.getElementById("userAge").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function checkusername() {
        var username=document.getElementById("userUsername").value.trim();
        if(username.length<4||username.length>13){
            alert("用户名不符合要求！请重新输入！");
            document.getElementById("userUsername").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function checkpassword() {
        var password=document.getElementById("userPassword").value.trim();
        if(password.length<4||password.length>13){
            alert("密码不符合要求！请重新输入！");
            document.getElementById("userPassword").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function checkPhone() {
        var phone=document.getElementById("userPhone").value.trim();
        if(!(/^1[34578]\d{9}$/.test(phone))){
            alert("手机号码有误，请重填");
            document.getElementById("userPhone").focus();
            return false;
        }
        else {
            return true;
        }
    }
    function checkisexist(){
        var username=$("#userUsername").val();
        var userId=$("#userId").val();
        var a;
        $.ajaxSetup({async:false});
        $.get(
            "http://localhost:8080/rs/user/checkeditusername",
            {"username":username,"userId":userId},
            function (result) {
                if("success"==result){
                    a=0;
                }
                else {
                    a=1;
                    alert("用户名已被注册！请重新填写！");
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
    function check() {
        if(checkPhone()&&checkAge()&checkusername()&&checkpassword()&&checkisexist()){
            return true;
        }
        else {
            return false;
        }
    }
</script>