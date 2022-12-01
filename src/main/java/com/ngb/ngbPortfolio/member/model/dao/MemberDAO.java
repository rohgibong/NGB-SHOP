package com.ngb.ngbPortfolio.member.model.dao;

import java.util.List;

import com.ngb.ngbPortfolio.member.model.dto.MemberDTO;
import com.ngb.ngbPortfolio.shop.model.dto.CartDTO;

public interface MemberDAO {
	public List<MemberDTO> getSelectAll();
	public MemberDTO getSelectOne(MemberDTO paramDto);
	public int setInsert(MemberDTO paramDto);
	public int getLogin(MemberDTO paramDto);
	public int getIdCheck(MemberDTO paramDto);
	public int getPwCheck(MemberDTO paramDto);
	public int getEmailCheck(MemberDTO paramDto);
	public int getPhoneCheck(MemberDTO paramDto);
	public String searchIdUsePhone(MemberDTO paramDto);
	public String searchIdUseEmail(MemberDTO paramDto);
	public int searchPwUsePhone(MemberDTO paramDto);
	public int searchPwUseEmail(MemberDTO paramDto);
	public int updatePw(MemberDTO paramDto);
	public int setUpdate(MemberDTO paramDto);
	public List<CartDTO> searchCartNo(int imsiCode);
	public int updateCartMemberCode(int imsiCode, int memberCode, int cartNo);
	public int deleteNotUpdate(int cartNo);
	public int setDelete(MemberDTO paramDto);
}
