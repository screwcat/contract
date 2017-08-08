$(function(){
	//var cpaymentInfo =eval("["+$("#cpaymentInfo").val()+"]");
	initTree(getAllDics(516));
	initTree(getAllDics(517));
	initTree(getAllDics(518));
	
	$('.thirdlevel').each(function(){		
		var str = $(this).next().html();		
		if(str.length<1){
			if(str==''){
				$(this).css('display','block');
			}else{
				$(this).css('display','none');
			}
		}
	})
	$('.secondlevel').each(function(){
		var temp=false;
		$(this).next().find(".thirdlevel").each(function(){
			if($(this).css('display')!='none'){
				temp=true;
			}
		})
		if(!temp){
			$(this).css('display','none');
		}
	})
	$('.firstlevel').each(function(){
		var temp=false;
		$(this).next().find(".secondlevel").each(function(){
			if($(this).css('display')!='none'){
				temp=true;
			}
		})
		if(!temp){
			$(this).css('display','none');
		}
	})
	function initTree(data) {
		if (data.length > 0) {
			strHtml = '';
			var showPaymentInfo = eval("[" + $("#cpaymentInfo").val()+ "]");
			for (var i = 1; i < data.length; i++) {
				strHtml = ""
				if (data[i].id == data[i].TopId) {
					var did = "D" + data[i].id;
					strHtml = '<li class="folderNode rootNode firstlevel"><input type="hidden" value="'
							+ data[i].id + '">' + data[i].name + '</li>';
					strHtml += '<ul id=' + did + '></ul>';
					$('#treeView0ul').append(strHtml);
				} else if (data[i].level == 2) {
					var did = "D" + data[i].id;
					var pdid = "D" + data[i].ParentId;
					strHtml = '<li class="folderNode secondlevel"><input type="hidden" value="'
							+ data[i].id + '" >&nbsp;' + data[i].name + '</li>';
					strHtml += '<ul id=' + did + '></ul>';
					$("#" + pdid).append(strHtml);
				} else if (data[i].level == 3) {
					var did = "D" + data[i].id;
					var pdid = "D" + data[i].ParentId;
					if ($("#paymentInfo").val() != '') {
						for (var k = 0; k < showPaymentInfo.length; k++) {
							if (data[i].id == showPaymentInfo[k].name) {
								if (showPaymentInfo[k].value != '') {
									strHtml = '<li class="treeNode thirdlevel"><input type="hidden" class="fourlevels"  value="'+ data[i].id+ '">'
											+ '<span >'+ data[i].name+ '&nbsp;:</span>'
											+ '<span class="bold"><lable id ="'+ data[i].id+ '" value="'+ showPaymentInfo[k].value
											+ '">'+ showPaymentInfo[k].value+ '</lable>元</span>';
									var courseInfo = eval("["+$('#courseIn').val()+"]");
									if(data[i].TopId!=516){
										var isv=false;
										if($('#courseIn').val() != ''){
											for(var j=0;j<courseInfo.length;j++){
												if(data[i].id == courseInfo[j].id){
													strHtml +='<input id="'+data[i].id+'"  value="'+courseInfo[j].val+'" type="text" class="ddlJF" />';
													isv=true;
												}
											}
										}
										if(!isv){
											strHtml +='<input id="'+data[i].id+'"  value="" type="text" class="ddlJF" />';
										}
									}else{
										var isv=false;
										if($('#courseIn').val() != ''){
										for(var j=0;j<courseInfo.length;j++){
											if(data[i].id == courseInfo[j].id){
												strHtml +='<input id="'+data[i].id+'" value="'+data[i].id+'" type="checkbox" class="ckb3" checked="checked"/>';
												isv=true;
											}
										}
										}
										if(!isv){
											strHtml +='<input id="'+data[i].id+'" value="'+data[i].id+'" type="checkbox" class="ckb3" />';
										}
									}
									strHtml +='</li>';
								}
							}
						}						
					}
					strHtml += '<ul id=' + did + '></ul>';
					$("#" + pdid).append(strHtml);
				}
				else if(data[i].level == 4){
					var pdid = "D" + data[i].ParentId;
					for (var k = 0; k < showPaymentInfo.length; k++) {
						if (data[i].id == showPaymentInfo[k].name) {
							if (showPaymentInfo[k].value != '') {
								strHtml = '<li class="treeNode "><input type="hidden"  value="'+ data[i].id+ '">'
								+ '<span >'+ data[i].name+ '&nbsp;:</span>'
								+ '<span class="bold"><lable id ="'+ data[i].id+ '" value="'+ showPaymentInfo[k].value
								+ '">&nbsp;'+ showPaymentInfo[k].value+ '</lable></span>小时</li>';
							}
						}
					}
					$("#" + pdid).append(strHtml);
				}
			}
		}
		return strHtml;  
	}
	//返回
	 $('#Button2').click(function(){
     	history.back(-1);
     })
     $('#Button1').click(function(){
    	 if(formsubmit()){
    		 $('#saveSubmit').submit();
    	 }
     })
	
})
//保存
function formsubmit(){
	var idval = [];
	var str = "";
	$('.thirdlevel').each(function(){    		
		if($(this).find(".ddlJF").length > 0){
			if($(this).find(".ddlJF").val()!=''){
				str+='{"id":"'+$(this).find('.fourlevels').val()+'","val":"'+$(this).find(".ddlJF").val()+'"},';
			}
	   }else{
		   if($(this).find('.ckb3').is(':checked')){			   
			   str+='{"id":"'+$(this).find('.ckb3').val()+'","val":"'+$(this).find('lable').html()+'"},';
		   }		  
	   }
	})
	if(str.length>0){
		str = str.substring(0,str.length-1);
	}
	//alert(str);
	$('#courseInfo').val(str);
	return true;
}

