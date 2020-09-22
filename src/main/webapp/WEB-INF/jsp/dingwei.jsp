<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
        body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
    </style>
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=eGWz1Lp8zgpt8QIg7AZRef2apOQxiAZl"></script>
    <title>IP定位获取当前城市</title>
</head>
<body>
<div style="width: 0%;height: 0%">
    <div id="allmap"></div>
</div>
</body>
</html>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap");
    var point = new BMap.Point(116.331398,39.897445);
    map.centerAndZoom(point,12);

    function myFun(result){
        var cityName = result.name;
        map.setCenter(cityName);
        window.location.href="../user/dingwei?city="+cityName;
    }
    var myCity = new BMap.LocalCity();
    myCity.get(myFun);
</script>

