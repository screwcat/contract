<%@ page language="java" contentType="text/html; charset=utf-8"
 pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>学生管理</title>
    <link href="<%=request.getContextPath()%>/contract/themes/cupertino/jquery.ui.all.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/contract/themes/cupertino/selfStyle.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/contract/scripts/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/ui/jquery.ui.position.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/ui/jquery.ui.core.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/ui/jquery.ui.widget.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/ui/jquery.ui.button.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/ui/jquery.ui.tabs.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/ui/jquery.ui.dialog.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/ui/jquery.ui.menu.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/function.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/datepicker4.8/WdatePicker.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/pages/Student/js/Student.js" type="text/javascript"></script> 

   <!-- 此js务必放在所有页面自带的js后面加载 -->
<script src="<%=request.getContextPath()%>/contract/scripts/base.min.js"></script>
<script src="<%=request.getContextPath()%>/contract/scripts/time.js"></script>
</head>
<body>
<jsp:include page="/pages/common/topPart.jsp"/>
<jsp:include page="/pages/common/leftPart.jsp"/>
<div id="rightPartA" style="overflow-x:hidden;">
<div>
<div>
    <button id="inputData" class="green" style="margin-left:10px;">导入学生</button>
    <button id="modifyStu" class="green"  style="margin-left:10px;" >批量修改</button>
    <button id="btnFill" class="green" style="margin-left:10px;">录入学生</button>
</div>
    <div class="panelBox buttonBox">
<!-- panelBox计划用于布局横向的简单一行 -->
<div class="dropDownList barLeft" id="Div3">
	<button>公司名称</button>
	<ul id="compy">		
	</ul>
	<input type="hidden" id="strCompany" name="strCompany"   value="${company}" />
</div>
<div class="dropDownList barMiddle" id="Div1">
	<button>学生年级</button>
		<ul id="classSelect">

	</ul>
	<input type="hidden" id="strStudentGrade" name="strStudentGrade" value="${grade}" />
</div>
<div class="dropDownList barRight" id="Div2">
	<button>学生状态</button>
	<ul id="stustate">
	    <%-- <li><a href="#N" val="0"><span class="ui-icon ui-icon-bullet"></span>学生状态</a></li>
		<li><a href="#N" val="1">未入校</a></li>
		<li><a href="#N" val="2">入校</a></li>
		<li><a href="#N" val="3">进入训练</a></li>
		<li><a href="#N" val="4">停飞</a></li> --%>
	</ul>
	<input type="hidden" id="strState" name="strState" value="${state}" />
</div>
<div class="iconInput left ml10" iconSize="16" width="150" height="28" >
	<input title="姓名" id="strStudentName" name="strStudentName"  type="text" value="${studentName}" maxlength="50" placeholder="姓名" />
	</div>
<div class="iconInput left" iconSize="16" width="150" height="28" >
	<input title="学号" id="strNo" name="strNo"type="text" value="${no}" maxlength="50" placeholder="学号" />
	</div>

<div class="buttonInput relative left " width="180" height="28">
	<input title="合同号" id="strContractNo" name="strContractNo" type="text" value="${contractNo}" maxlength="50" placeholder="合同号" />
	<button id="search">查询</button>
