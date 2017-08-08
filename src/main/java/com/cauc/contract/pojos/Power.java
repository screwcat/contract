// default package
// Generated 2016-7-22 15:08:04 by Hibernate Tools 3.4.0.CR1
package com.cauc.contract.pojos;
/**
 * Power generated by hbm2java
 */
public class Power implements java.io.Serializable {

	private int powerId;
	private String powerName;
	private Integer level;
	private Integer parentId;
	private String description;

	public Power() {
	}

	public Power(int powerId) {
		this.powerId = powerId;
	}

	public Power(int powerId, String powerName, Integer level, Integer parentId, String description) {
		this.powerId = powerId;
		this.powerName = powerName;
		this.level = level;
		this.parentId = parentId;
		this.description = description;
	}

	public int getPowerId() {
		return this.powerId;
	}

	public void setPowerId(int powerId) {
		this.powerId = powerId;
	}

	public String getPowerName() {
		return this.powerName;
	}

	public void setPowerName(String powerName) {
		this.powerName = powerName;
	}

	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
