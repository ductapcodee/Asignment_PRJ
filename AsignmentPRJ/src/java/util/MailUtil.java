/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author ADMIN
 */

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;

public class MailUtil {

    public static void sendEmail(String to, String subject, String messageText) throws MessagingException {
        String host = "smtp.gmail.com";
        String user = "minhduchoang2410@gmail.com"; // 🔥 Đổi thành Gmail bạn
        String pass = "zskq nmkc abor vpmb"; // 🔥 Đổi thành App Password 16 ký tự

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
            new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, pass);
                }
            }
        );

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(user));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        msg.setSubject(subject);
        msg.setText(messageText);

        Transport.send(msg);
    }
}
