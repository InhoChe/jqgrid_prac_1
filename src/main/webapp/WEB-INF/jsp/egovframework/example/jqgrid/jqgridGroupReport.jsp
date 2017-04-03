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

/******************************************
 * 화면 초기 로드시
 ******************************************/
$(document).ready(function() {	
	
	var selData = ${brandCombo};
	
	$.jgrid.defaults.width = 780;
	
	// 브랜드 그리드
	jqgridBrand.init();
	
	// 상품 그리드
	jqgridPrd.init(selData);
});

/******************************************
 * jsUtils
 ******************************************/
var commonJsUtil = 
{
	//널이나 빈값 undefined이면 true반환
    isEmpty : function(val){
    	
        if(null == val || null === val || "" == val || val == undefined || typeof(val) == undefined || "undefined" == val || "NaN" == val) {
        	
            return true;
        } else {
        	
            return false;
        }
    },
  	//영문숫자 체크
    isAlphaNumeric : function(val) {
       
       if (/[^a-zA-Z0-9]/.test(val)) {
        
          return false;
        } else {
            
           return true;
        }
    },
	isNumeric : function(val) {
    	
    	if (/[^0-9]/.test(val)) {
    		
            return false;
        } else {
        	
            return true;
        }
    }
}

/******************************************
 * jqgrid - 브랜드
 ******************************************/
var jqgridBrand = 
{
	init : function() {
		
		// 헤더
		var cnames = ['브랜드','브랜드명','순서','등록날자','등록자','행취소','행구분'];
	
       	jQuery("#gridList").jqGrid({
       		
       	   	url:'brandList.do',
       		datatype: "local",
       	   	colNames: cnames,
       	   	colModel:[
       	   		{name:'brandCd',    index:'brandCd', 		width:55, 	align:"center"},
       	   		{name:'brandNm',	index:'brandNm', 		width:100, 	align:"center"},
       	   		{name:'sortNo',		index:'sortNo', 		width:100, 	editable:true},
       	   		{name:'insDate',	index:'insDate', 		width:100},
       	   		{name:'insId',		index:'insId', 			width:100},
       	   		{name:'btn2',		index:'btn2', 			width:100, 	formatter:gridFunc.rowBtn},
       	   		{name:'editType', width:0, hidden:true}
       	   		
       	   	],
       	   	height: 	300,
       	   	rowNum:		10,
       	   	rowList:	[10,20,30],
       	   	regional: 	'kr',
       	   	pager: 		'#pager',
       	   	cellEdit: 	true,
       	   	cellurl: 	'saveBrand.do',
       	   	beforeSubmitCell:function(rowId, cellName, value) {    
       	   	var brandCd = (cellName=='brandCd') ? value : $("#gridList").getCell(rowId,'brandCd');
            var brandNm = (cellName=='brandNm') ? value : $("#gridList").getCell(rowId,'brandNm');
            var sortNo = (cellName=='sortNo') ? value : $("#gridList").getCell(rowId,'sortNo');
           
              var editType = $("#gridList").getCell(rowId,'editType');
              
              if(editType != "I") {
                 
                 editType = "U";
              
                 var jsonArray = [{"brandCd":brandCd, "brandNm":brandNm, "sortNo":sortNo, "editType" : editType}];
                 
                 return {"param1" : JSON.stringify(jsonArray)};
              }
       	   	},
       	   	
       	 	onCellSelect : function(rowId, colId, val, e) {
       	 	var brandCd = $("#gridList").getCell(rowId, 'brandCd');
            
            var editType = $("#gridList").getCell(rowId,'editType');
              
              if(editType != "I") {
                 //alert('U');
                 $('#gridList').setColProp('brandCd',{editable:false});
                 $('#gridList').setColProp('brandNm',{editable:false});
              }else{
                 //alert('I');
                 $('#gridList').setColProp('brandCd',{editable:true});
                 $('#gridList').setColProp('brandNm',{editable:true});
              }
       	 	}, 
       	 	ondblClickRow : function(rowId, iRow, iCol, e) {
       	 		
       	 		var brandCd = $("#gridList").getCell(rowId, 'brandCd');
       	 		// 첫 row를 더블 클릭 시
       	 		if(iCol == 0){
       	 			jqgridPrd.goSearch(brandCd);
       	 		}
       	 	},       	 	
       	    sortorder: "desc",
       	 	viewrecords : true,
       	    caption:"브랜드 정보 테이블"
       	});
	},
	
	goSearch : function() {
		
		var jsonObj = {};

			jsonObj.brandCd = $("#cbBrandList").val();
				
		$("#gridList").setGridParam({

	        datatype : "json",
	        postData : {"param" : JSON.stringify(jsonObj)},
	        loadComplete: function(data){
	        	
	        	$.each(data, function (i, item) { 

					if(i == "rows") {	
						
						if(item < 1) {							
				
							alert("데이터가 없습니다.");
						}
					}
	        	});
            },
	    }).trigger("reloadGrid");
	},
	
	saveRow : function() {
		
		var trObj = $("#gridList").find("tr");
		var iCnt = 0;
		var jsonArray1 = new Array();
		
		for (var i = 0; i < trObj.length; i++) {
			
			var that = $(trObj[i]);

			if(that.hasClass("edited")){
				
				var rowId = that.prop("id");
				var jsonObj = {};				
				
				var brandCd = $("#gridList").getCell(rowId, "brandCd");
				var editType = $("#gridList").getCell(rowId,'editType');
	       	   	
	       	   	if(editType != "I") {
	       	   		
	       	   		editType = "U";
	       	   	} else {
	       	   		
	       	   		editType = "I";
	       	   	}
	       	   	
				jsonObj.editType 	= editType;
				jsonObj.brandCd 	= brandCd;
				
				
				jsonObj.brandNm 		= $("#gridList").getCell(rowId, "brandNm");  
				jsonObj.sortNo 			= $("#gridList").getCell(rowId, "sortNo");
				jsonObj.insId 	    	= 'hanq'; //로그인후 세션에 가져오는 id값
				
				jsonArray1[iCnt] = jsonObj;

				iCnt++;
			}
		}
		 
		if(iCnt < 1) {
		
			alert('변경된 데이타가 없습니다.'); 
			
			return false;
		}
		
		if(!this.gridValid()) return false;
		
		var param1 = JSON.stringify(jsonArray1);
		
		$.ajax({
			
	        type       : "POST",
	        url        : "saveBrand.do",
	        data       : {"param1":param1},
	        async      : false,
	        success    : function(result) {
	        	
	        	if (result == "SUCCESS") {
	        		
	        		jqgrid.goSearch();	
	            }
	        },
	        error      : function() {
	        	
	        	alert("브랜드 저장시 Error 발생");
	        }
	    }); 
	},
	
	//저장 전 체크
	gridValid : function() {
				
		var trObj = $("#gridList").find("tr");
		
		for (var i = 0; i < trObj.length; i++) {
 		   	
			var that = $(trObj[i]);
 	    	
 	    	if(that.hasClass("edited")) {
 	    		
 	    		var rowId = that.prop("id");
 	    		
 	    		var brandCd = $("#gridList").getCell(rowId, "brandCd");
 	    		var brandNm = $("#gridList").getCell(rowId, "brandNm");    
 	    		var sortNo = $("#gridList").getCell(rowId, "sortNo"); 
 	    		
 	    		if(commonJsUtil.isEmpty(brandCd)){
 	    			
 	    			alert(rowId + "째 행 브랜드코드는 필수값입니다.");
 	    			
 	    			return false;
 	    			
 	    			break;
 	    		}
 	    		
				if(commonJsUtil.isEmpty(brandNm)){
 	    			
 	    			alert(rowId + "째 행 브랜드명은 필수값입니다.");
 	    			
 	    			return false;
 	    			
 	    			break;
 	    		}
 	    		
				if(!commonJsUtil.isAlphaNumeric(brandCd)){
						
					alert(rowId + "째 행 브랜드코드는 숫자 영문만 입력가능합니다.");
					
					return false;
					
					break;
				}
 	    	}
 	    }
		
		return true;
	}
}

