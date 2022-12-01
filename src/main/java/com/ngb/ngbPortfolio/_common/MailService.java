package com.ngb.ngbPortfolio._common;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	public JavaMailSenderImpl mailSender() {
        JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();

        javaMailSender.setProtocol("smtp");
        javaMailSender.setHost("127.0.0.1");
        javaMailSender.setPort(25);

        return javaMailSender;
    }
	
	@Autowired
	private JavaMailSender  mailSender;
	
	public void sendEmail(String toAddress, String fromAddress,
					String subject, String msgBody) {
		MimeMessage mail = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(mail, true, "UTF-8");
			messageHelper.setSubject(subject);
			String htmlContent = msgBody;
			messageHelper.setText(htmlContent, true);
			messageHelper.setFrom(fromAddress);
			messageHelper.setTo(toAddress);
			mailSender.send(mail);
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
	}
}
