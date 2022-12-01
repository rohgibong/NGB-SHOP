package com.ngb.ngbPortfolio.category.controller;

import java.net.UnknownHostException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ngb.ngbPortfolio._common.MultipartUpload;
import com.ngb.ngbPortfolio._common.Util;
import com.ngb.ngbPortfolio.category.model.dao.CategoryDAO;
import com.ngb.ngbPortfolio.category.model.dto.CategoryDTO;

@Controller
@RequestMapping("/category")
public class CategoryController {
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
		
		List<CategoryDTO> list = categoryDao.getSelectAll();
		
		model.addAttribute("list", list);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/view")
	public String view(
			Model model,
			HttpServletRequest request,
			@ModelAttribute CategoryDTO arguDto
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = serverInfo[2];
		String fileName = serverInfo[3];
		
		CategoryDTO returnDto = categoryDao.getSelectOne(arguDto);
		
		model.addAttribute("dto", returnDto);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		return folderName+"/"+fileName;
	}
	
	@RequestMapping("/chugaProc")
	@ResponseBody
	public String chugaProc(
			@ModelAttribute CategoryDTO arguDto
		) {
		
		int result = categoryDao.setInsert(arguDto);
		
		return result + "";
	}
	
	@RequestMapping("/sujungProc")
	@ResponseBody
	public String sujungProc(
			@ModelAttribute CategoryDTO arguDto
			) {
		int result = categoryDao.setUpdate(arguDto);
		
		return result + "";
	}
	
	@RequestMapping("/sakjeProc")
	@ResponseBody
	public String sakjeProc(
			@ModelAttribute CategoryDTO arguDto
		) {
		int result = categoryDao.setDelete(arguDto);
		
		return result + "";
	}
	
}