/******************************************
 * 그리드 관련 메소드
 ******************************************/
var gridFunc = 
{			

	addRow : function() {

		var totCnt = $("#gridList").getGridParam("records");

		var addData = {"brandCd":"" ,"brandNm":"" ,"sortNo":"", "insDtm":"", "insId":"", "editType":"I"};

		if(totCnt == null) {

			totCnt = 0;
		}

		$("#gridList").addRowData(totCnt + 1, addData);

		$("#gridList").setColProp("brandCd", {editable:true});
		$("#gridList").setColProp("brandNm", {editable:true});
	},

	clearGrid : function() {
		
		$("#gridList").clearGridData();
	},	

	rowBtn : function(cellvalue, options, rowObject) {
		
		if(rowObject.brandCd == "" || rowObject.brandCd == undefined){
			
			return '<a href="javascript:gridFunc.delRow('+options.rowId+');"> 행삭제 </a>';			
		} else {
			
			return "";
		}
	},
	
	delRow : function(rowid) {
		
		if(rowid != "") {
			
		 	$("#gridList").delRowData(rowid);
		}
	}
} 

var jqgridPrd = 
{
	init : function(selData) {

		var cnames = ['상품코드','상품명','브랜드','등록날자','등록자','행취소','행구분'];
	
       	jQuery("#gridListPrd").jqGrid({
       		
       	   	url:'prdList.do',
       		datatype: "local",
       	   	colNames: cnames,
       	   	colModel:[
				{name:'prdCd',      index:'prdCd', 		width:55, 		align:"center"},
				{name:'prdNm',		index:'prdNm', 		width:100, 		align:"center"},
       	   		{name:'brandCd',    index:'brandCd', 	width:55, 		align:"center" , editable:true, edittype: "select", formatter:"select",
	       	   		editoptions: {
	                    value: selData
	                 }},
       	   		{name:'insDate',	index:'insDate', 	width:100},
       	   		{name:'insId',		index:'insId', 		width:100},       	   		
       	   		{name:'btn2',		index:'btn2', 		width:100, 		formatter:gridFunc2.rowBtn},
       	   		{name:'editType', width:0, hidden:true}
       	   	],
       	   	height: 300,
       	   	rowNum:10,
       	   	rowList:[10,20,30],
       	   	regional : 'kr',
       	   	pager: '#pager2',
       	   	cellEdit : true,
       	   	cellurl : 'savePrd.do',
       	   	beforeSubmitCell : function(rowId, cellName, value) {    

       	   	},
       	 	onCellSelect : function(rowId, colId, val, e) {

       	 	},      	 	
       	    sortorder: "desc",
       	 	viewrecords : true,
       	    caption:"상품 정보 테이블"
       	});
	},
	goSearch : function(brandCd) {

		var jsonObj = {};

		jsonObj.brandCd = brandCd;

		$("#gridListPrd").setGridParam({

		        datatype : "json",
		        postData : {"param" : JSON.stringify(jsonObj)},
		        loadComplete: function(data){//데이터 로드되고 나서
		        
		        $.each(data, function (i, item) { 

					if(i == "rows") {
			
						if(item < 1) {
				
							alert("데이터가 없습니다.");
						}
					}
		        });
		            },
		        gridComplete : function(){ //그리드 그리고 나서
		         
		        }
		    }).trigger("reloadGrid");  
	},
	//저장 
	saveRow : function() {
		
		var selRow = $("#gridListPrd").getGridParam("selrow");
		//$("#gridListPrd").resetSelection();

		var trObj = $("#gridListPrd").find("tr");
		var iCnt = 0;
		var jsonArray1 = new Array();
		
		for (var i = 0; i < trObj.length; i++) {
			
			var that = $(trObj[i]);

			if(that.hasClass("edited")){
				
				var rowId = that.prop("id");
				var jsonObj = {};				
				
				//var brandCd = $("#gridListPrd").getCell(rowId, "brandCd");
				var editType = $("#gridListPrd").getCell(rowId,'editType');
	       	   	
	       	   	if(editType != "I") {
	       	   		
	       	   		editType = "U";
	       	   	} else {
	       	   		
	       	   		editType = "I";
	       	   	}
	       	   	//editCell
	       	   	//gridFunc2.getCellValue
				jsonObj.editType 	= editType;
				// 에딧박스인 상태에서 저장 누르면 input 테그로 넘어가는 부분 고처야함
				//$("#gridListPrd").editCell(i, 0, false);
				//$("#gridListPrd").editCell(i, 1, false);
				//var rowData = $("#gridListPrd").getRowData(rowId);
				//jQuery("#gridListPrd").saveRow(rowId, false, "clientArray"); edit-cell ui-state-highlight
				var tdList = that.find("td");
				
				for(var j = 0; j < 2; j++){
					if($(tdList[j]).hasClass("edit-cell")){
						if(j == 0){
							jsonObj.prdCd = gridFunc2.getCellValue(rowId, "prdCd");
						}else if (j == 1){
							console.log("============>"+$(tdList[j]).prop("id"));
							jsonObj.prdNm = gridFunc2.getCellValue(rowId, "prdNm");
						}
					}else{
						if(j == 0){
							jsonObj.prdCd = $("#gridListPrd").getCell(rowId,"prdCd");
						}else if (j == 1){
							jsonObj.prdNm = $("#gridListPrd").getCell(rowId,"prdNm");
						}
					}
				}
				
				//jsonObj.prdCd 		= gridFunc2.getCellValue["prdCd"]; //$("#gridListPrd").getCell(rowId, "prdCd");
				//jsonObj.prdNm 		= rowData["prdNm"]; //$("#gridListPrd").getCell(rowId, "prdNm");  
				jsonObj.brandCd 	= $("#gridListPrd").getCell(rowId,"brandCd");  //$("#gridListPrd").getCell(rowId, "brandCd"); 
				
				jsonObj.insId 	    = 'hanq';
				
				jsonArray1[iCnt] = jsonObj;

				iCnt++;
			}
		}
		 
		if(iCnt < 1) {
		
			alert('변경된 데이타가 없습니다.'); 
			
			return false;
		}
		
		if(!this.gridValid()) return false;
		
		var param1 = JSON.stringify(jsonArray1);
		
		$.ajax({
			
	        type       : "POST",
	        url        : "savePrd.do",
	        data       : {"param1":param1},
	        async      : false,
	        success    : function(result) {
	        	
	        	if (result == "SUCCESS") {
	        		
	        		jqgridPrd.goSearch();	
	            }
	        },
	        error      : function() {
	        	
	        	alert("브랜드 저장시 Error 발생");
	        }
	    }); 
	},
	
	//저장 전 체크
	gridValid : function() {
				
		var trObj = $("#gridListPrd").find("tr");
		
		for (var i = 0; i < trObj.length; i++) {
 		   	
			var that = $(trObj[i]);
 	    	
 	    	if(that.hasClass("edited")) {
 	    		
 	    		var rowId = that.prop("id");
 	    		var prdCd = $("#gridListPrd").getCell(rowId, "prdCd");
 	    		var prdNm = $("#gridListPrd").getCell(rowId, "prdNm");    
 	    		var brandCd = $("#gridListPrd").getCell(rowId, "brandCd");
 	    		
				if(commonJsUtil.isEmpty(prdNm)){
 	    			
 	    			alert(rowId + "째 행 상품명은 필수값입니다.");
 	    			
 	    			return false;
 	    			
 	    			break;
 	    		}
 	    		
				if(!commonJsUtil.isAlphaNumeric(prdCd)){
						
					alert(rowId + "째 행 상품코드는 숫자 영문만 입력가능합니다.");
					
					return false;
					
					break;
				}
 	    	}	 		   
 	    }
		
		return true;
	}
}

