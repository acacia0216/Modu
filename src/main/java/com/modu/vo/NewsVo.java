package com.modu.vo;

public class NewsVo {

	private int newsNo;
	private int groupNo;
	private String newsDate;
	private String news;
	
	public NewsVo() {
	}
	
	public NewsVo(int groupNo, String news) {
		this.groupNo = groupNo;
		this.news = news;
	}

	public NewsVo(int newsNo, int groupNo, String newsDate, String news) {
		this.newsNo = newsNo;
		this.groupNo = groupNo;
		this.newsDate = newsDate;
		this.news = news;
	}

	public int getNewsNo() {
		return newsNo;
	}

	public void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public String getNewsDate() {
		return newsDate;
	}

	public void setNewsDate(String newsDate) {
		this.newsDate = newsDate;
	}

	public String getNews() {
		return news;
	}

	public void setNews(String news) {
		this.news = news;
	}

	@Override
	public String toString() {
		return "NewsVo [newsNo=" + newsNo + ", groupNo=" + groupNo + ", newsDate=" + newsDate + ", news=" + news + "]";
	}
	
	
	
	
}
