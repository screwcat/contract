<%@ page language="java" import="com.opensymphony.xwork2.ActionContext" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>合同管理</title>
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
<script src="<%=request.getContextPath()%>/pages/contract/js/contract.js"></script>
<!-- 此js务必放在所有页面自带的js后面加载 -->
<script src="<%=request.getContextPath()%>/contract/scripts/base.min.js"></script>
<script src="<%=request.getContextPath()%>/contract/scripts/time.js"></script>
<script>

</script>

</head>
<body>
	<jsp:include page="/pages/common/topPart.jsp"></jsp:include>
	<jsp:include page="/pages/common/leftPart.jsp"></jsp:include>
	<div id="rightPartA" style="overflow-x: hidden;">
		<div>
			<div>
				<button id="Button2" class="green" style="margin-left: 13px;">新增合同</button>
				<button id="Button3" class="green" style="margin-left: 13px;">复制合同</button>
			</div>				
			<div class="panelBox buttonBox">
			    <!-- 年份 -->
				<div class="dropDownList barLeft" id="dropDownList0" id="Div1">
					<button id="timehidden" name="timehidden">${year}</button>
					<ul id="yearSelect">
					</ul>
					<input type="hidden" name=""  value="${year}" />
				</div>
				<input type="hidden" name="strSignTime" id="strSignTime" value="2" />
				<!-- 合同类型 -->
				<div class="dropDownList barMiddle" id="Div2">
					<button name="typehidden" id="typehidden" value=""></button>
					<ul id="status">
					</ul>
					<input type="hidden" name="" value="${typeName}" />
				</div>
				<input type="hidden" name="strType" id="strType" value="${type }" />
				<!-- 签约单位 -->
				<div class="dropDownList barMiddle" id="Div3">
					<button name="cmphidden" id="cmphidden" value=""></button>
					<ul id="compys">
					</ul>
					<input type="hidden" name=""  value="${compyName }" />
				</div>
				<input type="hidden" name="strCompy" id="strCompy" value="${compy }" />
				<!-- 学生类型 -->
				<div class="dropDownList barMiddle" id="Div4">
					<button id="stutypehidden" name="stutypehidden" value=""></button>
					<ul id="stu">
					</ul>
					<input type="hidden" name=""  value="${stuTypeName}" />
				</div>
				<input type="hidden" name="strStuType" id="strStuType" value="${stuType }" />
				<!-- 学生年级 -->
				<div class="dropDownList barMiddle" id="Div5">
					<button id="stugradehidden" name="stugradehidden">${stuYear}</button>
					<ul id="classSelect">
					</ul>
					<input type="hidden" name=""  value="${stuYear}" />
				</div>
				<input type="hidden" name="strGradeInfo" id="strGradeInfo" value="1" />
				<!-- 合同状态 -->
				<div class="dropDownList barMiddle" id="Div6">
					<button>合同状态</button>
					<ul>
					    <li><a href="javascript:getContractStatus('0')" val="0"><span class="ui-icon ui-icon-bullet"></span>合同状态</a></li>
					    <li><a href="javascript:getContractStatus('1')" val="1">意向</a></li> 
						<li><a href="javascript:getContractStatus('2')" val="2">初稿</a></li>
						<li><a href="javascript:getContractStatus('3')" val="3">定稿</a></li>
						<li><a href="javascript:getContractStatus('4')" val="4">生效</a></li>
						<li><a href="javascript:getContractStatus('5')" val="5">完成</a></li>
						<li><a href="javascript:getContractStatus('6')" val="6">终止</a></li>
					</ul>
					<input type="hidden" name="cstatusStr" id="cstatusStr" value="${cstatus}" />
				</div>
				<div class="buttonInput relative left ml10" width="180" height="28">
					<input title="合同号" id="strContractId" name="strContractId" placeholder="合同号"
						type="text" maxlength="50"  value="${contractId}" />
					<button id="queryContract">查询</button>
				</div>
				<!-- 查询的提交表单的隐藏域 -->
				<form id="contractQueryList" name="contractQueryList"
					action="<%=request.getContextPath()%>/contract/cContractQueryList.do" method="post">
					<input type="hidden" name="contractId" id="contractId"/> 
					<input type="hidden" name="signTime" id="signTime"/> 
					<input type="hidden" name="type" id="type"  />
					<input type="hidden" name="compy" id="compy" /> 
					<input type="hidden" name="stuType" id="stuType" /> 
					<input type="hidden" name="gradeInfo" id="gradeInfo"/>
					<input type="hidden" name="cstatus" id="cstatus" />
				</form>
				<form id="copyContract" name="copyContract"
					action="<%=request.getContextPath()%>/contract/copyContract.do" method="post">
					<input type="hidden" name="selcontractid" id="selcontractid"/>
					
				</form>
			</div>
			<div class="Panel ui-corner-all-0">
				<div class="panelContent clear">
					<table class="panelTable" border="0" cellspacing="0" cellpadding="3">
						<thead>
							<tr class="trSpliter">
								<th></th>
								<th width="80"></th>
								<th width="220"></th>
								<th width="180"></th>
								<th width="120"></th>
								<th width="220"></th>
								<th width="120"></th>
								<th width="120"></th>
								<th width="120"></th>
								<th width="180"></th>
							</tr>
							<tr>
								<th class="thSortableGray"></th>
								<th class="thSortableGray">年份</th>
								<th class="thSortableGray">合同名称</th>
								<th class="thSortableGray">合同号</th>
								<th class="thSortableGray">合同类型</th>
								<th class="thSortableGray">签约单位</th>
								<th class="thSortableGray">学生类型</th>
								<th class="thSortableGray">学生年级</th>
								<th class="thSortableGray">合同状态</th>
								<th class="thSortableGray" style="text-align:center;">操作</th>
							</tr>
						</thead>
						<tbody>
							<!-- 对 查询结果迭代循环 -->
							<s:iterator value="contractExtends">
									
								<tr>
									<td><input name="checkbox" class ="checkbox" type="checkbox" value="${CContractId}"  dataid="${CContractId}"/><b></b>
									</td>
									<!--年份  -->
									<td>${CSignTime}</td>
									<!-- 合同名称 -->
									<td>${CName}</td>
									<!-- 合同号 -->
									<td>${CContractId}</td>
									<!-- 合同类型 -->
									<td>${CTypeName}</td>
									<!-- 签约单位 -->
									<td>${CCompyName}</td>
									<!-- 学生类型 -->
									<td>${CStuTypeName}</td>
									<!-- 学生年级 -->
									<td>${CGradeInfo}</td>
									<!-- 合同状态 -->
									<td>
									    <c:if test="${CStatus=='1'}">意向 </c:if>
									    <c:if test="${CStatus=='2'}">初稿 </c:if>
									    <c:if test="${CStatus=='3'}">定稿 </c:if>
									    <c:if test="${CStatus=='4'}">生效 </c:if>
									    <c:if test="${CStatus=='5'}">完成 </c:if>
									    <c:if test="${CStatus=='6'}">终止 </c:if>
									</td>
									<!-- 操作 --><%-- contractRecPayment.do?${CId} --%>
									<td ><a href="contractInit.do?CID=${CId}" class="blue" style="font-size:13px;">初始化</a>
										<a href="selContract.do?CID=${CId}" class="blue" style="font-size:13px;">完善</a> 
										<a href="javascript:viewContract('${CId}')" class="blue" style="font-size:13px;" >查看</a>
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
			${pageStr}		
				</div>
			</div>
		</div>
	</div>

	<!-- 查看合同.do -->
	<form name="viewContract" id="viewContract"
		action="<%=request.getContextPath()%>/contract/cViewContract.do">
		<input type="hidden" name="CID" id="CID"/>
	</form>

	<script>
		$(function() {
			//checkbox选中 
			$(".checkbox").click(function(){  
				 var dataid=$(this).attr("dataid");
				 $("#selcontractid").val($(this).val());
				 $(".checkbox").each(function(){   
				    if(dataid!=$(this).attr("dataid")){
					   $(this).attr("checked",false);
					   $(this).parent().parent().find("td").removeClass();
					   $(this).next().removeClass().addClass("check boxunhecked");
				    }
				 });
			  });
		    /* 复制合同 */
			$('#Button3').click(function() {
				var ischeck=false;
				var chVal ;
				$(".checkbox").each(function(){  
				    if($(this).next().hasClass("boxChecked")==true){
					    chVal = $(this).val();
						ischeck=true;
				    }
				 });
				if(ischeck){
				 /* alert(chVal);
					alert(getLength(chVal)); */
					if(getLength(chVal)>2){ //最多复制两级 
						alert("您要复制的合同编号过长!");
					}else{
						$('#copyContract').submit()
					}					
				}
				else{
					alert("请选择一个合同");
				}
			});
			//判断字符是否匹配 
			function getLength(str){
				 if(/-/.test(str)){
				    return str.match(/-/ig).length;
				 }
				 return 1;
			}
			
			/* 新增合同 */
			$('#Button2').click(function() {
				window.location.href = '<%=request.getContextPath()%>/pages/contract/cAddContract.jsp';
			});
			
		})
	</script>
</body>
</html>