/******************************************
 * 그리드 관련 메소드
 ******************************************/
var gridFunc2 = 
{			
	//행추가
	addRow : function() {
		
		var selrow = $("#gridList").getGridParam("selrow");
		console.log("===>" + selrow);
		if(selrow == null || selrow == undefined || selrow < 0){
			alert("상품을 추가할 브랜드를 먼저 선택해 주세요!");
			return;
		}
		
		var trObj = $("#gridList").find("tr");
		var brandCd = $("#gridList").getCell($(trObj[selrow]).prop("id"), "brandCd");
		console.log("brandCd ==>" + brandCd);
		var totCnt = $("#gridListPrd").getGridParam("records");
		
		var addData = {"prdCd":"" ,"prdNm":"" ,"brandCd":brandCd ,"insDate":"", "insId":"", "editType":"I"};

		if(totCnt == null) {

			totCnt = 0;
		}

		$("#gridListPrd").addRowData(totCnt + 1, addData);

		$("#gridListPrd").setColProp("prdCd", {editable:true});
		$("#gridListPrd").setColProp("prdNm", {editable:true});
	},
	getCellValue : function(rowId, cellId) {
	    var cell = jQuery('#' + rowId + '_' + cellId);        
	    var val = cell.val();
	    return val;
	},
	clearGrid : function() {
		
		$("#gridListPrd").clearGridData();
	},	

	rowBtn : function(cellvalue, options, rowObject) {
		
		if(rowObject.prdCd == "" || rowObject.prdCd == undefined) {
			
			return '<a href="javascript:gridFunc2.delRow('+options.rowId+');"> 행삭제 </a>';			
		} else {
			
			return "";
		}
	},
	
	//행삭제
	delRow : function(rowid) {
		
		if(rowid != "") {
			
		 	$("#gridListPrd").delRowData(rowid);
		}
	}
} 
</script>
<div class="row">
	<div>
		<select id="cbBrandList">
			<option value="">전체</option>
			<c:forEach var="brandList" items="${brandList}" varStatus="status">
				<option value="${brandList.brandCd}">${brandList.brandNm}</option>
			</c:forEach>
		</select>
		<span><a href="#" onclick="javascript:jqgridBrand.goSearch();">조회</a></span> 
		<span><a href="#" onclick="javascript:gridFunc.addRow();">행추가</a></span>
		<span><a href="#" onclick="javascript:jqgridBrand.saveRow();">저장</a></span>
		<span><a href="#" onclick="javascript:gridFunc.clearGrid();">초기화</a></span>
	</div>			
	<div>
		<table id="gridList" ></table>
		<div id="pager"></div>
	</div>	
</div>
<br/>
<div class="row">
	<div>
		<span><a href="#" onclick="javascript:gridFunc2.addRow();">행추가</a></span>
		<span><a href="#" onclick="javascript:jqgridPrd.saveRow();">저장</a></span>
		<span><a href="#" onclick="">삭제</a></span>
		<span><a href="#" onclick="javascript:gridFunc2.clearGrid();">초기화</a></span>
	</div>
	<div>
		<table id="gridListPrd" ></table>
		<div id="pager2"></div>
	</div>
</div>