</div>
</div>
    <div class="Panel ui-corner-all-0">
    <div class="panelContent clear">
        <table class="panelTable" border="0" cellspacing="0" cellpadding="3">
            <thead>
	          <tr class="trSpliter">
	            <th></th>
				<th width="240"></th>
				<th width="240"></th>
				<th width="240"></th>
				<th width="240"></th>
				<th width="240"></th>
				<th width="240"></th>
				<th width="200"></th>
				<th width="240"></th>
			  </tr>
			  <tr>
			    <th class="thSortableGray"><input name="users" type="checkbox" id="checkAllStudent"><b></b></th>
				<th class="thSortableGray">姓名</th>
				<th class="thSortableGray">身份证</th>
				<th class="thSortableGray">学号</th>
				<th class="thSortableGray">公司</th>
				<th class="thSortableGray">年级</th>
				<th class="thSortableGray">合同号</th>
				<th class="thSortableGray">状态</th>
				<th class="thSortableGray"><span style="margin-left:40px;">操作</span></th>
			  </tr>
			</thead>
			<tbody>
			 <s:iterator value="studentList">
			   <tr>
			   <td><input name="checkboxName" type="checkbox" value=""  dataid="${studentId}"><b></b></td>
			     <td id="studentName_${studentId}">${studentName}</td>
				<td id="idCard_${studentId}">${idCard}</td>
				<td id="no_${studentId}">${no}</td>
				<td id="company_${studentId}">${company}</td>
				<td id="grade_${studentId}">${grade}</td>
				<td id="contractNo_${studentId}">${contractNo}</td>
				<td id="state_${studentId}">${stateShow}</td>
				<td><a href="javascript:void(0)" class="blue" onclick="test(${studentId})" dataid="${studentId}">修改状态</a>
				    <a href="javascript:void(0)" class="blue" onclick="contractListByNo(${studentId},'${contractNo}')">明细</a>
				</td>
				<form action="<%=request.getContextPath()%>/system/contractListByNo.do?StudentId=${studentId}" method="post" id="${studentId}">						
						<input type="hidden" id="nohidden" name="no" value="${no}"/>
						<input type="hidden" id="contractNohidden" name="contractNo" value="${contractNo}"/>
				</form>
			  </tr> 
			</s:iterator>			  
			</tbody>
        </table>
        <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30" align="right" class="link11">
<a href="javascript:firstPage();" class="blue"><span class="STYLE2">首页</span></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="javascript:prePage();" class="blue"><span class="STYLE2">上一页</span></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="javascript:nextPage();" class="blue"><span class="STYLE2">下一页</span></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="javascript:lastPage();" class="blue"><span class="STYLE2">尾页</span></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button"  value="跳转到" class="aLinkCommonBtn" onClick="jumpPage();">第<input type="text" name="page.currentPageNo" size="2" value="1" id="page.currentPageNo" style="height:24px; width:20px;border:1px solid #BBB;
border-radius:2px" onKeyPress="enterPress(this)"/>页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    本页显示1-7条 / 共1页7条
	</td>
  </tr>
</table>
    </div>
    </div>
</div>
</div>
<div id="dialogForm1" title="修改学生状态">
	<p class="validateTips">请填写所有信息</p>
	<form action="<%=request.getContextPath()%>/system/studentManagent_updateStudent.do" method="post" id="UpdateStudent">
	
	<input type="hidden" id="studentId" name="studentId" value=""/>
		<div class="jffpline clear">
		    <label class="jffp1">状态</label>

            <div class="popSelectWrap">
            <span class="popSelectArrowW">
                <span class="popSelectArrow ui-icon ui-icon-carat-1-s"></span>
            </span>
            <select id="selectStuStatus" class="popSelect" name="state">
                <!-- <option value="607" selected="selected">未入校</option>
                <option value="608">入校</option>
                <option value="609">进入训练</option>
                <option value="610">停飞</option> -->
            </select>
            </div>
		</div>
		<!-- <div class="jffpline clear otherline">
		    <label class="jffp1">进入训练时间</label>
		    <input type="text" id="strJoinTime" name="joinTime" value="" class="tableinput date" onmousedown="WdatePicker()" />
	    </div> -->
		<div class="jffpline tfline clear">
		    <label class="jffp1">停飞原因</label>
            <textarea id="strStopReason"  name="stopReason" cols="20" rows="2" class="mulTxt"></textarea>
		</div>
		<div class="jffpline tfline clear">
		    <label class="jffp1">停飞时间</label>
		    <input type="text" id="strStopTime"  name="stopTime" value="" class="tableinput date" onmousedown="WdatePicker()" />
	    </div>
	</form>
</div>

<form action="<%=request.getContextPath()%>/system/studentManagent_showManagent.do"
		method="post" id="readStudent">
		<input type="hidden" name="studentName" id="studentName" value="${studentName}"> 
		<input type="hidden" name="state" id="state" value="${state}">
		<input type="hidden" name="no" id="no" value="${no}">
		<input type="hidden" name="grade" id="grade" value="${grade}">
	    <input type="hidden" name="contractNo" id="contractNo" value="${contractNo}">
		<input type="hidden" name="company" id="company" value="${company}"> 
	</form>
</body>
</html>
