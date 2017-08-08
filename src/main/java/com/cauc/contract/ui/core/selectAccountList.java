package com.cauc.contract.ui.core;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.cauc.contract.FinanceServiceException;
import com.cauc.contract.business.AccountService;
import com.cauc.contract.business.IContractQuerylistService;
import com.cauc.contract.pojos.Account;
import com.cauc.contract.ui.common.BaseActionSupport;
import com.cauc.contract.ui.common.Paging;
import com.cauc.contract.util.AccountListBean;

/**
 * 结算节点方法 CQ
 */
@Controller
@Scope("prototype")
public class selectAccountList extends BaseActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5064195753936861475L;
	private int accountState;
	private int paymentState;
	private List<Account> allList;// 所有节点信息
	private List<Account> partOfList;// 部分节点信息
	private List<AccountListBean> allAccountList;// 全部节点信息封装
	private List<AccountListBean> partOfaccountList;// 部分节点信息封装类
	private String excelIdStr;// 生成Excel的结算ID
	private String newAccountId;

	// 分页部分
	// 分页
	private Paging paging;

	// 每页显示多少条
	private int pagesize;
	// 当前页码
	private int cur_page;
	// 分页字符串
	private String pageStr;

	/**
	 * 查询所有付款节点 swq
	 * 
	 * @return
	 * @throws FinanceServiceException
	 */
	public String selectAccount() throws FinanceServiceException {

		AccountService accountService = getFactory().getFinanceProviderInstance().getAccountService();
		// 查询结算编号最后一位 +1
		newAccountId = accountService.newAccountId();
		// 分页
		int totalRowCount = 0; // 查询到的总条目
		totalRowCount = accountService.getTotalRowCount("Account");
		this.paging = new Paging();
		// 当前页码
		if (this.cur_page == 0) {
			this.cur_page = 1;
		}
		// 每页显示数目
		this.pagesize = 5;
		// 设置当前页码
		this.paging.setCurPage(this.cur_page);
		// 把得到总共显示的数据记录设置在分页总纪录中
		this.paging.setTotalRowCount(totalRowCount);
		// 设置每页显示的数据记录 （根据页面显示条数设置 ）
		this.paging.setPageRowCount(this.pagesize);
		allList = accountService.selectAllAccount("Account", this.cur_page, pagesize, "A_ID", " 1=1 ", "order by A_ID");
		allAccountList = getAccountList(allList);

		pageStr = this.paging.getToolBar("selectAccountList.do");
		return SUCCESS;
	}

	/**
	 * 根据条件查询相应付款节点 CQ
	 * 
	 * @return
	 * @throws FinanceServiceException
	 */
	public String selectAccountById() throws FinanceServiceException {
		if (accountState == 0) {
			setAccountState(1);
		}
		if (paymentState == 0) {
			setPaymentState(1);
		}
		AccountService accountService = getFactory().getFinanceProviderInstance().getAccountService();
		// 查询结算编号最后一位 +1
		newAccountId = accountService.newAccountId();
		// 分页
		int totalRowCount = 0; // 查询到的总条目
		// 查询符合条件的所有节点信息
		totalRowCount = accountService.getPartTotalRowCount("Account", accountState, paymentState);
		this.paging = new Paging();
		// 当前页码
		if (this.cur_page == 0) {
			this.cur_page = 1;
		}
		// 每页显示数目
		this.pagesize = 5;
		// 设置当前页码
		this.paging.setCurPage(this.cur_page);
		// 把得到总共显示的数据记录设置在分页总纪录中
		this.paging.setTotalRowCount(totalRowCount);
		// 设置每页显示的数据记录 （根据页面显示条数设置 ）
		this.paging.setPageRowCount(this.pagesize);

		partOfList = accountService.getPartListByPage("Account", this.cur_page, pagesize, "A_ID", accountState,
				paymentState, "order by A_ID");

		// partOfList = accountService.selectAccountById(accountState,
		// paymentState);
		// 数据封装
		// partOfaccountList = getAccountList(partOfList);
		allAccountList = getAccountList(partOfList);
		pageStr = this.paging
				.getToolBar("selectAccountById.do?accountState=" + accountState + "&paymentState=" + paymentState);
		return SUCCESS;
	}

	/**
	 * 将前端需要的结算列表需要显示的列表书据封装 CQ
	 * 
	 * @param list
	 * @return
	 */
	public List<AccountListBean> getAccountList(List<Account> list) {
		IContractQuerylistService contractQuerylistService = getFactory().getFinanceProviderInstance()
				.getContractQuerylistService();
		List<AccountListBean> list1 = new ArrayList<AccountListBean>();
		for (int i = 0; i < list.size(); i++) {
			AccountListBean accountListBean = new AccountListBean();
			accountListBean.setAid(list.get(i).getAId());
			accountListBean.setAccountNo(list.get(i).getAAccountId());
			accountListBean.setPaymentNo(list.get(i).getPId());
			accountListBean.setContractNo(list.get(i).getCContractId());
			accountListBean.setFundsType(contractQuerylistService.getKindsName(list.get(i).getAFundsType()));
			accountListBean.setFundsSubtotal(
					(list.get(i).getPBuildFeeStandardPrice() + list.get(i).getPTrainFeeStandardPrice())
							* list.get(i).getPGradeStudentCount());
			accountListBean.setAccountState(list.get(i).getAAccountState());
			accountListBean.setPaymentState(list.get(i).getAPaymentState());
			accountListBean.setPBuildFeeStandardPrice(list.get(i).getPBuildFeeStandardPrice());
			accountListBean.setPTrainFeeStandardPrice(list.get(i).getPTrainFeeStandardPrice());
			accountListBean.setPGradeStudentCount(list.get(i).getPGradeStudentCount());
			list1.add(accountListBean);
		}
		return list1;
	}

	/**
	 * 生成Excel 表
	 * 
	 * @return
	 * @throws FinanceServiceException
	 * @throws IOException
	 */
	public void excelAccountById() throws FinanceServiceException, IOException {
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		response.setContentType("text/html;charset=UTF-8");
		// String url = request.getRealPath("/");
		AccountService accountService = getFactory().getFinanceProviderInstance().getAccountService();
		String[] accountIdArray = excelIdStr.split(",");
		accountService.addAccount(newAccountId, accountIdArray);
		response.getWriter().write("OK");
		// return SUCCESS;
	}

	/*---------------------------get/set方法-------------------------------*/
	public int getAccountState() {
		return accountState;
	}

	public void setAccountState(int accountState) {
		this.accountState = accountState;
	}

	public int getPaymentState() {
		return paymentState;
	}

	public void setPaymentState(int paymentState) {
		this.paymentState = paymentState;
	}

	public List<Account> getAllList() {
		return allList;
	}

	public void setAllList(List<Account> allList) {
		this.allList = allList;
	}

	public List<Account> getPartOfList() {
		return partOfList;
	}

	public void setPartOfList(List<Account> partOfList) {
		this.partOfList = partOfList;
	}

	public List<AccountListBean> getAllAccountList() {
		return allAccountList;
	}

	public void setAllAccountList(List<AccountListBean> allAccountList) {
		this.allAccountList = allAccountList;
	}

	public List<AccountListBean> getPartOfaccountList() {
		return partOfaccountList;
	}

	public void setPartOfaccountList(List<AccountListBean> partOfaccountList) {
		this.partOfaccountList = partOfaccountList;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Paging getPaging() {
		return paging;
	}

	public void setPaging(Paging paging) {
		this.paging = paging;
	}

	public int getPagesize() {
		return pagesize;
	}

	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}

	public int getCur_page() {
		return cur_page;
	}

	public void setCur_page(int cur_page) {
		this.cur_page = cur_page;
	}

	public String getPageStr() {
		return pageStr;
	}

	public void setPageStr(String pageStr) {
		this.pageStr = pageStr;
	}

	public String getExcelIdStr() {
		return excelIdStr;
	}

	public void setExcelIdStr(String excelIdStr) {
		this.excelIdStr = excelIdStr;
	}

	public String getNewAccountId() {
		return newAccountId;
	}

	public void setNewAccountId(String newAccountId) {
		this.newAccountId = newAccountId;
	}

}
