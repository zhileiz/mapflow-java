<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    import="java.util.List,com.shunicom.visualize.*,java.util.*"
    pageEncoding="UTF-8"%>

<html>

<%
processCSV pc = new processCSV();
List<String> result = pc.reprocess("/home/zhileiz/heatmap.csv");
Iterator<Point> points = pc.iterator();
%>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6254YFdX7nkww3tFT0YLR3ie6nC60kv8"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/GeoUtils/1.2/src/GeoUtils_min.js"></script>
    <script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
    <script src="https://use.fontawesome.com/d94b0d3b0f.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
    <script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.css" />
    <script src="http://d3js.org/d3.v4.min.js" charset="utf-8"></script>
    <link rel="stylesheet" href="stylesheets.css" />
    <title>热力图</title>
  </head>

  <body>
        <div class="choosePos" onclick="showMain()">
            <i class="fa fa-map-marker fa-5x"></i>
        </div>
        <div class="chooseDrop" id="mainChoices">
            <div style="margin-top:120px;">
                <div id="clickAllCity" class="dropdownitem">全市</div>
                <div class="dropdownitem" onclick="showDrop()">区县</div>
                <div class="dropdownitem" onclick="showAreas()">重点</div>
                <div onclick="showMain()"><i class="fa fa-angle-double-up fa-2x" aria-hidden="true"></i></div>
            </div>
        </div>
        <div class="chooseDrop" id="maindrop" style="margin-left:120px;">
            <div style="margin-top:163px;">
              <div id="clickHuangpu" class="dropdownitem">黄浦</div>
              <div id="clickXuhui" class="dropdownitem">徐汇</div>
              <div id="clickChangning" class="dropdownitem">长宁</div>
              <div id="clickJingan" class="dropdownitem">静安</div>
              <div id="clickPutuo" class="dropdownitem">普陀</div>
              <div id="clickHongkou" class="dropdownitem">虹口</div>
              <div id="clickYangpu" class="dropdownitem">杨浦</div>
              <div id="clickMinhang" class="dropdownitem">闵行</div>
              <div id="clickBaoshan" class="dropdownitem">宝山</div>
              <div id="clickJiading" class="dropdownitem">嘉定</div>
              <div id="clickPudong" class="dropdownitem">浦东</div>
              <div id="clickJinshan" class="dropdownitem">金山</div>
              <div id="clickSongjiang" class="dropdownitem">松江</div>
              <div id="clickQingpu" class="dropdownitem">青浦</div>
              <div id="clickFengxian" class="dropdownitem">奉贤</div>
              <div id="clickChongming" class="dropdownitem">崇明</div>
              <div onclick="showDrop()"><i class="fa fa-angle-double-up fa-3x" aria-hidden="true"></i></div>
            </div>
        </div>
        <div class="chooseDrop" id="mainAreas" style="margin-left:120px;">
            <div style="margin-top:206px;">
              <div id="clickRenMinGuangChang" class="dropdownitem">人民广场</div>
              <div id="clickDiShiNi" class="dropdownitem">迪士尼</div>
              <div id="clickZhongShanGongYuan" class="dropdownitem">中山公园</div>
              <div id="clickPuDongJiChang" class="dropdownitem">浦东机场</div>
              <div onclick="showAreas()"><i class="fa fa-angle-double-up fa-3x" aria-hidden="true"></i></div>
            </div>
        </div>
    <div class="infobox">
        当前区域总人数：<span id="total"></span>&nbsp&nbsp栅格数：<span id="number"></span>&nbsp&nbsp最大值：<span id="max"></span><br/>
        划定区域总人数：<span id="total2"></span>&nbsp&nbsp栅格数：<span id="number2"></span>&nbsp&nbsp最大值：<span id="max2"></span>
    </div>
    <div hidden class="switch-box">
        <div class="row justify-content-center" id="switch">
            <div class="col-3">选区</div>
            <div class="col-6">
            <div id="div1" class="open1">
            <div id="div2" class="open2"></div>
            </div>
        </div>
        <div class="col-3"> 拖拽</div>
    </div>
  </div>
  <div hidden class="infobox2">划定区域总人数：<span id="total2"></span><br/>栅格数：<span id="number2"></span><br/>最大值：<span id="max2"></span>
            <div class="row justify-content-center" id="switch2">
            <div class="col-3">放大</div>
            <div class="col-6">
            <div id="div3" class="open1">
            <div id="div4" class="open2"></div>
            </div>
        </div>
        <div class="col-3"> 选择</div>
    </div>
    </div>
    <div id="container" style="position:relative;"></div>
  </body>

