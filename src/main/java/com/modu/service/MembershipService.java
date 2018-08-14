package com.modu.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.modu.dao.MembershipDao;
import com.modu.vo.MembershipVo;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.UserGroupVo;
import com.sun.org.apache.regexp.internal.recompile;

@Service
public class MembershipService {
	
	@Autowired
	private MembershipDao membershipdao;
	
	
	
	public ModuGroupVo selectMembership(ModuGroupVo groupvo, UserGroupVo usergroupvo) {
		
		//그룹DB에 집어넣기
		
		/*회비일 설정하기*/
		Calendar cal = Calendar.getInstance();
		// 현재 년도, 월, 일
		int year = cal.get(cal.YEAR);
		int month = cal.get(cal.MONTH) + 2;
		String date = groupvo.getMemberFeeDate();
		
		String sysDate = year + "/" + month + "/" + date;
		
		groupvo.setMemberFeeDate(sysDate);
		int no = membershipdao.insertMembership(groupvo);
		
		//회비DB에 집어넣기 
		MembershipVo mvo = new MembershipVo();
		
		/*userName에 스트링으로 userNo를 가져와서 다시 변환하는 작업*/
		String[] str = usergroupvo.getUserName().split(",");
		 int[] user_groupNo = new int[str.length];
		 int fee = groupvo.getMemberFeeAmount();
		 for(int i=0; i<str.length; i++) {
			 user_groupNo[i] = Integer.parseInt(str[i]);
			 System.out.println(user_groupNo[i]);
			 mvo.setUser_groupNo(user_groupNo[i]);
			 mvo.setPaymentFee(fee);
			 mvo.setPaymentDate(sysDate);
			 membershipdao.insertPayment(mvo);
		 }		
		
		//회비관리에 보여줄 화면 select 하기  
	       ModuGroupVo gmo = membershipdao.selectMembership(no);
	       System.out.println(gmo.getMemberFeeDate());
	       
	       
	       String [] sysdate = gmo.getMemberFeeDate().split(" ");
	       System.out.println(sysdate[0]);
	       
	       String [] day = sysdate[0].split("-");
	       
	       System.out.println(day[2]);
	       gmo.setMemberFeeDate(day[2]);
	       
	      return gmo;
		 
	}
	
	public ModuGroupVo selectdefault(int groupNo) {
		ModuGroupVo mvo = membershipdao.selectMembership(groupNo);
		
		   System.out.println(mvo.getMemberFeeDate());
	       
	       String [] sysdate = mvo.getMemberFeeDate().split(" ");
	       System.out.println(sysdate[0]);
	       
	       String [] day = sysdate[0].split("-");
	       
	       System.out.println(day[2]);
	       mvo.setMemberFeeDate(day[2]);
		
		 return mvo;
	}
	
	public  List<MembershipVo> selectMembershipList(int groupNo){
		return membershipdao.selectMembershipList(groupNo);
		
	}

}
