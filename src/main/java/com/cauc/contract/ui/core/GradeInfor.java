package com.cauc.contract.ui.core;

import java.util.ArrayList;
import java.util.List;


public class GradeInfor {
	private String gradeYear;
	
	private String studentCount;
	
	private String schoolTime;
	
	//实际到款日期
	private String trueDate;
	//实际到款金额
	private String trueMoney;
	
   private List<StudentNameNoNew> studentNameNo=new ArrayList<StudentNameNoNew>();
	
	public List<StudentNameNoNew> getStudentNameNo() {
		return studentNameNo;
	}

	public void setStudentNameNo(List<StudentNameNoNew> studentNameNo) {
		this.studentNameNo = studentNameNo;
	}

	public String getTrueDate() {
		return trueDate;
	}

	public void setTrueDate(String trueDate) {
		this.trueDate = trueDate;
	}

	public String getTrueMoney() {
		return trueMoney;
	}

	public void setTrueMoney(String trueMoney) {
		this.trueMoney = trueMoney;
	}

	/**
	 * @return the gradeYear
	 */
	public String getGradeYear() {
		return gradeYear;
	}

	/**
	 * @param gradeYear the gradeYear to set
	 */
	public void setGradeYear(String gradeYear) {
		this.gradeYear = gradeYear;
	}

	/**
	 * @return the studentCount
	 */
	public String getStudentCount() {
		return studentCount;
	}

	/**
	 * @param studentCount the studentCount to set
	 */
	public void setStudentCount(String studentCount) {
		this.studentCount = studentCount;
	}

	/**
	 * @return the schoolTime
	 */
	public String getSchoolTime() {
		return schoolTime;
	}

	/**
	 * @param schoolTime the schoolTime to set
	 */
	public void setSchoolTime(String schoolTime) {
		this.schoolTime = schoolTime;
	}
		
}
class studentNameNo{
	private String studentNo=null;
	private String studentName=null;
	public String getStudentNo() {
		return studentNo;
	}
	public void setStudentNo(String studentNo) {
		this.studentNo = studentNo;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
}
