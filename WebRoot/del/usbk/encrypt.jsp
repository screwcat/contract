<%@page contentType="text/html; charset=GBK"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	
	//判断session是否失效
	String UniqueID = (String) session.getAttribute("UniqueID");
	if (UniqueID == null || UniqueID.equals("")) {
		response.sendRedirect("index.jsp");
	}
	
	//获得登陆用户ContainerName
	String ContainerName = (String) session.getAttribute("ContainerName");
%>

<html>

	<head>
		<title>BJCA证书应用演示环境</title>
		<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			font-family: Arial, Helvetica, sans-serif;
			font-size: 14px;
		}
		-->
		</style>
		<link href="style.css" rel="stylesheet" type="text/css" />

		<SCRIPT language=JavaScript src="SecX_Common.js"></SCRIPT>
		<Script Language="JavaScript">
				
	        var ContainerName = "<%=ContainerName%>";
	        function encrypt() 
	        {
		        var encryptData ="";
		        if (TestForm.ming.value == "") 
		        {
			        alert("Parameter is empty!");
			        return ;
		        }
		        
		        var enckey = GenerateRandom(24);
		        encryptData = EncryptData(enckey,TestForm.ming.value);
				if(enckey == '' || encryptData=='')
		        {
			        TestForm.miwen.value = '';
			        alert("加密失败," + errorMsg);
					return false;
		        }
		        TestForm.miwen.value = enckey + "|"+encryptData;
	        }	
	
	        function decrypt()
	        {
		        var decryptData="";
		        var AllCipherData = TestForm.miwen.value;
		        var enckey = AllCipherData.substring(0, AllCipherData.indexOf("|"));
		        var encdata = AllCipherData.substring(AllCipherData.indexOf("|") + 1, AllCipherData.length);
		        decryptData = DecryptData(enckey,encdata);
		        if(decryptData == "")
		        {
			        TestForm.mingwen.value = "解密失败！";
		        }
		        else
		        {
			        TestForm.mingwen.value = decryptData;
		        }
	        }

		</Script>

	</head>

	<body>
		<%@include file="top.jsp"%>
		<table width="957" border="0" align="center" cellpadding="0"
			cellspacing="0">

			<tr>
				<td bgcolor="#FEFDFB">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td width="267" align="left" valign="top">
					<%@include file="form.jsp"%>
				</td>
				<td align="left" valign="top" bgcolor="#FEFDFB">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								&nbsp;
							</td>
							<td class="font1">
								<img src="images/jt.gif" width="12" height="12" />
								数据加密功能演示
							</td>
						</tr>
						<tr>
                        	<td height="5"></td>
                        </tr>
						<tr>
							<td></td>
							<td>
								<table width="100%" height="2" border="0" cellpadding="0"
									cellspacing="0">
									<tr>
										<td height="2" bgcolor="#CCCCCC"></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
                        	<td height="10"></td>
                        </tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td align="left" valign="top">
								<form method="post" ID="TestForm" action="">
									<table width="98%" border="0" align="center" cellpadding="5"
										cellspacing="1" class="table1">
										<tr>
											<td style="font-size:14px;" width="35%">
												需要加密的数据：
											</td>
											<td style="font-size:14px;">
												<textarea name=textarea1 id=ming cols="40" rows="6">写入需要加密的数据！</textarea>
											</td>
										</tr>
										<tr>
											<td style="font-size:14px;">
												
												<input type="button" value="加密" class="button" style="width:50px;" onclick="encrypt();">
											</td>
											<td style="font-size:14px;">
												<textarea name=textarea2 id=miwen cols="40" rows="6">加密结果显示！</textarea>
											</td>
										</tr>
										<tr>
											<td style="font-size:14px;">
												
												<input type="button" value="解密" class="button" style="width:50px;" onclick="decrypt();">
												<div align="center">
													<font color="#FF0000">如果修改了加密信息，<br>则提示解密失败！</font>
												</div>

											</td>
											<td style="font-size:14px;">
												<textarea name=textarea3 id=mingwen cols="40" rows="6">解密结果显示！</textarea>
											</td>
										</tr>
									</table>
									
								</form>
							</td>
						</tr>

					</table>
				</td>
			</tr>
		</table>
		<%@include file="bottom.jsp"%>
	</body>

</html>

