package com.modu.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.modu.vo.MembershipVo;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.NewsVo;
import com.modu.vo.RankVo;
import com.modu.vo.UserGroupVo;


@Repository
public class ModuGroupDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	// 모임 추가하기
	public int plusGroup(ModuGroupVo groupvo) {
		System.out.println(groupvo.toString());
		sqlSession.insert("group.insert",groupvo);
		
	    return groupvo.getGroupNo();
	}
	
	//내가 속한 그룹명단
	public List<ModuGroupVo> selectGroup(int userNo) {
		return sqlSession.selectList("group.selectGroupList",userNo);
	}
    
	//내가 클릭한 그룹이미지, 이름
	public ModuGroupVo selectGroupImg(int groupNo) {

		return sqlSession.selectOne("group.selectImg",groupNo);
	}
    
	// 검색조건에 맞는 그룹리스트
	public List<ModuGroupVo> searchGroup(String gSearch){
		return sqlSession.selectList("group.searchList",gSearch);
	}
    
	// 그룹신청하기
	public int insertJoin (UserGroupVo usergroupvo) {
		return sqlSession.insert("group.insertJoin",usergroupvo);
	}
	
	//그룹 - 신청자명단 리스트(joinState=대기)
	public List<UserGroupVo> selectJoinList(int groupNo){
		return sqlSession.selectList("group.selectList",groupNo);
	}
	
	// 대기 그룹명단
	public List<UserGroupVo> selectJoinState(int userNo){
		return sqlSession.selectList("group.selectJoinState",userNo);
	}
	
	//그룹 - 회원자명단(joinState=완료)
	public List<UserGroupVo> selectUserList(int groupNo){
		return sqlSession.selectList("group.selectUserList",groupNo);
	}
	
	// 신청자 중 수락
	public int updateState(UserGroupVo usergroupvo) {
		
		System.out.println(usergroupvo.toString());
		return sqlSession.update("group.updateJoinState",usergroupvo);
		
	}
	
	// 신청자 중 거절 그리고 회원 중 추방하기 
	public int deleteState(int User_groupNo) {
		System.out.println(User_groupNo);
		return sqlSession.delete("group.deleteJoinState",User_groupNo);
	}
	
	// 회원 중 총무위임 
	public int updateMana(ModuGroupVo gvo) {
		return sqlSession.update("group.updateMana",gvo);
	}
	
	//그룹 수정
	public int updateGroup(ModuGroupVo groupvo) {
		return sqlSession.update("group.updateGroup",groupvo);
	}
	
	//그룹생성시 랭크 디폴트 값
	public int createRank(MembershipVo membershipVo) {
		   sqlSession.insert("group.createRank",membershipVo);
		return membershipVo.getRankNo();
	}
	
	//신청자 수락시 랭크 디폴트 값 부르기 
	public RankVo selectRankNo(int groupNo) {
		return sqlSession.selectOne("group.selectRankNo", groupNo);
	}
	
	// 신청자 수락시 새소식 추가
	public void insertNews(NewsVo newsVo) {
		sqlSession.insert("group.insertNews",newsVo);
	}
	
	//랭크 추가하기
	public int insertRank(RankVo rankvo) {
		return sqlSession.insert("group.insertRank",rankvo);
	}
	
	//랭크 리스트 불러오기 
	public List<RankVo> selectRank(int groupNo){
		System.out.println("그룹넘버"+groupNo);
		return sqlSession.selectList("group.selectRank",groupNo);
	}
	
	//랭크 삭제하기
	public int deleteRank(int rankNo) {
		return sqlSession.delete("group.delRank",rankNo);
	}
	
	//랭크 설정하기
	public int fixRank(RankVo rvo) {
		System.out.println(rvo);
		return sqlSession.update("group.fixRank",rvo);
	}
	
	//랭크 수정하기
	public int updateRank(RankVo rankvo) {
		return sqlSession.update("group.updateRank",rankvo);
	}
	



}
