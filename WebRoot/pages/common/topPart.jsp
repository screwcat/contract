<%@page contentType="text/html; charset=UTF-8"%><%@ taglib prefix="s"
	uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<div id="indexHead">
		<div class="headercontent">
			<img
				src="<%=request.getContextPath()%>/contract/themes/cupertino/images/kylogo.png" />
			<span class="sysNameC">民航凯亚飞行培训合同管理系统</span>
			<div class="sysNameE">  Necares Flight Training Contract Management System</div>
			<div class="logout">
				<span class="today" id="Clock"></span> 
				<span class="wel">欢迎</span> 
				<a href="#">${realun}</a> <span class="sep"></span> 
				<a href="#" id="click">退出</a>
				<input type="hidden" name="ui" id="ui" value="${ui}">
			</div>
		</div>
	</div>
	<div id="diag"  title="退出系统">
		<p class="validateTips"></p>
		<div>您确定要退出系统吗?</div>
	</div><%-- window.location.href = '<%=request.getContextPath()%>/pages/login/userLogin.jsp';  --%>
	<script>
		$('#click').click(function(){
			
			tips = $(".validateTips");
		    function updateTips(t) {
		        tips.html(t).addClass("ui-state-highlight");
		        setTimeout(function() {
		            tips.removeClass("ui-state-highlight", 1500);
		        }, 2000);
		    }
		    //$("#dia").dialog("open");
			$('#diag').dialog({
				//autoOpen: false,
		        height: 200,
		        width: 500,
		        background: '#FF0000', // 背景色
		        opacity: 0.27,     // 透明度
		        modal: true,
		        resizable: false,
		        buttons: {
		       	 "确 定": function() {	
		       		window.location.href = '<%=request.getContextPath()%>/contract/back.do';
		       	 },
		       	 "取 消": function() {
		              $(this).dialog("close");
		             // window.history.back();
		            }
		        }
			});	
	         
			
		})
	</script>