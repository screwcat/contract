﻿<%@ page language="java" import="com.opensymphony.xwork2.ActionContext"  pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>所有用户管理</title>

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
<script src="scripts/function.min.js"></script>

<style>
/*功能9*/
fieldset { padding: 0 1em 0 1em; border:0; width: 85%; }
.validateTips { border: 1px solid transparent; padding: 0 0.5em 0 0.5em; margin: 0; line-height: 30px; }
/*功能9*/

</style>

<script>
//用于存储选中的复选框的value值
//var values = "";
$(function() {

	//功能5
	$("div.dropDownList").find("button").css("width","100px").end().each(function(i){
		new $.dropDownList(i,true,100);
	})
	var $checkboxes=$("input[name='checkboxName']"),$checkAllUsersBox=$("#checkAllUsersBox");
	$checkboxes.change(function(){
	    //当复选框去掉选中状态后，将全选按钮的选择状态去掉（即去掉全选复选框的选中状态）
		if(!this.checked){
		   $checkAllUsersBox[0].checked=false;
		}
		//如果复选框的总数与选中状态的复选框数量相同，则表明当前页面中的所有复选框均被选中，然后将全选复选框的选中状态设为选中
		if($checkboxes.size()==$checkboxes.filter(":checked").size()) {
		  $checkAllUsersBox[0].checked=true;
		}
		//设置全选复选框触发change事件
		$checkAllUsersBox.trigger("change");

	});
	
	//全选复选框的单击事件
	$checkAllUsersBox.click(function(){
	    //当全选复选框处于选中或非选中状态时，循环处理每个复选框的状态，即当全选复选框当前的状态循环赋给每个复选框
		$checkboxes.each(function(){
			this.checked = $checkAllUsersBox[0].checked;
			$(this).trigger("change");

		});
	});

	var name = $( "#username" ),
		passObj = $( "#pass" ),
		againPassObj =  $( "#againPass" ),
		epassObj = $( "#epass" ),
		eagainPassObj =  $( "#eagainPass" ),
		allFields = $( [] ).add( name ).add( passObj ).add( againPassObj ).add( epassObj ).add( eagainPassObj ),
		tips = $( ".validateTips" );

	function updateTips( t ) {
		tips.html( t ).addClass( "ui-state-highlight" );
		setTimeout(function() {
			tips.removeClass( "ui-state-highlight", 1500 );
		},0 );
	}

	function checkLength( o, n, min, max ) {
		if ( o.val().length > max || o.val().length < min ) {
			o.addClass( "error" ).focus();
			updateTips( "<span class='ui-icon-custom ui-icon-custom-warning' style='margin-top: 6px;'></span>" + n + "的长度必须在" +
				min + "和" + max + "之间" );
			return false;
		} else {
			return true;
		}
	}

	function checkRegexp( o, regexp, n ) {
		if ( !( regexp.test( o.val() ) ) ) {
			o.addClass( "error" ).focus();
			updateTips( "<span class='ui-icon-custom ui-icon-custom-warning' style='margin-top: 6px;'></span>" + n );
			return false;
		} else {
			return true;
		}
	}
	
	function checkDiag( o,n ) {
		o.addClass( "error" ).focus();
		updateTips( "<span class='ui-icon-custom ui-icon-custom-warning' style='margin-top: 6px;'></span>" + n );
		return false;
	}

	$( "#dialogForm1" ).dialog({
		autoOpen: false,
		height: 400,
		width: 400,
		modal: true,
		resizable: false,
		buttons: {
			"确 定": function() {
				//确定按钮的处理代码段：
				var bValid = true;
				allFields.removeClass( "error" );

				var unameObj = $("#username");
				var passObj = $("#pass");
				var againPassObj = $("#againPass");
				
				bValid = bValid && checkLength( unameObj, "用户账号", 3, 100);
				//bValid = bValid && checkLength( passObj, "登录密码", 3, 100);
				/*
				if(passObj.val() != ""){
				    if(passObj.val() != againPassObj.val()){
					   bValid = bValid && checkDiag(passObj,"两次密码输入不一致，请确认后重试!");
					}
				}
				*/

				if ( bValid ) {

				    $("#cuname").val($("#username").val());
					$("#cpass").val("111111");
					
					$("#cVJob").val($("#VJob").val());
					$("#cVRealname").val($("#VRealname").val());
					$("#cldap").val($("#ldapid").val());
					//获取单选按钮value值
					var isSystemUser = $("input[name='isSystem']:checked").val();
					
					$("#cadmin").val(isSystemUser);
					
					$("#userForm").submit();
					
					$( this ).dialog( "close" );
				}


			},
			"取 消": function() {
			    /*
				   由于添加和修改功能共用了一个dialogForm1，所以单击“取消”按钮时，要注意如下问题：
				   1、单击“取消”按钮后，将dialogForm1中的各个文本框和密码框置空，因为当修改某条信息时，如果没有提交而是单击了编辑页面的“取消”按钮后，该条信息的值会缓存在dialogForm1                      中的各个文本框和密码框中
				   2、当修改某条信息时userForm表单的action属性已经设置为更新的地址，当单击“取消”按钮后，应恢复成添加的请求地址				
				*/
				$("#VId").val("");
				$("#username").val("");
				$("#pass").val("");
				$("#againPass").val("");
				$("#VJob").val("");
				$("#VRealname").val("");
				$("#ldapid").val("");
				$("#dialogForm1").dialog('option', 'title', '新建用户账号');
				$("#userForm").attr("action","createSystemUserAccount.do");
				$( this ).dialog( "close" );
				updateTips("");
			}
		},
		close: function() {
			allFields.val( "" ).removeClass( "error" );
		}
	});
	
	$( "#editForm1" ).dialog({
		autoOpen: false,
		height: 400,
		width: 400,
		modal: true,
		resizable: false,
		buttons: {
			"确 定": function() {
				//确定按钮的处理代码段：
				var bValid = true;
				allFields.removeClass( "error" );

				var passObj = $("#epass");
				var againPassObj = $("#eagainPass");

				/*
				if(passObj.val() != ""){
				    if(passObj.val() != againPassObj.val()){
					   bValid = bValid && checkDiag(passObj,"两次密码输入不一致，请确认后重试!");
					}
				}
				*/

				if ( bValid ) {

					$("#cpass").val("111111");
					
					//获取单选按钮value值
					var isSystemUser = $("input[name='eisSystem']:checked").val();
					
					$("#cadmin").val(isSystemUser);
					$("#cuname").val($("#eusernameid").val());;
					$("#cVJob").val($("#eVJob").val());
					$("#cVRealname").val($("#eVRealname").val());
					$("#cldap").val($("#eldapid").val());
					$("#userForm").submit();
					
					$( this ).dialog( "close" );
				}


			},
			"取 消": function() {

				$("#VId").val("");
				$("#username").val("");
				$("#ldapid").val("");
				$("#pass").val("");
				$("#againPass").val("");
				$("#dialogForm1").dialog('option', 'title', '新建用户账号');
				$("#userForm").attr("action","createSystemUserAccount.do");
				$( this ).dialog( "close" );
				updateTips("");
			}
		},
		close: function() {
			allFields.val( "" ).removeClass( "error" );
		}
	});

     //新建用户账号
	$("#modalDialogButton1").click(function(){
	    
		$( "#dialogForm1" ).dialog( "open" );
		
	});




    //删除用户账号
	$("#modalDialogButton2").click(function(){
        //将选中的用户账号的id使用逗号（,）拼接在一起
        var count =0;
		var ids="";
		var r1 = document.getElementsByName('checkboxName');
		for(i=0; i<r1.length; i++){
			if(r1[i].checked == true){
				count++;
				ids += r1[i].value + ",";
			}
		}
		
		if(count == 0){
			$("#dialogForm3Warning").html("<br/>请选择要删除的用户账号！"); //dialogForm3Warning：用于提示警告信息
			$( "#dialogForm3" ).dialog( "open" );
			return;
		}
		//进行相应的删除操作
		$("#usersidsStr").val(ids);
		$( "#dialogForm2" ).dialog( "open" );  //dialogForm2：用于进行删除的提示警告信息
		 
	});

    //停用用户账号
	$("#modalDialogButton3").click(function(){
        //将选中的用户账号的id使用逗号（,）拼接在一起
        var count =0;
		var ids="";
		var r1 = document.getElementsByName('checkboxName');
		for(i=0; i<r1.length; i++){
			if(r1[i].checked == true){
				count++;
				ids += r1[i].value + ",";
			}
		}
		
		if(count == 0){
			$("#dialogForm3Warning").html("<br/>请选择要停用的用户账号！"); //dialogForm3Warning：用于提示警告信息
			$( "#dialogForm3" ).dialog( "open" );
			return;
		}
		//进行相应的停用操作
		$("#stopusersidsStr").val(ids);
		$( "#dialogForm5" ).dialog( "open" );  //dialogForm2：用于进行停用的提示警告信息
		 
		 
		   
		
	});

    //恢复用户账号
	$("#modalDialogButton4").click(function(){
        //将选中的用户账号的id使用逗号（,）拼接在一起
        var count =0;
		var ids="";
		var r1 = document.getElementsByName('checkboxName');
		for(i=0; i<r1.length; i++){
			if(r1[i].checked == true){
				count++;
				ids += r1[i].value + ",";
			}
		}
		
		if(count == 0){
			$("#dialogForm3Warning").html("<br/>请选择要恢复的用户账号！"); //dialogForm3Warning：用于提示警告信息
			$( "#dialogForm3" ).dialog( "open" );
			return;
		}
		//进行相应的恢复操作
		$("#recoverusersidsStr").val(ids);
		$( "#dialogForm6" ).dialog( "open" );  //dialogForm2：用于进行恢复的提示警告信息
		 
		 
		   
		
	});


	
	$("#modalDialogButton5").click(function(){//刷新
		$("#searchKey").val("");
		$( "#searchForm" ).submit();
	});
	
	$("#modalDialogButton6").click(function(){//查询
	    var keyvalue = $.trim($("#userAccount").val());
		if(keyvalue == "账号/姓名"){
		   keyvalue = "";		
		}
		//alert($("#searchStatus").val());
		$("#searchKey").val(keyvalue);
		$("#searchUserAccountStatus").val($("#searchStatus").val());
		
		$( "#searchForm" ).submit();
	});



	$( "#dialogForm2" ).dialog({//删除内容窗口
		autoOpen: false,
		height: 200,
		width: 400,
		modal: true,
		resizable: false,
		buttons: {
			"确 定": function() {
				
				$("#deleteForm").submit();
			},
			"取 消": function() {
				$( this ).dialog( "close" );
			}
		},
		close: function() {
			allFields.val( "" ).removeClass( "error" );
		}
	});
	

	$( "#dialogForm5" ).dialog({//停用用户账号窗口
		autoOpen: false,
		height: 200,
		width: 400,
		modal: true,
		resizable: false,
		buttons: {
			"确 定": function() {
				
				$("#stopForm").submit();
			},
			"取 消": function() {
				$( this ).dialog( "close" );
			}
		},
		close: function() {
			allFields.val( "" ).removeClass( "error" );
		}
	});
	

	$( "#dialogForm6" ).dialog({//恢复用户账号窗口
		autoOpen: false,
		height: 200,
		width: 400,
		modal: true,
		resizable: false,
		buttons: {
			"确 定": function() {
				
				$("#recoverForm").submit();
			},
			"取 消": function() {
				$( this ).dialog( "close" );
			}
		},
		close: function() {
			allFields.val( "" ).removeClass( "error" );
		}
	});
	
	$( "#dialogForm3" ).dialog({//警告信息窗口
		autoOpen: false,
		height: 200,
		width: 400,
		modal: true,
		resizable: false,
		buttons: {
			"确 定": function() {
				$( this ).dialog( "close" );
			}
		},
		close: function() {
			allFields.val( "" ).removeClass( "error" );
		}
	});
	$( "#dialogForm4" ).dialog({//操作数据库返回提示窗口
		autoOpen: false,
		height: 200,
		width: 400,
		modal: true,
		resizable: false,
		buttons: {
			"确 定": function() {
				//var search=removeURLArgument(self.location.search,"statusMsg");
				//self.location.search=search;
				$( this ).dialog( "close" );
			}
		},
		close: function() {
			allFields.val( "" ).removeClass( "error" );
		}
	});
	function removeURLArgument(str,args){
	  var argsArray=str.substring(1).split("&");
	  var result="?";
	  for(var i=0;i<argsArray.length;i++){
		  if(i==argsArray.length-1){
			  if(argsArray[i].indexOf(args)<0)
				  result+=argsArray[i];
		  }else{
			  if(argsArray[i].indexOf(args)<0)
				  result+=argsArray[i]+"&";		
		  }
	  }
	  return result;
  }

    //处理导航隐藏
	$("#li1").click(function(){
		$(this).siblings().toggle(200).end().children(".ui-icon").toggleClass("ui-icon-carat-1-s").toggleClass("ui-icon-carat-1-e");
	});


});

	//编辑用户账号信息
    function execEdit(uid){
		//通过json读取字典对象
		params = {"id":uid};

		$.ajax({
			type:"post",
			url:"searchUserAccountById.do",
			data:params,
			dataType:"json",
			success:function(data){
				//编辑为窗口赋值

				$("#VId").val(data.VId);
				$("#eusernameid").val(data.VUsername);
				$("#eVJob").val(data.VJob);
				$("#eVRealname").val(data.VRealname);
				$("#eldapid").val(data.ldap);
				var objs = $("input[name='eisSystem']");
				
				if(objs!= null && objs.length>0){
				   for(var i=0; i<objs.length; i++){
				      
					  var jqueryObj = $(objs[i]);
					  
					  if(objs[i].value == data.IAdminStatus){
					      objs[i].checked = true;
					  }
					  
				   }
				}
				$("#userForm").attr("action","updateSystemUserAccount.do");
				$("#editForm1").dialog( "open" );

			},
			error:function(){
				
				$("#dialogForm3Warning").html("<br/>数据库连接错误，获取对象失败，请重试。");
				$( "#dialogForm3" ).dialog( "open" );
				return;
			}
		});	
	}
	
	
	//恢复默认密码
    function recoverPass(uid){
		//通过json读取字典对象
		params = {"id":uid};

		$.ajax({
			type:"post",
			url:"recoverDefaultPassword.do",
			data:params,
			dataType:"json",
			success:function(data){
				if(data == 0){
				   alert("【提示信息】默认密码恢复成功！");
				}else{
				   alert("【提示信息】默认密码恢复失败！");
				}

			},
			error:function(){
				//alert("数据库连接错误，获取对象失败，请重试。");
				$("#dialogForm3Warning").html("<br/>数据库连接错误，获取对象失败，请重试。");
				$( "#dialogForm3" ).dialog( "open" );
				return;
			}
		});	
	}
	
