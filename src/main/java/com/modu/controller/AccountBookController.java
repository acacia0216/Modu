package com.modu.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modu.service.ModuAccountbookService;
import com.modu.service.ModuGroupService;
import com.modu.service.ModuUserService;
import com.modu.vo.AccountbookCategoryVo;
import com.modu.vo.AccountbookTagVo;
import com.modu.vo.AccountbookVo;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.ModuUserVo;

@Controller
@RequestMapping(value="/accountbook/{groupNo}")
public class AccountBookController {

	@Autowired
	private ModuUserService moduUserService;	
	@Autowired
	private ModuAccountbookService moduAccountbookService;
	@Autowired
	private ModuGroupService groupService;

	@RequestMapping("")
	public String accountbook(@PathVariable("groupNo") String groupNo,Model model, HttpSession session){

		if(session.getAttribute("authUser") == null) {
			return "/index";
		}else {
		// 모임 카테고리
	      ModuUserVo uservo =  (ModuUserVo) session.getAttribute("authUser");
	      List<ModuGroupVo> gList  = groupService.selectGroup(uservo.getUserNo());
	      model.addAttribute("gList",gList);

	      // 클릭한 모임  가계부 보여주기
	      ModuGroupVo gvo = groupService.selectGroupImg(Integer.parseInt(groupNo));
	      model.addAttribute("gvo",gvo);

		return "/accountbook/accountbook";
		}
	}
	
	@RequestMapping("/{urlDate}")
	public String accountbook(@PathVariable("groupNo") String groupNo,Model model, HttpSession session, @PathVariable("urlDate") String urlDate){

		// 모임 카테고리
	      ModuUserVo uservo =  (ModuUserVo) session.getAttribute("authUser");
	      List<ModuGroupVo> gList  = groupService.selectGroup(uservo.getUserNo());
	      model.addAttribute("gList",gList);

	      // 클릭한 모임  가계부 보여주기
	      ModuGroupVo gvo = groupService.selectGroupImg(Integer.parseInt(groupNo));
	      model.addAttribute("gvo",gvo);
	      
	      String yy = urlDate.substring(0, 4);
	      String mm = urlDate.substring(5, 7);
	      
	      model.addAttribute("urlDate",yy + " / " + mm);

		return "/accountbook/accountbook";
	}
	
	@ResponseBody
	@RequestMapping( "/getaccountlist")
	public Map<String,Object> getAccountList(@RequestParam("month") String month,
			                                 @RequestParam("spendFlag") String spendFlag,@PathVariable("groupNo") String groupNo){
		Map<String,Object> map = moduAccountbookService.getAccountList(groupNo,month,spendFlag);
		return map;
	}
	
	@ResponseBody
	@RequestMapping( "/saveaccountbook")
	public AccountbookVo saveaccountbook(
			@RequestParam( value="usage", required=false, defaultValue="사용내역") String usage,
			@RequestParam( value="spend", required=false, defaultValue="0") String spend,
			@RequestParam( value="category", required=false, defaultValue="0") String category,
			@PathVariable("groupNo") String groupNo,
			@RequestParam("date") String date,
			@RequestParam("spendFlag") String spendFlag){
		System.out.println("사용내역"+usage);
		System.out.println("지출액"+spend);
		System.out.println("카테고리"+category);
		System.out.println("그룹번호"+groupNo);
		System.out.println("날짜"+date);
		System.out.println("sf"+spendFlag);
		return moduAccountbookService.saveAccountbook(usage,spend,category,groupNo,date,spendFlag);
	}
	
	@ResponseBody
	@RequestMapping( "/deleteaccountbook")
	public void deleteaccountbook(@RequestParam("AccountbookList") String AccountbookList){
		moduAccountbookService.deleteaccountbook(AccountbookList);
	}
	
	@ResponseBody
	@RequestMapping( "/updateaccountbook")
	public void updateaccountbook(@RequestParam("accountbookno") String accountbookno, @RequestParam("data") String data, @RequestParam("updatePos") String updatePos, @RequestParam("spendFlag") String spendFlag){
		moduAccountbookService.updateAccountbook(accountbookno,data,updatePos,spendFlag);
	}
	
