package com.modu.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.modu.dao.BoardDao;
import com.modu.vo.AccountbookAddressVo;
import com.modu.vo.BoardVo;
import com.modu.vo.FileVo;
import com.modu.vo.NewsVo;

@Service
public class BoardService {

	
	@Autowired
	private BoardDao dao;
	
	
	
	@Transactional
	public void addPost(BoardVo boardVo, HashMap<String, Object> map) {
		
		System.out.println("서비스 까지 왓수다");
		
		
		//주소 등 가게  정보  insert
		List<AccountbookAddressVo> addrList= boardVo.getAddressList();
		if(addrList!=null) {
			for(AccountbookAddressVo addrVo : addrList) {
				
				String title = addrVo.getTitle();
				System.out.println("타이틀"+title);
				if(title!=null&&!("").equals(title)) {
					System.out.println("addrvo투스트링"+addrVo.toString());
					String checkAddrNo =dao.checkAddr(addrVo);
					System.out.println("체크어드레스no--"+checkAddrNo);
					String addrNo = "";
					
					if(checkAddrNo!=null&&!("").equals(checkAddrNo)) {
						//중복이 있을 경우 db에 넣진 말고 board에 연결은 해라
						System.out.println("DB에 같은 점포 중복 있음");
						addrNo = checkAddrNo;
					} else {
						//중복 없으면 db에 넣어라
						System.out.println("DB에 같은 점포 없음");
						AccountbookAddressVo resultAddrVo = dao.insertAddr(addrVo);
						addrNo = resultAddrVo.getAccountbookAddressNo();
						/*dao.updateAddrNo(boardVo);*/
						
					}
					
				String accountNo = addrVo.getAccountbookNo();
				System.out.println("가계부번호 "+accountNo + " 에다가 주소록 번호 "+addrNo +"를 업데이트한다");
				Map<String, Object> addrMap = new HashMap<>();
				addrMap.put("accountbookNo", accountNo);
				addrMap.put("accountbookAddressNo",addrNo);
				dao.updateAddrNo(addrMap);
				/*	List<BoardVo> accList = boardVo.getAccountList();
					
					for(BoardVo vo  : accList) {
						List<AccountbookAddressVo> addrList = vo.getAddressList();
						
						String accountNo = vo.getAccountbookNo();
						
				
						
						
					}*/
					
				}
				
				
				
			}
		}
			
		
				
		// 가계부 첨부
		// 넣어야 하는것 1. 보드 tbl에 태그no -- board에 이미 들어갔음
		if(boardVo.getTagName()==null||("").equals(boardVo.getTagName())) {
	         
	         
	      } else {
	         

	         if(boardVo.getTagNo()==null||("").equals(boardVo.getTagNo())) {
	            //날짜로 불러오기
	            // accountNo 마다 tagNo ( acc_tag_tbl ) 넣어주기
	            // tagNo는 seq.nextval
	            System.out.println("찌거바"+ boardVo);
	             BoardVo tempTag;
	            tempTag = dao.checkTag(boardVo);
	            if(tempTag == null) {
	               tempTag = dao.insertTag(boardVo);
	               String tagNo=tempTag.getTagNo();
	               boardVo.setTagNo(tagNo);
	               List<BoardVo> accountList  = boardVo.getAccountList();
	               
	               NewsVo newsVo = new NewsVo(boardVo.getGroupNo(),"[ "+boardVo.getTagName()+" ] 보고서가 작성되었습니다.");
	       		   dao.insertNews(newsVo);
	               for(BoardVo vo : accountList){
	                  vo.setTagNo(tagNo);
	                  dao.connectTagGroup(vo);   
	               }
	               
	            } else {
	               
	               
	            }
	            
	         } else {
	            //태그로 불러오기
	         }
	         
	         List<BoardVo> accountList =  boardVo.getAccountList();
	         for (BoardVo vo : accountList) {
	            
	            System.out.println("&&& 업데이트 장소 직전");
	            dao.updatePlace(vo);
	         
	         }
	         
	         
	      }
		
		//글 내용
		String boardNo = dao.addPost(boardVo);
		
		
		
		//파일
		MultipartFile[] files = (MultipartFile[])map.get("files");
		
		System.out.println("######################"+files[0].getSize());
	
		
		/*파일 아이템 Null 체크 -- 파일item은 null이 없기때문에  파일 사이즈나 파일 이름으로 한다.*/
		if(files[0].getSize()!=0) { 
			FileVo fileVo =(FileVo)map.get("fileVo");
			String saveDir = "D:\\modu\\upload";
			for(MultipartFile file: files) {
				
				//오리지날 파일명
				String orgName = file.getOriginalFilename();
				System.out.println("orgName: "+ orgName);
						
				// 확장자
				String exName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
				System.out.println("exName: "+ exName);
						
				// 저장파일명
				String saveName = System.currentTimeMillis() + UUID.randomUUID().toString()+exName;
				System.out.println("saveName: " + saveName);
				
				// 파일패스
				String filePath = saveDir+"\\"+saveName;
				System.out.println("filePath: " + filePath);
				
			
				// 파일사이즈
				long fileSize = file.getSize();
				System.out.println("fileSize: "+fileSize);
				
				fileVo.setBoardNo(boardNo);
				fileVo.setBoardImgPath(filePath);
				fileVo.setImgSize(fileSize);
				fileVo.setOriginalName(orgName);
				fileVo.setSaveName(saveName);
				System.out.println("서비스: " + fileVo.toString());
				dao.restoreFile(fileVo);
								
				//파일 서버로 복사
				
				try {
					byte[] fileData = file.getBytes();               //메모리에 있는 파일을 서버로 내보낸다. --> outStream
					OutputStream out = new FileOutputStream(filePath);
					BufferedOutputStream bout = new BufferedOutputStream(out);
					
					bout.write(fileData);
					
					if(bout != null) {
						bout.close();
					}
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
		    }
		}
		
		NewsVo newsVo = new NewsVo(boardVo.getGroupNo(),"[ "+boardVo.getBoardTitle()+" ] 이 작성되었습니다.");
		dao.insertNews(newsVo);
	}
	
	
	public void modiPost(BoardVo boardVo, HashMap<String, Object> map) {
		
		System.out.println("서비스 까지 왓수다");
		//글 내용
		String boardNo = dao.addPost(boardVo);
		
		// 가계부 첨부
		// 넣어야 하는것 1. 보드 tbl에 태그no -- board에 이미 들어갔음
		System.out.println("!@#!$!#%!$$----"+boardVo.getTagNo());
		if(boardVo.getTagNo()==null||("").equals(boardVo.getTagNo())) {
			//날짜로 불러오기
			// accountNo 마다 tagNo ( acc_tag_tbl ) 넣어주기
			// tagNo는 seq.nextval
			
			
		} else {
			//태그로 불러오기
			
			List<BoardVo> accountList =  boardVo.getAccountList();
			for (BoardVo vo : accountList) {
				
				System.out.println("&&& 업데이트 장소 직전");
				dao.updatePlace(vo);
			
			}
		
			
		}
		
		
		//파일
		MultipartFile[] files = (MultipartFile[])map.get("files");
		
		System.out.println("######################"+files[0].getSize());
	
		
		/*파일 아이템 Null 체크 -- 파일item은 null이 없기때문에  파일 사이즈나 파일 이름으로 한다.*/
		if(files[0].getSize()!=0) { 
			FileVo fileVo =(FileVo)map.get("fileVo");
			String saveDir = "D:\\modu\\upload";
			for(MultipartFile file: files) {
				
				//오리지날 파일명
				String orgName = file.getOriginalFilename();
				System.out.println("orgName: "+ orgName);
						
				// 확장자
				String exName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
				System.out.println("exName: "+ exName);
						
				// 저장파일명
				String saveName = System.currentTimeMillis() + UUID.randomUUID().toString()+exName;
				System.out.println("saveName: " + saveName);
				
				// 파일패스
				String filePath = saveDir+"\\"+saveName;
				System.out.println("filePath: " + filePath);
				
			
				// 파일사이즈
				long fileSize = file.getSize();
				System.out.println("fileSize: "+fileSize);
				
				fileVo.setBoardNo(boardNo);
				fileVo.setBoardImgPath(filePath);
				fileVo.setImgSize(fileSize);
				fileVo.setOriginalName(orgName);
				fileVo.setSaveName(saveName);
				System.out.println("서비스: " + fileVo.toString());
				dao.restoreFile(fileVo);
								
				//파일 서버로 복사
				
				try {
					byte[] fileData = file.getBytes();               //메모리에 있는 파일을 서버로 내보낸다. --> outStream
					OutputStream out = new FileOutputStream(filePath);
					BufferedOutputStream bout = new BufferedOutputStream(out);
					
					bout.write(fileData);
					
					if(bout != null) {
						bout.close();
					}
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
		    }
		}
		
				
	}

	
	@Transactional
	public List<FileVo> addImg(HashMap<String, Object> map) {
		
		System.out.println("서비스 까지 왓수다");
		
		//파일
		MultipartFile[] files = (MultipartFile[])map.get("files");
		
		System.out.println("######################"+files[0].getSize());
	
		List<FileVo> imgList = null;
		/*파일 아이템 Null 체크 -- 파일item은 null이 없기때문에  파일 사이즈나 파일 이름으로 한다.*/
		if(files[0].getSize()!=0) { 
			FileVo fileVo =(FileVo)map.get("fileVo");
			String boardNo = fileVo.getBoardNo();
			String saveDir = "D:\\modu\\upload";
			for(MultipartFile file: files) {
				
				//오리지날 파일명
				String orgName = file.getOriginalFilename();
				System.out.println("orgName: "+ orgName);
						
				// 확장자
				String exName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
				System.out.println("exName: "+ exName);
						
				// 저장파일명
				String saveName = System.currentTimeMillis() + UUID.randomUUID().toString()+exName;
				System.out.println("saveName: " + saveName);
				
				// 파일패스
				String filePath = saveDir+"\\"+saveName;
				System.out.println("filePath: " + filePath);
				
			
				// 파일사이즈
				long fileSize = file.getSize();
				System.out.println("fileSize: "+fileSize);
				
				
				fileVo.setBoardNo(boardNo);
				fileVo.setBoardImgPath(filePath);
				fileVo.setImgSize(fileSize);
				fileVo.setOriginalName(orgName);
				fileVo.setSaveName(saveName);
				System.out.println("서비스: " + fileVo.toString());
				dao.restoreFile(fileVo);
				imgList = dao.getPostImgs(boardNo);	
				//파일 서버로 복사
				
				try {
					byte[] fileData = file.getBytes();               //메모리에 있는 파일을 서버로 내보낸다. --> outStream
					OutputStream out = new FileOutputStream(filePath);
					BufferedOutputStream bout = new BufferedOutputStream(out);
					
					bout.write(fileData);
					
					if(bout != null) {
						bout.close();
					}
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
		    }
		}
		
					
		return imgList;
	}
	
	public int addCmt(BoardVo boardVo) {
		
		int flag=dao.addCmt(boardVo);
		if(flag==1) {
			int cmtCount = dao.cmtCount(boardVo.getBoardNo());
			return cmtCount;
		} else {
			int cmtCount=-1;
			return cmtCount;
		}
	}
	
	public int deleteCmt(BoardVo boardVo) {
		
		int flag = dao.deleteCmt(boardVo.getCommentNo());
		if(flag==1) {
			int cmtCount = dao.cmtCount(boardVo.getBoardNo());
			return cmtCount;
		} else {
			int cmtCount=-1;
			return cmtCount;
		}
		
	}
	
	
	
	public int postCheck(int groupNo) {
		
		int postCheck = dao.postCheck(groupNo);
		return postCheck;
	}
	
	public List<BoardVo> getPostList(BoardVo boardVo) {
		
		
		List<BoardVo> postList= (List<BoardVo>)dao.getPostList(boardVo.getGroupNo());
		for(BoardVo vo : postList) {
			
			String boardNo = vo.getBoardNo();
			List<FileVo> imgList = dao.getPostImgs(boardNo);
			int likeCount = dao.likeCount(boardNo);
			boardVo.setBoardNo(boardNo);
			String likeState = dao.likeState(boardVo);
			int cmtCount = dao.cmtCount(boardNo);
			vo.setCmtCount(cmtCount);
			vo.setLikeState(likeState);
			vo.setLikeCount(likeCount);
		    vo.setImgList(imgList);
		    if(vo.getTagNo()!=null) {
			    vo.setAccountList(getAccountList(vo));
			    String tagName = dao.getTagName(vo);
			    vo.setTagName(tagName);
		    }
		    
		}
		return postList;
	}
	
	public BoardVo getPost(int boardNo) {
		
		// 글 제목 내용 
		BoardVo boardVo=dao.getPost(boardNo);
		boardVo.setImgList(dao.getPostImgs(String.valueOf(boardNo)));
		String tagNo =boardVo.getTagNo();
		if(tagNo!=null) {
			
			boardVo.setAccountList(dao.getAccountList(boardVo.getTagNo()));
		}
		
		System.out.println("왜 수정 널 ??? " + boardVo.getBoardNo() +boardVo.getBoardContent());
		
		return boardVo;
		/*String tagName = dao.getTagName(boardVo);*/
		
	}
	
	
	@Transactional
	public int deletePost(String boardNo) {
		
		System.out.println("서비스에서 받은 no == "+boardNo);
		int flagImg = dao.deleteImg(boardNo);
		int flagCmt =dao.deleteCmtAll(boardNo);
		int flagLike = dao.deleteLikeAll(boardNo);
		int flagPost = dao.deletePost(boardNo);
		System.out.println("이미지 삭제:"+flagImg+"글 삭제:"+flagPost+"댓글 삭제:"+flagCmt+flagLike);
		int flag=0;
		flag= flagImg+flagPost;
		return flag;
	}
	

	public BoardVo updateLike(BoardVo boardVo) {
		

		String likeState = boardVo.getLikeState();
		System.out.println("서비스 스테이트 " +likeState);
		/*BoardVo resultVo= new BoardVo();*/
		
		if("0".equals(likeState)) {
			int likeCheck=dao.likeCheck(boardVo);
			if(likeCheck==0) {
				
				boardVo.setLikeState("1");
				dao.insertLike(boardVo);
				
			} else {
				
				System.out.println("서비스 스테이트 실행여부0" +likeState);
				boardVo.setLikeState("1");
				dao.updateLike(boardVo);
				
			}
		
			
		} else {
			System.out.println("서비스 스테이트 실행여부1" +likeState);
			boardVo.setLikeState("0");
			dao.updateLike(boardVo);
		}
		int likeCount = dao.likeCount(boardVo.getBoardNo());
		boardVo.setLikeCount(likeCount);
		
		/*
		int no = Integer.parseInt(vo.getNo());
		resultVo = dao.selectImg(no);
		resultVo.getLike();*/
		
		return boardVo;
	}
	
	
	public List<BoardVo> getCmtList(BoardVo boardVo){
		
		List<BoardVo> list = dao.getCmtList(boardVo);
/*		for(BoardVo vo : list) {
			
			String boardNo = vo.getBoardNo();
	
			
		}*/
		return list;
	}
	
	public List<BoardVo> getTagList(int groupNo){
		
		List<BoardVo> tagList = dao.getTagList(groupNo);
		return tagList;
	}
	 
	public List<BoardVo> getAccountList(BoardVo boardVo){
		
		List<BoardVo> accountList = dao.getAccountList(boardVo.getTagNo());
		for( BoardVo vo :  accountList ) {
			
			String accountbookAddressNo = vo.getAccountbookAddressNo();
//			System.out.println("가계부 불러올때 addrNo가 있는가? ------"+accountbookAddressNo);
			if(accountbookAddressNo!=null&&!("").equals(accountbookAddressNo)) {
				// addrNo가 있다면 addrList 불러와서 셋팅 하렴  
				List<AccountbookAddressVo> addrList= dao.getAddrList(accountbookAddressNo);
				if(addrList!=null&&!addrList.isEmpty()) {
					String roadAddress = addrList.get(0).getRoadAddress();
					System.out.println(addrList.get(0));
	//				System.out.println("뿌릴 주소 확인--> "+roadAddress);	
					vo.setRoadAddress(roadAddress);
					vo.setAddressList(addrList);
				}
			}
		}
		
		return accountList;
	}
	
	public List<BoardVo> getAccountBookByDate(BoardVo boardVo){
		
		
		String accountbookRegDate=boardVo.getAccountbookRegDate();
		accountbookRegDate = accountbookRegDate.replaceFirst("-", "/");
		String[] date= accountbookRegDate.split(" ~ ");
		System.out.println("!@#!@#!@#"+date[0]+"!"+date[1]);
		boardVo.setStartDate(date[0]);
		boardVo.setEndDate(date[1]);
		List<BoardVo> accountList = dao.getAccountBookByDate(boardVo);
		return accountList;
	}

	public List<BoardVo> getAccountbookList(String AccountbookList){

		if(AccountbookList.equals("")) {
			return null;
		}
		AccountbookList = AccountbookList.substring(1);
		String[] array = AccountbookList.split(",");
		
		ArrayList<String> Acclist = new ArrayList<>();
		for(String item : array) {
			Acclist.add(item);
		}

		Map map = new HashMap();
		map.put("Acclist", Acclist);

		return dao.getAccountbookList(map);
	}
	
	
}
	
