package com.modu.vo;

public class PlaceRecommendVo {

	private String title;
	private String roadaddress;
	private String telephone;
	private int maxperson;
	private float avgpersonnel;
	private int eachspend;
	private float avgspend;
	private float maxpointx;
	private float maxpointy;
	
	
	
	public PlaceRecommendVo() {
		
	}

	public PlaceRecommendVo(String title, String roadaddress, String telephone, int maxperson, float avgpersonnel,
			int eachspend, float avgspend, float maxpointx, float maxpointy) {
		this.title = title;
		this.roadaddress = roadaddress;
		this.telephone = telephone;
		this.maxperson = maxperson;
		this.avgpersonnel = avgpersonnel;
		this.eachspend = eachspend;
		this.avgspend = avgspend;
		this.maxpointx = maxpointx;
		this.maxpointy = maxpointy;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRoadaddress() {
		return roadaddress;
	}

	public void setRoadaddress(String roadaddress) {
		this.roadaddress = roadaddress;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public int getMaxperson() {
		return maxperson;
	}

	public void setMaxperson(int maxperson) {
		this.maxperson = maxperson;
	}

	public float getAvgpersonnel() {
		return avgpersonnel;
	}

	public void setAvgpersonnel(float avgpersonnel) {
		this.avgpersonnel = avgpersonnel;
	}

	public int getEachspend() {
		return eachspend;
	}

	public void setEachspend(int eachspend) {
		this.eachspend = eachspend;
	}

	public float getAvgspend() {
		return avgspend;
	}

	public void setAvgspend(float avgspend) {
		this.avgspend = avgspend;
	}

	public float getMaxpointx() {
		return maxpointx;
	}

	public void setMaxpointx(float maxpointx) {
		this.maxpointx = maxpointx;
	}

	public float getMaxpointy() {
		return maxpointy;
	}

	public void setMaxpointy(float maxpointy) {
		this.maxpointy = maxpointy;
	}

	@Override
	public String toString() {
		return "PlaceRecommendVo [title=" + title + ", roadaddress=" + roadaddress + ", telephone=" + telephone
				+ ", maxperson=" + maxperson + ", avgpersonnel=" + avgpersonnel + ", eachspend=" + eachspend
				+ ", avgspend=" + avgspend + ", maxpointx=" + maxpointx + ", maxpointy=" + maxpointy + "]";
	}
	
}
