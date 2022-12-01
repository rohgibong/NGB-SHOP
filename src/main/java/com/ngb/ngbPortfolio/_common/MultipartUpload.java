package com.ngb.ngbPortfolio._common;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;


public class MultipartUpload {
	String attachPath = Constants.ATTACH_PATH;
	int maxupload = Constants.MAX_UPLOAD;

	private int createDirectory(String uploadPath) {
		java.io.File isDir = new java.io.File(uploadPath);
		if(!isDir.isDirectory()) {
			isDir.mkdirs();
		}
		
		int result = 0;
		if(isDir.exists()) {
			result++;
		}
		
		return result;
	}
	
	private String attachFileReName(String originalFileName, byte[] fileData, String uploadPath) {
		String ext = originalFileName.substring(originalFileName.lastIndexOf('.')).toLowerCase();
		
		UUID uuid = UUID.randomUUID();
		
		String newFileName = uuid.toString() + ext;
		java.io.File f1 = new java.io.File(uploadPath, newFileName);
		
		try {
			FileCopyUtils.copy(fileData, f1);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return newFileName;
	}
	
	public List<String> attachProc(List<MultipartFile> multiFileList, String savePath){
		String uploadPath = attachPath + savePath;
		
		int createDirResult = createDirectory(uploadPath);
		
		if(createDirResult <= 0) {
			System.out.println("디렉토리가 존재하지 않습니다.");
		}
		
		List<String> list = new ArrayList<>();
		
		for(int i=0; i<multiFileList.size(); i++) {
			MultipartFile file = multiFileList.get(i);
			
			String originalFileName = "";
			String newFileName = "";
			long fileSize = 0;
			String contentType = "";
			String mimeType = "";
			
			int failCounter = 0;
			
			try {
				originalFileName = file.getOriginalFilename();
				newFileName = attachFileReName(originalFileName, file.getBytes(), uploadPath);
				fileSize = file.getSize();
				contentType = file.getContentType();
				
				InputStream inputStream;
				inputStream = file.getInputStream();
				Tika tika = new Tika();
				mimeType = tika.detect(inputStream);
				
			} catch(Exception e) {
				//e.printStackTrace();
				failCounter++;
			}
			if(contentType.equals(mimeType) && (failCounter == 0)) {
				String msg = "";
				msg += originalFileName + ",";
				msg += newFileName + ",";
				msg += fileSize + ",";
				msg += contentType + ",";
				msg += mimeType;
				list.add(msg);
			} else {
				fileCheck(savePath, newFileName);
				list.add("-");
			}
		}
		return list;
	}
	
	public void fileCheck(String savePath, String fileName) {
		String uploadPath = attachPath + savePath;
		java.io.File f1 = new java.io.File(uploadPath + "/" + fileName);
		if(f1.exists()){
			f1.delete();
		}
	}
	
}
