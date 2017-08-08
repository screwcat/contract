<%@ page language="java" import="com.opensymphony.xwork2.ActionContext" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>教员执照历史列表</title>

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

<script>
A_WIDTH=200; //注意，不要写成var A_WIDTH，这个值已经在function.js中定义好了，只需要重新赋值
$(function() {
	$("#modalDialogButton7").click(function(){//返回
		$( "#searchForm" ).submit();
	});
	
	$("#modalDialogButton6").click(function(){//查询
		$( "#searchHistory" ).submit();
	});
	
	$( "#dialogContent" ).dialog({//内容窗口
		autoOpen: false,
		height: 480,
		width: 600,
		modal: true,
		resizable: false,
		buttons: {
			"确 定": function() {
				
				$( this ).dialog( "close" );
			}
		}
	});
	
});
Date.prototype.dateformat = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
//查看人员信息
function showPeopleMsg(id,istype){

	if(id=="" || istype==""){
		return;	
	}

	params = {"id":id,"key":istype};
	$.ajax({
		type:"post",
		url:"showMessageZzTeacherAjaxHistory.do",
		data:params,
		dataType:"json",
		success:function(data){

			if(data==null){
				$("#dialogForm3Warning").html("获取信息失败，信息不存在。");
				$( "#dialogForm3" ).dialog( "open" );
				return;
			}
			$("#contentid").html(getContent(data));
			$("#dialogContent").dialog('option', 'title',  "所选教员："+data.teacherBaseInfo);
			$( "#dialogContent" ).dialog( "open" );
		}, 
		error:function(XMLHttpRequest, textStatus, errorThrown){
			if(XMLHttpRequest.getResponseHeader("sessionstatus")=="timeout"){
				return;
			}
			$("#dialogForm3Warning").html("数据库连接错误，获取对象失败，请重试。");
			$( "#dialogForm3" ).dialog( "open" );
			return;
		}
	});	
}
function getContent(data){
	var content = "";
	var yxq = "";
	var qfsj = "";
	var gxsj = "";
	var hgz = "";
	var sfjk = "";
	if(data.DEffectdate != null && data.DEffectdate != "" && data.DEffectdate != "null"){
		yxq = (new Date(data.DEffectdate)).dateformat("yyyy-MM-dd");
	}
	if(data.DIssuetime != null && data.DIssuetime != "" && data.DIssuetime != "null"){
		qfsj = (new Date(data.DIssuetime)).dateformat("yyyy-MM-dd");
	}
	if(data.DUpdatedate != null && data.DUpdatedate != "" && data.DUpdatedate != "null"){
		gxsj = (new Date(data.DUpdatedate)).dateformat("yyyy-MM-dd");
	}
	if(data.IHgz == 1){
		hgz = "学员合格证";
	}else if(data.IHgz == 2){
		hgz = "教员合格证";
	}
	if(data.IJiankong == 1){
		sfjk = "监控";
	}else if(data.IJiankong == 2){
		sfjk = "不监控";
	}
	content+="<tr>";
	content+="<td width='80'>教员姓名：</td>";
	content+="<td width='140' height=\"24\">"+data.teacherBaseInfo+"</td>";
	content+="<td width='80'>教员编号：</td>";
	content+="<td width='140' height=\"24\">"+data.teacherCode+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>所在部门：</td>";
	content+="<td height=\"24\">"+data.deptName+"</td>";
	content+="<td>执照编号：</td>";
	content+="<td height=\"24\">"+data.VCardid+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>有效期：</td>";
	content+="<td height=\"24\">"+yxq+"</td>";
	content+="<td>局长授权签发：</td>";
	var jzsq = "";
	if(data.VIssuer != null && data.VIssuer != "null"){
		jzsq = data.VIssuer;
	}
	content+="<td height=\"24\">"+jzsq+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>签发单位：</td>";
	var qfdw = "";
	if(data.VCompany != null && data.VCompany != "null"){
		qfdw = data.VCompany;
	}
	content+="<td height=\"24\">"+qfdw+"</td>";
	content+="<td>签发时间：</td>";
	content+="<td height=\"24\">"+qfsj+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>更新时间：</td>";
	content+="<td height=\"24\">"+gxsj+"</td>";
	content+="<td>合格证：</td>";
	content+="<td height=\"24\">"+hgz+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>是否监控：</td>";
	content+="<td height=\"24\">"+sfjk+"</td>";
	content+="<td>执照性质：</td>";
	var zzxz = "";
	if(data.VXingzhi != null && data.VXingzhi != "null"){
		zzxz = data.VXingzhi;
	}
	content+="<td height=\"24\">"+zzxz+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>教员执照等级：</td>";
	content+="<td colspan=\"3\" height=\"24\">"+data.VDengji+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>教员执照类型：</td>";
	content+="<td colspan=\"3\" height=\"24\">"+data.VJyzzlx+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>执照类型：</td>";
	content+="<td colspan=\"3\" height=\"24\">"+data.VZzlx+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>仪表等级：</td>";
	content+="<td colspan=\"3\" height=\"24\">"+data.VYbdj+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>飞机级别等级：</td>";
	content+="<td colspan=\"3\" height=\"24\">"+data.VFjjbdj+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>航空器类别：</td>";
	content+="<td colspan=\"3\" height=\"24\">"+data.VHkqlb+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>航空器型别等级：</td>";
	content+="<td colspan=\"3\" height=\"24\">"+data.VHkqdj+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td>旋翼机级别等级：</td>";
	content+="<td colspan=\"3\" height=\"24\">"+data.VXyjdj+"</td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"4\"><span class=\"panelLine\"></span></td>";
	content+="</tr>"
	
	content+="<tr>";
	content+="<td colspan=\"2\">运输航空公司飞行教员执照等级：</td>";
	content+="<td colspan=\"2\" height=\"24\">"+data.VYszzdj+"</td>";
	content+="</tr>"
	
	return content;
}
</script>

