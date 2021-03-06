// default package
// Generated 2016-7-19 17:02:05 by Hibernate Tools 3.4.0.CR1
package com.cauc.contract.pojos;

import java.util.ArrayList;
import java.util.List;

import com.cauc.contract.ui.core.StudentNameNoNew;

/**
 * Contract generated by baib
 * 合同年级json 反射实体类
 */
public class ContractGradeInfo implements java.io.Serializable {

	/**
	 * guot
	 */
	private static final long serialVersionUID = 1L;
	private String gradeYear;
	private String studentCount;
	private String schoolTime;
	private List<StudentNameNoNew> studentNameNo=new ArrayList<StudentNameNoNew>();

	public List<StudentNameNoNew> getStudentNameNo() {
		return studentNameNo;
	}

	public void setStudentNameNo(List<StudentNameNoNew> studentNameNo) {
		this.studentNameNo = studentNameNo;
	}

	public ContractGradeInfo() {
	}

	public ContractGradeInfo(String CGradeYear, String CStudentCount, String CSchoolTime) {
		this.gradeYear = CGradeYear;
		this.studentCount = CStudentCount;
		this.schoolTime = CSchoolTime;
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
}



