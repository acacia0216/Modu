package com.modu.vo;

public class AccountbookAddressVo {

	String accountbookAddressNo;
	String accountbookNo;
	String country;
	String sido;
	String sigugun;
	String dongmyun;
	String ri; 
	String rest;
	String telephone;
	String category;
	String title;
	String roadAddress;
	String pointX;
	String pointY;
	
	
	
	
	
	
	
	
	public String getPointX() {
		return pointX;
	}
	public void setPointX(String pointX) {
		this.pointX = pointX;
	}
	public String getPointY() {
		return pointY;
	}
	public void setPointY(String pointY) {
		this.pointY = pointY;
	}
	public String getAccountbookNo() {
		return accountbookNo;
	}
	public void setAccountbookNo(String accountbookNo) {
		this.accountbookNo = accountbookNo;
	}
	public String getRoadAddress() {
		return roadAddress;
	}
	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}
	public String getAccountbookAddressNo() {
		return accountbookAddressNo;
	}
	public void setAccountbookAddressNo(String accountbookAddressNo) {
		this.accountbookAddressNo = accountbookAddressNo;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getSigugun() {
		return sigugun;
	}
	public void setSigugun(String sigugun) {
		this.sigugun = sigugun;
	}
	public String getDongmyun() {
		return dongmyun;
	}
	public void setDongmyun(String dongmyun) {
		this.dongmyun = dongmyun;
	}
	public String getRi() {
		return ri;
	}
	public void setRi(String ri) {
		this.ri = ri;
	}
	public String getRest() {
		return rest;
	}
	public void setRest(String rest) {
		this.rest = rest;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	@Override
	public String toString() {
		return "AccountbookAddressVo [accountbookAddressNo=" + accountbookAddressNo + ", accountbookNo=" + accountbookNo
				+ ", country=" + country + ", sido=" + sido + ", sigugun=" + sigugun + ", dongmyun=" + dongmyun
				+ ", ri=" + ri + ", rest=" + rest + ", telephone=" + telephone + ", category=" + category + ", title="
				+ title + ", roadAddress=" + roadAddress + ", pointX=" + pointX + ", pointY=" + pointY + "]";
	}
	
	
}

