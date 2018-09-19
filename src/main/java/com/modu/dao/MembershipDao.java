package com.modu.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.modu.vo.MembershipVo;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.NewsVo;

@Repository
public class MembershipDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int updateAccount(ModuGroupVo groupvo) {
		sqlSession.update("membership.updateAccount",groupvo);
		return groupvo.getGroupNo();
	}
	
	public ModuGroupVo selectMembership(int groupNo) {
		return sqlSession.selectOne("membership.selectMembership",groupNo);
	}
	
	public List<MembershipVo> getMemberfeeList(MembershipVo membershipVo) {	
		return sqlSession.selectList("membership.getMemberfeeList",membershipVo);		
	}
	
	public List<MembershipVo> getMemberfeeCardList(int groupNo) {	
		return sqlSession.selectList("membership.getMemberfeeCardList",groupNo);		
	}
	
	public List<MembershipVo> getMemberfeeCardInfo(int groupNo) {	
		return sqlSession.selectList("membership.getMemberfeeCardInfo",groupNo);		
	}
	
	public List<MembershipVo> getInsertMemberfeeList(Map map) {	
		return sqlSession.selectList("membership.getInsertMemberfeeList",map);		
	}
	
	public List<MembershipVo> checkFeeGroupName(MembershipVo membershipVo) {	
		return sqlSession.selectList("membership.checkFeeGroupName",membershipVo);		
	}
	
	public void insertMemberfeeByRank(Map map) {	
		sqlSession.insert("membership.insertMemberfeeByRank",map);		
	}
	
	public void insertMemberfeeByName(Map map) {	
		sqlSession.insert("membership.insertMemberfeeByName",map);		
	}
	
	public void deleteMemberfee(MembershipVo membershipVo) {	
		sqlSession.delete("membership.deleteMemberfee",membershipVo);		
	}
	
	public void rcvMemberfee(MembershipVo membershipVo) {	
		sqlSession.update("membership.rcvMemberfee",membershipVo);		
	}
	
	public void insertToAccountbook(MembershipVo membershipVo) {	
		sqlSession.insert("membership.insertToAccountbook",membershipVo);		
	}
	
	public void insertNews(NewsVo newsVo) {
		sqlSession.insert("membership.insertNews",newsVo);
	}
	
	//회원 추방시 !
	public void delMember(int user_groupNo){
		sqlSession.delete("membership.delMember",user_groupNo);
	}
}
