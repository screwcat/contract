package com.cauc.contract.pojos;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

public class Account implements Serializable{
	
	private Integer AId;//
	private String AAccountId;//
	private String CContractId;//
	private float PBuildFeeStandardPrice;//
	private float PTrainFeeStandardPrice;//
	private Integer AAccountState;//
	private Integer APaymentState;//
	private Date ALastModifyTime;//
	private String ALastModifyPerson;//
	private Integer PGradeStudentCount;//
	private String ANoticeUrl;//
	private Date AAccountTime;
	private Integer PId;
	private int AFundsType;
	public Account() {
		
	}
	
	public Account(Integer aId, String aAccountId, String cContractId, float pBuildFeeStandardPrice,
			float pTrainFeeStandardPrice, Integer aAccountState, Integer aPaymentState, Date aLastModifyTime,
			String aLastModifyPerson, Integer pGradeStudentCount, String aNoticeUrl, Date aAccountTime, Integer pId,
			int aFundsType) {
		AId = aId;
		AAccountId = aAccountId;
		CContractId = cContractId;
		PBuildFeeStandardPrice = pBuildFeeStandardPrice;
		PTrainFeeStandardPrice = pTrainFeeStandardPrice;
		AAccountState = aAccountState;
		APaymentState = aPaymentState;
		ALastModifyTime = aLastModifyTime;
		ALastModifyPerson = aLastModifyPerson;
		PGradeStudentCount = pGradeStudentCount;
		ANoticeUrl = aNoticeUrl;
		AAccountTime = aAccountTime;
		PId = pId;
		AFundsType = aFundsType;
	}

	public Integer getAId() {
		return AId;
	}
	public void setAId(Integer aId) {
		AId = aId;
	}
	public String getAAccountId() {
		return AAccountId;
	}
	public void setAAccountId(String aAccountId) {
		AAccountId = aAccountId;
	}
	public String getCContractId() {
		return CContractId;
	}
	public void setCContractId(String cContractId) {
		CContractId = cContractId;
	}
	public float getPBuildFeeStandardPrice() {
		return PBuildFeeStandardPrice;
	}
	public void setPBuildFeeStandardPrice(float pBuildFeeStandardPrice) {
		PBuildFeeStandardPrice = pBuildFeeStandardPrice;
	}
	public float getPTrainFeeStandardPrice() {
		return PTrainFeeStandardPrice;
	}
	public void setPTrainFeeStandardPrice(float pTrainFeeStandardPrice) {
		PTrainFeeStandardPrice = pTrainFeeStandardPrice;
	}
	public Integer getAAccountState() {
		return AAccountState;
	}
	public void setAAccountState(Integer aAccountState) {
		AAccountState = aAccountState;
	}
	public Integer getAPaymentState() {
		return APaymentState;
	}
	public void setAPaymentState(Integer aPaymentState) {
		APaymentState = aPaymentState;
	}
	public Date getALastModifyTime() {
		return ALastModifyTime;
	}
	public void setALastModifyTime(Date aLastModifyTime) {
		ALastModifyTime = aLastModifyTime;
	}
	public String getALastModifyPerson() {
		return ALastModifyPerson;
	}
	public void setALastModifyPerson(String aLastModifyPerson) {
		ALastModifyPerson = aLastModifyPerson;
	}
	public Integer getPGradeStudentCount() {
		return PGradeStudentCount;
	}
	public void setPGradeStudentCount(Integer pGradeStudentCount) {
		PGradeStudentCount = pGradeStudentCount;
	}
	public String getANoticeUrl() {
		return ANoticeUrl;
	}
	public void setANoticeUrl(String aNoticeUrl) {
		ANoticeUrl = aNoticeUrl;
	}
	public Date getAAccountTime() {
		return AAccountTime;
	}
	public void setAAccountTime(Date aAccountTime) {
		AAccountTime = aAccountTime;
	}
	public Integer getPId() {
		return PId;
	}
	public void setPId(Integer pId) {
		PId = pId;
	}

	public int getAFundsType() {
		return AFundsType;
	}

	public void setAFundsType(int aFundsType) {
		AFundsType = aFundsType;
	}
	
}
