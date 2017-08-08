<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
  <SCRIPT LANGUAGE="JavaScript">
   
   
    var pageCount = parseInt('<s:property value="page.totalPageCount"/>');
    var pageIndex = parseInt('<s:property value="page.currentPageNo"/>');
    var recordStartLine = parseInt('<s:property value="page.pageStart"/>');
    var recordEndLine = parseInt('<s:property value="page.pageEnd"/>');
    var recordCount = parseInt('<s:property value="page.totalCount"/>');
    var orderBy = '<s:property value="orderBy"/>';
    var orderType = '<s:property value="orderType"/>';
 
    function firstPage(){
        if (pageIndex!=1){
            gotoPage(1);
        }
    }   
    function nextPage(){
        if (pageIndex<pageCount){
            gotoPage(pageIndex+1);
        }     
    }
    function prePage(){
        if (pageIndex>1){
            gotoPage(pageIndex-1);
        }
    } 
    function lastPage(){
        if (pageIndex!=pageCount){
            gotoPage(pageCount);
        }     
    }   
   
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
  
        
    function setURLArgs(args, argumentName, value){
        var reg = new RegExp('([\?&]?'+argumentName+'=)([^&]*)([&$]*)', 'gi');
        value = encodeURI(value);
        if( args.search(reg)!=-1){		
            args = args.replace(reg,'$1'+value+'$3');
        }else{
           args += (args.indexOf('?')!=-1 ? '&' : '?') + argumentName+'='+value;
        }	
        return args;
    }  
    function enterPress(e){
        if(event.keyCode==13){
            if (isNaN(parseInt(e.value))){
                gotoPage(1);
            }else{
                if (parseInt(e.value)>parseInt(pageCount)){
                    gotoPage(1);
                }else{
                   
                    gotoPage(e.value);
                }
            }
            return false;
        }
    }
    function jumpPage(){
    	var value=document.getElementById("currentPageNo").value;
        if (isNaN(parseInt(value))){
              gotoPage(1);
        }else{
           if (parseInt(value)>parseInt(pageCount)){
               gotoPage(1);
           }else{           
               gotoPage(value);
           }
        }    	
    }    
  </SCRIPT>
<div style="display:none">
<s:textfield name="orderBy"/>
<s:textfield name="orderType"/>
</div>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td width="32%" align="center">已选择<span id="selectIdSum"></span>条记录</td>
<td width="68%" height="30" align="right" >
<a href="javascript:firstPage();" class="blue">首页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="javascript:prePage();" class="blue">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="javascript:nextPage();" class="blue">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="javascript:lastPage();" class="blue">尾页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button"  value="跳转到" onclick="jumpPage();">第<s:textfield name="currentPageNo" id="currentPageNo" size="2" onkeypress="enterPress(this)" Style="height:15px; width:20px;"/>页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
本页显示<s:property value="page.pageStart"/>-<s:property value="page.pageEnd"/>条 / 共<s:property value="page.totalPageCount"/>页<s:property value="page.totalCount"/>条
</td>
</tr>
</table>