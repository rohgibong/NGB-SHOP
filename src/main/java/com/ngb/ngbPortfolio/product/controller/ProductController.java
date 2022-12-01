package com.ngb.ngbPortfolio.product.controller;

import java.net.UnknownHostException;
import java.util.List;

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
			HttpServletRequest request
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		List<ProductDTO> list = productDao.getSelectAll();
		List<CategoryDTO> categoryList = categoryDao.getSelectAll();
		
		model.addAttribute("list", list);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
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
