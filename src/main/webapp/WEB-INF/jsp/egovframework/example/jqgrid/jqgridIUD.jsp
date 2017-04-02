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
	
	jqgridTable.init();
});

/******************************************
 * jqgrid 
 ******************************************/
var jqgridTable = 
{
	init : function() {
		
		var cnames = ['아이디','이름','전화번호','주소','기타','성별코드','구분'];
		
	    $("#jqGrid").jqGrid({
	    	
	        url: "jqgridStartMain.do",
	        datatype: "local",
	        colNames: cnames,
	        colModel:[
	   	   		{name:'seq',		index:'seq', 		width:55, 	key:true, 	align:"center"},
	   	   		{name:'name',		index:'name', 		width:100, 				align:"center"},
	   	   		{name:'phone',		index:'phone', 		width:100, editable:true},
	   	   		{name:'address',	index:'address', 	width:100, editable:true},
	   	   		{name:'etcc',		index:'etcc', 		width:100, editable:true},
	   	   		{name:'gender',		index:'gender',     width:100, editable:true, 
	   	   			edittype: "select", //grid.common.js
	   	   			formatter:gridFunc.fnCellDispType, //grid.locale-kr.js에서 predefined formatter를 사용 하거나, 커스텀 함수를 사용할 수 있다
	   	   			editoptions : {
	   	   				
	   	   				value	:	'1:남자; 2:여자', //{"1":"남자","2":"여자"},
	   	   				dataEvents	:	[{
	   	   					type : 'change',		// js 6409 라인
	   	   					fn   : function(e){
	   	   						//alert("성별 바꿈!");
	   	   					}
	   	   				}]
	   	   			}
	   	   		},
	   	   		{name:'btn',		index:'btn',     	width:100, formatter:gridFunc.rowBtn}  //formatter -> jqgrid에서 함수 호출 키워드 다음 행을 그리기전에 호출된다.
			],
	        height			: 480,
	        rowNum			: 10,
	        rowList			: [10,20,30],
	        pager			: '#jqGridPager',
	        cellEdit		: true, //디폴트 false임
	        cellsubmit		: "clientArray",  //셀단위에서 엔터치면 바로 서버로 보내는 것이 아니라 대기하도록 설정 default = remote
	        multiselect		: true,				//체크박스 생성
	        rownumbers  	: true,
	        onCellSelect : function(rowId, colId, val, e){
	    		
	    		var seq = $("#jqGrid").getCell(rowId, 'seq');
	    		
	    		if(colId >= 3){ // 기존 3(이름)인 경우만 했지만 다른 컬럼 조건도 걸리게 변경
	    			
	    			if(!CommonJsUtil.isEmpty(seq)){
	    				
	    				$('#jqGrid').setColProp('name',{editable:false});
	    				$("#jqGrid").setColProp('phone', {editable:false});
	    				$("#jqGrid").setColProp('address', {editable:false});
	    				$("#jqGrid").setColProp('etcc', {editable:false});
	    			}else{
	    				$('#jqGrid').setColProp('name',{editable:true});
	    				$("#jqGrid").setColProp('phone', {editable:true});
	    				$("#jqGrid").setColProp('address', {editable:true});
	    				$("#jqGrid").setColProp('etcc', {editable:true});
	    			}
	    		}
	    	},
	        ondblClickRow : function(rowId, iRow, iCol, e) {

				if(iCol == 1) {
					
	          		alert(rowId+" 째줄 입니다.");
	          	}
	        },
	    
	        viewrecords : true,
	        caption:"실습용 테이블"
	    });
	},
	
	goSearch : function() {
		
		var jsonObj = {};

		if($("#selectId").val() != "C") {
			
			jsonObj.serviceImplYn = $("#selectId").val();
		}
		
		$("#jqGrid").setGridParam({
			
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
	    
	        gridComplete : function() {
		 		
	    	}
	    }).trigger("reloadGrid");
	},
	
	gridValid : function() {
		
		var trObj = $("#jqGrid").find("tr");
		
		for (var i = 0; i < trObj.length; i++){
			
			var $this = $(trObj[i]);
			
			if($this.hasClass("edited")) {
				
				var rowId = $this.prop("id");
				var phone = $("#gridList").getCell(rowId, "phone");
				
				if(!CommonJsUtil.isNumeric(phone)) {
					
					alert(rowId + "째 행 전화번호는 숫자만 입력가능합니다.");
					
					return false;
					
					break;
				}
			}
		}
	},
	
	saveData : function() {
		
		//저장 전 유효성검사 체크
		if(!this.gridValid()) return false;
		
        var param1 = jqgridTable.selectData('save');
        $.ajax({

          type       : "POST",
          url        : "saveJqgrid.do",
          data       : {"param1" : param1},
          async      : false,
          beforeSend : function(xhr) {
          
              // 전송 전 Code
          },
          success    : function(result) {
          if(result == "SUCCESS") {
             alert("성공적으로 저장하였습니다.");
             jqgridTable.goSearch();
          }
          },
          error      : function() {
          
          alert("저장시 Error 발생");
          }
       }); 
    },
    deleteData : function() {
    	var param1 = jqgridTable.selectData('delete');
        $.ajax({

           type       : "POST",
           url        : "deleteJqgrid.do",
           data       : {"param1" : param1},
           async      : false,
           beforeSend : function(xhr) {
           
               // 전송 전 Code
           },
           success    : function(result) {
           if(result == "SUCCESS") {
              alert("성공적으로 저장하였습니다.");
              jqgridTable.goSearch();
           }
           },
           error      : function() {
           
           alert("저장시 Error 발생");
           }
        }); 
    },
    selectData : function(gubun){
       
       var gubunText = gubun == 'save' ? '저장' : '삭제';
       var checkData = $("#jqGrid").getGridParam("selarrrow");
       
       if(checkData.length == 0){
          
          alert("저장할 데이터를 선택하여 주십시오.");
          return;
       }
       
       if(confirm("선택한 데이터를"+gubunText+" 하시겠습니까?") == false){
          
          return false;
       }
       
       var iCnt = 0;
        var jsonArray1 = new Array();

        for(var i = 0; i < checkData.length; i++) {
           
           var jsonObj = {};
           
           var seq = $("#jqGrid").getCell(checkData[i], "seq");
           
           var editType = "";
           
           if(!CommonJsUtil.isEmpty(seq)) {
                     
               editType = "U";
           } else {
                     
               editType = "I";
           }
                  
           jsonObj.editType = editType;
           jsonObj.seq = seq;
           
           jsonObj.name =       $("#jqGrid").getCell(checkData[i], "name");  
           jsonObj.phone =    $("#jqGrid").getCell(checkData[i], "phone"); 
           jsonObj.address =    $("#jqGrid").getCell(checkData[i], "address");
           jsonObj.etcc =       $("#jqGrid").getCell(checkData[i], "etcc");
           jsonObj.gender =    $("#jqGrid").getCell(checkData[i], "gender");
           
           jsonArray1[iCnt] = jsonObj;
           
           iCnt++;
        }
     
        var param1 = JSON.stringify(jsonArray1);
        
        return param1;         
    }

}

