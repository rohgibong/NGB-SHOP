package com.ngb.ngbPortfolio._common;

import java.net.Inet4Address;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Util {
	public String[] getServerInfo(HttpServletRequest request) throws UnknownHostException {
		String path = request.getContextPath();
		String ip = Inet4Address.getLocalHost().getHostAddress();
		String uri = request.getRequestURI().toString();
		
		String[] imsiArray = uri.split("/");
		String folderName = imsiArray[imsiArray.length-2];
		String fileName = imsiArray[imsiArray.length-1];
		
		String[] array = new String[4];
		array[0] = path;
		array[1] = ip;
		array[2] = folderName;
		array[3] = fileName;
		
		return array;
	}
	
	public String[] getSessionCheck(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		int sessionNo = 0;
		String sessionId = "";
		String sessionName = "";
		
		if(session.getAttribute("sessionNo") != null) {
			sessionNo = (Integer)session.getAttribute("sessionNo");
		}
		if(session.getAttribute("sessionId") != null) {
			sessionId = (String)session.getAttribute("sessionId");
		}
		if(session.getAttribute("sessionName") != null) {
			sessionName = (String)session.getAttribute("sessionName");
		}
		
		String[] result = new String[3];
		result[0] = sessionNo + "";
		result[1] = sessionId;
		result[2] = sessionName;
		
		return result;
	}
	
	public String rand() {
		Random ran = new Random();
		String str = "";
		int num = 0;
		while(str.length()!=6) {
			num = ran.nextInt(75)+48;
			if((num>=48 && num<=57) || (num>=65 && num <= 90) || (num>=97 && num<=122)) {
				str += (char)num;
			} else {
				continue;
			}
		}
		return str;
	}
	
	public int getNumberCheck(String str, int defaultStr) {
		int result = 0;
		
		String temp = str;
		if(temp == null || temp.trim().equals("")) {
			temp = "-";
		}
		
		for(int i=0; i<=9; i++) {
			temp = temp.replace(i+"", "");
		}
		
		if(temp.equals("")) {
			result = Integer.parseInt(str);
		} else {
			result = defaultStr;
		}
		
		return result;
	}
	
	public Map<String, Integer> getPagerMap(int pageNumber, int productSize, int pageSize, int totalRecord){
		/* int jj = totalRecord - pageSize * (pageNumber - 1); */
		int startRecord = productSize * (pageNumber - 1) + 1;
		int lastRecord = productSize * pageNumber;
		if(lastRecord > totalRecord) {
			lastRecord = totalRecord;
		}
		int totalPage = 0;
		int startPage = 1;
		int lastPage = 1;
		if(totalRecord > 0) {
			totalPage = totalRecord / productSize + (totalRecord % productSize == 0 ? 0 : 1);
			startPage = (pageNumber / pageSize - (pageNumber % pageSize != 0 ? 0 : 1)) * pageSize + 1;
			lastPage = startPage + pageSize - 1;
			if(lastPage > totalPage) {
				lastPage = totalPage;
			}
		}
		if(totalRecord == 0) {
			totalPage = 1;
		}
		
		Map<String, Integer> map = new HashMap<>();
		/* map.put("jj", jj); */
		map.put("startRecord", startRecord);
		map.put("lastRecord", lastRecord);
		map.put("totalPage", totalPage);
		map.put("startPage", startPage);
		map.put("lastPage", lastPage);
		return map;
	}
	
}
