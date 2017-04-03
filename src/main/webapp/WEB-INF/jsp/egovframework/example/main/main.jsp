<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<script type="text/javascript" src="jqGrid-master/jquery.js"></script>  

<script type="text/javascript">
   function pageSubmitFn(pageName) {
      
      if(pageName == "jqgridStart") {
         
         $("#frm").attr("action", "jqgridStart.do");   
      } else if(pageName == "jqgridIUD") {
         
         $("#frm").attr("action", "jqgridIUD.do");   
      } else if(pageName == "jqgridM") {
          
          $("#frm").attr("action", "jqgridM.do");   
      } else if(pageName == "jqgridGroupReport") {
          
          $("#frm").attr("action", "jqgridGroupReport.do");   
      }
      
      $("#frm").submit();
   }
</script>
</head>
<body>
<form id="frm" name="frm">
   
</form>
<div>
    <ul>
        <li>
           <a href="#" onclick="javascript:pageSubmitFn('jqgridStart')">jqgridStart</a>
        </li>
        <li>
           <a href="#" onclick="javascript:pageSubmitFn('jqgridIUD')">jqgridUID</a>
        </li>
        <li>
           <a href="#" onclick="javascript:pageSubmitFn('jqgridM')">jqgridM</a>
        </li>
        <li>
           <a href="#" onclick="javascript:pageSubmitFn('jqgridGroupReport')">jqgridGroupReport</a>
        </li>
    </ul>
</div>
</body>
</html>