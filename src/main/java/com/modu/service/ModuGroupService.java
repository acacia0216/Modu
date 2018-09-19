package com.modu.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.modu.dao.MembershipDao;
import com.modu.dao.ModuGroupDao;
import com.modu.vo.MembershipVo;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.NewsVo;
import com.modu.vo.RankVo;
import com.modu.vo.UserGroupVo;

@Service
public class ModuGroupService {

	@Autowired
	private ModuGroupDao groupDao;
	
	@Autowired
	private MembershipDao membershipDao;

	@Transactional
	   public List<ModuGroupVo> plusGroup(ModuGroupVo groupvo, MultipartFile multipartFile, UserGroupVo usergroupvo) {
	      // 오리지날 파일명
	      String OrgName = multipartFile.getOriginalFilename();
	      System.out.println("오리지날 파일명 = " + OrgName);

	      // 확장자
	      String exname = multipartFile.getOriginalFilename()
	            .substring(multipartFile.getOriginalFilename().lastIndexOf(".")); // 확장자는 점으로 구별하니까//오리지널파일명에서 마지막 점부터
	                                                               // 자른다.
	      System.out.println("확장자 = " + exname);

	      // 저장파일명
	      String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exname; // 지금시간과 랜덤수 +확장자
	      System.out.println("저장파일명 = " + saveName);

	      // 폴더에 저장할 것 이다.
	      String saveDir = "D:\\modu\\upload";
	      String filepath = saveDir + "\\" + saveName;
	      System.out.println("파일패스 = " + filepath);

	      // 파일사이즈
	      long fileSize = multipartFile.getSize();
	      System.out.println("파일사이즈 = " + fileSize);

	      groupvo.setGroupImg(saveName);
	      groupvo.setManager(usergroupvo.getUserNo());

	      try {
	         byte[] fileData = multipartFile.getBytes();
	         OutputStream out = new FileOutputStream(saveDir + "/" + saveName);
	         BufferedOutputStream bout = new BufferedOutputStream(out);
	         bout.write(fileData);
	         if (bout != null) {
	            bout.close();
	         }
	      } catch (IOException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }

	      int groupNo = groupDao.plusGroup(groupvo);
	      MembershipVo membershipVo = new MembershipVo();
	      membershipVo.setGroupNo(groupNo);
	      membershipVo.setRankName("Gold");
	      
	      int rankNo1 = groupDao.createRank(membershipVo);
	      membershipVo.setRankName("Silver");
	      int rankNo2 = groupDao.createRank(membershipVo);
	      membershipVo.setRankName("Bronze");
	      int rankNo3 = groupDao.createRank(membershipVo);
	      
	      System.out.println(groupNo + "그룹생성");

	      Calendar cal = Calendar.getInstance();
	      // 현재 년도, 월, 일
	      int year = cal.get(cal.YEAR);
	      int month = cal.get(cal.MONTH) + 1;
	      int date = cal.get(cal.DATE);

	      String sysDate = year + "/" + month + "/" + date;

	      usergroupvo.setGroupNo(groupNo);
	      usergroupvo.setJoinMessage("총무");
	      usergroupvo.setJoinState("완료");
	      
	      //총무에게 rankNo 부여하기 
	      usergroupvo.setRankNo(rankNo1);
	      
	      usergroupvo.setJoinDate(sysDate);
	      groupDao.insertJoin(usergroupvo);

	      return groupDao.selectGroup(usergroupvo.getUserNo());
	   }

	public List<ModuGroupVo> selectGroup(int userNo) {
		return groupDao.selectGroup(userNo);
	}

	public ModuGroupVo selectGroupImg(int groupNo) {
		return groupDao.selectGroupImg(groupNo);
	}

	public List<ModuGroupVo> searchGroup(String gSearch,int userNo) {
	      
	      
	      //검색한 그룹중 내가 가입한 그룹이 있을때 신청 못하도록 걸러주기 
	      List<ModuGroupVo> SList = groupDao.searchGroup(gSearch);
	      List<ModuGroupVo> GList = groupDao.selectGroup(userNo);
	      List<UserGroupVo> UList = groupDao.selectJoinState(userNo);
	      
	      
	      for (ModuGroupVo svo : SList ) {
	         for(ModuGroupVo gvo : GList) {
	            
	            if(svo.getGroupNo() == gvo.getGroupNo()) {
	               svo.setIsJoin("yes");
	            }
	         }
	      }
	      
	      for(ModuGroupVo svo: SList) {
	         for(UserGroupVo uvo: UList) {
	            if(svo.getGroupNo() == uvo.getGroupNo()) {
	                  svo.setIsJoin("ing");
	               
	            }
	         }
	      }
	    System.out.println(SList.toString());
	      
	      
	      return  SList;            
	   }

	public int insertJoin(UserGroupVo usergroupvo) {
	      Calendar cal = Calendar.getInstance();
	      // 현재 년도, 월, 일
	      int year = cal.get(cal.YEAR);
	      int month = cal.get(cal.MONTH) + 1;
	      int date = cal.get(cal.DATE);
	      String sysDate = year + "/" + month + "/" + date;
	      
	      

	      usergroupvo.setJoinState("대기");
	      usergroupvo.setJoinDate(sysDate);
	      usergroupvo.setRankNo(0);

	      return groupDao.insertJoin(usergroupvo);
	   }