var newRowCnt = 0;

var gridFunc =
{
	// 행추가
	addRow : function() {
		
		if(newRowCnt > 4){
			alert("5개 이상 삽입할 수 없습니다.");
			return;
		}
		
		var totCnt = $("#jqGrid").getGridParam("records"); //api method에 설명 및 파라미터 정보 있음.
		
		var addData = {"seq":"", "name":"", "phone":"", "address":"", "etcc":"", "gender":"1"};
		
		$("#jqGrid").addRowData(totCnt+1, addData, 'first');		// jquery.jqGrid.js  4416 참고
		$("#jqGrid").setColProp("name", {editable:true});
		$("#jqGrid").setColProp("phone", {editable:true});
		$("#jqGrid").setColProp("address", {editable:true});
		$("#jqGrid").setColProp("etcc", {editable:true});
		
		newRowCnt++;
	},
	rowBtn : function(cellvalue, options , rowObjects) {
	   if(rowObjects.seq == ""){
	   	  return '<a href="javascript:gridFunc.delRow(' + options.rowId+');">행삭제</a>';         
	   }else{
	      return "";
	   }
	},      
	delRow : function(rowid) {
	   console.log(rowid);
	   if(rowid != ""){
	     $("#jqGrid").delRowData(rowid);
	     newRowCnt--;
	   }
	},
	fnCellDispType : function(cellVal, options, rowObj) { // http://www.trirand.com/jqgridwiki/doku.php?id=wiki:custom_formatter 참조
		//console.log(cellVal);
		//console.log(options);
		//console.log(rowObj);
		var strDisp = "";
		strDisp = "<select id='cbGender_" + options.rowId + 
		          "' onchange=javascript:gridFunc.cbGenderChange('cbGender_" + options.rowId + "','" 
		        		  													 + options.rowId + "','"
		        		  													 + rowObj.id + "')>";
		for(i = 1; i < 3; i++){
			
			var cellText = (i == 1)?'남자':'여자';
			var selected = (i == rowObj.gender)?'selected="select"':'';
			
			strDisp += "<option " + selected + " value='" + i + "'>" + cellText + "</option>";
		}
		strDisp += '</select>';
		return strDisp;
	},
	cbGenderChange : function(comboId, rowId, id) {
		var selectedVal = $("#" + comboId).val();
		
		alert("comboId : " + comboId + " rowId : " + rowId + " id : " + id + "selectedVal : " + selectedVal);
		
		$('#gridList').setCell(rowId,'gender',selectedVal);
	},
	clearGrid : function() {
		$("#jqGrid").clearGridData();
	}
}
var CommonJsUtil = 
{
    isEmpty : function(val) {
     
        if(null == val || null === val || "" == val || val == undefined || typeof(val) == undefined || "undefined" == val || "NaN" == val) {
         
            return true;
        } else {
         
            return false;
        }
    },
    
    isNumeric : function(val) {
    	
    	if(/[^0-9]/.test(val)) {
    		return false;
    	} else {
    		return true;
    	}
    }
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
			<span><a href="#" onclick="javascript:jqgridTable.goSearch();">조회</a></span> 
			<span><a href="#" onclick="javascript:gridFunc.addRow();">행추가</a></span>
			<span><a href="#" onclick="javascript:jqgridTable.saveData();">저장</a></span>
			<span><a href="#" onclick="javascript:gridFunc.clearGrid();">초기화</a></span>
			<span><a href="#" onclick="javascript:jqgridTable.deleteData();">삭제</a></span>
		</div>			
		<div>
			<table id="jqGrid"></table>
    		<div id="jqGridPager"></div>
		</div>	
	</div>
</body>
</html>