</script>
<!-- 此js务必放在所有页面自带的js后面加载 -->
<script src="scripts/base.min.js"></script>
</head>
<body class="hide">
<div id="leftPartA">
<div>
	<s:action name="open_leftList" executeResult="true">
    <s:param name="parentid">4028816a4714304c014714a1e0b9000a</s:param>
    <s:param name="name"><%=ActionContext.getContext().getName()%></s:param> 
    </s:action>
</div>
</div>

<div id="rightPartA"><div>

<div class="panelBox buttonBox">
<%request.setAttribute("k",ActionContext.getContext().getName());%>
<s:if test="#session.loginContext.urlAddress=='all'">
	<s:set name="r" value="0"/>
</s:if>
<s:else>
	<s:set name="pos" value="#session.loginContext.urlAddress.indexOf(#request.k+'.do')"/>
	<s:if test='#pos==-1'>
		<s:set name="r" value="1"/>
    </s:if>
    <s:else>
		<s:set name="r" value="#session.loginContext.urlAddress.substring(#pos+#request.k.length()+6,#pos+#request.k.length()+7)"/>
    </s:else>
</s:else>
<s:if test="#r==null || #r==0">
	<button id="modalDialogButton1" class="green" primary="ui-icon-button-addperson">新建管理员账号</button>
	<button class="normal barLeft" id="modalDialogButton2">删除账号</button>
	<button class="normal barMiddle" id="modalDialogButton3">停用账号</button>
	<button class="normal barMiddle" id="modalDialogButton4">恢复账号</button>
