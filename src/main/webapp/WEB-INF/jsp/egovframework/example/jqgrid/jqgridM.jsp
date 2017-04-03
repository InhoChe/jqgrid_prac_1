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
		
		var jsonObj = {};

		if($("#selectId").val() != "C") {
			
			jsonObj.serviceImplYn = $("#selectId").val();
		}
		
		var cnames = ['아이디','이름','전화번호','주소','기타','성별코드'];  
	    var prevCellVal = { cellId: undefined, value: undefined };
		/*	    
	    var grid = $("#jqGrid"),
	    	setHeaderWidth = function () {
	    		console.log(this.jqgridTable);
		        var $self = $("#jqGrid"),
		            colModel = $self.jqGrid("getGridParam", "colModel"),
		            cmByName = {},
		            ths = $self.headers, // array with column headers
		            cm,
		            i,
		            l = colModel.length;
		        console.log($self);
		        // save width of every column header in cmByName map
		        // to make easy access there by name
		        for (i = 0; i < l; i++) {
		            cm = colModel[i];
		            cmByName[cm.name] = $(ths[i].el).outerWidth();
		        }
		        // resize headers of additional columns based on the size of
		        // the columns below the header
		        $("#h2").width(cmByName.address + cmByName.etcc);
		        $("#h1").width(cmByName.phone);
		    };
	    */
	    $("#jqGrid").jqGrid({
	    	
	        url: "jqgridStartMain.do",
	        datatype: "json",
	        postData : {"param" : JSON.stringify(jsonObj)},   
	        colNames: cnames,
	        colModel:[
	   	   		{name:'seq',		index:'seq', 		width:55, 	key:true, 		align:"center"},
	   	   		{name:'name',		index:'name', 		width:100, 					align:"center"},
	   	   		{name:'phone',		index:'phone', 		width:100},
	   	   		{name:'address',	index:'address', 	width:100},
	   	   		{name:'etcc',		index:'etcc', 		width:100},
	   	   		{name:'gender',		index:'gender', 	width:100,
	   	   			cellattr: function (rowId, val, rawObject, cm, rdata){
	   	   				
	   	   				var result;
	   	   				
	   	   				if (prevCellVal.value == val){
	   	   					
	   	   					result = ' style="display: none" rowspanid="' + prevCellVal.cellId + '"';
	   	   				} else{
	   	   					
	   	   					var cellId = 'row_' + rowId + '_' + cm.name;
	   	   					
	   	   					result = ' rowspan="1" rowid="mergeRow" id="' + cellId + '"';
	   	   					prevCellVal = { cellId: cellId, value: val };
	   	   				}
	   	   				return result;
	   	   			}
	   	   		}
			],
			/*
			resizeStop: function () {
		        // see http://stackoverflow.com/a/9599685/315935
		        var $self = $(this),
		            shrinkToFit = $self.jqGrid("getGridParam", "shrinkToFit");

		        $self.jqGrid("setGridWidth", this.grid.newWidth, shrinkToFit);
		        setHeaderWidth.call(this);
		    },
		    */
			gridComplete : function() {
	            /*
				$("#jqGrid").jqGrid("setGroupHeaders", {
					useColSpanStyle: false,
					
					groupHeaders:[
						//{startColumnName: 'seq', numberOfColumns: 1, titleText: '아이디'},
						//{startColumnName: 'name', numberOfColumns: 1, titleText: '이름'},
						{startColumnName: 'phone', numberOfColumns: 3, titleText: '한큐헤더2'}
					]
				});
				
				$("#jqGrid").jqGrid("setGroupHeaders", {
					useColSpanStyle: true,
					
					groupHeaders:[
						//{startColumnName: 'seq', numberOfColumns: 1, titleText: '아이디'},
						//{startColumnName: 'name', numberOfColumns: 1, titleText: '이름'},
						//{startColumnName: 'phone', numberOfColumns: 1, titleText: '전화번호'},
						{startColumnName: 'phone',
						 numberOfColumns: 3,
						 titleText: 
							'<table style="width:100%;border-spacing:0px;">' +
				            '<tr><td id="h0" colspan="2"><em>한큐헤더2</em></td></tr>' +
				            '<tr>' +
				            	'<td id="h1">전화번호</td>' +
				                '<td id="h2">한큐헤더</td>' +
				            '</tr>' +
				            '</table>'
				        }
						//{startColumnName: 'gender', numberOfColumns: 1, titleText: '성별코드'}
					]
					
				});
				
				//$("th[title=DetailsPriceShiping]").removeAttr("title");
				$("#h0").css({
				    borderBottomWidth: "1px",
				    borderBottomColor: "#c5dbec", // the color from jQuery UI which you use
				    borderBottomStyle: "solid",
				    padding: "4px 0 6px 0"
				});
				$("#h1").css({
				    borderRightWidth: "1px",
				    borderRightColor: "#c5dbec", // the color from jQuery UI which you use
				    borderRightStyle: "solid",
				    padding: "4px 0 4px 0"
				});
				
				$("#h2").css({
				    padding: "4px 0 4px 0"
				});
				
				setHeaderWidth.call(this[0]);
				*/
				
				$("#jqGrid").jqGrid("setGroupHeaders", {
					useColSpanStyle: true,
					
					groupHeaders:[
						//{startColumnName: 'seq', numberOfColumns: 1, titleText: '아이디'},
						//{startColumnName: 'name', numberOfColumns: 1, titleText: '이름'},
						{startColumnName: 'phone', numberOfColumns: 3, titleText: '한큐헤더2'}
					]
				});
				
				$("#jqGrid").jqGrid("setGroupHeaders", {
					useColSpanStyle: true,
					
					groupHeaders:[
						//{startColumnName: 'seq', numberOfColumns: 1, titleText: '아이디'},
						//{startColumnName: 'name', numberOfColumns: 1, titleText: '이름'},
						//{startColumnName: 'phone', numberOfColumns: 1, titleText: '전화번호'},
						{startColumnName: 'address', numberOfColumns: 2, titleText: '한큐헤더'}
						//{startColumnName: 'gender', numberOfColumns: 1, titleText: '성별코드'}
					]
					
				});
				
				$('th[rowspan="2"]').attr('rowspan', 3);
				//$("ui-state-default ui-th-column-header ui-th-ltr").attr("rowSpan","1");
				
	            var grid = this;
	             
	            $('td[rowspan="1"]',grid).each(function(){
	                //alert(this.id);
	                var spans = $('td[rowspanid="' + this.id + '"]', grid).length + 1;
	             	//alert(spans);
	                if(spans > 1){
	                   
	                    $(this).attr('rowspan',spans);
	                }
	            });
	        },

	        height			: 480,
	        rowNum			: 10,
	        rowList			: [10,20,30],
	        pager			: '#jqGridPager',
	        cellsubmit  	: "clientArray", 
	        rownumbers  	: true,      
	        viewrecords : true,
	        sortorder: "desc",
	        caption:"헤더 머지 jqgrid 테이블"
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
	}
}

/******************************************
 * 그리드 관련 메소드
 ******************************************/
var gridFunc = 
{			
	//그리드 초기화
	clearGrid : function() {
		
		$("#gridList").clearGridData();
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
		</div>			
		<div>
			<table id="jqGrid"></table>
    		<div id="jqGridPager"></div>
		</div>	
	</div>
</body>
</html>