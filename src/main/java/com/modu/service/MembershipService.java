package com.modu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.modu.dao.MembershipDao;
import com.modu.vo.MembershipVo;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.NewsVo;

@Service
public class MembershipService {
	
	@Autowired
	private MembershipDao membershipdao;

	public ModuGroupVo accountSettting(ModuGroupVo groupvo) {
		
		int no =membershipdao.updateAccount(groupvo);
		return membershipdao.selectMembership(no);
	}
	
	public ModuGroupVo selectdefault(int groupNo) {
		return membershipdao.selectMembership(groupNo);
	}
	
	public  List<MembershipVo> getMemberfeeList(int groupNo, String feeGroupName){
		MembershipVo membershipVo = new MembershipVo();
		membershipVo.setGroupNo(groupNo);
		membershipVo.setFeeGroupName(feeGroupName);
		
		return membershipdao.getMemberfeeList(membershipVo);	
	}
	
	public List<MembershipVo> getMemberfeeCardList(int groupNo){	
		List<MembershipVo> memberfeeCardList = membershipdao.getMemberfeeCardList(groupNo);
		List<MembershipVo> memberfeeCardInfo = membershipdao.getMemberfeeCardInfo(groupNo);
		
		for(int i=0;i<memberfeeCardList.size();i++) {
			for(int j=0;j<memberfeeCardInfo.size();j++) {
				if(memberfeeCardList.get(i).getFeeGroupName().equals(memberfeeCardInfo.get(j).getFeeGroupName())) {
					memberfeeCardList.get(i).setPaymentAmount(memberfeeCardInfo.get(j).getPaymentAmount());
					memberfeeCardList.get(i).setPaymentFee(memberfeeCardInfo.get(j).getPaymentFee());
					memberfeeCardList.get(i).setPaymentDay(memberfeeCardInfo.get(j).getPaymentDay());
				}
			}
		}
		return memberfeeCardList;
	}
	
	public  List<MembershipVo> getInsertMemberfeeList(int groupNo, String mode){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("groupNo", groupNo);
		map.put("mode", mode);
		return membershipdao.getInsertMemberfeeList(map);	
	}
	
	@Transactional
	public String insertMemberfee(String feeGroupName,String data,int groupNo,String mode,String paymentDate){	
		String result = "success";
		MembershipVo membershipVo = new MembershipVo();
		membershipVo.setFeeGroupName(feeGroupName);
		membershipVo.setGroupNo(groupNo);
		List<MembershipVo> membershipVoList = membershipdao.checkFeeGroupName(membershipVo);
		if(!membershipVoList.isEmpty()) {
			result = "fail";
			return result;
		}
		
		data = data.substring(1);
		String[] dataList = data.split(",");
		
		String y = paymentDate.substring(0, 4);
		String m = paymentDate.substring(6, 8);
		String d = paymentDate.substring(10, 12);
		paymentDate = y+"/"+m+"/"+d;
		
		Map<String,Object> map =  new HashMap<String,Object>();

		for(int i=0;i<dataList.length;i++) {
			if(i%3==0) {
				map = new HashMap<String,Object>();
				map.put("feeGroupName", feeGroupName);
				map.put("groupNo", groupNo);
				map.put("paymentDate", paymentDate);			
			}
			switch(i%3) {
				case 0:
					if(mode.equals("byRank")) {
						map.put("rankNo", dataList[i]);
					}else {
						map.put("user_groupNo", dataList[i]);
					}		
					break;
				case 1:
					if(mode.equals("byRank")) {
						map.put("rankName", dataList[i]);
					}else {
						map.put("userName", dataList[i]);
					}	
					break;
				case 2:
					if(mode.equals("byRank")) {
						map.put("rankPaymentFee", dataList[i]);	
					}else {
						map.put("paymentFee", dataList[i]);
					}	
					break;
			}
			if(i%3==2) {
				if(mode.equals("byRank")) {
					membershipdao.insertMemberfeeByRank(map);
				}else {
					membershipdao.insertMemberfeeByName(map);
				}				
			}			
		}
		NewsVo newsVo = new NewsVo(groupNo,"[ "+feeGroupName+" ] 회비가 추가되었습니다.");
		membershipdao.insertNews(newsVo);
		return result;		
	}
	
	public void deleteMemberfee(int groupNo,String feeGroupName){	
		MembershipVo membershipVo = new MembershipVo();
		membershipVo.setFeeGroupName(feeGroupName);
		membershipVo.setGroupNo(groupNo);
		membershipdao.deleteMemberfee(membershipVo);
	}
	
	@Transactional
	public void rcvMemberfee(int groupNo,String paymentFee,String memberfeeNo){	
		MembershipVo membershipVo = new MembershipVo();
		membershipVo.setGroupNo(groupNo);
		membershipVo.setPaymentFee(Integer.parseInt(paymentFee));
		membershipVo.setMemberfeeNo(Integer.parseInt(memberfeeNo));
		membershipdao.rcvMemberfee(membershipVo);
		membershipdao.insertToAccountbook(membershipVo);
	}
}
