package com.cauc.contract.pojos;

import java.util.ArrayList;
import java.util.List;

import com.cauc.contract.ui.core.StudentNameNoNew;

public class Average {
	/**
	 * AverageList
	 */
	private String contractId;//合同号	
	private String targetAmount;//标的额
	private String trainPrice;//训练报价
	private String partyPrice;//合作共建
	private String trainTheory;//理论培训
	private String trainBalance;//训练费余额
	private String avgTrainB ;//平均训练费余额
	private String dealPrice; //成交价
	private String cSignTime;//签订时间
	
	private String p_receive;//接收页面传递年份
	
	private String gradeInfo;// 年级学生信息(JSON)	
	private String paymentInfo;// 付款详细信息 json
    private String gradeYear;   //年级
	private String studentCount;//学生人数
	private String schoolTime;  //入学时间
	private String name;//合同号
	private String value;//经费
	private List<StudentNameNoNew> studentNameNo=new ArrayList<StudentNameNoNew>();
	
	
	
	//  getter and  setter 
	public String getContractId() {
		return contractId;
	}
	public void setContractId(String contractId) {
		this.contractId = contractId;
	}
	public String getDealPrice() {
		return dealPrice;
	}
	public void setDealPrice(String dealPrice) {
		this.dealPrice = dealPrice;
	}
	public String getP_receive() {
		return p_receive;
	}
	public void setP_receive(String p_receive) {
		this.p_receive = p_receive;
	}
	public String getGradeInfo() {
		return gradeInfo;
	}
	public void setGradeInfo(String gradeInfo) {
		this.gradeInfo = gradeInfo;
	}
	public String getPaymentInfo() {
		return paymentInfo;
	}
	public void setPaymentInfo(String paymentInfo) {
		this.paymentInfo = paymentInfo;
	}
	public String getTargetAmount() {
		return targetAmount;
	}
	public void setTargetAmount(String targetAmount) {
		this.targetAmount = targetAmount;
	}
	public String getTrainPrice() {
		return trainPrice;
	}
	public void setTrainPrice(String trainPrice) {
		this.trainPrice = trainPrice;
	}
	public String getPartyPrice() {
		return partyPrice;
	}
	public void setPartyPrice(String partyPrice) {
		this.partyPrice = partyPrice;
	}
	public String getTrainTheory() {
		return trainTheory;
	}
	public void setTrainTheory(String trainTheory) {
		this.trainTheory = trainTheory;
	}
	public String getTrainBalance() {
		return trainBalance;
	}
	public void setTrainBalance(String trainBalance) {
		this.trainBalance = trainBalance;
	}
	public String getcSignTime() {
		return cSignTime;
	}
	public void setcSignTime(String cSignTime) {
		this.cSignTime = cSignTime;
	}
	public String getGradeYear() {
		return gradeYear;
	}
	public void setGradeYear(String gradeYear) {
		this.gradeYear = gradeYear;
	}
	public String getStudentCount() {
		return studentCount;
	}
	public void setStudentCount(String studentCount) {
		this.studentCount = studentCount;
	}
	public String getSchoolTime() {
		return schoolTime;
	}
	public void setSchoolTime(String schoolTime) {
		this.schoolTime = schoolTime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getAvgTrainB() {
		return avgTrainB;
	}
	public void setAvgTrainB(String avgTrainB) {
		this.avgTrainB = avgTrainB;
	}
	public List<StudentNameNoNew> getStudentNameNo() {
		return studentNameNo;
	}
	public void setStudentNameNo(List<StudentNameNoNew> studentNameNo) {
		this.studentNameNo = studentNameNo;
	}
	
	
	
}

