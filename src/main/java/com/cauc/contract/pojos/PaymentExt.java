package com.cauc.contract.pojos;

import java.util.Date;

public class PaymentExt  {

	/**
	 * guot
	 */
	private static final long serialVersionUID = 1L;

	private int Year;//年份
	private int Month;//月份
	private String YPReceiveMoney;//预计收款金额和
	private String TPReceiveMoney;//通知收款金额和
	private String PRealityDate;
	//private String P_REALITY_DATE;
	private String TrueMoney;//实际到款金额
	private String TrueDate;//实际到款日期
	private String unpaid;//未到帐合计
	private String p_receivedate;//到款日期
	
	private String sumYPReceiveMoney;
	private String sumTPReceiveMoney;
	private String sumTrueMoney;
	private String sumUnpaid;

	private int PId;
	private String PContractId;
	private int PReceiveDate;
	private int PArrears;
 
	
	
	//--------------------------------
	public String getUnpaid() {
		return unpaid;
	}
	public void setUnpaid(String string) {
		this.unpaid = string;
	}
	public int getMonth() {
		return Month;
	}
	public void setMonth(int month) {
		Month = month;
	}
	public int getYear() {
		return Year;
	}
	public void setYear(int year) {
		Year = year;
	}
	public String getYPReceiveMoney() {
		return YPReceiveMoney;
	}
	public void setYPReceiveMoney(String yPReceiveMoney) {
		YPReceiveMoney = yPReceiveMoney;
	}
	public String getTPReceiveMoney() {
		return TPReceiveMoney;
	}
	public void setTPReceiveMoney(String tPReceiveMoney) {
		TPReceiveMoney = tPReceiveMoney;
	}
	public String getPRealityDate() {
		return PRealityDate;
	}
	public void setPRealityDate(String pRealityDate) {
		PRealityDate = pRealityDate;
	}
	public String getTrueMoney() {
		return TrueMoney;
	}
	public void setTrueMoney(String trueMoney) {
		TrueMoney = trueMoney;
	}
	public String getTrueDate() {
		return TrueDate;
	}
	public void setTrueDate(String trueDate) {
		TrueDate = trueDate;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getSumYPReceiveMoney() {
		return sumYPReceiveMoney;
	}
	public void setSumYPReceiveMoney(String sumYPReceiveMoney) {
		this.sumYPReceiveMoney = sumYPReceiveMoney;
	}
	public String getSumTPReceiveMoney() {
		return sumTPReceiveMoney;
	}
	public void setSumTPReceiveMoney(String sumTPReceiveMoney) {
		this.sumTPReceiveMoney = sumTPReceiveMoney;
	}
	public String getSumTrueMoney() {
		return sumTrueMoney;
	}
	public void setSumTrueMoney(String sumTrueMoney) {
		this.sumTrueMoney = sumTrueMoney;
	}
	public String getSumUnpaid() {
		return sumUnpaid;
	}
	public void setSumUnpaid(String sumUnpaid) {
		this.sumUnpaid = sumUnpaid;
	}
	public String getP_receivedate() {
		return p_receivedate;
	}
	public void setP_receivedate(String p_receivedate) {
		this.p_receivedate = p_receivedate;
	}
//	public String getP_REALITY_DATE() {
//		return P_REALITY_DATE;
//	}
//	public void setP_REALITY_DATE(String p_REALITY_DATE) {
//		P_REALITY_DATE = p_REALITY_DATE;
//	}
	public int getPId() {
		return PId;
	}
	public void setPId(int pId) {
		PId = pId;
	}
	public String getPContractId() {
		return PContractId;
	}
	public void setPContractId(String pContractId) {
		PContractId = pContractId;
	}
	public int getPReceiveDate() {
		return PReceiveDate;
	}
	public void setPReceiveDate(int pReceiveDate) {
		PReceiveDate = pReceiveDate;
	}
	public int getPArrears() {
		return PArrears;
	}
	public void setPArrears(int pArrears) {
		PArrears = pArrears;
	}
	
	
	
	
}
