package com.ngb.ngbPortfolio.member.controller;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ngb.ngbPortfolio._common.MailService;
import com.ngb.ngbPortfolio._common.MessageService;
import com.ngb.ngbPortfolio._common.Util;
import com.ngb.ngbPortfolio.member.model.dao.MemberDAO;
import com.ngb.ngbPortfolio.member.model.dto.MemberDTO;
import com.ngb.ngbPortfolio.shop.model.dao.ShopProductDAO;
import com.ngb.ngbPortfolio.shop.model.dto.CartDTO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private MessageService messageService;
	
	@Inject
	MemberDAO memberDao;
	
	@Inject
	ShopProductDAO shopProductDao;
	
	@RequestMapping("/list")
	public String list(
			Model model,
			HttpServletRequest request
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		List<MemberDTO> list = memberDao.getSelectAll();
		
		model.addAttribute("list", list);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		return folderName+"/"+fileName;
	}
	
	//로그인---------------------------------------------------------------------------------------------------------------------
	@RequestMapping("/login")
	public String login(
			Model model,
			HttpServletRequest request
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		String referer = request.getHeader("Referer");
		
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		model.addAttribute("referer", referer);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/loginProc")
	public String loginProc(
			Model model,
			HttpSession session,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto,
			String referer
			) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String refererGubun[] = referer.split("ngbPortfolio");
		
		int result = memberDao.getLogin(arguDto);
		
		if(result > 0) {
			String ipArray[] = ip.split("[.]");
			String imsiCode2 = ipArray[0]+ipArray[1]+ipArray[2];
			int imsiCode = Integer.parseInt(imsiCode2);
			
			List<CartDTO> searchCartList = memberDao.searchCartNo(imsiCode);
			if(searchCartList.size() > 0) {
				for(int i=0; i<searchCartList.size(); i++) {
					CartDTO cartDto = searchCartList.get(i);
					int cartNo = cartDto.getCartNo();
					cartDto.setMemberCode(result);
					int imsiResult = shopProductDao.updateAmount(cartDto);
					if(!(imsiResult > 0)) {
						memberDao.updateCartMemberCode(imsiCode, result, cartNo);
					} else {
						memberDao.deleteNotUpdate(cartNo);
					}
				}
			}
			arguDto.setMemberCode(result);
			MemberDTO returnDto = memberDao.getSelectOne(arguDto);
			session.setAttribute("sessionNo", result);
			session.setAttribute("sessionId", returnDto.getId());
			session.setAttribute("sessionName", returnDto.getName());
			if(refererGubun[1].substring(1).equals("member/login") || refererGubun[1].substring(1).equals("member/loginProc")
				|| refererGubun[1].substring(1).equals("member/checkPw") || refererGubun[1].substring(1).equals("member/memberJoinProc")
				|| refererGubun[1].substring(1).equals("member/searchIdPw") || refererGubun[1].substring(1).equals("member/searchId")
				|| refererGubun[1].substring(1).equals("member/searchPw")
				|| refererGubun[1].substring(1).equals("member/searchIdUsePhone") || refererGubun[1].substring(1).equals("member/searchIdUseEmail")
				|| refererGubun[1].substring(1).equals("member/pwChangeProc")) {
				return "redirect:/";
			} else {
				return "redirect:/"+refererGubun[1].substring(1);
			}
		} else {
			request.setAttribute("path", path);
			request.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			request.setAttribute("url", "/member/login");
			return "alert";
		}
		
	}
	
	@RequestMapping("/logout")
	public String logout(
			Model model,
			HttpSession session,
			HttpServletRequest request
			) {
		String referer = request.getHeader("Referer");
		String refererGubun[] = referer.split("ngbPortfolio");
		session.invalidate();
		return "redirect:/"+refererGubun[1].substring(1);
		
	}
	//로그인---------------------------------------------------------------------------------------------------------------------
	
	//아이디&비밀번호 찾기----------------------------------------------------------------------------------------------------------
	@RequestMapping("/searchIdPw")
	public String searchIdPw(
			Model model,
			HttpServletRequest request
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/searchId")
	public String searchId(
			Model model,
			HttpServletRequest request
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/searchIdUsePhone")
	public String searchIdUsePhone(
			Model model,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
		) throws IOException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		request.setAttribute("path", path);
		String result = memberDao.searchIdUsePhone(arguDto);
		
		if(result.equals("x")) {
			request.setAttribute("msg", "일치하는 회원정보가 없습니다.");
			request.setAttribute("url", "/member/searchId");
			return "alert";
		} else {
			request.setAttribute("msg", "회원님의 아이디는 ["+result+"]입니다.");
			request.setAttribute("url", "/member/login");
			return "alert";
		}
	}
	
	@RequestMapping("/searchIdUseEmail")
	public String searchIdUseEmail(
			Model model,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
		) throws IOException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		request.setAttribute("path", path);
		String result = memberDao.searchIdUseEmail(arguDto);
		
		if(result.equals("x")) {
			request.setAttribute("msg", "일치하는 회원정보가 없습니다.");
			request.setAttribute("url", "/member/searchId");
			return "alert";
		} else {
			request.setAttribute("msg", "회원님의 아이디는 ["+result+"]입니다.");
			request.setAttribute("url", "/member/login");
			return "alert";
		}
	}
	
	@RequestMapping("/searchPw")
	public String searchPw(
			Model model,
			HttpServletRequest request
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/searchPwUsePhone")
	public String searchPwUsePhone(
			Model model,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
		) throws IOException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		request.setAttribute("path", path);
		int result = memberDao.searchPwUsePhone(arguDto);
		
		if(result > 0) {
			request.setAttribute("id", arguDto.getId());
			request.setAttribute("memberCode", result);
			request.setAttribute("msg", "비밀번호는 분실 시 찾아드릴 수 없는 정보입니다.\\n비밀번호를 다시 설정해주세요.");
			return "member/pwChange";
		} else {
			request.setAttribute("msg", "일치하는 회원정보가 없습니다.");
			request.setAttribute("url", "/member/searchPw");
			return "alert";
		}
	}
	
	@RequestMapping("/searchPwUseEmail")
	public String searchPwUseEmail(
			Model model,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
		) throws IOException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		request.setAttribute("path", path);
		int result = memberDao.searchPwUseEmail(arguDto);
		
		if(result > 0) {
			request.setAttribute("id", arguDto.getId());
			request.setAttribute("memberCode", result);
			request.setAttribute("msg", "비밀번호는 분실 시 찾아드릴 수 없는 정보입니다.\\n비밀번호를 다시 설정해주세요.");
			return "member/pwChange";
		} else {
			request.setAttribute("msg", "일치하는 회원정보가 없습니다.");
			request.setAttribute("url", "/member/searchPw");
			return "alert";
		}
	}
	
	@RequestMapping("/pwChange")
	public String pwChange(
			Model model,
			HttpServletRequest request,
			int memberCode,
			String id
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		model.addAttribute("memberCode", memberCode);
		model.addAttribute("id", id);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/pwChangeProc")
	public String pwChangeProc(
			Model model,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
		) throws IOException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String[] sessionArray = util.getSessionCheck(request);
		int sessionNo = Integer.parseInt(sessionArray[0]);
		
		request.setAttribute("path", path);
		
		MemberDTO imsiDto = memberDao.getSelectOne(arguDto);
		
		if(imsiDto.getPasswd().equals(arguDto.getPasswd())) {
			request.setAttribute("memberCode", arguDto.getMemberCode());
			request.setAttribute("id", arguDto.getId());
			request.setAttribute("msg", "이전 비밀번호와 다른 비밀번호로 변경해주세요.");
			return "member/pwChange";
		}
		
		int result = memberDao.updatePw(arguDto);
		
		if(result > 0) {
			if(sessionNo > 0) {
				request.setAttribute("msg", "비밀변호 변경이 완료되었습니다.");
				request.setAttribute("url", "/");
				return "alert";
			} else {
				request.setAttribute("msg", "비밀번호를 변경하셨습니다.\\n변경 된 비밀번호로 다시 로그인해주세요.");
				request.setAttribute("url", "/member/login");
				return "alert";
			}
		} else {
			request.setAttribute("memberCode", arguDto.getMemberCode());
			request.setAttribute("id", arguDto.getId());
			request.setAttribute("msg", "비밀번호 변경 중 오류가 발생했습니다.");
			return "member/pwChange";
		}
	}
	
	//아이디&비밀번호 찾기----------------------------------------------------------------------------------------------------------
	
	//회원가입--------------------------------------------------------------------------------------------------------------------
	@RequestMapping("/memberJoinForm")
	public String memberJoinForm(
			Model model,
			HttpServletRequest request
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/idCheck")
	@ResponseBody
	public String idCheck(
			@ModelAttribute MemberDTO arguDto
		) {
		int result = memberDao.getIdCheck(arguDto);
		
		return result + "";
	}
	
	@RequestMapping("/emailCheck")
	@ResponseBody
	public String emailCheck(
			@ModelAttribute MemberDTO arguDto
			) {
		int result = memberDao.getEmailCheck(arguDto);
		
		return result + "";
	}
	
	@RequestMapping("/phoneCheck")
	@ResponseBody
	public String phoneCheck(
			@ModelAttribute MemberDTO arguDto
			) {
		int result = memberDao.getPhoneCheck(arguDto);
		
		return result + "";
	}
	
	@RequestMapping("/noticeMail")
	@ResponseBody
	public String noticeMail(String email1, String email2) throws Exception {
		Util util = new Util();
		String randomCode = util.rand();
		String addr = "rohgibong@gmail.com";
		String subject = "["+randomCode+"] NGB SHOP 인증번호입니다.";
		String body = "안녕하세요.<br>"
				+"NGB SHOP 회원가입을 위한 인증번호입니다.<br>"
				+"<h1>["+randomCode+"]</h1>"
				+"위 인증코드를 입력하여 이메일 인증을 완료해주세요.";
		String email = email1 +"@" + email2;
		mailService.sendEmail(email, addr, subject, body);
		
		return randomCode;
	}
	
	@RequestMapping("/noticeMessage")
	@ResponseBody
	public String noticeMessage(String phone1, String phone2, String phone3) throws Exception {
		Util util = new Util();
		String randomCode = util.rand();
		String toNumber = phone1 + phone2 + phone3;
		messageService.sendMessage(toNumber, randomCode); //실제 전화번호로 보내져서 개발 중 닫음
		
		return randomCode;
	}
	
	@RequestMapping("/memberJoinProc")
	public String memberJoinProc(
			Model model,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
			) throws IOException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		request.setAttribute("path", path);
		
		int result = memberDao.setInsert(arguDto);
		if (result > 0) {
			request.setAttribute("msg", "회원가입을 환영합니다.");
			request.setAttribute("url", "/member/login");
			return "alert";
		} else {
			request.setAttribute("msg", "회원가입중 오류가 발생했습니다");
			request.setAttribute("url", "/member/memberJoinForm");
			return "alert";
		}
	}
	
	//회원가입--------------------------------------------------------------------------------------------------------------------
	
	//회원정보수정-----------------------------------------------------------------------------------------------------------------
	@RequestMapping("/checkPw")
	public String checkPw(
			Model model,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		MemberDTO returnDto = memberDao.getSelectOne(arguDto);
		
		model.addAttribute("dto", returnDto);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		model.addAttribute("folderName", folderName);
		model.addAttribute("fileName", fileName);
		return "_home/index";
	}
	
	@RequestMapping("/pwCheck")
	@ResponseBody
	public String pwCheck(
			Model model,
			@ModelAttribute MemberDTO arguDto
		) {
		int result = memberDao.getPwCheck(arguDto);
		
		return result + "";
	}
	
	@RequestMapping("/changeUserInfo")
	public String changeUserInfo(
			Model model,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		MemberDTO returnDto = memberDao.getSelectOne(arguDto);
		
		model.addAttribute("dto", returnDto);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		model.addAttribute("folderName", folderName);
		model.addAttribute("fileName", fileName);
		return "_home/index";
	}
	
	@RequestMapping("/pwChangeWin")
	public String pwChangeWin(
			Model model,
			HttpServletRequest request,
			int memberCode,
			String id
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		model.addAttribute("memberCode", memberCode);
		model.addAttribute("id", id);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/pwChangeProcWin")
	public String pwChangeProcWin(
			Model model,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
		) throws IOException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		request.setAttribute("path", path);
		
		MemberDTO imsiDto = memberDao.getSelectOne(arguDto);
		
		if(imsiDto.getPasswd().equals(arguDto.getPasswd())) {
			request.setAttribute("memberCode", arguDto.getMemberCode());
			request.setAttribute("id", arguDto.getId());
			request.setAttribute("msg", "이전 비밀번호와 다른 비밀번호로 변경해주세요.");
			return "member/pwChangeWin";
		}
		
		int result = memberDao.updatePw(arguDto);
		
		if(result > 0) {
			request.setAttribute("msg", "비밀변호 변경이 완료되었습니다.");
			return "alertClose";
		} else {
			request.setAttribute("memberCode", arguDto.getMemberCode());
			request.setAttribute("id", arguDto.getId());
			request.setAttribute("msg", "비밀번호 변경 중 오류가 발생했습니다.");
			return "member/pwChangeWin";
		}
	}
	
	@RequestMapping("/sujungProc")
	public String sujungProc(
			Model model,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
		) throws IOException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		request.setAttribute("path", path);
		int result = memberDao.setUpdate(arguDto);
		
		if(result > 0) {
			request.setAttribute("msg", "회원정보가 수정되었습니다.");
			request.setAttribute("url", "/");
			return "alert";
		} else {
			request.setAttribute("msg", "회원정보 수정 중 오류가 발생했습니다.");
			request.setAttribute("url", "/");
			return "alert";
		}
	}
	
	@RequestMapping("/sakjeProc")
	public String sakjeProc(
			Model model,
			HttpSession session,
			HttpServletRequest request,
			@ModelAttribute MemberDTO arguDto
			) throws IOException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		int memberCode = arguDto.getMemberCode();
		
		request.setAttribute("path", path);
		
		shopProductDao.sakjeMemberCart(memberCode);
		int result = memberDao.setDelete(arguDto);
		
		if(result > 0) {
			session.invalidate();
			request.setAttribute("msg", "회원탈퇴가 완료되었습니다.\\n이용해주셔서 감사합니다.");
			request.setAttribute("url", "/");
			return "alert";
		} else {
			request.setAttribute("msg", "회원탈퇴 중 오류가 발생했습니다.");
			request.setAttribute("url", "/");
			return "alert";
		}
	}
	
	
	
	
	//회원정보수정-----------------------------------------------------------------------------------------------------------------
	
	
	//잘못된 접근입니다 경고창-------------------------------------------------------------------------------------------------------
	@RequestMapping("/warning")
	public String warning(
			Model model,
			HttpServletRequest request
			) throws IOException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		request.setAttribute("path", path);
		request.setAttribute("msg", "잘못된 접근방식입니다.");
		request.setAttribute("url", "/");
		return "alert";
	}
	
	
	
	
	//잘못된 접근입니다 경고창-------------------------------------------------------------------------------------------------------
		
}