</s:if>
	<button class="normal <s:if test="#r==null || #r==0">barMiddle</s:if>" id="modalDialogButton5">全部</button>

    <div class="dropDownList barMiddle">
    <button></button><span class="bar"></span>
    <ul>
    <li><a href="?userType=" val=""><span class="ui-icon ui-icon-bullet"></span>用户类型</a></li>
    <li><a href="?userType=1" val="1">学员</a></li>
    <li><a href="?userType=2" val="2">教员</a></li>
    <li><a href="?userType=3" val="3">管理员</a></li>
    <li><a href="?userType=4" val="4">其他人员</a></li>
    </ul><input type="hidden"  id="userTypeid" value="${userType}" />
    </div>
    <div class="dropDownList barRight">
    <button></button><span class="bar"></span>
    <ul>
    <li><a href="searchAllStatusUserInfos.do?searchStatus=10" val="10"><span class="ui-icon ui-icon-bullet"></span>状态</a></li>
    <li><a href="searchAllStatusUserInfos.do?searchStatus=0" val="0"><span id="0"></span>正常(开通)</a></li>
    <li><a href="searchAllStatusUserInfos.do?searchStatus=1" val="1"><span id="1"></span>停用</a></li>
    <li><a href="searchAllStatusUserInfos.do?searchStatus=-1" val="-1"><span id="-1"></span>删除</a></li>
    </ul><input type="hidden"  id="searchStatus" value="${searchStatus}" />
    </div>
	
    <div class="buttonInput relative left" width="160" height="28">
       <input id="userAccount" name="userAccount"  type="text" maxlength="50" value="账号/姓名" title="账号/姓名"/>  
	  <button id="modalDialogButton6">查询</button>
    </div>
