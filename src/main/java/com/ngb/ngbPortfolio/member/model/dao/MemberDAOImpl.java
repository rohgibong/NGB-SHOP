package com.ngb.ngbPortfolio.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ngb.ngbPortfolio.member.model.dto.MemberDTO;
import com.ngb.ngbPortfolio.shop.model.dto.CartDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<MemberDTO> getSelectAll() {
		return sqlSession.selectList("member.getSelectAll");
	}
	
	@Override
	public MemberDTO getSelectOne(MemberDTO paramDto) {
		return sqlSession.selectOne("member.getSelectOne", paramDto);
	}

	@Override
	public int setInsert(MemberDTO paramDto) {
		return sqlSession.insert("member.setInsert", paramDto);
	}

	@Override
	public int getLogin(MemberDTO paramDto) {
		int result = 0;
		if(sqlSession.selectOne("member.getLogin", paramDto) != null) {
			result = sqlSession.selectOne("member.getLogin", paramDto);
		}
		return result;
	}

	@Override
	public int getIdCheck(MemberDTO paramDto) {
		int result = 0;
		if(sqlSession.selectOne("member.getIdCheck", paramDto) != null) {
			result = sqlSession.selectOne("member.getIdCheck", paramDto);
		}
		return result;
	}
	
	@Override
	public int getPwCheck(MemberDTO paramDto) {
		int result = 0;
		if(sqlSession.selectOne("member.getPwCheck", paramDto) != null) {
			result = sqlSession.selectOne("member.getPwCheck", paramDto);
		}
		return result;
	}
	
	@Override
	public int getEmailCheck(MemberDTO paramDto) {
		int result = 0;
		if(sqlSession.selectOne("member.getEmailCheck", paramDto) != null) {
			result = sqlSession.selectOne("member.getEmailCheck", paramDto);
		}
		return result;
	}
	
	@Override
	public int getPhoneCheck(MemberDTO paramDto) {
		int result = 0;
		if(sqlSession.selectOne("member.getPhoneCheck", paramDto) != null) {
			result = sqlSession.selectOne("member.getPhoneCheck", paramDto);
		}
		return result;
	}

	@Override
	public String searchIdUsePhone(MemberDTO paramDto) {
		String result = "x";
		if(sqlSession.selectOne("member.searchIdUsePhone", paramDto) != null) {
			result = sqlSession.selectOne("member.searchIdUsePhone", paramDto);
		}
		return result;
	}

	@Override
	public String searchIdUseEmail(MemberDTO paramDto) {
		String result = "x";
		if(sqlSession.selectOne("member.searchIdUseEmail", paramDto) != null) {
			result = sqlSession.selectOne("member.searchIdUseEmail", paramDto);
		}
		return result;
	}

	@Override
	public int searchPwUsePhone(MemberDTO paramDto) {
		int result = 0;
		if(sqlSession.selectOne("member.searchPwUsePhone", paramDto) != null) {
			result = sqlSession.selectOne("member.searchPwUsePhone", paramDto);
		}
		return result;
	}

	@Override
	public int searchPwUseEmail(MemberDTO paramDto) {
		int result = 0;
		if(sqlSession.selectOne("member.searchPwUseEmail", paramDto) != null) {
			result = sqlSession.selectOne("member.searchPwUseEmail", paramDto);
		}
		return result;
	}

	@Override
	public int updatePw(MemberDTO paramDto) {
		return sqlSession.update("member.updatePw", paramDto);
	}

	@Override
	public int setUpdate(MemberDTO paramDto) {
		return sqlSession.update("member.setUpdate", paramDto);
	}

	@Override
	public List<CartDTO> searchCartNo(int imsiCode) {
		return sqlSession.selectList("member.searchCartNo", imsiCode);
	}
	@Override
	public int updateCartMemberCode(int imsiCode, int memberCode, int cartNo) {
		Map<String, Integer> columns = new HashMap<>();
		columns.put("imsiCode", imsiCode);
		columns.put("memberCode", memberCode);
		columns.put("cartNo", cartNo);
		return sqlSession.update("member.updateCartMemberCode", columns);
	}

	@Override
	public int deleteNotUpdate(int cartNo) {
		return sqlSession.delete("member.deleteNotUpdate", cartNo);
	}

	@Override
	public int setDelete(MemberDTO paramDto) {
		return sqlSession.delete("member.setDelete", paramDto);
	}

	


}
