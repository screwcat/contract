package com.cauc.contract.business.hibernate;

import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.cauc.contract.FinanceServiceException;
import com.cauc.contract.business.IPayListService;
import com.cauc.contract.business.dao.GenericHibernateDAO;
import com.cauc.contract.pojos.Dictionary;
import com.cauc.contract.pojos.PDateInfo;
import com.cauc.contract.pojos.Payment;
import com.cauc.contract.pojos.PaymentExt;
import com.cauc.contract.pojos.PaymentExtends;
import com.cauc.contract.ui.core.GradeInfor;
import com.cauc.contract.util.CommonUtils;
import com.cauc.contract.util.JsonToBean;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

@Service
public class PayListImpl extends GenericHibernateDAO implements IPayListService {

	/**
	 * 通过序号查询
	 */
	public List<PaymentExtends> UpSearchPayList(PaymentExtends paymentExtend) throws FinanceServiceException {
		String sql = "select isnull(p.PId,''),isnull(p.CCompy,''),isnull(p.PContractId,''),isnull(p.PReceiveMoney,''),"
				+ " isnull(p.PReceiveDate,''),isnull(p.PName,''),isnull(p.PPaymentPercent,''),"
				+ " isnull(p.PRemark,''),isnull(p.PContractGrade,''),isnull(p.PNoticeStatus,''),"
				+ " isnull(p.PRealityDate,''),isnull(p.PPicture,''),isnull(p.PNoticeUrl,''),"
				+ " p.PCurrentStage,p.PGeneralPhase from Payment p where " + " p.PId='" + paymentExtend.getPId() + "'";
		List<Object[]> templist = null;
		PaymentExtends extend;
		List<PaymentExtends> returnList = new ArrayList();
		try {
			templist = super.createQuery(sql).list();
			for (Object[] t : templist) {
				extend = new PaymentExtends();
				extend.setP_id(t[0].toString());// 序号
				extend.setC_compy(t[1].toString());// 付款单位
				extend.setPContractId(t[2].toString());// 合同编号
				extend.setP_receive_money(t[3].toString());// 接收金额

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String dateNowStr = sdf.format((Date) t[4]);
				// extend.setPReceiveDate(new Date(dateNowStr));//接收时间
				extend.setP_receivedate(dateNowStr);
				extend.setPName(t[5].toString());// 节点描述
				extend.setP_payment_percent(t[6].toString());// 百分比
				// extend.setP_money(t[7].toString());//到款金额
				extend.setP_remark(t[7].toString());// 备注
				//extend.setP_arrears(t[8].toString());// 欠款金额
				extend.setP_contractgrade(t[8].toString());// 年级
				extend.setPNoticeStatus(CommonUtils.ObjecttoInt(t[9]));// 付款状态
				extend.setP_truedate(t[10].toString());// 实际到款日期
				extend.setP_picture(t[11].toString());// 图片
				extend.setNoticeUrl(t[12].toString());// pdf地址
				extend.setPCurrentStage(CommonUtils.ObjecttoInt(t[13]));//当前阶段
				extend.setPGeneralPhase(CommonUtils.ObjecttoInt(t[14]));//当前总阶段
				returnList.add(extend);
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return returnList;
	}
	/**
	 * 保存修改页面
	 */
	@Override
	@Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
	public void UpdatePay(Payment paymentExtend)
			throws FinanceServiceException {
		try {
			Payment pay = get(Payment.class, paymentExtend.getPId());
			pay.setCCompy(paymentExtend.getCCompy());// 付款单位
			pay.setPReceiveMoney(paymentExtend.getPReceiveMoney());// 预计付款金额
			pay.setPPaymentPercent(paymentExtend.getPPaymentPercent());// 百分比
			pay.setPReceiveDate(paymentExtend.getPReceiveDate());// 预计到款时间
			// pay.setPMoney(paymentExtend.getPMoney());//实际到款金额
			//pay.setPArrears(paymentExtend.getPArrears());//欠款金额
			pay.setPRemark(paymentExtend.getPRemark());// 备注
			pay.setPRealityDate(paymentExtend.getPRealityDate());
			pay.setPPicture(paymentExtend.getPPicture());
			Float money = (float) 0;
			List<GradeInfor> list = JsonToBean.makeJavaBean(pay.getPRealityDate(),GradeInfor.class);
			for(GradeInfor json :list){
				money+=Float.parseFloat(json.getTrueMoney());
			}
			if(money == pay.getPReceiveMoney()){
				pay.setPNoticeStatus(2);//已通知
			}
			update(pay);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	/**根据合同编号查找
	 * @throws ParseException */
	@Override
	@Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
	public void searchPayment(Payment payment) throws FinanceServiceException, ParseException {
		List<Payment> list =null;
		String hql="from Payment p where p.PContractId = ?";
		Object[] ob=new Object[]{
				payment.getPContractId()
		};
		list = super.find(hql,ob);
		// Date d=new Date();   
		 SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		 Calendar cal = Calendar.getInstance();
		 int day=0;
		 int jspPCurrentStage=0;
		 int jspyear = 0;
		if(CollectionUtils.isNotEmpty(list)){
			for(Payment pay:list){
				Date receiveDate =df.parse(df.format(pay.getPReceiveDate()));
				cal.setTime(receiveDate);
				int day1 = cal.get(Calendar.DAY_OF_YEAR);
				if(pay.getPId()==payment.getPId()){
					Date jspPeceiveDate = payment.getPReceiveDate();
					cal.setTime(jspPeceiveDate);
					int day2 = cal.get(Calendar.DAY_OF_YEAR);
				    day = day2-day1;//jsp页面预计到款时间天数差值
				    if(pay.getPCurrentStage()!=null){
				    	jspPCurrentStage  = pay.getPCurrentStage();//jsp页面当前阶段
				    }else{
				    	jspPCurrentStage = 0;
				    }
					jspyear =  pay.getPContractGrade();//jsp页面年份
				}
			}
			//System.out.println(day+">>>>>>"+jspPCurrentStage);
			for(Payment pay:list){
				if(pay.getPContractGrade()==jspyear){
					if(pay.getPCurrentStage()!=null){
						if(pay.getPCurrentStage()>jspPCurrentStage){
							Date receiveDate =df.parse(df.format(pay.getPReceiveDate()));
							cal.setTime(receiveDate);
							cal.add(Calendar.DATE, day);
							//System.out.println(cal.getTime());
							pay.setPReceiveDate(cal.getTime());
							//System.out.println(pay.getPReceiveDate());
							super.update(pay);
						}
					}
					
				}
			}
		}
	}
 
	/**
	 * swq 初次加载 查询总记录条数
	 * 
	 * @throws FinanceServiceException
	 */
	@Override
	public int getTotalRowCount(String str, PaymentExtends extend) throws FinanceServiceException {
		try {
			String hql = "select  count(1) from " + str + " where 1=1";
			if (extend.getCCompy() != 0 && extend.getCCompy() != 2) {
				if (StringUtils.isNotBlank(extend.getCPrivateName())) {
					hql += " and (C_COMPY ='" + extend.getCCompy() + "' or P_PRIVATE_NAME like '"
							+ extend.getCPrivateName() + "%')";

				} else
					hql += " and C_COMPY ='" + extend.getCCompy() + "'";
			}
			if (extend.getCCompy() == 0 || extend.getCCompy() == 2) {
				if (StringUtils.isNotBlank(extend.getCPrivateName()) && (!("null".equals(extend.getCPrivateName())))) {
					hql += " and  P_PRIVATE_NAME like '" + extend.getCPrivateName() + "%'";
				} else
					hql += "";
			}
			if(extend.getPNoticeStatus()!=0 ){
				hql += " and P_NOTICE_STATUS = '"+extend.getPNoticeStatus()+"' ";
			}
			if (StringUtils.isNotBlank(extend.getCContractId()) && (!("null".equals(extend.getCContractId())))) {
				hql += " and P_CONTRACT_ID like '" + extend.getCContractId() + "%'";

			}
			if (StringUtils.isNotBlank(extend.getP_receivedate()) && (!("null".equals(extend.getP_receivedate())))) {
				String time = extend.getP_receivedate();
				int t = Integer.parseInt(time);
				time = time + "-1-1 00:00:00";
				t = t + 1;
				String addTime = t + "-1-1 00:00:00";
				hql += " and P_RECEIVE_DATE >'" + time + "' and P_RECEIVE_DATE<'" + addTime + "'";
				// hql += " and P_RECEIVE_DATE like
				// '"+extend.getP_receivedate()+"%'";
			}
			List<Object[]> tempList = super.createSQLQuery(hql).list();
			Object object = tempList.get(0);
			return (Integer.parseInt(object.toString()));
		} catch (HibernateException e) {
			throw new FinanceServiceException("查询失败！");
		}
	}

	/**
	 * swq 初次加载分页
	 */

	public List<PaymentExtends> getListByPage(String tbName, int pageIndex, int pageSize, String primaryKey,
			PaymentExtends extend, String strOrder) {
		String afieleds = " P_ID ,C_COMPY, P_CONTRACT_ID , P_NAME, P_RECEIVE_MONEY, P_RECEIVE_DATE, P_NOTICE_STATUS, P_PRIVATE_NAME ";
		String strWhere = " where 1=1 ";
		if (extend.getCCompy() != 0 && extend.getCCompy() != 2) {
			if (StringUtils.isNotBlank(extend.getCPrivateName())) {
				strWhere += " and (C_COMPY ='" + extend.getCCompy() + "' or P_PRIVATE_NAME like '"
						+ extend.getCPrivateName() + "%')";

			} else
				strWhere += " and C_COMPY ='" + extend.getCCompy() + "'";
		}
		if (extend.getCCompy() == 0 || extend.getCCompy() == 2) {
			if (StringUtils.isNotBlank(extend.getCPrivateName()) && (!("null".equals(extend.getCPrivateName())))) {
				strWhere += " and  P_PRIVATE_NAME like '" + extend.getCPrivateName() + "%'";
			} else
				strWhere += "";
		}
		/*if (extend.getPStatus() != 0 && extend.getPStatus() != 512) {
			strWhere += " and P_STATUS ='" + extend.getPStatus() + "'";
		}*/
		if(extend.getPNoticeStatus()!=0 ){
			strWhere += " and P_NOTICE_STATUS = '"+extend.getPNoticeStatus()+"' ";
		}
		if (StringUtils.isNotBlank(extend.getCContractId()) && (!("null".equals(extend.getCContractId())))) {
			strWhere += " and P_CONTRACT_ID like '" + extend.getCContractId() + "%'";

		}
		if (StringUtils.isNotBlank(extend.getP_receivedate()) && (!("null".equals(extend.getP_receivedate())))) {
			String time = extend.getP_receivedate();
			int t = Integer.parseInt(time);
			time = time + "-1-1 00:00:00";
			t = t + 1;
			String addTime = t + "-1-1 00:00:00";
			strWhere += " and P_RECEIVE_DATE >'" + time + "' and P_RECEIVE_DATE<'" + addTime + "'";
		}
		String hql = "select top " + pageSize + " " + afieleds + " from " + tbName + strWhere + " " + strOrder;
		if (pageIndex > 1) {
			String addafieleds = "a.P_ID, a.C_COMPY ,a.P_CONTRACT_ID, a.P_NAME ,a.P_RECEIVE_MONEY, a.P_RECEIVE_DATE,a.P_NOTICE_STATUS ,a.P_PRIVATE_NAME ";
			hql = "select " + addafieleds + " from " + tbName + " as a inner join (select " + afieleds
					+ " from (select row_number() over(" + strOrder + ") as rownum," + afieleds + " from " + tbName
					+ strWhere + ") as t where rownum between " + ((pageIndex - 1) * pageSize + 1) + " and "
					+ pageIndex * pageSize + ") as b on a." + primaryKey + "=b." + primaryKey + " order by b.P_ID Desc";
		}
		List<Object[]> tempList = super.createSQLQuery(hql).list();
		List<PaymentExtends> listextends = new ArrayList<PaymentExtends>();
		for (Object[] o : tempList) {
			PaymentExtends paymentExtends = new PaymentExtends();
			int compyid = Integer.parseInt(o[1].toString());
			if (compyid == 0) {
				paymentExtends.setC_compy("");
			} else {
				String compyStr = getDictionaryNameById(compyid);
				paymentExtends.setC_compy(compyStr);
			}

//			int status = CommonUtils.ObjecttoInt(o[6]);
//			String statusStr = getDictionaryNameById(status);
			paymentExtends.setP_id(o[0].toString());
			// paymentExtends.setC_compy(compyStr);
			paymentExtends.setPContractId(o[2].toString());
			paymentExtends.setP_name(o[3].toString());
			paymentExtends.setP_receive_money(o[4].toString());
			paymentExtends.setPReceiveDate((Date) o[5]);
			//paymentExtends.setP_status(statusStr);
			paymentExtends.setPNoticeStatus(CommonUtils.ObjecttoInt(o[6]));
			try {
				paymentExtends.setCPrivateName(CommonUtils.ObjecttoString(o[7]));
			} catch (Exception e) {
			}
			listextends.add(paymentExtends);
		}
		return listextends;
	}

	/**
	 * 根据Id 在数据字典中获取该Id的名字
	 * 
	 * @param id
	 * @return
	 */
	private String getDictionaryNameById(int id) {
		String hql = "from Dictionary where DictionaryId =" + id;
		List<Dictionary> dictionaryList = new ArrayList<Dictionary>();
		dictionaryList = super.find(hql);
		if (!CollectionUtils.isEmpty(dictionaryList)) {
			return dictionaryList.get(0).getDictionaryName();
		}
		return "";
	}

	@Override
	public String backgetDictionaryNameById(int id) {
		String hql = "from Dictionary where DictionaryId =" + id;
		List<Dictionary> dictionaryList = new ArrayList<Dictionary>();
		dictionaryList = super.find(hql);
		String name = dictionaryList.get(0).getDictionaryName();
		return name;
	}

	/**
	 * swq 结算通知的保存
	 */
	@Override
	@Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
	public void saveNotice(String noticeInfor, int id) {
		Payment payment = get(Payment.class, id);
		payment.setPNotice(noticeInfor);
		update(payment);
	}

	/**
	 * swq 生成结算通知的pdf
	 * 
	 * @throws IOException
	 */
	@Override
	@Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
	public void saveAndGenerateNotice(String noticeInfor, int serial) throws IOException {
		// 获取系统时间并转换为字符串形式
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String time = df.format(new Date());
		time = time.substring(2, 12);
		try {
			File headPath = new File("d:/pdf/");// 获取文件夹路径
			if (!headPath.exists()) {// 判断文件夹是否创建，没有创建则创建新文件夹
				headPath.mkdirs();
			}
			Document document = new Document(PageSize.A4, 50, 50, 50, 50);
			PdfWriter writer = PdfWriter.getInstance(document,
					new FileOutputStream("d:/pdf/" + serial + time + ".pdf"));
			BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "UniGB-UCS2-H", false);
			Font bold_fontChinese = new Font(bfChinese, 12, Font.BOLD, Color.BLACK);
			document.open();
			document.add(new Paragraph(noticeInfor, bold_fontChinese));
			document.close();
			writer.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		// 获取要保存的文件路径的字段
		String hql = "from Payment where PId =" + serial;
		List<Payment> paymentList = new ArrayList<Payment>();
		paymentList = super.find(hql);
		String url = paymentList.get(0).getPNoticeUrl();
		int noticeStatus = paymentList.get(0).getPNoticeStatus();
		if (noticeStatus == 4) {
			noticeStatus = 3;
		}
		// 修改保存的文件路径

		String url1 = "d:/pdf/" + serial + time + ".pdf";
		if (url!=null && url.indexOf(',') > 0) {
			String[] tfUrl = url.split(",");
			if (tfUrl[0].equals(url1)) {
			} else {
				String newUrl = "d:/pdf/" + serial + time + ".pdf," + url;
				Payment payment = get(Payment.class, serial);
				payment.setPNoticeStatus(noticeStatus);
				payment.setPNoticeUrl(newUrl);
				update(payment);
			}
		} else {
			String newUrl = "d:/pdf/" + serial + time + ".pdf," + url;
			Payment payment = get(Payment.class, serial);
			payment.setPNoticeStatus(noticeStatus);
			payment.setPNoticeUrl(newUrl);
			update(payment);
		}

	}

	/**
	 * swq 删除pdf的地址
	 */
	@Override
	@Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
	public void delNoticeUrl(String delUrlStr, int serial) {
		// 根据ID 查询存放pdf地址的字段
		String hql = "from Payment where PId =" + serial;
		List<Payment> paymentList = new ArrayList<Payment>();
		paymentList = super.find(hql);
		String url = paymentList.get(0).getPNoticeUrl();
		String[] tfUrl = url.split(",");
		String newUrl = "";
		for (int i = 0; i < tfUrl.length; i++) {

			if (delUrlStr.equals(tfUrl[i])) {
			} else {
				newUrl = newUrl + tfUrl[i] + ",";
			}
		}
		Payment payment = get(Payment.class, serial);
		payment.setPNoticeUrl(newUrl);
		update(payment);

	}
	//更新付款状态
	@Override
	public void noticeStatus(Payment payment) {
		Payment pay= get(Payment.class, payment.getPId());
		update(pay);
	}

	/**删除发票*/
	@Override
	@Transactional(readOnly = false, isolation = Isolation.READ_COMMITTED)
	public void delPicture(String picture, int serial) throws IOException {
		String hql = "from Payment where PId =" + serial;
		List<Payment> paymentList = new ArrayList<Payment>();
		paymentList = super.find(hql);
		String strpic = paymentList.get(0).getPPicture();
		String pic[] = strpic.split(",");
		String newPic = "";
		for(int i=0;i<pic.length;i++){
			if(!picture.equals(pic[i])){
				newPic+=pic[i]+",";				
			}else{}
		}
		/*if(newPic.length()>0){
			newPic=newPic.substring(0,newPic.length()-1);
		}*/
		Payment payment = get(Payment.class, serial);
		payment.setPPicture(newPic);
		update(payment);
	}
	/**
	 * 根据合同PID查找
	 */
	public Payment searchPaymentById(Payment payment) throws FinanceServiceException, ParseException {
		List<Payment> list = null;
		String hql = "from Payment p where p.PId = ?";
		Object[] ob = new Object[] { payment.getPId() };
		list = super.find(hql, ob);
		return list.get(0);
	}
	
}
