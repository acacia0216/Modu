package com.modu.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.modu.dao.ModuGroupDao;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.UserGroupVo;

@Service
public class ModuGroupService {

	@Autowired
	private ModuGroupDao groupDao;

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
		
	    // 1. 검색한 것중 그룹 넘버 찾기 
		/*int i =1;
		int []sNo = new int[100000];
		for(ModuGroupVo svo : SList) {
			System.out.println(svo.getGroupNo());
			sNo[i] = svo.getGroupNo();
			System.out.println(sNo[i]);
			i++;
		}
		
		// 2. 내가 가지고 있는 그룹 넘버 찾기 
		int j =1;
		int []gNo = new int[100000];
		for(ModuGroupVo gvo : GList) {
			System.out.println(gvo.getGroupNo());
			gNo[j] = gvo.getGroupNo();
			System.out.println(gNo[j]);
			j++;
		}*/
		//int[]m = new  int [10000];
		
	 	// 비교하기 
//		for (int s =0; s<sNo.length;s++ ) {
//			for(int g=0; g<gNo.length;g++) {
//				
//				if(sNo.equals(gNo)) {
//					m[i] = 
//				}
//			}
//			
//		} 
		for (ModuGroupVo svo : SList ) {
			for(ModuGroupVo gvo : GList) {
				
				if(svo.getGroupNo() == gvo.getGroupNo()) {
					svo.setIsJoin("yes");
				}
			}
		}
	 
		
		
		
		return  SList;            
	}

	public ModuGroupVo insertJoin(UserGroupVo usergroupvo) {
		Calendar cal = Calendar.getInstance();
		// 현재 년도, 월, 일
		int year = cal.get(cal.YEAR);
		int month = cal.get(cal.MONTH) + 1;
		int date = cal.get(cal.DATE);
		String sysDate = year + "/" + month + "/" + date;

		usergroupvo.setJoinState("대기");
		usergroupvo.setJoinDate(sysDate);
		groupDao.insertJoin(usergroupvo);

		return groupDao.selectGroupImg(usergroupvo.getGroupNo());
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

			usergroupvo.setJoinState("완료");
			usergroupvo.setJoinDate(sysDate);
			groupDao.updateState(usergroupvo);
			
		} else if ("1".equals(usergroupvo.getJoinState())) {
			 groupDao.deleteState(usergroupvo.getUser_groupNo());
		} else {
			System.out.println("오류");
			
		}
		return groupDao.selectUserList(usergroupvo.getGroupNo());

	}

	public int deleteUser(int getUser_groupNo) {
		return groupDao.deleteState(getUser_groupNo);
	}
	
	public int updateMana(UserGroupVo usergroupvo ) {
		
		ModuGroupVo gvo = new ModuGroupVo();
		gvo.setManager(usergroupvo.getUserNo());
		gvo.setGroupNo(usergroupvo.getGroupNo());
		return groupDao.updateMana(gvo);
	}
	
	public int updateGroup(ModuGroupVo groupvo, MultipartFile multipartFile) {
		
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
				
				return groupDao.updateGroup(groupvo);
		
	}
	

}
