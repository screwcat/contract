﻿<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>主页</title>
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
    <!-- 此js务必放在所有页面自带的js后面加载 -->
    <script src="<%=request.getContextPath()%>/contract/scripts/base.min.js"></script>
    <script src="<%=request.getContextPath()%>/contract/scripts/time.js"></script>
</head>
<body>
<jsp:include page="/pages/common/topPart.jsp"></jsp:include>
<jsp:include page="/pages/common/leftPart.jsp"></jsp:include>
<div id="rightPartA" style="overflow-x:hidden;">
    <div class="contract_list_wrap">
        <div class="Panel">
            <div class="panelHead">
                <span>待处理合同</span>
            </div>
            <div class="panelContent">
                <table class="panelTable" cellspacing="0" cellpadding="3" border="0">
                	<s:iterator value="cont">
                		<c:if test="${CStatus=='1'}">
	                    <tr>
	                        <td id="line">
	                        	<%-- <a href="<%=request.getContextPath()%>/contract/cUpdateContract.htm" class="default"> --%>
	                            <a href="javascript:viewContract('${CId}')" class="default">
	                            ${CName }&nbsp;意向</a>
	                        </td>
	                    </tr>
                    	</c:if>
                   </s:iterator>
                  <s:iterator value="cont">
                  	<c:if test="${CStatus=='2'}">
	                    <tr>
	                        <td id="line">
	                        	<%-- <a href="<%=request.getContextPath()%>/contract/cModifyContract.htm" class="default"> --%>
	                             <a href="javascript:viewContract('${CId}')" class="default"> 
	                            ${CContractId }&nbsp;初稿</a>
	                        </td>
	                    </tr>
                    </c:if>
                   </s:iterator>
                </table>
            </div>
        </div>
    </div>
    
    <div class="contract_list_wrap">
        <div class="Panel">
            <div class="panelHead">
                <span>待处理收款</span>
            </div>
            <div class="panelContent">
                <table class="panelTable" cellspacing="0" cellpadding="3" border="0">
                  <s:iterator value="paymen"> 
                   <c:if test="${PArrears<'0'}">
                    <tr>
                        <td>
                        	<a href="javascript:viewpay('${PId}')" class="red">${PContractId }&nbsp;有欠款</a>
                        </td>
                    </tr>
                    </c:if>
                   </s:iterator>
				    <s:iterator value="paymen">
				    <c:if test="${PReceiveDate>'0'}">
	                    <tr>
	                        <td>
	                           <a href="javascript:viewpay('${PId}')" class="default">${PContractId }&nbsp;将到收款日</a>
	                        </td>
	                    </tr> 
	                </c:if>
                    </s:iterator>
                </table>
            </div>
        </div>
    </div>
</div>
	<!-- 查看合同.do -->
	<form name="viewContract" id="viewContract"
		action="<%=request.getContextPath()%>/selContract.do">
		<input type="hidden" name="CID" id="CID">
		<!-- <input type="hidden" name="cId" id="cId"> -->
	</form>
	<!-- 查看付款.do -->
	 <form name="viewPay" id="viewpay"
		action="<%=request.getContextPath()%>/updateSearch.do">
		<!-- <input type="hidden" name="PId" id="PId"> -->
		<input type="hidden" name="serialHide" id="serialHide">
	</form> 
	<script>
	 function viewContract(CId){
    		$("#CID").val(CId);
			$("#viewContract").submit();
    	};
   	  function viewpay(PId){
   		  $("#serialHide").val(PId);
    	 /*  $("#PId").val(PId); */
		  $("#viewpay").submit();
    	};    
	</script>
</body>
</html>