</html>

<script type="text/javascript">

    // ################
    // 1. 控件和操作类函数
    // ################

    var layers = [];
    // 地图选区操作
                // a. 热点区域
    document.getElementById("clickRenMinGuangChang").onclick = function(){
      removeRegion(layers);
      var point = new BMap.Point(121.481139,31.235301);
      changeCenter(point,17);
    }
    document.getElementById("clickDiShiNi").onclick = function(){
        removeRegion(layers);
        var point = new BMap.Point(121.674752,31.147665);
        changeCenter(point,16);
      }
    document.getElementById("clickZhongShanGongYuan").onclick = function(){
        removeRegion(layers);
        var point = new BMap.Point(121.425139,31.224753);
        changeCenter(point,17);
      }
    document.getElementById("clickPuDongJiChang").onclick = function(){
        removeRegion(layers);
        var point = new BMap.Point(121.81484,31.156873);
        changeCenter(point,15);
      }
        // b. 行政区县
    document.getElementById("clickAllCity").onclick = function(){
      removeRegion(layers);
      var point = new BMap.Point(121.7, 31.16);
      changeCenter(point,11);
    }
    document.getElementById("clickHuangpu").onclick = function(){
        getBoundary("上海市黄浦区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickXuhui").onclick = function(){
        getBoundary("上海市徐汇区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickChangning").onclick = function(){
        getBoundary("上海市长宁区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickJingan").onclick = function(){
        getBoundary("上海市静安区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickPutuo").onclick = function(){
        getBoundary("上海市普陀区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickHongkou").onclick = function(){
        getBoundary("上海市虹口区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickYangpu").onclick = function(){
        getBoundary("上海市杨浦区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickMinhang").onclick = function(){
        getBoundary("上海市闵行区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickBaoshan").onclick = function(){
        getBoundary("上海市宝山区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickJiading").onclick = function(){
        getBoundary("上海市嘉定区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickPudong").onclick = function(){
        getBoundary("上海市浦东新区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickJinshan").onclick = function(){
        getBoundary("上海市金山区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickSongjiang").onclick = function(){
        getBoundary("上海市松江区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickQingpu").onclick = function(){
        getBoundary("上海市青浦区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickFengxian").onclick = function(){
        getBoundary("上海市奉贤区");
        var t = setTimeout("get()",1000);
      }
    document.getElementById("clickChongming").onclick = function(){
        getBoundary("上海市崇明区");
        var t = setTimeout("get()",1000);
      }

    // #####################
    // 2. 地图和热力图展示类函数
    // #####################

    //初始化地图
    var map = new BMap.Map("container");
    var point = new BMap.Point(121.7, 31.16);
    map.centerAndZoom(point, 11);
    map.disableScrollWheelZoom();
    map.setMapStyle({style:'midnight'});

    //地图点JAVA脚本
    var points =[];

    //查看是否支持热力图
    if(!isSupportCanvas()){
        alert('热力图目前只支持有canvas支持的浏览器,您所使用的浏览器不能使用热力图功能~')
    }

    //初始化热力图
    heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":12});
    map.addOverlay(heatmapOverlay);
    function get(){
        $.ajax({
            url:"http://localhost:8080/visualize/ServicesServlet",
            type:"post",
            async:true,
            dataType:"json",
            success:function(data){
              points = data;
              var max = countCurrent(map);
              redrawByZoomLevel(map,max);
            }
           });
    }
    get();
    var t = setInterval("get()",30000);

    //判断浏览区是否支持canvas
    function isSupportCanvas(){
        var elem = document.createElement('canvas');
        return !!(elem.getContext && elem.getContext('2d'));
    }

    // #####################
    // 2. 拖拽选区函数
    // #####################

    //鼠标绘制完成回调方法   获取各个点的经纬度
    var overlays = [];
    var overlaycomplete = function(e){
        overlays.push(e.overlay);
        if (document.getElementById("div3").className != "open1"){
        var path = e.overlay.getPath();//Array<Point> 返回多边型的点数组
        var pointSW = new BMap.Point(path[3].lng,path[3].lat);
        var pointNE = new BMap.Point(path[1].lng,path[1].lat);
        var bound = new BMap.Bounds(pointSW,pointNE);
        var center = bound.getCenter();
        map.panTo(center, false);
        while (map.getBounds().containsBounds(bound)){
            map.zoomIn();
            map.panTo(center, false);
        }
        var max = countCurrent(map);
        redrawByZoomLevel(map,max);
      } else {
        var path = e.overlay.getPath();//Array<Point> 返回多边型的点数组
        var pointSW = new BMap.Point(path[3].lng,path[3].lat);
        var pointNE = new BMap.Point(path[1].lng,path[1].lat);
        var bound = new BMap.Bounds(pointSW,pointNE);
        countRegion(map,bound);
      }
        clearAll();
    };
    var styleOptions = {
        strokeColor:"red",    //边线颜色。
        strokeWeight: 3,       //边线的宽度，以像素为单位。
        strokeOpacity: 0.8,       //边线透明度，取值范围0 - 1。
        fillOpacity: 0,      //填充的透明度，取值范围0 - 1。
        strokeStyle: 'solid' //边线的样式，solid或dashed。
    }
    //实例化鼠标绘制工具
    var drawingManager = new BMapLib.DrawingManager(map, {
        isOpen: false, //是否开启绘制模式
        enableDrawingTool: false, //是否显示工具栏
        drawingMode:BMAP_DRAWING_RECTANGLE,//绘制模式  多边形
        drawingToolOptions: {
            anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
            offset: new BMap.Size(5, 5), //偏离值
            drawingModes:[
                BMAP_DRAWING_RECTANGLE
            ]
        },
        rectangleOptions: styleOptions //多边形的样式
    });

     //添加鼠标绘制工具监听事件，用于获取绘制结果
    drawingManager.addEventListener('overlaycomplete', overlaycomplete);
    function clearAll() {
        for(var i = 0; i < overlays.length; i++){
            map.removeOverlay(overlays[i]);
        }
        overlays.length = 0
    }

    // #####################
    // 3. 地图和热力图重绘函数
    // #####################

    //根据可视区域展示总人数，返回热力图最大值
    function countCurrent(map){
        var total = 0;
        var number = 0;
        var max = 0;
        var onhand = 0;
        var boundary = map.getBounds();
        for (var point in points){
            var longit = parseFloat(points[point].lng);
            var latit = parseFloat(points[point].lat);
            var temp = new BMap.Point(longit,latit);
            if (boundary.containsPoint(temp)){
                var curr = parseInt(points[point].count);
                total = total + curr;
                if (curr > max){
                    max = curr;
                }
                number = number + 1;
            }
        }
        document.getElementById("total").innerHTML = total;
        document.getElementById("number").innerHTML = number;
        document.getElementById("max").innerHTML = max;
        return (max+total/number)/2.5;
    }

    function countRegion(map, bounds){
      var total = 0;
      var number = 0;
      var max = 0;
      var onhand = 0;
      var boundary = bounds;
      for (var point in points){
          var longit = parseFloat(points[point].lng);
          var latit = parseFloat(points[point].lat);
          var temp = new BMap.Point(longit,latit);
          if (boundary.containsPoint(temp)){
              var curr = parseInt(points[point].count);
              total = total + curr;
              if (curr > max){
                  max = curr;
              }
              number = number + 1;
          }
      }
      document.getElementById("total2").innerHTML = total;
      document.getElementById("number2").innerHTML = number;
      document.getElementById("max2").innerHTML = max;
    }

    // 地图选区重绘函数
    function changeMapPos(point,zoom,radius,scale){
        map.removeOverlay(heatmapOverlay);
        map.centerAndZoom(point, zoom);
        heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":radius});
        map.addOverlay(heatmapOverlay);
        map.enableDragging();
        heatmapOverlay.setDataSet({data:points,max:scale});
    }

    function changeCenter(point,level){
        changeMapPos(point,level,280,3000);
        var max = countCurrent(map);
        redrawByZoomLevel(map,max);
    }

    // 根据缩放大小重绘热力图
    function redrawByZoomLevel(map,curmax){
        var zoomLevel = map.getZoom();
        var center = map.getCenter;
        if (zoomLevel == 10){
            map.removeOverlay(heatmapOverlay);
            heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":10});
            map.addOverlay(heatmapOverlay);
            heatmapOverlay.setDataSet({data:points,max:curmax});
        }
        else if (zoomLevel == 11){
            map.removeOverlay(heatmapOverlay);
            heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":12});
            map.addOverlay(heatmapOverlay);
            heatmapOverlay.setDataSet({data:points,max:curmax});
        }
        else if (zoomLevel == 12){
            map.removeOverlay(heatmapOverlay);
            heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":20});
            map.addOverlay(heatmapOverlay);
            heatmapOverlay.setDataSet({data:points,max:curmax});
        }
        else if (zoomLevel == 13){
            map.removeOverlay(heatmapOverlay);
            heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":40});
            map.addOverlay(heatmapOverlay);
            heatmapOverlay.setDataSet({data:points,max:curmax});
        }
        else if (zoomLevel == 14){
            map.removeOverlay(heatmapOverlay);
            heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":70});
            map.addOverlay(heatmapOverlay);
            heatmapOverlay.setDataSet({data:points,max:curmax});
        }
        else if (zoomLevel == 15){
            map.removeOverlay(heatmapOverlay);
            heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":110});
            map.addOverlay(heatmapOverlay);
            heatmapOverlay.setDataSet({data:points,max:curmax});
        }
        else if (zoomLevel == 16){
            map.removeOverlay(heatmapOverlay);
            heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":160});
            map.addOverlay(heatmapOverlay);
            heatmapOverlay.setDataSet({data:points,max:curmax});
        }
        else if (zoomLevel >= 17){
            map.removeOverlay(heatmapOverlay);
            heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":240});
            map.addOverlay(heatmapOverlay);
            heatmapOverlay.setDataSet({data:points,max:curmax});
        }
    }

    // ##########
    // 4. 地图事件
    // ##########

    // 拖拽时重绘地图
    map.addEventListener("dragend",function(evt){
        var div1=document.getElementById("div1");
        if (div1.className=="open1"){
            var max = countCurrent(map);
            redrawByZoomLevel(map,max);
        } else {
            alert(evt.point.lng + "," + evt.point.lat);
        }
    });

    //选区下拉框
    function showDrop(){
        var x = document.getElementById('maindrop');
        var y = document.getElementById('mainAreas');
        if (x.style.display === 'none'){
            x.style.display = 'block';
            if (y.style.display === 'block'){
                showAreas();
            }
        } else {
            x.style.display = 'none';
        }
    }
    
    function showAreas(){
        var x = document.getElementById('mainAreas');
        var y = document.getElementById('maindrop');
        if (x.style.display === 'none'){
            x.style.display = 'block';
            if (y.style.display === 'block'){
                showDrop();
            }
        } else {
            x.style.display = 'none';
        }
    }
    
    function showMain(){
        var x = document.getElementById('mainChoices');
        var y = document.getElementById('maindrop');
        var z = document.getElementById('mainAreas');
        if (x.style.display === 'none'){
            x.style.display = 'block';
        } else {
            x.style.display = 'none';
            if (y.style.display === 'block'){
            	showDrop();
            }
            if (z.style.display === 'block'){
                showAreas();
            }
        }
    }

    //鼠标滚轮缩放
    var scrollFunc = function (e) {
        if (e.wheelDelta) {  //判断浏览器IE，谷歌滑轮事件
            if (e.wheelDelta > 0) { //当滑轮向上滚动时
                map.zoomIn();
                var max = countCurrent(map);
                redrawByZoomLevel(map,max);
            }
            if (e.wheelDelta < 0) { //当滑轮向下滚动时
                map.zoomOut();
                var max = countCurrent(map);
                redrawByZoomLevel(map,max);
            }
        }
    }
    //滚动滑轮触发scrollFunc方法  //ie 谷歌
    window.onmousewheel = scrollFunc;

    window.onload=function(){
        var div2=document.getElementById("div2");
        var div1=document.getElementById("div1");
        var div3=document.getElementById("div3");
        var div4=document.getElementById("div4");
        div2.onclick=function(){
            if (div1.className=="close1"){
                div1.className="open1";
                div2.className="open2";
                map.enableDragging();
                drawingManager.close();
            } else {
                div1.className="close1";
                div2.className="close2";
                map.disableDragging();
                drawingManager.open();
            }
        }
        div4.onclick=function(){
            if (div3.className =="close1"){
                div3.className="open1";
                div4.className="open2";
            } else {
                div3.className="close1";
                div4.className="close2";
                map.disableDragging();
                drawingManager.open();
            }
        }
    }

    function getBoundary(k){
        var bdary = new BMap.Boundary();
        removeRegion(layers);
        bdary.get(k, function(rs){       //获取行政区域
            var count = rs.boundaries.length; //行政区域的点有多少个
            if (count === 0) {
                alert('未能获取当前输入行政区域');
                return ;
            }
            var pointArray = [];
            var total = 0;
            var number = 0;
            var max = 0;
            var onhand = 0;
            for (var i = 0; i < count; i++) {
                var ply = new BMap.Polygon(rs.boundaries[i], {strokeWeight: 2, strokeColor: "#ff0000"}); //建立多边形覆盖物
                map.addOverlay(ply);  //添加覆盖物
                layers.push(ply);
                pointArray = pointArray.concat(ply.getPath());
                for (var point in points){
                    var longit = parseFloat(points[point].lng);
                    var latit = parseFloat(points[point].lat);
                    var temp = new BMap.Point(longit,latit);
                    if (BMapLib.GeoUtils.isPointInPolygon(temp,ply)){
                        var curr = parseInt(points[point].count);
                        total = total + curr;
                        if (curr > max){
                            max = curr;
                        }
                        number = number + 1;
                    }
                }
            }
            map.setViewport(pointArray);
            document.getElementById("total2").innerHTML = total;
            document.getElementById("number2").innerHTML = number;
            document.getElementById("max2").innerHTML = max;
        });
        return layers[0];
    }
    function removeRegion(layers){
        for (var i = 0; i < layers.length; i++){
            map.removeOverlay(layers.shift());
        }
    }

    showDrop();
    showMain();
    showAreas();
    
    document.onkeydown = checkKey;
    function checkKey(e){
    	e = e || window.event;
        var div2=document.getElementById("div2");
        var div1=document.getElementById("div1");
    	if (e.keyCode == "16"){
    		if (div1.className=="close1"){
                div1.className="open1";
                div2.className="open2";
                map.enableDragging();
                drawingManager.close();
            } else {
                div1.className="close1";
                div2.className="close2";
                map.disableDragging();
                drawingManager.open();
            }
    	}
    }


</script>
