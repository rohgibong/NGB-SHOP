package com.ngb.ngbPortfolio._index;

import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ngb.ngbPortfolio._common.Util;
import com.ngb.ngbPortfolio.product.model.dto.ProductDTO;
import com.ngb.ngbPortfolio.shop.model.dao.ShopProductDAO;

@Controller
public class IndexController {
	@Inject
	ShopProductDAO shopProductDao;
	
	@RequestMapping("/")
	public String index(
			Model model,
			HttpServletRequest request,
			@ModelAttribute ProductDTO arguDto,
			String pageNumber,
			String categoryCode
		) throws UnknownHostException {
		Util util = new Util();
		String[] serverInfo = util.getServerInfo(request);
		String path = serverInfo[0];
		String ip = serverInfo[1];
		String folderName = "_home";
		String fileName = "main";
		
		/* int randomCode = (int)(Math.random()*15)+1; */
		int randomCode = (int)(Math.random()*8)+1;
		int code = util.getNumberCheck(categoryCode, randomCode);
		arguDto.setCategoryCode(code);
		model.addAttribute("categoryCode", code);
		System.out.println("code : " + code);
		
		int pageNumber2 = util.getNumberCheck(pageNumber, 1);
		model.addAttribute("pageNumber", pageNumber2);
		
		int productSize = 20;
		int pageSize = 10;
		
		int totalRecord = shopProductDao.getTotalRecordAll(arguDto);
		model.addAttribute("totalRecord", totalRecord);
		Map<String, Integer> map = util.getPagerMap(pageNumber2, productSize, pageSize, totalRecord);
		map.put("pageSize", pageSize);
		model.addAttribute("map", map);
		arguDto.setStartRecord(map.get("startRecord"));
		arguDto.setLastRecord(map.get("lastRecord"));
		List<ProductDTO> list = shopProductDao.getSelectAllCate(arguDto);
		int productCounter = list.size();
		
		int cellCounter = 4;
		
		int imsiMok = productCounter / cellCounter;
		int imsiNa = productCounter % cellCounter;
		
		int rowCounter = 0;
		if (imsiNa > 0){
			rowCounter = imsiMok + 1;
		} else{
			rowCounter = imsiMok;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("path", path);
		model.addAttribute("ip", ip);
		model.addAttribute("folderName", folderName);
		model.addAttribute("fileName", fileName);
		model.addAttribute("cellCounter", cellCounter);
		model.addAttribute("rowCounter", rowCounter);
		model.addAttribute("productCounter", productCounter);
		return "_home/index";
	}
}
