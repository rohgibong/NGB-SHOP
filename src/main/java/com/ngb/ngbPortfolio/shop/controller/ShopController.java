package com.ngb.ngbPortfolio.shop.controller;

import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ngb.ngbPortfolio._common.Util;
import com.ngb.ngbPortfolio.category.model.dao.CategoryDAO;
import com.ngb.ngbPortfolio.member.model.dao.MemberDAO;
import com.ngb.ngbPortfolio.member.model.dto.MemberDTO;
import com.ngb.ngbPortfolio.product.model.dto.ProductDTO;
import com.ngb.ngbPortfolio.shop.model.dao.ShopProductDAO;
import com.ngb.ngbPortfolio.shop.model.dto.CartDTO;

@Controller
@RequestMapping("/shop")
public class ShopController {
	@Inject
	ShopProductDAO shopProductDao;
	@Inject
	CategoryDAO categoryDao;
	@Inject
	MemberDAO memberDao;
	
	@RequestMapping("/list")
	public String list(
			Model model,
			HttpServletRequest request,
			@ModelAttribute ProductDTO arguDto,
			String pageNumber
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		int pageNumber2 = util.getNumberCheck(pageNumber, 1);
		model.addAttribute("pageNumber", pageNumber2);
		
		int productCounter = 0;
		
		String title = "";
		String title2 = "";
		String title3 = "";
		String title4 = "";
		
		int productSize = 20; // 한 페이지에 20개
		int pageSize = 10; // 10페이지 까지
		
		
		if(!(arguDto.getCategoryCode() > 0)) {
			int checkSearchGubun = util.getNumberCheck(arguDto.getSearchGubun(), 17);
			if(checkSearchGubun > 16) {
				int totalRecord = shopProductDao.getTotalRecordVendor(arguDto);
				model.addAttribute("totalRecord", totalRecord);
				Map<String, Integer> map = util.getPagerMap(pageNumber2, productSize, pageSize, totalRecord);
				map.put("pageSize", pageSize);
				model.addAttribute("map", map);
				arguDto.setStartRecord(map.get("startRecord"));
				arguDto.setLastRecord(map.get("lastRecord"));
				List<ProductDTO> list = shopProductDao.getSearchVendorName(arguDto);
				productCounter = list.size();
				title = arguDto.getVendorName();
				title4 = "브랜드샵에서 같은 브랜드 상품을 모아볼 수 있어요!";
				model.addAttribute("list", list);
				model.addAttribute("categoryCode", 0);
			} else {
				int totalRecord = shopProductDao.getTotalRecordSearch(arguDto);
				model.addAttribute("totalRecord", totalRecord);
				Map<String, Integer> map = util.getPagerMap(pageNumber2, productSize, pageSize, totalRecord);
				map.put("pageSize", pageSize);
				model.addAttribute("map", map);
				int searchGubun = Integer.parseInt(arguDto.getSearchGubun());
				String searchData = arguDto.getSearchData();
				arguDto.setCategoryCode(searchGubun);
				arguDto.setStartRecord(map.get("startRecord"));
				arguDto.setLastRecord(map.get("lastRecord"));
				List<ProductDTO> list = shopProductDao.getSelectAllSearch(arguDto);
				productCounter = list.size();
				title2 = "\""+ searchData + "\"";
				title3 = "(으)로 검색된 목록";
				model.addAttribute("list", list);
				model.addAttribute("searchGubun", searchGubun);
				model.addAttribute("searchData", searchData);
				model.addAttribute("categoryCode", 0);
			}
		} else {
			if(arguDto.getCategoryCode() > 16) {
				request.setAttribute("path", path);
				request.setAttribute("msg", "잘못된 접근방식입니다.");
				request.setAttribute("url", "/");
				return "alert";
			}
			int totalRecord = shopProductDao.getTotalRecordAll(arguDto);
			model.addAttribute("totalRecord", totalRecord);
			Map<String, Integer> map = util.getPagerMap(pageNumber2, productSize, pageSize, totalRecord);
			map.put("pageSize", pageSize);
			model.addAttribute("map", map);
			arguDto.setStartRecord(map.get("startRecord"));
			arguDto.setLastRecord(map.get("lastRecord"));
			List<ProductDTO> list = shopProductDao.getSelectAllCate(arguDto);
			productCounter = list.size();
			
			int categoryCode = arguDto.getCategoryCode();
			
			if(categoryCode == 1) {
				title = "패션의류/잡화";
			} else if(categoryCode == 2) {
				title = "뷰티";
			} else if(categoryCode == 3) {
				title = "출산/유아동";
			} else if(categoryCode == 4) {
				title = "식품";
			} else if(categoryCode == 5) {
				title = "주방용품";
			} else if(categoryCode == 6) {
				title = "생활용품";
			} else if(categoryCode == 7) {
				title = "홈인테리어";
			} else if(categoryCode == 8) {
				title = "가전/디지털";
			} else if(categoryCode == 9) {
				title = "스포츠/레저";
			} else if(categoryCode == 10) {
				title = "자동차용품";
			} else if(categoryCode == 11) {
				title = "도서/음반/DVD";
			} else if(categoryCode == 12) {
				title = "완구/취미";
			} else if(categoryCode == 13) {
				title = "문구/오피스";
			} else if(categoryCode == 14) {
				title = "반려동물용품";
			} else if(categoryCode == 15) {
				title = "헬스/건강식품";
			}
			model.addAttribute("list", list);
			model.addAttribute("categoryCode", categoryCode);
		}
		int cellCounter = 4;
		
		int imsiMok = productCounter / cellCounter;
		int imsiNa = productCounter % cellCounter;
		
		int rowCounter = 0;
		if (imsiNa > 0){
			rowCounter = imsiMok + 1;
		} else{
			rowCounter = imsiMok;
		}
		
		model.addAttribute("title", title);
		model.addAttribute("title2", title2);
		model.addAttribute("title3", title3);
		model.addAttribute("title4", title4);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		model.addAttribute("folderName", folderName);
		model.addAttribute("fileName", fileName);
		model.addAttribute("cellCounter", cellCounter);
		model.addAttribute("rowCounter", rowCounter);
		model.addAttribute("productCounter", productCounter);
		return "_home/index";
	}
	