	@ResponseBody
	@RequestMapping( "/taggroup")
	public void taggroup(@PathVariable("groupNo") int groupNo, @RequestParam("AccountbookList") String AccountbookList,@RequestParam("tagName") String tagName){
		moduAccountbookService.taggroup(groupNo,AccountbookList,tagName);
	}

	
	@ResponseBody
	@RequestMapping( "/searchaccountlistbydate")
	public Map<String,Object> searchAccountListByDate(@PathVariable("groupNo") String groupNo, @RequestParam("searchDate1") String searchDate1, @RequestParam("searchDate2") String searchDate2, @RequestParam("spendFlag") String spendFlag){
		Map<String,Object> map = moduAccountbookService.searchAccountListByDate(groupNo,searchDate1,searchDate2,spendFlag);
		return map;
	}
	
	@ResponseBody
	@RequestMapping( "/searchaccountlist")
	public Map<String,Object> searchAccountList(@PathVariable("groupNo") String groupNo, @RequestParam("mode") String mode, @RequestParam("searchText") String searchText, @RequestParam("spendFlag") String spendFlag){
		Map<String,Object> map = moduAccountbookService.searchAccountList(groupNo,mode,searchText,spendFlag);
		return map;
	}
	
	@ResponseBody
	@RequestMapping( "/inserttag")
	public AccountbookTagVo insertTag(@PathVariable("groupNo") int groupNo, @RequestParam("accountbookNo") String accountbookNo, @RequestParam("tagname") String tagname){	
		return moduAccountbookService.insertTag(groupNo,accountbookNo,tagname);
	}
	
	@ResponseBody
	@RequestMapping( "/updateTag")
	public void updateTag(@PathVariable("groupNo") int groupNo, @RequestParam("accountbookNo") String accountbookNo, @RequestParam("accountbooktagno") String accountbooktagno, @RequestParam("tagno") String tagno, @RequestParam("tagname") String tagname){	
		moduAccountbookService.updateTag(groupNo,accountbookNo,accountbooktagno,tagno,tagname);
	}
	
	@ResponseBody
	@RequestMapping( "/getTagList")
	public List<AccountbookTagVo> getTagList(@RequestParam("accountNo") String accountNo){
		return moduAccountbookService.getTagList(accountNo);
	}
	
	@ResponseBody
	@RequestMapping( "/tagDelete")
	public void tagDelete(@RequestParam("accountbooktagno") String accountbooktagno,@RequestParam("tagno") String tagno){
		moduAccountbookService.tagDelete(accountbooktagno,tagno);
	}
	
	@ResponseBody
	@RequestMapping( "/getmodalcategorylist")
	public List<AccountbookCategoryVo> getModalcCtegoryList(@PathVariable("groupNo") String groupNo){
		return moduAccountbookService.getModalcCtegoryList(groupNo);
	}
	
	@ResponseBody
	@RequestMapping( "/categorydelete")
	public void categorydelete(@PathVariable("groupNo") String groupNo,@RequestParam("categoryno") String categoryno){
		moduAccountbookService.categoryDelete(groupNo,categoryno);
	}
	
	@ResponseBody
	@RequestMapping( "/updatecategory")
	public void updateCategory(@RequestParam("categoryno") String categoryno,@RequestParam("categoryname") String categoryname){
		moduAccountbookService.categoryUpdate(categoryno,categoryname);
	}
	
	@ResponseBody
	@RequestMapping( "/insertcategory")
	public int insertCategory(@PathVariable("groupNo") String groupNo,@RequestParam("categoryname") String categoryname){
		return moduAccountbookService.categoryInsert(groupNo,categoryname);
	}
	
	@ResponseBody
	@RequestMapping( "/saveAccountbookForAndroid")
	public AccountbookVo saveAccountbookForAndroid(
			@RequestParam( value="usage", required=false, defaultValue="사용내역") String usage,
			@RequestParam( value="spend", required=false, defaultValue="0") String spend,
			@RequestParam( value="category", required=false, defaultValue="0") String category,
			@PathVariable("groupNo") String groupNo,
			@RequestParam("date") String date,
			@RequestParam("spendFlag") String spendFlag){
		System.out.println("사용내역"+usage);
		System.out.println("지출액"+spend);
		System.out.println("카테고리"+category);
		System.out.println("그룹번호"+groupNo);
		System.out.println("날짜"+date);
		System.out.println("sf"+spendFlag);
		return moduAccountbookService.saveAccountbookForAndroid(usage,spend,category,groupNo,date,spendFlag);
	}
	
}