<!-- 此js务必放在所有页面自带的js后面加载 -->
<script src="scripts/base.min.js"></script>

</head>
<body class="hide">
<div id="leftPartA"><div>
<s:action name="open_leftList" executeResult="true">
<s:param name="parentid">4028816a4714304c0147149e89190004</s:param>
<s:param name="name"><%=ActionContext.getContext().getName()%></s:param> 
</s:action>
</div></div>

<div id="topPartD">
<div class="panelBox buttonBox">
<button id="modalDialogButton7" class="normal"><span style="font-size:13px">&lt;&lt;</span> 返回</button>
</div>
</div>

<div id="rightPartD"><div>

<div class="Panel ui-corner-all-0" id="Panel2">
<div class="panelContent">

<table class="panelTable" id="usersTable" border="0" cellspacing="0" cellpadding="3">
    <thead>
      <tr class="trSpliter">
        <th width="80"></th>
        <th width="80"></th>
        <th width="145"></th>
        <th width="90"></th>
        <th width="90"></th>
        <th width="100"></th>
        <th width="130"></th>
        <th width="130"></th>
        <th></th>
      </tr>
      <tr>
        <th class="thSortableGray">教员姓名</th>
        <th class="thSortableGray">教员编号</th>
        <th class="thSortableGray">执照编号</th>
        <th class="thSortableGray">签发日期</th>
        <th class="thSortableGray">到期日期</th>
        <th class="thSortableGray">剩余有效期(天)</th>
        <th class="thSortableGray">上一次熟练检查日期</th>
        <th class="thSortableGray">下一次熟练检查日期</th>
        <th class="thSortableGray"></th>
      </tr>
    </thead>
    <tbody >
    <s:iterator value="viewTeacherBaseInfoList">
      <tr>
        <td><a href="javascript:void(0)" onclick="showPeopleMsg('${VId}','${used}');" class="blue">${VName}</a>${bList}</td>
        <td>${VCode}</td>
        <td>${VSfz}</td>
        <td>${DIssueTime}</td>
        <td>${DUsedTime}</td>
        <td><s:if test='iday<=31'>
                <s:set name="col" value="'#FF0000'"/>
                <s:set name="img" value="'top1.gif'"/>
            </s:if>
			<s:elseif test='31<iday and iday<=61'>
                <s:set name="col" value="'#EBA600'"/>
                <s:set name="img" value="'top2.gif'"/>
            </s:elseif>
			<s:elseif test='61<iday and iday<=90'>
                <s:set name="col" value="'#00A2BE'"/>
                <s:set name="img" value="'top3.gif'"/>
            </s:elseif>
			<s:else>
                <s:set name="img" value="''"/>
                <s:set name="col" value="'#000000'"/>
            </s:else>            
         &nbsp;&nbsp;&nbsp;&nbsp;<font color="${col}">${iday} <s:if test="#img!=''"><img src="themes/cupertino/images/${img}"  align="absmiddle"/></s:if></font>               
         </td>
        <td>${DResultdate}</td>
        <td>${VDoctor}</td>
        <td><s:if test='used==0'>在用执照</s:if><s:else>历史执照</s:else></td>
      </tr>
      <s:if test='checkList.size()>0'>
      <tr>
        <th></th>
        <th></th>
        <th class="thSortableGray">检查日期</th>
        <th class="thSortableGray">检查类型</th>
        <th class="thSortableGray">航空器编号</th>
        <th class="thSortableGray">检查教员</th>
        <th class="thSortableGray">到期日期</th>
        <th class="thSortableGray">剩余有效期(天)</th>
        <th></th>
      </tr>
      </s:if>
      <s:iterator value="checkList">
      <tr>
        <td></td>
        <td></td>
        <td>${viewDCheckdate}</td>
        <td>${typeName}</td>
        <td>${VFlyform}</td>
        <td>${VCheckteacher}</td>
        <td>${viewDEffectdate}</td>
        <td>${iday}</td>
        <td></td>
      </tr>
      </s:iterator> 
    </s:iterator> 
    </tbody>
</table>

</div>
</div>
</div>
</div>

<div id="dialogContent"  title="查看教员执照信息">
	<table width="100%" border="0" cellpadding="0" cellspacing="2" style="line-height:20px;">
    <tbody id="contentid">
    </tbody>
    </table>
</div>
<form id="searchForm" action="searchZzListTeacherAction.do" method="post">
<input type="hidden" name="deptId" value="${deptId}" />
<input type="hidden" name="key" value="${key}" />
</form>
</body>
</html>