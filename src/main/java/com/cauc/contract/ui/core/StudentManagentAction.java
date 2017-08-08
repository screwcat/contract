package com.cauc.contract.ui.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.cauc.contract.FinanceServiceException;
import com.cauc.contract.business.IDataDicManageService;
import com.cauc.contract.business.IStudentManagementService;
import com.cauc.contract.cache.DictionaryCache;
import com.cauc.contract.pojos.ConStudent;
import com.cauc.contract.pojos.Contract;
import com.cauc.contract.pojos.Dictionary;
import com.cauc.contract.pojos.Student;
import com.cauc.contract.ui.common.BaseActionSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class StudentManagentAction extends BaseActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6188242964891024165L;
	private Student student;
	private List<Student> studentList;
	private Dictionary parentdictionary;

	private String studentId;
	private String studentName;
	private String idCard;
	private String no;
	private String grade;
	private String company;
	private String contractNo;
	private String state;
	private String joinTime;
	private String stopReason;
	private String stopTime;
	private Date addTime;
	private Integer addUser;
	private Date lastModifyTime;
	private Integer lastModifyUser;
	private String stateShow;

	private ConStudent contractEntety;
	private String courseInfo;
	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getJoinTime() {
		return joinTime;
	}

	public void setJoinTime(String joinTime) {
		this.joinTime = joinTime;
	}

	public String getStopReason() {
		return stopReason;
	}

	public void setStopReason(String stopReason) {
		this.stopReason = stopReason;
	}

	public String getStopTime() {
		return stopTime;
	}

	public void setStopTime(String stopTime) {
		this.stopTime = stopTime;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Integer getAddUser() {
		return addUser;
	}

	public void setAddUser(Integer addUser) {
		this.addUser = addUser;
	}

	public Date getLastModifyTime() {
		return lastModifyTime;
	}

	public void setLastModifyTime(Date lastModifyTime) {
		this.lastModifyTime = lastModifyTime;
	}

	public Integer getLastModifyUser() {
		return lastModifyUser;
	}

	public void setLastModifyUser(Integer lastModifyUser) {
		this.lastModifyUser = lastModifyUser;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	public Student getStudent() {

		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public List<Student> getStudentList() {
		return studentList;
	}

	public void setStudentList(List<Student> studentList) {
		this.studentList = studentList;
	}

	public String getStateShow() {
		return stateShow;
	}

	public void setStateShow(String s) {
		this.stateShow = s;
	}

	public Dictionary getParentdictionary() {
		return parentdictionary;
	}

	public void setParentdictionary(Dictionary parentdictionary) {
		this.parentdictionary = parentdictionary;
	}

	public ConStudent getContractEntety() {
		return contractEntety;
	}

	public void setContractEntety(ConStudent contractEntety) {
		this.contractEntety = contractEntety;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getCourseInfo() {
		return courseInfo;
	}

	public void setCourseInfo(String courseInfo) {
		this.courseInfo = courseInfo;
	}

	/**
	 * 查询显示学生管理页面用的数据
	 * 
	 * @return
	 * @throws FinanceServiceException
	 * @throws NumberFormatException
	 */
	public String showStudent() throws NumberFormatException, FinanceServiceException {

		IStudentManagementService service = getFactory().getFinanceProviderInstance().getStudentManagementService();
		Student student = new Student();
		// 姓名
		if (null != studentName && !studentName.equals("姓名")) {
			student.setStudentName(studentName);
		} else {
			student.setStudentName("");
		}
		// 公司
		if (null != company && !company.equals("0") && !company.equals("")) {
			student.setCompany(company);
		} else {
			student.setCompany("0");
		}
		// 学号
		if (null != no && !no.equals("学号")) {
			student.setNo(no);
		} else {
			student.setNo("");
		}
		// 合同号
		if (null != contractNo && !contractNo.equals("合同号")) {
			student.setContractNo(contractNo);
		} else {
			student.setContractNo("");
		}
		// 状态
		if (null != state && !state.equals("0") && !state.equals("")) {
			student.setState(Integer.parseInt(state));
		} else {
			student.setState(0);
		}
		// 年级
		if (null != grade && !grade.equals("0") && !grade.equals("") ) {
			student.setGrade(Integer.parseInt(grade));
		} else {
			student.setGrade(0);
		}
		studentList = service.readAllStudent(student);
		/*for (Student s : studentList) {
			if (null != s.getState()) {
				switch (s.getState()) {
				case 1:
					s.setStateShow("未入校");
					break;
				case 2:
					s.setStateShow("入校");
					break;
				case 3:
					s.setStateShow("进入训练");
					break;
				case 4:
					s.setStateShow("停飞");
					break;
				default:
					break;
				}
			}
		}*/
		IDataDicManageService service1 = getFactory().getFinanceProviderInstance().getDataDicManageService();
		for (Student s : studentList) {
			parentdictionary = service1.getdataDictionary(Integer.parseInt(s.getCompany()));
			if (null != parentdictionary) {
				s.setCompany(parentdictionary.getDictionaryName());
			}
			parentdictionary = service1.getdataDictionary(s.getState());
			if(null != parentdictionary){
				s.setStateShow(parentdictionary.getDictionaryName());
			}
		}
		return SUCCESS;
	}

	/**
	 * 增加用户信息
	 * 
	 * @return
	 */
	public String addStudent() throws FinanceServiceException {
		try {
			IStudentManagementService service = getFactory().getFinanceProviderInstance().getStudentManagementService();
			if (null != studentName) {
				Date date = new Date();
				Student student = new Student();
				student.setStudentName(studentName);
				student.setCompany(company);
				student.setContractNo(contractNo);
				student.setIdCard(idCard);
				student.setGrade(Integer.parseInt(grade));
				student.setNo(no);
				student.setAddTime(date);
				student.setState(607);
				service.saveStudent(student);

			} else {
				return "false";
			}
		} catch (FinanceServiceException e) {
			throw new FinanceServiceException("新增合同失败。");
		}
		return SUCCESS;
	}

	/**
	 * 更新用户信息
	 * 
	 * @return
	 * @throws Exception
	 */
	public String updateStudent() throws Exception {
		try {
			IStudentManagementService service = getFactory().getFinanceProviderInstance().getStudentManagementService();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();

			String[] idList = studentId.split(",");
			for (int i = 0; i < idList.length; i++) {
				if (idList[i].equals("undefined"))
					continue;
				Student student = new Student();
				student.setStudentId(Integer.parseInt(idList[i]));
				student.setState(Integer.parseInt(state));
//				if (!joinTime.equals(""))
//					student.setJoinTime(sdf.parse(joinTime));

				student.setStopReason(stopReason);
				if (!stopTime.equals(""))
					student.setStopTime(sdf.parse(stopTime));
				student.setLastModifyTime(date);
				service.saveStudent(student);
			}
			return SUCCESS;
		} catch (FinanceServiceException e) {
			return ERROR;
		}
	}

	/**
	 * 根据id获取用户对象json
	 * 
	 * @return
	 * @throws IOException
	 */
	public String getStudentInfo() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		IStudentManagementService service = getFactory().getFinanceProviderInstance().getStudentManagementService();
		int StudentId = Integer.parseInt(request.getParameter("studentId"));
		String resultStr = service.getInfoById(StudentId);
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(resultStr);
		out.flush();
		out.close();
		return resultStr;
	}

	public String getDictionary() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		int DictionaryId = Integer.parseInt(request.getParameter("DictionaryId"));
		JSONObject jsonObj = null;
		JSONArray jsonArr = null;
		JSONObject dicJson = null;
		jsonObj = new JSONObject();

		jsonArr = new JSONArray();
		DictionaryCache dictionaryCache = DictionaryCache.getInstance();
		List<Dictionary> dictList = dictionaryCache.getAllDic();
		if (dictList != null && dictList.size() > 0) {
			for (Dictionary dic : dictList) {
				dicJson = new JSONObject();
				if (dic.getDictionaryId() == DictionaryId
						|| ((null != dic.getParentId() && dic.getParentId() == DictionaryId))) {
					dicJson.put("id", dic.getDictionaryId());
					dicJson.put("name", dic.getDictionaryName());
					dicJson.put("level", dic.getLevel());
					jsonArr.add(dicJson);
				}
			}
		}
		jsonObj.put("dics", jsonArr);
		String resultStr = jsonObj.toString();
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(resultStr);
		out.flush();
		out.close();
		return resultStr;

	}

	public String ContractListByNo() {
		IStudentManagementService service = getFactory().getFinanceProviderInstance().getStudentManagementService();
		Student student = new Student();
		student.setNo(no);
		student.setContractNo(contractNo);
		contractEntety = service.ContractListByNo(student);
		return SUCCESS;
	}

	public String saveDetaile() throws FinanceServiceException {
		IStudentManagementService service = getFactory().getFinanceProviderInstance().getStudentManagementService();
		Student student = new Student();
		student.setStudentId(Integer.parseInt(studentId));
		student.setCourseInfo(courseInfo);//课程信息
		service.saveDetaile(student);
		return SUCCESS;
	}
}