	@RequestMapping("/view")
	public String view(
			Model model,
			HttpServletRequest request,
			@ModelAttribute ProductDTO arguDto
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		ProductDTO returnDto = shopProductDao.getSelectOne(arguDto);
		
		model.addAttribute("dto", returnDto);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		model.addAttribute("folderName", folderName);
		model.addAttribute("fileName", fileName);
		return "_home/index";
	}
	
	@RequestMapping("/cartChugaProc")
	@ResponseBody
	public String cartChugaProc(
			@ModelAttribute CartDTO arguDto,
			String no
		) {
		int memberCode = Integer.parseInt(no);
		arguDto.setMemberCode(memberCode);
		
		int searchResult = shopProductDao.searchCart(arguDto);
		
		int result = 0;
		
		if(searchResult > 0) {
			result = shopProductDao.updateAmount(arguDto);
		} else {
			String buyOX = "X";
			arguDto.setBuyOX(buyOX);
			result = shopProductDao.setCartChuga(arguDto);
		}
		
		return result + "";
	}
	
	@RequestMapping("/searchCart")
	@ResponseBody
	public String searchCart(
			@ModelAttribute CartDTO arguDto,
			String no
			) {
		int memberCode = Integer.parseInt(no);
		arguDto.setMemberCode(memberCode);
		
		int result = shopProductDao.searchCart(arguDto);
		
		return result + "";
	}
	
