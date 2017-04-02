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
	
	<link rel="stylesheet" type="text/css" href="jqGrid-master/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="jqGrid-master/css/ui.jqgrid.css" />
	<!-- <link rel="stylesheet" type="text/css" href="jqGrid-master/css/addons/ui.multiselect.css" /> -->
	
	<script type="text/javascript" src="jqGrid-master/jquery.js"></script>  
	<script type="text/javascript" src="jqGrid-master/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="jqGrid-master/js/jquery.jqGrid.min.js"></script>

    <title>Hanq</title>
</head>

<script type="text/javascript">
$(document).ready(function() {

	var cnames = ['아이디','이름','전화번호','주소','기타','성별코드'];

    $("#jqGrid").jqGrid({
    
        url: "jqgridStartMain2.do",
        datatype: "local",
        colNames: cnames,
        colModel:[
			      {name:'seq',index:'seq', width:55, key:true, align:"center"},  //name은 화면에서 사용, index가 쿼리로 가져온 컬럼의 명과 일치 해야한다.
			      {name:'name',index:'name', width:100, align:"center"},
			      {name:'phone',index:'phone', width:100},
			      {name:'address',index:'address', width:100},
			      {name:'etcc',index:'etcc', width:100},
			      {name:'gender',index:'gender',     width:100}
				 ],
		         height: 480,
		         rowNum: 10,
		         rowList: [10,20,30],
		         pager: '#jqGridPager', //페이징을 넣을 위치 id
		         rownumbers  : true,    //맨 앞에 번호
			     ondblClickRow : function(rowId, iRow, iCol, e) {  //더블클릭 이벤트로우id(삭제시 인덱스와 달라짐), 클릭한 로우인덱스, 컬럼인덱스, 익셉션
					 if(iCol == 1) {
				          alert(rowId+" 째줄 입니다.");
				     }
			     },
			     multiselect: true,
			     viewrecords : true,		//우측 하단에 한글설명
			     caption:"실습용 테이블"
	});
});

function goSearch(){
	var jsonObj = {};
	
	if($("#selectId").val() != "C"){
		jsonObj.serviceImplYn = $("#selectId").val();
	}
	
	$("#jqGrid").setGridParam({
		datatype : "json",
		postData : {"param" : JSON.stringify(jsonObj)},
		loadComplete : function(data){
			
		},
		
		gridComplete : function() {
			
		}
	}).trigger("reloadGrid");   //조회 후 그리드 리로드  Jquery.jqGrid 7728
}
</script>
<body>
<div class="row">
	<div>
		<select id="selectId">
			<option value="">전체</option>
			<option value="A">임플A</option>
			<option value="B">임플B</option>
			<option value="C">임플C</option>
			<option value="D">임플D</option>
		</select>
		<span><a href="#" onclick="javascript:goSearch();">조회</a></span> 
	</div>
	<div>
		<table id="jqGrid"></table>
		<div id="jqGridPager"></div>
	</div>
</div>
</body>
</html>