</div>






<div class="Panel ui-corner-all-0" id="Panel2">


	<div class="panelContent">

		<table class="panelTable" id="usersTable" border="0" cellspacing="0" cellpadding="3">
			<thead>
			  <tr class="trSpliter">
				<th width="40"></th>
				<th width="80"></th>
                <th width="90"></th>
                <th width="75"></th>
                <th width="75"></th>
                <th width="170"></th>
				<th width="100"></th>
				<th width="75"></th>
				<th width="150"></th>
                <th></th>
			  </tr>
			  <tr>
				<th class="thSortableGray" style="padding-left: 6px;"><input type="checkbox" value="" id="checkAllUsersBox"><b></b></th>
				<th class="thSortableGray">用户账号</th>
                <th class="thSortableGray">Ldap账号</th>
                <th class="thSortableGray">用户类型</th>
                <th class="thSortableGray">姓名</th>
                <th class="thSortableGray">所在部门</th>
                
				<th class="thSortableGray">用户状态</th>
				<th class="thSortableGray">管理员</th>
				<th class="thSortableGray">创建时间</th>
				<th class="thSortableGray"></th>
			  </tr>
			</thead>
			<tbody>
			<s:iterator value="page.data">
			  <tr>
				<td><s:if test="VUsername!='admin'"><input name="checkboxName" type="checkbox" value="${VId}"><b></b></s:if></td>
				<td >${VUsername}</td>
                 <td>${ldap}</td>
                <td ><s:if test='IUserType==1'>学员</s:if>
                <s:if test='IUserType==2'>教员</s:if>
                <s:if test='IUserType==3'>管理员</s:if>
                <s:if test='IUserType==4'>其他人员</s:if>
                </td>
                <td>${VRealname}</td>
                <td>${VJob}</td>
				<td>
				   <s:if test="IStatus == 0">
				       已开通
				   </s:if>
				   <s:elseif test="IStatus == 1">
				       已停用
				   </s:elseif>
                   <s:elseif test="IStatus == -1">
				       已被删除
				   </s:elseif>
				   
				</td>
				<td>
				   <s:if test="IAdminStatus == 0">
				       否
				   </s:if>
				   <s:elseif test="IAdminStatus == 1">
				       是
				   </s:elseif>
				</td>
				<td>	
				    <s:date name="DCreateDate" format="yyyy-MM-dd HH:mm:ss" />		   
				</td>
				<td>
				  <s:if test="VUsername!='admin'"> <s:if test="#r==null || #r==0"><a href="javascript:execEdit('${VId}')" class="blue">修改</a></s:if></s:if>
				</td>
			  </tr>
			</s:iterator> 
            <s:iterator value="(page.pageSize-page.data.size).{ #this }">
			  <tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td></td>
                <td></td>
                <td></td>
                <td>&nbsp;</td>
				<td>&nbsp;</td>
			  </tr>
              </s:iterator>
			</tbody>
		</table>
