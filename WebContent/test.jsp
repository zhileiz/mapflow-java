<%@ page language="java" contentType="text/html; charset=UTF-8" 
import="java.util.List,com.shunicom.visualize.processCSV"
    pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="./js/jquery.min.js"></script>
    <title>热力图功能示例</title>
<script type="text/javascript">
//[{\"lng\":123.123,\"lat\":456.456,\"count\":12},{\"lng\":123.123,\"lat\":456.456,\"count\":12}]
	 $.ajax({
	  url:"http://localhost:8080/visualize/ServicesServlet",
	  type:"post",
	  async:true,
	  dataType:"json",
	  success:function(data){
		$.each(data,function(i,item){
			document.write(item.lng);
		})
	  }
	 });

</script>

</head>
<body>
</body>
</html>
