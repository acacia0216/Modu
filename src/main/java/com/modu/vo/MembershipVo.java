package com.modu.vo;

public class MembershipVo {
	
	private int memberfeeNo; //회비번호
	private int user_groupNo; // 유저 그룹번호 -> 이거로 조인
	private int paymentFee; // 납부해야할 금액
	private String paymentDate; // 납부해야할 날짜
	private int paymentAmount; // 납부액 
	private String paymentDay; // 납부일 
	private String userName; //조인
	private int rankNo;
	private String feeGroupName;
	private int rankPaymentFee;
	private String rankPaymentDate;
	private String rankName;
	private int groupNo;
	
	public MembershipVo() {
		
	}
	public MembershipVo(int memberfeeNo, int user_groupNo, int paymentFee, String paymentDate, int paymentAmount,
			String paymentDay, String userName, int rankNo, String feeGroupName, int rankPaymentFee,
			String rankPaymentDate, String rankName, int groupNo) {
		this.memberfeeNo = memberfeeNo;
		this.user_groupNo = user_groupNo;
		this.paymentFee = paymentFee;
		this.paymentDate = paymentDate;
		this.paymentAmount = paymentAmount;
		this.paymentDay = paymentDay;
		this.userName = userName;
		this.rankNo = rankNo;
		this.feeGroupName = feeGroupName;
		this.rankPaymentFee = rankPaymentFee;
		this.rankPaymentDate = rankPaymentDate;
		this.rankName = rankName;
		this.groupNo = groupNo;
	}
	public int getMemberfeeNo() {
		return memberfeeNo;
	}
	public void setMemberfeeNo(int memberfeeNo) {
		this.memberfeeNo = memberfeeNo;
	}
	public int getUser_groupNo() {
		return user_groupNo;
	}
	public void setUser_groupNo(int user_groupNo) {
		this.user_groupNo = user_groupNo;
	}
	public int getPaymentFee() {
		return paymentFee;
	}
	public void setPaymentFee(int paymentFee) {
		this.paymentFee = paymentFee;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	public int getPaymentAmount() {
		return paymentAmount;
	}
	public void setPaymentAmount(int paymentAmount) {
		this.paymentAmount = paymentAmount;
	}
	public String getPaymentDay() {
		return paymentDay;
	}
	public void setPaymentDay(String paymentDay) {
		this.paymentDay = paymentDay;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getRankNo() {
		return rankNo;
	}
	public void setRankNo(int rankNo) {
		this.rankNo = rankNo;
	}
	public String getFeeGroupName() {
		return feeGroupName;
	}
	public void setFeeGroupName(String feeGroupName) {
		this.feeGroupName = feeGroupName;
	}
	public int getRankPaymentFee() {
		return rankPaymentFee;
	}
	public void setRankPaymentFee(int rankPaymentFee) {
		this.rankPaymentFee = rankPaymentFee;
	}
	public String getRankPaymentDate() {
		return rankPaymentDate;
	}
	public void setRankPaymentDate(String rankPaymentDate) {
		this.rankPaymentDate = rankPaymentDate;
	}
	public String getRankName() {
		return rankName;
	}
	public void setRankName(String rankName) {
		this.rankName = rankName;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	
	@Override
	public String toString() {
		return "MembershipVo [memberfeeNo=" + memberfeeNo + ", user_groupNo=" + user_groupNo + ", paymentFee="
				+ paymentFee + ", paymentDate=" + paymentDate + ", paymentAmount=" + paymentAmount + ", paymentDay="
				+ paymentDay + ", userName=" + userName + ", rankNo=" + rankNo + ", feeGroupName=" + feeGroupName
				+ ", rankPaymentFee=" + rankPaymentFee + ", rankPaymentDate=" + rankPaymentDate + ", rankName="
				+ rankName + ", groupNo=" + groupNo + "]";
	}

}
