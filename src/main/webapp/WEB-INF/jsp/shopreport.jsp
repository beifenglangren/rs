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
    <script src="../js/echarts.js"></script>
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
    <c:if test="${user.userIdentity==0}">
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
    </c:if>
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
        <div style="padding: 20px;">
            <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px;margin-bottom: 20px">
                查看商家报表
            </div>
            <input type="hidden" value="${shopId}" id="shopId" name="shopId">
            <div id="main" style="width: 600px; height: 400px;float: left"></div>
            <div id="echartsPie" style="width: 600px; height: 400px;float: left"></div>
            <div id="echartsLine" style="width: 600px; height: 400px;float: left"></div>
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
    var myChart = echarts.init(document.getElementById('main'));//main是<div id="main" style="width: 600px;height:400px;"></div>的id
    myChart.setOption(
        {
            title: {
                text: '分类销量展示'
            },
            tooltip: {
                trigger: 'axis',
            },
            legend: {
                data:['销量']
            },
            xAxis: {
                type: 'category',
                data: []
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'bar',
                data: []
            }]
        }
    );
    var myChart2 = echarts.init(document.getElementById('echartsPie'));//main是<div id="main" style="width: 600px;height:400px;"></div>的id
    myChart2.setOption(
        {
            title : {
                text: '时段销量',
                subtext: '啦',
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: []
            },
            series : [
                {
                    name: '购买次数',
                    type: 'pie',
                    radius : '55%',
                    center: ['50%', '60%'],
                    data:[
                    ],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        }
    );
    var myChart3 = echarts.init(document.getElementById('echartsLine'));
    myChart3.setOption(
        {
            title: {
                text: '月销售额展示'
            },
            tooltip: {
                trigger: 'axis',
            },
            xAxis: {
                type: 'category',
                data: []
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                name: '月销售额',
                data: [],
                type: 'line'
            }]
        }
    );
    var names=[];
    var nums=[];
    var names2=[];
    var nums2=[];
    var shopId=$("#shopId").val();
    $(document).ready(function(){
        $.ajax({
            type : "get",
            async : true,
            data : {shopId : shopId},
            url : "${pageContext.request.contextPath}/shop/echarts",
            dataType : "json",
            success : function(data){
                if(data.code==1){
                    var obj = eval(data.items);     //解析后台传来的json数据
                    for (var i = 0; i < obj.length; i++) {
                        names.push(obj[i].name);
                    }
                    for (var i = 0; i < obj.length; i++) {
                        nums.push(obj[i].num);
                    }
                    myChart.hideLoading(); //隐藏加载动画
                    myChart.setOption({ //加载数据图表
                        xAxis : {
                            data : names
                        },
                        series : [ {
                            // 根据名字对应到相应的系列
                            name : '销量',
                            data : nums
                        } ]
                    });
                }
                else {
                    alert("失败");
                }
            },
            error : function (errMsg) {
                alert("图表请求数据失败!");
                myChart.hideLoading();
            }
        })
        $.ajax({
            type : "get",
            async : true,
            url : "${pageContext.request.contextPath}/shop/echarts2",
            data : {shopId : shopId},
            dataType : "json",
            success : function(datas){
                var data = eval(datas);;
                var servicedata=[];
                for(var i=0;i<data.name.length;i++){
                    var obj=new Object();
                    obj.name=data.name[i];
                    obj.value=data.data[i];
                    servicedata[i]=obj;
                }
                myChart2.setOption({ //加载数据图表
                    legend: {
                        orient : 'vertical',
                        x : 'left',
                        data:data.name
                    },
                    series : [ {
                        // 根据名字对应到相应的系列
                        name:'购买次数',
                        type:'pie',
                        radius : '55%',//饼图的半径大小
                        center: ['50%', '60%'],//饼图的位置
                        data:servicedata
                    } ]
                });
            },
            error : function (errMsg) {
                alert("图表请求数据失败!");
                myChart2.hideLosading();
            }
        })
    })
    $.ajax({
        type : "get",
        async : true,
        url : "${pageContext.request.contextPath}/shop/echarts3",
        data : {shopId : shopId},
        dataType : "json",
        success : function(data){
            if(data.code==1){
                var obj = eval(data.items);     //解析后台传来的json数据
                for (var i = 0; i < obj.length; i++) {
                    names2.push(obj[i].name);
                }
                for (var i = 0; i < obj.length; i++) {
                    nums2.push(obj[i].num);
                }
                myChart3.hideLoading(); //隐藏加载动画
                myChart3.setOption({ //加载数据图表
                    xAxis : {
                        data : names2
                    },
                    series : [ {
                        // 根据名字对应到相应的系列
                        name : '月销售额',
                        data : nums2
                    } ]
                });
            }
            else {
                alert("失败");
            }
        },
        error : function (errMsg) {
            alert("图表请求数据失败!");
            myChart3.hideLoading();
        }
    })
    // 指定图表的配置项和数据
</script>