	public List<UserGroupVo> selectJoinList(int groupNo) {
		return groupDao.selectJoinList(groupNo);
	}

	public List<UserGroupVo> selectUserList(int groupNo) {
		return groupDao.selectUserList(groupNo);
	}

	public List<UserGroupVo> joinCheck(UserGroupVo usergroupvo) {

	      if ("0".equals(usergroupvo.getJoinState())) {
	         Calendar cal = Calendar.getInstance();
	         // 현재 년도, 월, 일
	         int year = cal.get(cal.YEAR);
	         int month = cal.get(cal.MONTH) + 1;
	         int date = cal.get(cal.DATE);

	         String sysDate = year + "/" + month + "/" + date;

	         
	         RankVo rvo = groupDao.selectRankNo(usergroupvo.getGroupNo());
	         
	         usergroupvo.setJoinState("완료");
	         usergroupvo.setJoinDate(sysDate);
	         usergroupvo.setRankNo(rvo.getRankNo());
	         groupDao.updateState(usergroupvo);
	         
	         NewsVo newsVo = new NewsVo(usergroupvo.getGroupNo(),"[ "+usergroupvo.getUserName()+" ] 님이 모임에 가입하였습니다.");
	         groupDao.insertNews(newsVo);
	         
	      } else if ("1".equals(usergroupvo.getJoinState())) {
	          groupDao.deleteState(usergroupvo.getUser_groupNo());
	      } else {
	         System.out.println("오류");
	         
	      }
	      return groupDao.selectUserList(usergroupvo.getGroupNo());

	   }

	public int deleteUser(int getUser_groupNo) {
		
		membershipDao.delMember(getUser_groupNo);
		return groupDao.deleteState(getUser_groupNo);
	}
	
	public int updateMana(UserGroupVo usergroupvo ) {
		
		ModuGroupVo gvo = new ModuGroupVo();
		gvo.setManager(usergroupvo.getUserNo());
		gvo.setGroupNo(usergroupvo.getGroupNo());
		return groupDao.updateMana(gvo);
	}
	
	public int updateGroup(ModuGroupVo groupvo, MultipartFile multipartFile) {
	      
	      if(!multipartFile.isEmpty()) {
	         
	         
	         // 오리지날 파일명
	         String OrgName = multipartFile.getOriginalFilename();
	         System.out.println("오리지날 파일명 = " + OrgName);
	         
	         // 확장자
	         String exname = multipartFile.getOriginalFilename()
	               .substring(multipartFile.getOriginalFilename().lastIndexOf(".")); // 확장자는 점으로 구별하니까//오리지널파일명에서 마지막 점부터
	         // 자른다.
	         System.out.println("확장자 = " + exname);
	         
	         // 저장파일명
	         String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exname; // 지금시간과 랜덤수 +확장자
	         System.out.println("저장파일명 = " + saveName);
	         
	         // 폴더에 저장할 것 이다.
	         String saveDir = "D:\\modu\\upload";
	         String filepath = saveDir + "\\" + saveName;
	         System.out.println("파일패스 = " + filepath);
	         
	         // 파일사이즈
	         long fileSize = multipartFile.getSize();
	         System.out.println("파일사이즈 = " + fileSize);
	         
	         groupvo.setGroupImg(saveName);
	         
	         try {
	            byte[] fileData = multipartFile.getBytes();
	            OutputStream out = new FileOutputStream(saveDir + "/" + saveName);
	            BufferedOutputStream bout = new BufferedOutputStream(out);
	            bout.write(fileData);
	            if (bout != null) {
	               bout.close();
	            }
	         } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	         }
	         
	      } 
	      else{ 
	         String saveName=groupvo.getGroupImg();
	         groupvo.setGroupImg(saveName); 
	      } 
	      return groupDao.updateGroup(groupvo);
	      
	   }
	
	//등급 추가하기
	   public List<RankVo> plusRank(RankVo rankvo){
	      
	      int no = groupDao.insertRank(rankvo);
	      System.out.println("rank추가하기 성공"+no);
	      
	      return groupDao.selectRank(rankvo.getGroupNo());
	      
	   }
	   
	   //듬급 불러오기 
	   public List<RankVo> selectRank(int groupNo){
		   return groupDao.selectRank(groupNo);
	   }
	   
	   //등급 삭제하기 
	   public List<RankVo> deleteRank(RankVo rankvo){
	      
	      int no = groupDao.deleteRank(rankvo.getRankNo());
	      System.out.println("rank삭제하기 성공"+no);
	      
	      return groupDao.selectRank(rankvo.getGroupNo());
	      
	   }
	   
	   //등급 설정하기
	   public int fixRank(RankVo rvo) {
		   return groupDao.fixRank(rvo);
	   }
	   //등급 수정하기
	   public int updateRank(RankVo rankvo) {
		   return groupDao.updateRank(rankvo);
	   }
	   
	

}
