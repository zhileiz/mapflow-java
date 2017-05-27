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
    <script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
    <script src="https://use.fontawesome.com/d94b0d3b0f.js"></script>
    <!--加载鼠标绘制工具-->
    <script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
    <!--加载检索信息窗口-->
    <script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.css" />
    <title>热力图功能示例</title>
    <style type="text/css">
      ul,li{list-style: none;margin:0;padding:0;float:left;}
      html{height:107%;overflow:hidden;background-color:black;}
      body{min-height:100%;overflow:hidden;font-family:"微软雅黑";margin-left:0px;margin-top:0px;margin-right:0px;background-color:black;}
      #container{height:100%;width:100%;}
      #r-result{width:100%;}
      #menu{border-radius:20px;margin:5%;}
      .choosePos{height:120px;width:120px;z-index:2;background-color:white;margin:3% 5%;margin-left:90px;border-radius:50%;color:black;text-align:center;position:absolute;}
      .chooseDrop{min-height:400px;width:100px;text-align:center;border-radius:50px;z-index:1;background-color:yellow;margin:100px;margin-top:4%;position:absolute;display:block;color:black;font-size:16px;}
      .fa-map-marker{margin-top:12%;}
      .dropdownitem{padding:4px;margin:3px;border-bottom:2px solid black;}
      #switch{
      text-align:center;
      }
#div1{
        width: 100px;
        height: 60px;
        border-radius: 50px;
        position: relative;
    }
    #div2{
        width: 56px;
        height: 56px;
        border-radius: 50%;
        position: absolute;
        background: white;
        box-shadow: 0px 2px 4px rgba(0,0,0,0.4);
    }
    .open1{
        background: rgba(0,184,0,0.8);
    }
    .open2{
        top: 2px;
        right: 1px;
    }
    .close1{
        background: rgba(255,255,255,0.4);
        border:3px solid rgba(0,0,0,0.15);
        border-left: transparent;
    }
    .close2{
        left: 0px;
        top: 0px;
        border:2px solid rgba(0,0,0,0.1);
    }
      
      .infobox{min-height:30px;width:20%;z-index:2;margin-left:70%;border-radius:50px;font-size:18px;text-align:center;margin-top:4%;background-color:white;display:block;position:absolute;}
    </style>
  </head>

  <body>
        <div class="choosePos" onclick="showDrop()">
            <i class="fa fa-map-marker fa-5x"></i>
        </div>
        <div class="chooseDrop" id="maindrop">
            <div style="margin-top:120px;">
              <div id="clickAllCity" class="dropdownitem">全市</div>
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
    <div class="infobox">当前区域总人数：<span id="total"></span><br/>栅格数：<span id="number"></span><br/>最大值：<span id="max"></span>
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
    <div id="container" style="position:relative;"></div>
  </body>

</html>

<script type="text/javascript">

    // ################
    // 1. 控件和操作类函数
    // ################

    // 地图选区操作
    document.getElementById("clickAllCity").onclick = function(){
      var point = new BMap.Point(121.7, 31.16);
      changeCenter(point,11);
    }
    document.getElementById("clickHuangpu").onclick = function(){
        var point = new BMap.Point(121.491193,31.237373);
        changeCenter(point,14);
      }
    document.getElementById("clickXuhui").onclick = function(){
        var point = new BMap.Point(121.442944,31.194955);
        changeCenter(point,14);
      }
    document.getElementById("clickChangning").onclick = function(){
        var point = new BMap.Point(121.430876,31.226667);
        changeCenter(point,14);
      }
    document.getElementById("clickJingan").onclick = function(){
        var point = new BMap.Point(121.453645,31.233922);
        changeCenter(point,14);
      }
    document.getElementById("clickPutuo").onclick = function(){
        var point = new BMap.Point(121.402315,31.255424);
        changeCenter(point,14);
      }
    document.getElementById("clickHongkou").onclick = function(){
        var point = new BMap.Point(121.511686,31.27019);
        changeCenter(point,14);
      }
    document.getElementById("clickYangpu").onclick = function(){
        var point = new BMap.Point(121.531523,31.265499);
        changeCenter(point,14);
      }
    document.getElementById("clickMinhang").onclick = function(){
        var point = new BMap.Point(121.388372,31.118512);
        changeCenter(point,14);
      }
    document.getElementById("clickBaoshan").onclick = function(){
        var point = new BMap.Point(121.388372,31.118512);
        changeCenter(point,14);
      }
    document.getElementById("clickJiading").onclick = function(){
        var point = new BMap.Point(121.272237,31.381373);
        changeCenter(point,14);
      }
    document.getElementById("clickPudong").onclick = function(){
        var point = new BMap.Point(121.550499,31.227373);
        changeCenter(point,14);
      }
    document.getElementById("clickJinshan").onclick = function(){
        var point = new BMap.Point(121.348902,30.747995);
        changeCenter(point,14);
      }
    document.getElementById("clickSongjiang").onclick = function(){
        var point = new BMap.Point(121.235472,31.038175);
        changeCenter(point,14);
      }
    document.getElementById("clickQingpu").onclick = function(){
        var point = new BMap.Point(121.130559,31.156444);
        changeCenter(point,14);
      }
    document.getElementById("clickFengxian").onclick = function(){
        var point = new BMap.Point(121.48054,30.923915);
        changeCenter(point,14);
      }
    document.getElementById("clickChongming").onclick = function(){
        var point = new BMap.Point(121.403767,31.628513);
        changeCenter(point,14);
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
    var points =[
      <%
      for(String s : result){
        out.println(s);
      }
      %>
    ];

    //查看是否支持热力图
    if(!isSupportCanvas()){
        alert('热力图目前只支持有canvas支持的浏览器,您所使用的浏览器不能使用热力图功能~')
    }

    //初始化热力图
    heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":12});
    map.addOverlay(heatmapOverlay);
    var max = countCurrent(map);
    redrawByZoomLevel(map,max);

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
        var path = e.overlay.getPath();//Array<Point> 返回多边型的点数组
        var pointSW = new BMap.Point(path[3].lng,path[3].lat);
        var pointNE = new BMap.Point(path[1].lng,path[1].lat);
        var bound = new BMap.Bounds(pointSW,pointNE);
        var center = bound.getCenter();
        map.panTo(center, false);
        while (map.getBounds().containsBounds(bound)){
            map.zoomIn();
        }
        var max = countCurrent(map);
        redrawByZoomLevel(map,max);
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
    	if (x.style.display === 'none'){
    		x.style.display = 'block';
    	} else {
    		x.style.display = 'none';
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
    }
    
    
    showDrop();

</script>