<s:include value="../common/pagination_system.jsp" />

</div>
</div>
</div>
</div>


<div id="dialogForm1" title="新建用户账号">
	<p class="validateTips">请填写所有信息</p>

	<fieldset>
     Ldap账号：
     <input type="text" id="ldapid" class="text ui-widget-content ui-corner-all"  style="width:200px;"/>
    <span class="panelLine"></span>
		用户账号：
		<input type="text" name="username" id="username" class="text ui-widget-content ui-corner-all"  style="width:200px;"/>
        <span class="panelLine"></span>
        真实姓名：
		<input type="text" name="VRealname" id="VRealname" class="text ui-widget-content ui-corner-all"  style="width:200px;"/>
        <span class="panelLine"></span>
        职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务：
		<input type="text" name="VJob" id="VJob" class="text ui-widget-content ui-corner-all"  style="width:200px;"/>
		<input type="hidden" name="pass" id="pass" class="text ui-widget-content ui-corner-all"  style="width:200px;"/>
		<input type="hidden" name="againPass" id="againPass" class="text ui-widget-content ui-corner-all"  style="width:200px;"/>
        <span class="panelLine"></span>
		系统管理员：
		<input type="radio" name="isSystem"  value="1" />是&nbsp;&nbsp;
		<input type="radio" name="isSystem"  value="0" checked="checked"/>否
	</fieldset>

