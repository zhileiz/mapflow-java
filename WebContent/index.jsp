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
    document.getElementById("clickChange1").onclick = function(){
    	changeMapPos1();
    }
    document.getElementById("clickChange2").onclick = function(){
        changeMapPos2();
    }
    document.getElementById("clickChange3").onclick = function(){
        changeMapPos3();
    }
    document.getElementById("clickChange4").onclick = function(){
        changeMapPos4();
    }
    function changeMapPos1(){
        map.removeOverlay(heatmapOverlay);
        var point = new BMap.Point(121.673121,31.14944);
        map.centerAndZoom(point, 16);
        heatmapOverlayk = new BMapLib.HeatmapOverlay({"radius":100});
        map.addOverlay(heatmapOverlayk);
        map.enableDragging();
        heatmapOverlayk.setDataSet({data:points,max:800});
    }
    function changeMapPos2(){
        map.removeOverlay(heatmapOverlay);
        var point = new BMap.Point(121.483329,31.235889);
        map.centerAndZoom(point, 17);
        heatmapOverlayk = new BMapLib.HeatmapOverlay({"radius":100});
        map.addOverlay(heatmapOverlayk);
        map.enableDragging();
        heatmapOverlayk.setDataSet({data:points,max:8000});
    }
    function changeMapPos3(){
        map.removeOverlay(heatmapOverlay);
        var point = new BMap.Point(121.817487,31.15766);
        map.centerAndZoom(point, 16);
        heatmapOverlayk = new BMapLib.HeatmapOverlay({"radius":100});
        map.addOverlay(heatmapOverlayk);
        map.enableDragging();
        heatmapOverlayk.setDataSet({data:points,max:3000});
    }
    function changeMapPos4(){
        map.removeOverlay(heatmapOverlay);
        var point = new BMap.Point(121.424581,31.225596);
        map.centerAndZoom(point, 16);
        heatmapOverlayk = new BMapLib.HeatmapOverlay({"radius":100});
        map.addOverlay(heatmapOverlayk);
        map.enableDragging();
        heatmapOverlayk.setDataSet({data:points,max:8000});
    }

    var map = new BMap.Map("container");          // 创建地图实例
    var point = new BMap.Point(121.9, 31.16);
    map.centerAndZoom(point, 11);             // 初始化地图，设置中心点坐标和地图级别
    map.disableScrollWheelZoom();

    var points =[
      <%
      String[] output = null;
      int max =0;
      for(String s : result){
        output = s.split(",");
        if(Integer.parseInt(output[3])>max){
            max = Integer.parseInt(output[3]);
        }
        System.out.println("unchanged longitude: " + output[1]);
        System.out.println("unchanged latitude: " + output[2]);
        Double[] coordinates = transform.transform(Double.parseDouble(output[2]), Double.parseDouble(output[1]));
        System.out.println("baidu longitude: " + coordinates[0]);
        System.out.println("baidu latitude: " + coordinates[1]);
        out.println("{\"lng\":\""+coordinates[0]+"\",\"lat\":\""+coordinates[1]+"\",\"count\":\""+output[3]+"\"},");
      }
      %>
    ];

    if(!isSupportCanvas()){
        alert('热力图目前只支持有canvas支持的浏览器,您所使用的浏览器不能使用热力图功能~')
    }
    //详细的参数,可以查看heatmap.js的文档 https://github.com/pa7/heatmap.js/blob/master/README.md
    //参数说明如下:
    /* visible 热力图是否显示,默认为true
     * opacity 热力的透明度,1-100
     * radius 势力图的每个点的半径大小
     * gradient  {JSON} 热力图的渐变区间 . gradient如下所示
     *  {
            .2:'rgb(0, 255, 255)',
            .5:'rgb(0, 110, 255)',
            .8:'rgb(100, 0, 255)'
        }
        其中 key 表示插值的位置, 0~1.
            value 为颜色值.
     */
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

    var sel = document.getElementById('stylelist');
    for(var key in mapstyles){
        var style = mapstyles[key];
        var item = new  Option(style.title,key);
        sel.options.add(item);
    }
  changeMapStyle('midnight')
  sel.value = 'midnight';

  function changeMapStyle(style){
      map.setMapStyle({style:style});
      if(style=='grayscale'){
        map.removeOverlay(heatmapOverlay);
        var point = new BMap.Point(121.673121,31.14944);
        map.centerAndZoom(point, 16);
        heatmapOverlayk = new BMapLib.HeatmapOverlay({"radius":100,'gradient': {'0.001':'#08FFFC','0.01':'#96FF6B','0.1':'#FFFC00','0.3':'#FD9A00','0.5':'#FC5B00','0.95':'#F80000'}});
        map.addOverlay(heatmapOverlayk);
        map.enableDragging();
        heatmapOverlayk.setDataSet({data:points,max:800});
      }
      $('#desc').html(mapstyles[style].desc);
  }
  
  function changeMapPos(){
	  map.removeOverlay(heatmapOverlay);
      var point = new BMap.Point(121.673121,31.14944);
      map.centerAndZoom(point, 16);
      heatmapOverlayk = new BMapLib.HeatmapOverlay({"radius":100});
      map.addOverlay(heatmapOverlayk);
      map.enableDragging();
      heatmapOverlayk.setDataSet({data:points,max:800});
  }

    //判断浏览区是否支持canvas
    function isSupportCanvas(){
        var elem = document.createElement('canvas');
        return !!(elem.getContext && elem.getContext('2d'));
    }
</script>
