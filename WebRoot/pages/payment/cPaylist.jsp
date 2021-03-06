<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>付款管理</title>
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
    <script src="<%=request.getContextPath()%>/pages/payment/js/cPaylist.js" type="text/javascript"></script>
    <script>
    $(function() {
/*         new $.dropDownList(0, true, 180);
        new $.dropDownList(1, true, 180);
        new $.dropDownList(2, true, 180);
 */    });
    
    
</script>
    <!-- 此js务必放在所有页面自带的js后面加载 -->
    <script src="<%=request.getContextPath()%>/contract/scripts/base.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/time.js"></script>
</head>
<body>
<jsp:include page="/pages/common/topPart.jsp"/>
<jsp:include page="/pages/common/leftPart.jsp"/>
<div id="rightPartA" style="overflow-x:hidden;">
<div>
<div class="panelBox buttonBox">
<!-- panelBox计划用于布局横向的简单一行 -->
<div class="dropDownList barLeft" id="div1">
	<button id = "yearStr">${year}</button>
	<ul id="classSelect">
	</ul>
	<input type="hidden" name="${year}" value="${year}" />
</div>
<div class="dropDownList barMiddle" id="div2">
	<%-- <button id="trainingstatus">${trainName}</button>
	<ul id="status">
	</ul>
	<input type="hidden" name="${trainName}" value="${trainName}" /> --%>
	<button>付款状态</button>
	<ul>
		<li><a href="javascript:getPayNotice('0')" val="0"><span class="ui-icon ui-icon-bullet"></span>付款状态</a></li>
		<li><a href="javascript:getPayNotice('2')" val="2">已付款</a></li>
		<li><a href="javascript:getPayNotice('3')" val="3">已通知</a></li>
		<li><a href="javascript:getPayNotice('4')" val="4">未通知</a></li>
	</ul>
	<input type="hidden" name="payNoticeStr" id="payNoticeStr" value="${payNotice}" />
</div>
<div class="dropDownList barMiddle" id="div3">
	<button>${compyName}</button>
	<ul id="paycompany">
	</ul>
	<input type="hidden" name="${compyName}" value="${compyName}" />
	
</div>
<div class="iconInput left ml10" iconSize="16" width="150" height="28" >
	<input id="pensioner" title="自费生姓名" type="text" maxlength="50" placeholder="自费生姓名" value="${C_PRIVATE_NAME }" />
	</div>
<div class="buttonInput relative left ml10" width="180" height="28">
	<input id="ccontractid" title="合同号"  type="text" maxlength="50" placeholder="合同号" value="${CContractId }" />
	<button  id="searchPaylist">查询</button>
</div>
</div>
    
    <div class="Panel ui-corner-all-0">
    <div class="panelContent clear">
        <table class="panelTable" border="0" cellspacing="0" cellpadding="3">
            <thead>
	          <tr class="trSpliter">
				<th width="60"></th>
				<th width="240"></th>
				<th width="180"></th>
				<th width="180"></th>
				<th width="180"></th>
				<th width="180"></th>
				<th width="180"></th>
				<th width="210"></th>
			  </tr>
			  <tr>
				<th class="thSortableGray">序号</th>
				<th class="thSortableGray">付款单位/自费生</th>
				<th class="thSortableGray">合同号</th>
				<th class="thSortableGray">付款节点</th>
				<th class="thSortableGray">计划付款金额(元)</th>
				<th class="thSortableGray">计划付款日期</th>
				<th class="thSortableGray">付款状态</th>
				<th class="thSortableGray" style="text-align:center;"><span class="ml10">操作</span></th>
			  </tr>
			</thead>
			<form action="<%=request.getContextPath()%>/showPaylist.do" method="post" id="searchForm" >
				<!-- 自费生姓名  -->
				<input type="hidden" name="C_PRIVATE_NAME" id="pensionerHide" />
				<!-- 合同号 -->
				<input type="hidden" name="CContractId" id="ccontractidHide" />
				<!-- 训练状态 -->
				<!-- <input type="hidden" name="TrainingStatus" value="0" id="trainingstatusHide" /> -->
				<!-- 付款状态 -->
				<input type="hidden" name="payNotice" id="payNotice"  />
				<!-- 训练单位 -->
				<input type="hidden" name="compyId" id="compyId" value="0"/>
				<!-- 年份 -->
				<input type="hidden" name="cyear" value="" id="cyear" />
				
			</form>
			
			
			<tbody>
			<s:iterator value="viewPaylist" >
					<tr>
						<td id="serial">${p_id}</td>
						<td>${c_compy}${CPrivateName}</td>
						<td>${PContractId }</td>
						<td>${p_name}</td>
						<td>${p_receive_money}</td>
						<td class="pdate">${PReceiveDate }</td>
						<td><%-- ${p_status} --%>
						<c:if test="${pNoticeStatus=='2'}">已付款</c:if>
						<c:if test="${pNoticeStatus=='3'}">已通知</c:if>
						<c:if test="${pNoticeStatus=='4'}">未通知</c:if>
						</td>	
			    <td><a href="javascript:void(0)" class="blue"  onclick="SearchUpdate(${p_id})" id="update">付款阶段</a>
			        <a href="javascript:void(0)" class="blue"  onclick="" id="update">付款通知</a></td>
					<form action="<%=request.getContextPath()%>/updateSearch.do" method="post" id="searchUpdate">
						<input type="hidden" id="serialHide" name="serialHide">
						<input type="hidden" id="ccontractidHide" name="CContractId"/>
					</form>
				</tr>
				<input type="hidden" name="date1" class="date1" value="${PReceiveDate }" />
			</s:iterator>
			</tbody>
        </table>
        ${pageStr}	
    </div>
    </div>
</div>
</div>
<%-- <input type="hidden" name="TrainingStatusStr" id="TrainingStatusStr" value="${TrainingStatus}"> --%>
<input type="hidden" name="compyIdStr" id="compyIdStr" value="${compyId}">
</body>
</html>