<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <div style="padding: 15px;">
            <div style="background: #ffe51a;width: 100%;height: 50px;text-align: center;font-weight: bold;font-size: 30px;margin-bottom: 20px">
                审核商家
            </div>
            <fieldset class="layui-elem-field layui-field-title">
            <legend>商家基本信息</legend>
            <div class="layui-field-box">
                <div style="float: left;margin-bottom: 50px;margin-right: 70px;width: 350px;height: 70px">
                    <div style="float: left;font-size: 18px;font-weight: bold;margin-right: 100px">商家名</div>
                    <div style="float: left;font-size: 18px">${shop.shopName}</div>
                </div>
                <div style="float: left;margin-bottom: 50px;margin-right: 70px;width: 350px;height: 70px">
                    <div style="float: left;font-size: 18px;font-weight: bold;margin-right: 100px">地址</div>
                    <div style="float: left;font-size: 18px">${shop.shopAddress}</div>
                </div>
                <div style="float: left;margin-bottom: 50px;margin-right: 70px;width: 350px;height: 70px">
                    <div style="float: left;font-size: 18px;font-weight: bold;margin-right: 100px">描述</div>
                    <div style="float: left;font-size: 18px">${shop.shopDesc}</div>
                </div>
                <div style="float: left;margin-bottom: 50px;margin-right: 70px;width: 350px;height: 70px">
                    <div style="float: left;font-size: 18px;font-weight: bold;margin-right: 100px">人均价格</div>
                    <div style="float: left;font-size: 18px">${shop.shopPrice}</div>
                </div>
                <div style="float: left;margin-bottom: 50px;margin-right: 70px;width: 350px;height: 70px">
                    <div style="float: left;font-size: 18px;font-weight: bold;margin-right: 100px">商家电话</div>
                    <div style="float: left;font-size: 18px">${shop.shopPhone}</div>
                </div>
                <div style="float: left;margin-bottom: 50px;margin-right: 70px;width: 350px;height: 70px">
                    <div style="float: left;font-size: 18px;font-weight: bold;margin-right: 100px">商家图片</div>
                    <div style="float: left;font-size: 18px"><img src="../img/${shop.shopImg}" width="70px" height="70px"></div>
                </div>
                <div style="float: left;margin-bottom: 50px;margin-right: 70px;width: 350px;height: 70px">
                    <div style="float: left;font-size: 18px;font-weight: bold;margin-right: 100px">创建时间</div>
                    <div style="float: left;font-size: 18px"><fmt:formatDate value="${shop.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></div>
                </div>
                <div style="float: left;margin-bottom: 50px;margin-right: 70px;width: 350px;height: 70px">
                    <div style="float: left;font-size: 18px;font-weight: bold;margin-right: 100px">更新时间</div>
                    <div style="float: left;font-size: 18px"><fmt:formatDate value="${shop.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></div>
                </div>
                <div style="float: left;margin-bottom: 50px;margin-right: 70px;width: 350px;height: 70px">
                    <div style="float: left;font-size: 18px;font-weight: bold;margin-right: 100px">商家分类</div>
                    <div style="float: left;font-size: 18px">${shop.categoryMaster.categoryName}</div>
                </div>
                <div style="float: left;margin-bottom: 50px;margin-right: 70px;width: 350px;height: 70px">
                    <div style="float: left;font-size: 18px;font-weight: bold;margin-right: 100px">商家法人</div>
                    <div style="float: left;font-size: 18px">${shop.user.userName}</div>
                </div>
            </div>
        </fieldset>
            <fieldset class="layui-elem-field layui-field-title">
                <legend>处理过程</legend>
                <div class="layui-field-box">
                    <table style="font-size: 18px;border-collapse:separate; border-spacing:0px 20px;">
                        <colgroup>
                            <col width="200">
                            <col width="200">
                            <col width="200">
                            <col width="300">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>处理时间</th>
                            <th>处理结果</th>
                            <th>处理人</th>
                            <th>备注</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${shop.dealRecords}" var="deal">
                        <tr>
                            <td><fmt:formatDate value="${deal.dealTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                            <td><c:if test="${deal.dealResult==0}">通过</c:if>
                                <c:if test="${deal.dealResult==1}">打回</c:if>
                                <c:if test="${deal.dealResult==2}">否决</c:if>
                            </td>
                            <td>${deal.user.userName}</td>
                            <td>${deal.dealInfo}</td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </fieldset>
            <form class="layui-form" action="../deal/check" method="post">
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">备注：</label>
                    <div class="layui-input-block">
                        <textarea name="content" id="content" class="layui-textarea"></textarea>
                    </div>
                </div>
                <input type="hidden" value="${shop.shopId}" id="shopId" name="shopId">
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="formDemo" name="dealway" value="0" onclick="return confirm('确定通过？')">通过</button>
                        <button class="layui-btn" lay-submit lay-filter="formDemo" name="dealway" value="1" onclick="return confirm('确定打回？')">打回</button>
                        <button class="layui-btn" lay-submit lay-filter="formDemo" name="dealway" value="2" onclick="return confirm('确定否决？')">否决</button>
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
</script>