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
                    贤心
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">查看个人信息</a></dd>
                    <dd><a href="">修改个人信息</a></dd>
                    <dd><a href="">修改密码</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退出</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item"><a href="../user/index">首页</a></li>
                <li class="layui-nav-item"><a href="../shop/selfcollect">我的收藏</a></li>
                <li class="layui-nav-item"><a href="../product/oftenbuy">常买餐品</a></li>
                <li class="layui-nav-item"><a href="../shop/oftenbuy">常去店家</a></li>
                <li class="layui-nav-item"><a href="../order/list">我的订单</a></li>
                <li class="layui-nav-item"><a href="../review/selfreview">我的评价</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="margin-top: 20px;text-align: center">
            <span style="font-weight: bold;font-size: 30px">支付剩余时间：</span>
            <div id="title"></div>
            <hr class="layui-bg-gray">
                <div style="font-size: 20px">
                    <img src="../img/${orderMaster.shop.shopImg}" width="60px" height="60px">
                    ￥${orderMaster.orderTotal}&nbsp;&nbsp;&nbsp;&nbsp;${orderMaster.shop.shopName}&nbsp;&nbsp;&nbsp;&nbsp;${orderMaster.orderCode}
                </div>
            <hr class="layui-bg-gray">
            <div>
                <img src="../img/zhifubao.jpg" width="500px" height="300px">
            </div>
            <div>
                <img src="../img/erweima.jpg" width="250px" height="250px">
            </div>
            <a href="../order/pay?masterId=${orderMaster.orderId}">
            <input type="button" value="确认支付￥${orderMaster.orderTotal}" style="background: #ffe51a;color: #000000;border-style: none;font-weight: bold;font-size: 20px;width: 250px;height: 40px">
            </a>
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
    window.onload = function(){
                   var m = 14;  //分
                 var s = 59;  //秒
                 var countdown = document.getElementById("title");
                   getCountdown();
                   setInterval(function(){ getCountdown() },1000);
                   function getCountdown (){
                       if(m>=10&&s>=10){
                           countdown.innerHTML = "<span style='font-weight: bold;font-size: 24px'>"+m+"</span> ：<span style='font-weight: bold;font-size: 24px'>"+s+"</span>";
                       }
                       if(m>=10&&s<10){
                           countdown.innerHTML = "<span style='font-weight: bold;font-size: 24px'>"+m+"</span> ：<span style='font-weight: bold;font-size: 24px'>"+"0"+s+"</span>";
                       }
                       if(m<10&&s>=10){
                           countdown.innerHTML = "<span style='font-weight: bold;font-size: 24px'>"+"0"+m+"</span> ：<span style='font-weight: bold;font-size: 24px'>"+s+"</span>";
                       }
                       if(m<10&&s<10){
                           countdown.innerHTML = "<span style='font-weight: bold;font-size: 24px'>"+"0"+m+"</span> ：<span style='font-weight: bold;font-size: 24px'>"+"0"+s+"</span>";
                       }
                          if( m == 0 && s == 0 ){
                               alert("倒计时结束");
                                  m = 14;
                                 s = 59;
                            }else if( m >= 0 ){
                              if( s > 0 ){
                                         s--;
                                   }else if( s == 0 ){
                                       m--;
                                      s = 59;
                                       }
                               }
                        }
                }

</script>