	@RequestMapping("/cartList")
	public String cartList(
			Model model,
			HttpServletRequest request,
			@ModelAttribute CartDTO arguDto
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		String[] sessionArray = util.getSessionCheck(request);
		int sessionNo = Integer.parseInt(sessionArray[0]);
		
		if(!(sessionNo > 0)) {
			String ipArray[] = ip.split("[.]");
			String imsiCode2 = ipArray[0]+ipArray[1]+ipArray[2];
			int imsiCode = Integer.parseInt(imsiCode2);
			arguDto.setMemberCode(imsiCode);
		} else {
			arguDto.setMemberCode(sessionNo);
		}
		
		List<CartDTO> cartList = shopProductDao.getSelectAllCart(arguDto);
		List<ProductDTO> productList = shopProductDao.getSelectAll();
		
		model.addAttribute("cartList", cartList);
		model.addAttribute("productList", productList);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/sujungAmount")
	@ResponseBody
	public String sujungAmount(
			@ModelAttribute CartDTO arguDto
		) {
		int result = shopProductDao.sujungAmount(arguDto);
		
		return result + "";
	}
	
	@RequestMapping("/sakjeCartOne")
	@ResponseBody
	public String sakjeCartOne(
			@ModelAttribute CartDTO arguDto
		) {
		int result = shopProductDao.sakjeCartOne(arguDto);
		
		return result + "";
	}
	
	@RequestMapping("/sakjeCartChecked")
	@ResponseBody
	public String sakjeCartChecked(
			String chk_items
		) {
		int result = 0;
		String cartNoArray[] = chk_items.split(",");
		for(int i=0; i<cartNoArray.length; i++) {
			result = shopProductDao.sakjeCartChecked(cartNoArray[i]);
		}
		
		return result + "";
	}
	
	@RequestMapping("/sakjeSoldOut")
	@ResponseBody
	public String sakjeSoldOut(
			String chk_items
		) {
		int result = 0;
		String cartNoArray[] = chk_items.split(",");
		for(int i=0; i<cartNoArray.length; i++) {
			result = shopProductDao.sakjeCartChecked(cartNoArray[i]);
		}
		return result + "";
	}
	
	@RequestMapping("/gumaePage")
	public String gumaePage(
			Model model,
			HttpServletRequest request,
			String checkedItem,
			String checkAmount
			) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		List<CartDTO> gumaeList = new ArrayList<>();
		String item[] = checkedItem.split(",");
		
		for(int i=0; i<item.length; i++) {
			int cartNo = Integer.parseInt(item[i]);
			CartDTO dto = new CartDTO();
			dto.setCartNo(cartNo);
			CartDTO returnDto = shopProductDao.getSelectOneCart(dto);
			if(!(checkAmount == "" || checkAmount.equals("0"))) {
				int amount = Integer.parseInt(checkAmount);
				returnDto.setProductAmount(amount);
			}
			gumaeList.add(returnDto);
		}
		
		List<ProductDTO> productList = shopProductDao.getSelectAll();
		List<MemberDTO> memberList = memberDao.getSelectAll();
		
		model.addAttribute("checkedItem", checkedItem);
		model.addAttribute("productList", productList);
		model.addAttribute("gumaeList", gumaeList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/gumaeProc")
	public String gumaeProc(
		HttpServletRequest request,
		String checkedProduct,
		@ModelAttribute CartDTO arguDto
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		String item[] = checkedProduct.split(",");
		for(int i=0; i<item.length; i++) {
			int cartNo = Integer.parseInt(item[i]);
			CartDTO dto = new CartDTO();
			dto.setCartNo(cartNo);
			shopProductDao.updateBuy(dto);
		}
		request.setAttribute("path", path);
		request.setAttribute("msg", "상품 주문이 완료되었습니다.");
		request.setAttribute("url", "/");
		return "alert";
	}
	
	@RequestMapping("/boughtProduct")
	public String boughtProduct(
			Model model,
			HttpServletRequest request,
			@ModelAttribute CartDTO arguDto
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		List<CartDTO> boughtList = shopProductDao.getSelectAllBought(arguDto);
		List<ProductDTO> productList = shopProductDao.getSelectAll();
		
		model.addAttribute("boughtList", boughtList);
		model.addAttribute("listSize", boughtList.size());
		model.addAttribute("productList", productList);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		model.addAttribute("folderName", folderName);
		model.addAttribute("fileName", fileName);
		return "_home/index";
	}
	
	@RequestMapping("/cancelBought")
	@ResponseBody
	public String cancelBought(
			@ModelAttribute CartDTO arguDto
			) {
		int searchResult = shopProductDao.searchCart(arguDto);
		int result = 0;
		
		if(searchResult > 0) {
			result = shopProductDao.updateAmount(arguDto);
		} else {
			String buyOX = "X";
			arguDto.setBuyOX(buyOX);
			result = shopProductDao.setCartChuga(arguDto);
		}
		shopProductDao.sakjeCartOne2(arguDto);
		
		return result + "";
	}
	
	
}
