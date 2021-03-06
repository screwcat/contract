<%@ page language="java" import="com.opensymphony.xwork2.ActionContext" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>课程完成情况查询</title>
<link rel="stylesheet" href="themes/cupertino/jquery.ui.all.css">
<script src="scripts/jquery.min.js"></script>
<script src="scripts/jquery-ui.min.js"></script>
<script src="scripts/ui/jquery.ui.position.min.js"></script>
<script src="scripts/ui/jquery.ui.core.min.js"></script>
<script src="scripts/ui/jquery.ui.widget.min.js"></script>
<script src="scripts/ui/jquery.ui.button.min.js"></script>
<script src="scripts/ui/jquery.ui.tabs.min.js"></script>
<script src="scripts/ui/jquery.ui.dialog.min.js"></script>
<script src="scripts/ui/jquery.ui.menu.min.js"></script>
<script src="scripts/ui/jquery.ui.progressbar.min.js"></script>
<script src="scripts/function.min.js"></script>
<script type="text/javascript" src="../js/wdatepicker/WdatePicker.js" ></script>

<style>
.ui-progress-bar {
  height: 26px;
  width:170px;
  padding-bottom:1px; padding-top:1px;padding-left:6px;
 background-color: #FFFFFF;
}
fieldset { padding: 0 1em 0 1em; border:0; width: 85%; }
.validateTips { border: 1px solid transparent; padding: 0 0.5em 0 0.5em; margin: 0; line-height: 30px; }
.progress{width:120px; background-color:#F6F6F6; border-color:#AFAFAF; height:15px;}
.ptext{position: absolute; padding-left:45px; line-height:15px;}
.btext{color:#333333; font-size:10px;}
.percent{margin-left:25px;}
.imgs{cursor:pointer;}

.panelTable { width: 100%; background-color: #FFFFFF; }
.panelTable th { line-height: 20px; border-bottom: ridge 2px #EEEEEE; font-weight: normal; }
/*.panelTable td { line-height: 32px; border-bottom: solid 1px #EEEEEE; padding: 6px; }*/
.panelTable td { line-height: 28px; border-bottom: solid 0px #EEEEEE; padding: 2px 6px; }
/*.panelTable tr:hover td { background-color: #F5F5F5; }*/
.panelTable td.hover { background-color: #FFFFFF; }
.panelTable td.hover .hide { display: block; }
.panelTable td.selected { background-color: #FFFFD5; }
.panelTable tr.unread { line-height: 32px; border-bottom: solid 1px #EEEEEE; font-weight: bold; }
.panelTable tr.trSpliter th { line-height: 0px; height: 0; border: 0; padding: 0; }
.panelTable tr.trEmpty td { line-height: 14px; height: 14px; padding: 0; border-bottom: solid 1px #EEEEEE; }
.panelTable tr.trGray th { line-height: 12px; border-bottom: solid 1px #EEEEEE; background-color: #F6F6F6; color: #8F8F8F; text-align: left; padding: 5px; }
.panelTable th.thSortableGray { line-height: 15px; border-top: solid 1px #AFAFAF; border-bottom: solid 1px #AFAFAF; background-color: #F6F6F6; color: #999999; text-align: left; padding: 5px; }
.panelTable th.thSortable { line-height: 15px; border-top: solid 1px #AFAFAF; border-bottom: solid 1px #AFAFAF; background-color: #F6F6F6; color: #999999; text-align: left; padding: 5px; cursor: pointer; }
.panelTable th.thSortableHover { background-color: #E8E8E8; }

</style>
<script>
$(function() {
	//大纲进度条
	var out = document.getElementsByName("outline");
	var fout = document.getElementsByName("foutline");
	var fv;
	for(var i=0; i<out.length; i++){
		
		fv = fout[i].value/out[i].value*100;
		if(fv!=0 && fv<1){
			fv =1;	
		}
		setProgressBar("outline" + (i+1), fv);
		$("#opercent" + (i+1)).html(fv.toFixed(1));
	}

	//设置进度条数值
	$( "#dialogForm3" ).dialog({//操作数据库返回提示窗口
		autoOpen: false,
		height: 200,
		width: 400,
		modal: true,
		resizable: false,
		buttons: {
			"关 闭": function() {
				$( this ).dialog( "close" );
			}
		}
	});
	$( "#detailDialogForm" ).dialog({
		autoOpen: false,
		height: 480,
		width: 1024,
		modal: true,
		resizable: false,
		buttons: {
			"关 闭": function() {
				$( this ).dialog( "close" );
			}
		}
	});
	$("#modalDialogButton4").click(function(){
		if($("#searchUser").val()=="学号/姓名"){
			$("#keyid").val("");
		}else{
			$("#keyid").val($("#searchUser").val());
		}
		$("#searchForm").submit();
	});

});
function setProgressBar(progressbar1,num){
	$("#" + progressbar1).progressbar({value: parseInt(num)});
}
</script>
<!-- 此js务必放在所有页面自带的js后面加载 -->
<script src="scripts/base.min.js"></script>
</head>
<body class="hide">
<div id="leftPartA"><div>
	<s:action name="open_leftList" executeResult="true">
    <s:param name="parentid">4028816a4714304c0147149b5bb20001</s:param>
    <s:param name="name"><%=ActionContext.getContext().getName()%></s:param> 
    </s:action>
</div></div>

<div id="rightPartA"><div>

<div class="panelBox buttonBox">

 <div class="buttonInput relative left" width="180" height="28">
    <input id="searchUser" value="学号/姓名" name="searchUser"  type="text" maxlength="50" title="学号/姓名"/><button id="modalDialogButton4" >查询</button>
    
 </div>
</div>

<div class="Panel ui-corner-all-0" id="Panel2">
	<div class="panelContent">
   <table class="panelTable" id="usersTable" border="0" cellspacing="0" cellpadding="0">
			<thead>
			  <tr class="trSpliter">
				<th width="40"></th>
				<th width="450"></th>
                <th></th>
			  </tr>
              
			  <tr>
				<th class="thSortableGray"></th>
				<th class="thSortableGray">学员</th>
				<th class="thSortableGray">完成进度(已完成时长/总时长)</th>
              </tr>
			</thead><s:set name="units" value="0"/>
              <s:iterator value="page.data" status="i"><s:set name="units" value="#units+1"/>
             <tr class="normal">
				<td align="right"><img src="themes/cupertino/images/jiahao.gif"  border="0" class="imgs" id="${outlineId}-0-${i.count}-${VCode}" onclick="execDot('${outlineId}-0-${i.count}-${VCode}')"/></td>
				<td>${VCode} -- ${VName} -- ${outlineName}</td>
				<td><div class="ui-progress-bar" title="${VName} -- ${outlineName}">
                <div id="outline${i.count}" PB_CLASS_LOW="progressbarRed" PB_CLASS_MIDDLE="progressbarRed" PB_CLASS_HIGH="progressbarGreen" PB_PERCENT_LOW="100" PB_PERCENT_MIDDLE="100" class="progress">
				  <div class="ptext"><span class="btext">${viewFinishTime}/${viewTotalTime}</span><span id="opercent${i.count}" class="percent"></span>%</div>
				  </div>            
            	</div><input type="hidden" name="foutline" value="${finishTime}"><input type="hidden" name="outline" value="${totalTime}"></td>
              </tr>
              <tr>
              <td colspan="3" class="normal">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="unit${i.count}" style="display:none;">
                </table>
                </td>
              </tr>
              
              </s:iterator>
		</table>
        <s:include value="../common/pagination_system_post.jsp" />
</div>
</div>
</div>
</div>

<div id="dialogForm3">
<table width="100%" border="0" align="center" cellpadding="0">
<tr>
<td width="20%" height="90" align="center" valign="middle"><img src="themes/cupertino/images/warning.png" /></td>
<td width="90%" align="left" valign="middle"><span style="font-size: 14px; font-weight: bold; color: #555555; line-height:23px;" id="dialogForm3Warning"></span></td>
</tr>
</table>
</div>

<div id="detailDialogForm">   
<table id="usersTable4" class="colorTable" border="1" bordercolor="#E0E0E0" cellspacing="0" cellpadding="2" >

  <thead>
    <tr>
      <th width="85" rowspan="2">日期</th>
      <th width="50" rowspan="2">航空器<br>
        登记号</th>
      <th colspan="4">起飞\降落站</th>
      <th width="50" rowspan="2">飞行<br>
        科目</th>
      <th colspan="2">着陆次数</th>
      <th width="60" rowspan="2">驾驶员<br>
        飞行时间</th>
      <th colspan="4">机长或单飞时间</th>
      <th colspan="4">副驾驶或带飞时间</th>
      <th colspan="2">仪表飞行时间</th>
      <th colspan="3">模拟机\训练器</th>
 
    </tr>
    <tr>
      <th width="40">起飞站</th>
      <th width="40">降落站</th>
      <th width="35">出发时刻</th>
      <th width="35">到达时刻</th>
      <th width="30">夜间</th>
      <th width="30">昼间</th>
      <th width="30">机长</th>
      <th width="30">单飞</th>
      <th width="30">转场</th>
      <th width="30">夜间</th>
      <th width="50">副驾驶</th>
      <th width="30">带飞</th>
      <th width="30">转场</th>
      <th width="30">夜间</th>
      <th width="50">模拟<br>仪表</th>
      <th width="50">真实<br>仪表</th>
      <th width="60">训练地点</th>
      <th width="50">模拟机<br>时间</th>
      <th width="50">训练器<br>时间</th>
      </tr>
   </thead> 
    <tbody id="line1">

  </tbody>
</table>
<br>
<span id="pingyu"></span>
<br>
<span id="subjectScore"></span>
</div>
</body>
</html>
<!--<input type="hidden"  id="outlineLengthId" value="${units}">-->
<form  action="open_flightTrainingRecordCompletionPage.do" method="post" id="searchForm">
<input type="hidden" name="name" id="keyid" value="${name}" >
<input type="hidden" name="pageIndex" id="pageIndexid">
<input type="hidden"  id="selLessons"/>
<input type="hidden"  id="selPhases"/>
<input type="hidden"  id="selUnits"/>
</form>
<script>
function execDot(ids){
	var str = ids;//id,类型,数量；
	var id = str.split("-")[0];	
	var level = str.split("-")[1];
	var num = str.split("-")[2];
	var code = str.split("-")[3];
	var os = "";
	if(level==0){//大纲
		os="";
		var stra = $("#selUnits").val();
		if(stra.indexOf(id + level+code)!=-1){
			if($("#unit" + num)[0].style.display==''){
				$("#" + str).attr("src","themes/cupertino/images/jiahao.gif");
				$("#unit" + num)[0].style.display='none';
			}else{
				$("#" + str).attr("src","themes/cupertino/images/jianhao.gif");
				$("#unit" + num)[0].style.display='';	
			}
			return;	
		}

		$("#selUnits").val(stra+id + level+code);
		params = {"outlineid":id,"studentCode":code};
		$.ajax({
			async:false,//同步请求，默认异步
			type:"post",
			url:"showUnitTrainingRecordCompletionListByOutlineId.do",
			data:params,
			dataType:"json",
			success:function(data){
				for(i=0;i<data.length;i++){
					os+="<tr>";
					os+="<td width=\"25\"></td>";
					if(data[i].isChild==0){
						os+="<td width=\"435\">&nbsp;&nbsp;&nbsp;&nbsp;"+data[i].VName+"</td>";
					}else{
						os+="<td width=\"435\"><img src=\"themes/cupertino/images/jiahao.gif\" class=\"imgs\" ";
						os+="id=\""+ data[i].VId + "-1-" +(i+1) + "-"+ code +"\" ";
						os+="onclick=\"execDot('"+data[i].VId + "-1-" +(i+1) + "-"+ code +"')\"/>";
						os+="&nbsp;"+data[i].VName+"</td>";
					}
					
					os+="<td><div class=\"ui-progress-bar\" title=\""+data[i].VName +"\">";
					os+="<div id=\"unit"+data[i].VId+code+"\" PB_CLASS_LOW=\"progressbarRed\"";
					os+=" PB_CLASS_MIDDLE=\"progressbarRed\" PB_CLASS_HIGH=\"progressbarGreen\""
					os+=" PB_PERCENT_LOW=\"100\" PB_PERCENT_MIDDLE=\"100\" class=\"progress\">";
					os+="<div class=\"ptext\"><span class=\"btext\">"+data[i].viewFinishTime;
					os+="/"+data[i].viewTotalTime+"</span>";

					/*
					if(data[i].finishTime<10){
						os+="&nbsp;&nbsp;&nbsp;";
					}
					if(data[i].finishTime>=10 && data[i].finishTime<100){
						os+="&nbsp;&nbsp;";
					}
					
					if(data[i].totalTime<10){
						os+="&nbsp;&nbsp;&nbsp;";
					}
					if(data[i].totalTime>=10 && data[i].totalTime<100){
						os+="&nbsp;&nbsp;";
					}
					*/

					os+="<span id=\"upercent"+data[i].VId+code+"\" class=\"percent\"></span>%</div></div></div>";
					os+="<input type=\"hidden\" name=\"funit\" value=\""+data[i].finishTime+"\">";
					os+="<input type=\"hidden\" name=\"unita\" value=\""+data[i].totalTime+"\">";
					os+="<input type=\"hidden\" name=\"unitp\" value=\""+data[i].VId+code+"\">";
					
					os+="</td>";
					os+="</tr>";
					os+="<tr>";
					os+="<td colspan=\"3\">";
					os+="<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"";
					os+=" style=\"display:none\" id=\"phase"+data[i].VId + code+"\">";
					os+="</table>";
					os+="</td>";
					os+="</tr>";
				}

			},
			error:function(){
				$("#dialogForm3Warning").html("数据库连接错误，获取对象失败，请重试。");
				$( "#dialogForm3" ).dialog( "open" );
				return;
			}
		});
		$("#unit" + num).html(os);	
		//单元进度条
		var unita = document.getElementsByName("unita");
		var funit = document.getElementsByName("funit");
		var unitp = document.getElementsByName("unitp");
		var fu;
		
		for(var i=0; i<unita.length; i++){
			if(unita[i].value==0){
				fu = 0;
			}else{
				fu = funit[i].value/unita[i].value*100;
			}
			if(fu!=0 && fu<1){
				fu=1;
			}
			setProgressBar("unit"+unitp[i].value, fu);
			$("#upercent"+unitp[i].value).html(fu.toFixed(1));
		}
		
		if($("#unit" + num)[0].style.display==''){
			$("#" + str).attr("src","themes/cupertino/images/jiahao.gif");
			$("#unit" + num)[0].style.display='none';
		}else{
			$("#" + str).attr("src","themes/cupertino/images/jianhao.gif");
			$("#unit" + num)[0].style.display='';	
		}
	}
	if(level==1){//单元
		//获取单元阶段
		var stra = $("#selPhases").val();
		if(stra.indexOf(id + level + code)!=-1){
			if($("#phase" + id+code)[0].style.display==''){
				$("#" + str).attr("src","themes/cupertino/images/jiahao.gif");
				$("#phase" + id+code)[0].style.display='none';
			}else{
				$("#" + str).attr("src","themes/cupertino/images/jianhao.gif");
				$("#phase" + id+code)[0].style.display='';	
			}
			return;	
		}
		$("#selPhases").val(stra+id + level + code);
		os = "";
		params = {"unitid":id,"studentCode":code};
		$.ajax({
			async:false,//同步请求，默认异步
			type:"post",
			url:"showPhaseTrainingRecordCompletionListByUnitId.do",
			data:params,
			dataType:"json",
			success:function(data){
				for(i=0;i<data.length;i++){
					os+="<tr class=\"normal\">";
					os+="<td width=\"25\"></td>";
					if(data[i].isChild==0){
						os+="<td width=\"429\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+data[i].VName +"</td>";
					}else{
						os+="<td width=\"429\">&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"themes/cupertino/images/jiahao.gif\"";
						os+=" class=\"imgs\" id=\""+data[i].VId + "-2-" +(i+1) + "-" + code+"\"";
						os+=" onclick=\"execDot('"+data[i].VId + "-2-" +(i+1) + "-" + code +"')\"/>&nbsp;"+data[i].VName+"</td>";
					}
					os+="<td><div class=\"ui-progress-bar\" title=\""+data[i].VName +"\">";
					os+="<div id=\"phase"+data[i].VId+code+"\" PB_CLASS_LOW=\"progressbarRed\"";
					os+=" PB_CLASS_MIDDLE=\"progressbarRed\" PB_CLASS_HIGH=\"progressbarGreen\""
					os+=" PB_PERCENT_LOW=\"100\" PB_PERCENT_MIDDLE=\"100\" class=\"progress\">";
					os+="<div class=\"ptext\"><span class=\"btext\">"+data[i].viewFinishTime;
					os+="/"+data[i].viewTotalTime+"</span>";
					
					/*
					if(data[i].finishTime<10){
						os+="&nbsp;&nbsp;&nbsp;";
					}
					if(data[i].finishTime>=10 && data[i].finishTime<100){
						os+="&nbsp;&nbsp;";
					}
					
					if(data[i].totalTime<10){
						os+="&nbsp;&nbsp;&nbsp;";
					}
					if(data[i].totalTime>=10 && data[i].totalTime<100){
						os+="&nbsp;&nbsp;";
					}
					*/

					os+="<span id=\"ppercent"+data[i].VId+code+"\" class=\"percent\"></span>%</div></div></div>";
					os+="<input type=\"hidden\" name=\"fphase\" value=\""+data[i].finishTime+"\">";
					os+="<input type=\"hidden\" name=\"phasea\" value=\""+data[i].totalTime+"\">";
					os+="<input type=\"hidden\" name=\"phasep\" value=\""+data[i].VId+code+"\">";
					
					os+="</td>";
					os+="</tr>";
					os+="<tr>";
					os+="<td colspan=\"3\">";
					os+="<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"";
					os+=" style=\"display:none\" id=\"lesson"+data[i].VId + code+"\">";
					os+="</table>";
					os+="</td>";
					os+="</tr>";
				}
			},
			error:function(){
				$("#dialogForm3Warning").html("数据库连接错误，获取对象失败，请重试。");
				$( "#dialogForm3" ).dialog( "open" );
				return;
			}
		});

		$("#phase" + id+code).html(os);
		
		//阶段进度条
		var phasea = document.getElementsByName("phasea");
		var fphase = document.getElementsByName("fphase");
		var phasep = document.getElementsByName("phasep");
		var fu;
		
		for(var i=0; i<phasea.length; i++){
			if(phasea[i].value==0){
				fu = 0;
			}else{
				fu = fphase[i].value/phasea[i].value*100;
			}
			if(fu!=0 && fu<1){
				fu=1;
			}
			setProgressBar("phase"+phasep[i].value, fu);
			$("#ppercent"+phasep[i].value).html(fu.toFixed(1));
		}
		if($("#phase" + id+code)[0].style.display==''){
			$("#" + str).attr("src","themes/cupertino/images/jiahao.gif");
			$("#phase" + id+code)[0].style.display='none';
		}else{
			$("#" + str).attr("src","themes/cupertino/images/jianhao.gif");
			$("#phase" + id+code)[0].style.display='';	
		}
		
	}
	if(level==2){//阶段
	
		var stra = $("#selLessons").val();
		if(stra.indexOf(id + level + code)!=-1){
			if($("#lesson" + id+code)[0].style.display==''){
				$("#" + str).attr("src","themes/cupertino/images/jiahao.gif");
				$("#lesson" + id+code)[0].style.display='none';
			}else{
				$("#" + str).attr("src","themes/cupertino/images/jianhao.gif");
				$("#lesson" + id+code)[0].style.display='';	
			}
			return;	
		}
		$("#selLessons").val(stra+id + level + code);
		os = "";
		params = {"phaseid":id,"studentCode":code};
		$.ajax({
			async:false,//同步请求，默认异步
			type:"post",
			url:"showLessonTrainingRecordCompletionListByPhaseId.do",
			data:params,
			dataType:"json",
			success:function(data){
				var p = 0;
				for(i=0;i<data.length;i++){
					
					if(p==0){
						os+="<tr><td width=\"36\"></td>";
					}
					
					os+="<td width=\"40\" align=\"right\" title=\""+data[i].VName+"\">"+data[i].VCode+"</td>";
					os+="<td width=\"180\">";
					if(data[i].finishTime>0){
						os+="<div class=\"ui-progress-bar imgs\" title=\""+data[i].VName+"\" onclick=\"showContent('"+data[i].VId+"','"+code+"')\">";
					}else{
						os+="<div class=\"ui-progress-bar\" title=\""+data[i].VName+"\">";
					}
					os+="<div id=\"clesson"+data[i].VId+code+id+"\" PB_CLASS_LOW=\"progressbarRed\"";
					os+=" PB_CLASS_MIDDLE=\"progressbarRed\" PB_CLASS_HIGH=\"progressbarGreen\""
					os+=" PB_PERCENT_LOW=\"100\" PB_PERCENT_MIDDLE=\"100\" class=\"progress\">";
					os+="<div class=\"ptext\"><span class=\"btext\">"+data[i].viewFinishTime;
					os+="/"+data[i].viewTotalTime+"</span>";

					/*
					if(data[i].finishTime<10){
						os+="&nbsp;&nbsp;&nbsp;";
					}
					if(data[i].finishTime>=10 && data[i].finishTime<100){
						os+="&nbsp;&nbsp;";
					}
					
					if(data[i].totalTime<10){
						os+="&nbsp;&nbsp;&nbsp;";
					}
					if(data[i].totalTime>=10 && data[i].totalTime<100){
						os+="&nbsp;&nbsp;";
					}
					*/

					os+="<span id=\"clpercent"+data[i].VId+code+id+"\" class=\"percent\"></span>%</div></div></div>";
					os+="<input type=\"hidden\" name=\"fclesson\" value=\""+data[i].finishTime+"\">";
					os+="<input type=\"hidden\" name=\"clessona\" value=\""+data[i].totalTime+"\">";
					os+="<input type=\"hidden\" name=\"clessonp\" value=\""+data[i].VId+code+id+"\">";
					
					os+="</td>";
					p++;
					
					if(p>=4){
						p=0;
						os+="<td></td></tr>";
					}
					
				}
				
				if(p<4 && p>0){
					for(j=0;j<4-p;j++){
						os+="<td></td><td></td>";
					}
					os+="</tr>";
				}
				

			},
			error:function(){
				$("#dialogForm3Warning").html("数据库连接错误，获取对象失败，请重试。");
				$( "#dialogForm3" ).dialog( "open" );
				return;
			}
		});

		$("#lesson" + id+code).html(os);
		//课程进度条
		
		var lessona = document.getElementsByName("clessona");
		var flesson = document.getElementsByName("fclesson");
		var lessonp = document.getElementsByName("clessonp");
		var fu;
		
		for(var i=0; i<lessona.length; i++){
			if(lessona[i].value==0){
				fu = 0;
			}else{
				fu = flesson[i].value/lessona[i].value*100;
			}
			if(fu!=0 && fu<1){
				fu=1;
			}
			setProgressBar("clesson"+lessonp[i].value, fu);
			$("#clpercent"+lessonp[i].value).html(fu.toFixed(1));
		}
		
		
		if($("#lesson" + id+code)[0].style.display==''){
			$("#" + str).attr("src","themes/cupertino/images/jiahao.gif");
			$("#lesson" + id+code)[0].style.display='none';
		}else{
			$("#" + str).attr("src","themes/cupertino/images/jianhao.gif");
			$("#lesson" + id+code)[0].style.display='';	
		}
	}
}
function showContent(id,code){

	var content="";
	var vid = "";
	params = {"lessonid":id,"studentCode":code};
	$.ajax({
		async:false,//同步请求，默认异步
		type:"post",
		url:"showTrainingRecordCompletionDetailByLessonId.do",
		data:params,
		dataType:"json",
		success:function(data){
			vid = data.VId;
			content="<tr>";
			content+="<td>"+data.DFlydate+"</td>";
			content+="<td>"+data.planeCode+"</td>";
			content+="<td>"+data.VFpos+"</td>";
			content+="<td>"+data.VLpos+"</td>";
			content+="<td>"+data.DFlymoment+"</td>";
			content+="<td>"+data.DEndmoment+"</td>";
			content+="<td>"+data.VNo+"</td>";
			if(data.ILangnighttimes!=null && data.ILangnighttimes!=0){
				content+="<td>"+data.ILangnighttimes+"</td>";
			}else{
				content+="<td></td>";
			}
			if(data.ILanddaytimes!=null && data.ILanddaytimes!=0){
				content+="<td>"+data.ILanddaytimes+"</td>";
			}else{
				content+="<td></td>";
			}
			content+="<td>"+data.DTrantime+"</td>";
			content+="<td>"+data.DJizhangtime+"</td>";
			content+="<td>"+data.DDanfeitime+"</td>";
			content+="<td>"+data.DZhuanchangtime+"</td>";
			content+="<td>"+data.DYejiantime+"</td>";
			content+="<td>"+data.DFujiashitime+"</td>";
			content+="<td>"+data.DDaifeitime+"</td>";
			content+="<td>"+data.DFjszhuanchangtime+"</td>";
			content+="<td>"+data.DFjszcyjtime+"</td>";
			content+="<td>"+data.DMoniyibiaotime+"</td>";
			content+="<td>"+data.DZhenshiyibiao+"</td>";
			content+="<td>"+data.VTranpos+"</td>";
			content+="<td>"+data.DMnjsj+"</td>";
			content+="<td>"+data.DXlqsj+"</td>";
			content+="</tr>";
			$("#line1").html(content);
			$("#detailDialogForm").dialog('option', 'title', '姓名：'+
			data.studentName+'   学号：'+data.studentVCode+' 教员：'+data.teacherName+
			' 飞行种类：'+data.VFlytype+' 监视教员：'+data.monitorteacherName+' 压座学员：'+data.VSecondstudent);
			
		},
		error:function(){
			$("#dialogForm3Warning").html("数据库连接错误，获取对象失败，请重试。");
			$( "#dialogForm3" ).dialog( "open" );
			return;
		}
	});

	params = {"id":vid};
	$.ajax({
		async:false,//同步请求，默认异步
		type:"post",
		url:"showStudentCommentByTrainingId.do",
		data:params,
		dataType:"json",
		success:function(data){
			if(data!=null){
				var content = "";
				content+="<table width=\"100%\" border=\"0\" bordercolor=\"#E0E0E0\" cellspacing=\"0\" cellpadding=\"3\" >";
				content+="<tr>";
				content+="<th align=\"left\" bgcolor=\"#F6F6F6\">教员评语</th>";
				content+="</tr>";
				content+="<tr>";
				content+="<td align=\"left\" >"+data.message+"</td>";
				content+="</tr>";
				content+="<tr>";
				content+="<td colspan=\"2\" ><span class=\"panelLine\"></span></td>";
				content+="</tr>";
				content+="</table>";
				$("#pingyu").html(content);
			}
		},
		error:function(){
			$("#dialogForm3Warning").html("数据库连接错误，获取对象失败，请重试。");
			$( "#dialogForm3" ).dialog( "open" );
			return;
		}
	});
	
	$.ajax({
		async:false,//同步请求，默认异步
		type:"post",
		url:"showStudentSubjectScoreByTrainingId.do",
		data:params,
		dataType:"json",
		success:function(data){
			var content = "";
			var flag = 0;
			content+="<table width=\"100%\" border=\"0\" bordercolor=\"#E0E0E0\" cellspacing=\"0\" cellpadding=\"3\" >";
			content+="<tr>";
			content+="<th width=\"200\" align=\"left\" bgcolor=\"#F6F6F6\">分类</th>";
			content+="<th width=\"200\" align=\"left\" bgcolor=\"#F6F6F6\">科目</th>";
			content+="<th align=\"left\" bgcolor=\"#F6F6F6\">实际分数</th>";
			content+="</tr>";
			for(i=0;i<data.length;i++){
				content+="<tr>";
				content+="<td align=\"left\">"+data[i].typeName+"</td>";
				content+="<td align=\"left\">"+data[i].VName+"</td>";
				content+="<td align=\"left\">&nbsp;&nbsp;"+data[i].DScore+"</td>";
				content+="</tr>";
				content+="<tr>";
				content+="<td colspan=\"3\" ><span class=\"panelLine\"></span></td>";
				content+="</tr>";
				flag++;
			}
			content+="</table>";
			if(flag>0){
				$("#subjectScore").html(content);
			}else{
				$("#subjectScore").html("");
			}
			$( "#contentDialogForm" ).dialog("open");
		},
		error:function(){
			$("#dialogForm3Warning").html("数据库连接错误，获取对象失败，请重试。");
			$( "#dialogForm3" ).dialog( "open" );
			return;
		}
	});
	
	$( "#detailDialogForm" ).dialog("open");
}
</script>