</div>

<div id="editForm1" title="编辑用户账号">
	<p class="validateTips">请填写所有信息</p>

	<fieldset> 
    Ldap账号：
        <input type="text" id="eldapid" class="text ui-widget-content ui-corner-all"  style="width:200px;"/>
        <span class="panelLine"></span>
		用户账号：
        <input type="text" name="username" id="eusernameid" class="text ui-widget-content ui-corner-all"  style="width:200px;"/>
        <span class="panelLine"></span>
         真实姓名：
		<input type="text" name="eVRealname" id="eVRealname" class="text ui-widget-content ui-corner-all"  style="width:200px;"/>
        <span class="panelLine"></span>
        职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务：
		<input type="text" name="eVJob" id="eVJob" class="text ui-widget-content ui-corner-all"  style="width:200px;"/>
        <span class="panelLine"></span>
		<input type="hidden" name="epass" id="epass" class="text ui-widget-content ui-corner-all" style="width:200px;" />
		<input type="hidden" name="eagainPass" id="eagainPass" class="text ui-widget-content ui-corner-all" style="width:200px;" />
		<label for="vadminstatus">系统管理员：</label>
		<input type="radio" name="eisSystem"  value="1" />是&nbsp;&nbsp;
		<input type="radio" name="eisSystem"  value="0" checked="checked"/>否
	</fieldset>

</div>



<div id="dialogForm2">
	<fieldset>
		<div class="panelLeft" style="width: 55px;"><img src="themes/cupertino/images/warning.png" /></div>
		<div class="panelRight" style="margin-left: 75px;">
			<span style="font-size: 14px; font-weight: bold; color: #555555; line-height:23px;">确定要删除选中的信息吗？</span>
		</div>
	</fieldset>	
</div>

