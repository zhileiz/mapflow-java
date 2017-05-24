<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    import="java.util.List,com.shunicom.visualize.*,java.util.ArrayList,java.util.Map"
    pageEncoding="UTF-8"%>

<html>

<% List<String> result = new processCSV().generate("/home/zhileiz/heatmap.csv"); %>

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6254YFdX7nkww3tFT0YLR3ie6nC60kv8"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
    <script type="text/javascript" src="http://developer.baidu.com/map/custom/stylelist.js"></script>
    <script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
    <title>热力图功能示例</title>
    <style type="text/css">
      ul,li{list-style: none;margin:0;padding:0;float:left;}
      html{height:107%;overflow:hidden;}
      body{min-height:100%;overflow:hidden;font-family:"微软雅黑";margin-left:0px;margin-top:0px;margin-right:0px;}
      #container{height:100%;width:100%;}
      #r-result{width:100%;}
      #menu{border-radius:20px;margin:5%;}
    </style>
  </head>

  <body>
    <div style="position:absolute;color:black;z-index:90;">
      <div class="row justify-content-end" style="border:10%;">
         <div class="col-12" id="menu" style="font-size:30px;">
              <div id="clickChange1">迪士尼</div>
              <div id="clickChange2">人民广场</div>
              <div id="clickChange3">浦东机场</div>
              <div id="clickChange4">中山公园</div>
         </div>
      </div>
    </div>
    <div id="container" style="position:relative;z-index:20;"></div>
  </body>

</html>

<script type="text/javascript">

    // 地图选区操作
    document.getElementById("clickChange1").onclick = function(){
      var point = new BMap.Point(121.673121,31.14944);
        changeMapPos(point,17,150,800);
    }
    document.getElementById("clickChange2").onclick = function(){
      var point = new BMap.Point(121.483329,31.235889);
        changeMapPos(point,17,150,5000);
    }
    document.getElementById("clickChange3").onclick = function(){
      var point = new BMap.Point(121.817487,31.15766);
        changeMapPos(point,16,150,3000);
    }
    document.getElementById("clickChange4").onclick = function(){
      var point = new BMap.Point(121.424581,31.225596);
        changeMapPos(point,17,150,5000);
    }

    // 地图选区重绘函数
    function changeMapPos(point,zoom,radius,scale){
        map.removeOverlay(heatmapOverlay);
        map.centerAndZoom(point, zoom);
        heatmapOverlayk = new BMapLib.HeatmapOverlay({"radius":radius});
        map.addOverlay(heatmapOverlayk);
        map.enableDragging();
        heatmapOverlayk.setDataSet({data:points,max:scale});
    }

    //初始化地图
    var map = new BMap.Map("container");
    var point = new BMap.Point(121.9, 31.16);
    map.centerAndZoom(point, 11);
    map.disableScrollWheelZoom();

    //地图点JAVA脚本
    var points =[
      <%
      String[] output = null;
      int max =0;
      for(String s : result){
        output = s.split(",");
        if(Integer.parseInt(output[3])>max){
            max = Integer.parseInt(output[3]);
        }
        Double[] coordinates = transform.transform(Double.parseDouble(output[2]), Double.parseDouble(output[1]));
        out.println("{\"lng\":\""+coordinates[0]+"\",\"lat\":\""+coordinates[1]+"\",\"count\":\""+output[3]+"\"},");
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
    heatmapOverlay.setDataSet({data:points,max:3000});
    function setGradient(){
        var gradient = {};
        var colors = document.querySelectorAll("input[type='color']");
        colors = [].slice.call(colors,0);
        colors.forEach(function(ele){
            gradient[ele.getAttribute("data-key")] = ele.value;
        });
        heatmapOverlay.setOptions({"gradient":gradient});
    }

    //判断浏览区是否支持canvas
    function isSupportCanvas(){
        var elem = document.createElement('canvas');
        return !!(elem.getContext && elem.getContext('2d'));
    }
</script>
