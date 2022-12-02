package com.ngb.ngbPortfolio.product.controller;

import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ngb.ngbPortfolio._common.MultipartUpload;
import com.ngb.ngbPortfolio._common.Util;
import com.ngb.ngbPortfolio.category.model.dao.CategoryDAO;
import com.ngb.ngbPortfolio.category.model.dto.CategoryDTO;
import com.ngb.ngbPortfolio.product.model.dao.ProductDAO;
import com.ngb.ngbPortfolio.product.model.dto.ProductDTO;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Inject
	ProductDAO productDao;
	@Inject
	CategoryDAO categoryDao;
	
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
		int productSize = 30;
		int pageSize = 10;
		int checkSearchGubun = util.getNumberCheck(arguDto.getSearchGubun(), 17);
		
		if(checkSearchGubun > 16) {
			int totalRecord = productDao.getTotalRecord();
			model.addAttribute("totalRecord", totalRecord);
			Map<String, Integer> map = util.getPagerMap(pageNumber2, productSize, pageSize, totalRecord);
			map.put("pageSize", pageSize);
			model.addAttribute("map", map);
			arguDto.setStartRecord(map.get("startRecord"));
			arguDto.setLastRecord(map.get("lastRecord"));
			List<ProductDTO> list = productDao.getSelectAllPage(arguDto);
			productCounter = list.size();
			model.addAttribute("list", list);
			model.addAttribute("searchGubun", checkSearchGubun);
		} else {
			arguDto.setCategoryCode(checkSearchGubun);
			int totalRecord = productDao.getTotalRecordSearch(arguDto);
			model.addAttribute("totalRecord", totalRecord);
			Map<String, Integer> map = util.getPagerMap(pageNumber2, productSize, pageSize, totalRecord);
			map.put("pageSize", pageSize);
			model.addAttribute("map", map);
			String searchData = arguDto.getSearchData();
			arguDto.setStartRecord(map.get("startRecord"));
			arguDto.setLastRecord(map.get("lastRecord"));
			List<ProductDTO> list = productDao.getSelectAllSearch(arguDto);
			productCounter = list.size();
			model.addAttribute("list", list);
			model.addAttribute("searchGubun", checkSearchGubun);
			model.addAttribute("searchData", searchData);
		}
		
		
		
		
		List<CategoryDTO> categoryList = categoryDao.getSelectAll();
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		model.addAttribute("productCounter", productCounter);
		return folderName+"/"+fileName;
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
		
		ProductDTO returnDto = productDao.getSelectOne(arguDto);
		List<CategoryDTO> categoryList = categoryDao.getSelectAll();
		
		model.addAttribute("dto", returnDto);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/chuga")
	public String chuga(
			Model model,
			HttpServletRequest request
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		List<CategoryDTO> categoryList = categoryDao.getSelectAll();
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/chugaProc")
	public String chugaProc(
			Model model,
			HttpServletRequest request,
			@ModelAttribute ProductDTO arguDto,
			@RequestParam("file") List<MultipartFile> multiFileList
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		MultipartUpload mu = new MultipartUpload();
		List<String> list = mu.attachProc(multiFileList, "/ngbPortfolio/product");
		
		String attachInfo = "";
		for(int i=0; i<list.size(); i++) {
			attachInfo += "|" + list.get(i);
		}
		attachInfo = attachInfo.substring(1);
		arguDto.setAttachInfo(attachInfo);
		
		int result = productDao.setInsert(arguDto);
		
		if(result > 0) {
			request.setAttribute("path", path);
			request.setAttribute("msg", "등록 성공");
			request.setAttribute("url", "/product/list");
			return "alert";
		} else {
			request.setAttribute("path", path);
			request.setAttribute("msg", "등록 실패");
			request.setAttribute("url", "/product/chuga");
			return "alert";
		}
	}
	
	@RequestMapping("/sujung")
	public String sujung(
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
		
		ProductDTO returnDto = productDao.getSelectOne(arguDto);
		List<CategoryDTO> categoryList = categoryDao.getSelectAll();
		
		model.addAttribute("dto", returnDto);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/sujungProc")
	public String sujungProc(
			Model model,
			HttpServletRequest request,
			@ModelAttribute ProductDTO arguDto,
			String imsiAttach
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		String attachInfo = imsiAttach;
		arguDto.setAttachInfo(attachInfo);
		
		int result = productDao.setUpdate(arguDto);
		if(result > 0) {
			request.setAttribute("path", path);
			request.setAttribute("msg", "수정 성공");
			request.setAttribute("url", "/product/list");
			return "alert";
		} else {
			request.setAttribute("path", path);
			request.setAttribute("msg", "수정 실패");
			request.setAttribute("url", "/product/sujung?productCode="+arguDto.getProductCode());
			return "alert";
		}
	}
	
	@RequestMapping("/sujungProcAttach")
	public String sujungProcAttach(
			Model model,
			HttpServletRequest request,
			String imsiAttach,
			@ModelAttribute ProductDTO arguDto,
			@RequestParam("file") List<MultipartFile> multiFileList
			) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		String[] imsiArray = imsiAttach.split(",");
		MultipartUpload mu = new MultipartUpload();
		mu.fileCheck("/ngbPortfolio/product", imsiArray[1]);
		List<String> list = mu.attachProc(multiFileList, "/ngbPortfolio/product");
		
		String attachInfo = "";
		for(int i=0; i<list.size(); i++) {
			attachInfo += "|" + list.get(i);
		}
		attachInfo = attachInfo.substring(1);
		arguDto.setAttachInfo(attachInfo);
		
		int result = productDao.setUpdate(arguDto);
		if(result > 0) {
			request.setAttribute("path", path);
			request.setAttribute("msg", "수정 성공");
			request.setAttribute("url", "/product/list");
			return "alert";
		} else {
			request.setAttribute("path", path);
			request.setAttribute("msg", "수정 실패");
			request.setAttribute("url", "/product/sujung?productCode="+arguDto.getProductCode());
			return "alert";
		}
	}
	
	@RequestMapping("/sakjeProc")
	public String sakjeProc(
			Model model,
			HttpServletRequest request,
			@ModelAttribute ProductDTO arguDto
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		
		int result = productDao.setDelete(arguDto);
		if(result > 0) {
			request.setAttribute("path", path);
			request.setAttribute("msg", "삭제 성공");
			request.setAttribute("url", "/product/list");
			return "alert";
		} else {
			request.setAttribute("path", path);
			request.setAttribute("msg", "삭제 실패");
			request.setAttribute("url", "/product/list");
			return "alert";
		}
	}
	
	
}