<div id="dialogForm3">
	<fieldset>
		<div class="panelLeft" style="width: 55px;"><img src="themes/cupertino/images/warning.png" /></div>
		<div class="panelRight" style="margin-left: 75px;">
			<span style="font-size: 14px; font-weight: bold; color: #555555;" id="dialogForm3Warning"></span>
		</div>
	</fieldset>	
</div>

<div id="dialogForm4">
	<fieldset>
		<div class="panelLeft" style="width: 55px;"><img src="themes/cupertino/images/warning.png" /></div>
		<div class="panelRight" style="margin-left: 75px;">
			<span style="font-size: 14px; font-weight: bold; color: #555555; " id="dialogForm4Span"></span>
		</div>
	</fieldset>	
</div>

<div id="dialogForm5">
	<fieldset>
		<div class="panelLeft" style="width: 55px;"><img src="themes/cupertino/images/warning.png" /></div>
		<div class="panelRight" style="margin-left: 75px;">
			<span style="font-size: 14px; font-weight: bold; color: #555555; line-height:23px;">确定要停用选中的用户账号吗？</span>
		</div>
	</fieldset>	
</div>


<div id="dialogForm6">
	<fieldset>
		<div class="panelLeft" style="width: 55px;"><img src="themes/cupertino/images/warning.png" /></div>
		<div class="panelRight" style="margin-left: 75px;">
			<span style="font-size: 14px; font-weight: bold; color: #555555; line-height:23px;">确定要恢复选中的用户账号吗？</span>
		</div>
	</fieldset>	
</div>



<form id="userForm" method="post" action="createSystemUserAccount.do">
	<input type="hidden" name="tuser.VId" id="VId"/>
	<input type="hidden" name="tuser.VUsername" id="cuname" />
    <input type="hidden" name="tuser.VLdap" id="cldap" />
	<input type="hidden" name="tuser.VPassword" id="cpass" />
	<input type="hidden" name="tuser.IAdminStatus" id="cadmin" />
    <input type="hidden" name="tuser.VRealname" id="cVRealname" />
    <input type="hidden" name="tuser.VJob" id="cVJob" />
	<input type="hidden" name="key" value="${key}"/>
	<input type="hidden" name="pageIndex" value="${pageIndex}"/>
    <input type="hidden" name="userType" value="${userType}" />
</form>

<form  action="searchAllStatusUserInfos.do" method="post" id="searchForm">
  <input name="key" type="hidden" id="searchKey">
  <input name="searchStatus" type="hidden" id="searchUserAccountStatus">
  <input type="hidden" name="userType" value="${userType}" />
</form>
<form  action="deleteUserAccountForAllStatus.do" method="post" id="deleteForm">
    <input name="userids" type="hidden" id="usersidsStr">
    <input type="hidden" name="key" value="${key}"/>
    <input type="hidden" name="pageIndex" value="${pageIndex}"/>
    <input type="hidden" name="userType" value="${userType}" />
</form>

<form  action="stopUserAccountForAllStatus.do" method="post" id="stopForm">
    <input name="userids" type="hidden" id="stopusersidsStr">
    <input type="hidden" name="key" value="${key}"/>
    <input type="hidden" name="pageIndex" value="${pageIndex}"/>
    <input type="hidden" name="userType" value="${userType}" />
</form>

<form  action="recoverUserAccountForAllStatus.do" method="post" id="recoverForm">
    <input name="userids" type="hidden" id="recoverusersidsStr">
    <input type="hidden" name="key" value="${key}"/>
    <input type="hidden" name="pageIndex" value="${pageIndex}"/>
    <input type="hidden" name="userType" value="${userType}" />
</form>


<%@ include file="../../result.jsp"%>
<script>
//用于显示添加、修改、删除等的提示信息
var operateResult=$("#statusMsgId").val();
$(function(){
	if(operateResult !=null && operateResult!="" ){
		$("#dialogForm4Span").html("<br/>"+operateResult);
		$( "#dialogForm4" ).dialog( "open" );//dialogForm4：用于显示操作成功后返回提示页面
	}
});
</script>

</body>
</html>