package com.modu.vo;

public class RankVo {
   
   private int rankNo;
   private String rankName;
   private int groupNo;
   private String rankExplain;
   private int user_groupNo;
   
   
public RankVo() {
}
public RankVo(int rankNo, String rankName, int groupNo, String rankExplain, int user_groupNo) {
	this.rankNo = rankNo;
	this.rankName = rankName;
	this.groupNo = groupNo;
	this.rankExplain = rankExplain;
	this.user_groupNo = user_groupNo;
}
public int getRankNo() {
	return rankNo;
}
public void setRankNo(int rankNo) {
	this.rankNo = rankNo;
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
public String getRankExplain() {
	return rankExplain;
}
public void setRankExplain(String rankExplain) {
	this.rankExplain = rankExplain;
}
public int getUser_groupNo() {
	return user_groupNo;
}
public void setUser_groupNo(int user_groupNo) {
	this.user_groupNo = user_groupNo;
}
@Override
public String toString() {
	return "RankVo [rankNo=" + rankNo + ", rankName=" + rankName + ", groupNo=" + groupNo + ", rankExplain="
			+ rankExplain + ", user_groupNo=" + user_groupNo + "]";
}
   
   

}