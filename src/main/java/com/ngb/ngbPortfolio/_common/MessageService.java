package com.ngb.ngbPortfolio._common;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class MessageService {
	public void sendMessage(String toNumber, String randomCode) {
		String api_key = "NCSTJFTE6FGZHWED";
	    String api_secret = "AWFA0LUMOY4NTTCHQIJJ8ZI6NUHBCDNT";
	    Message coolsms = new Message(api_key, api_secret);
	    HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", toNumber);
		params.put("from", "01079280939");
		params.put("type", "SMS");
		params.put("text", "[NGB SHOP] 인증번호 ["+randomCode+"] 를 입력하세요.");
		params.put("app_version", "test app 1.2"); // application name and version
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
	}
}
