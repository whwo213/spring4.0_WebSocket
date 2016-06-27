package com.spring.mvc.socket;

import com.spring.mvc.vacation.service.VacationService;
import com.spring.mvc.user.UserControll;
import com.spring.mvc.vacation.vo.VacationVo;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.Message;
import org.springframework.messaging.handler.annotation.MessageExceptionHandler;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;

import java.security.Principal;
import java.util.Calendar;
import java.util.Date;


/**
 * Created by young on 2016-06-25.
 */
@Controller
public class SocketController {
    Logger logger = LoggerFactory.getLogger(UserControll.class);

    @Autowired
    VacationService vacationService;

    private SimpMessagingTemplate template;

    public SocketController(SimpMessagingTemplate template) {
        this.template = template;
    }


    public static class MessageDTO{
        public Date date;
        public String content;
        public String asdf;

        public MessageDTO(String message){
            this.date = Calendar.getInstance().getTime();
            this.content = message;
            this.asdf = "asdfsadfsafasdf";
        }
    }

    @MessageMapping("/send")
    @SendTo("/topic/entries")
    public String guestbook(
            String message,
            Principal user,
            VacationVo vacationVo,
            JSONObject jsonObject
    ){
//        System.out.println("Received message:" + message);

        JSONParser jsonParser = new JSONParser();
        try {
            Object obj = jsonParser.parse(message);
            jsonObject = (JSONObject) obj;
            String date = (String) jsonObject.get("date");
            String memo = (String) jsonObject.get("memo");
            String userName = (String) jsonObject.get("userName");
            String email = (String) jsonObject.get("email");

            String parentIdx = vacationService.uniqIdxSelect(email);

            vacationVo.setVACATION_MEMO(memo);
            vacationVo.setVACATION_DATE(date);
            vacationVo.setVACATION_USER_NAME(userName);
            vacationVo.setPARENT_IDX(parentIdx);
            vacationService.Register(vacationVo);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        System.out.println(jsonObject.toJSONString()+"/"+user);
        return jsonObject.toJSONString();
    }

    @MessageMapping("/chat")
    public void sendUserMassage(Message<Object> message, @Payload ChatMessage chatMessage) {
        Principal principal = message.getHeaders().get(SimpMessageHeaderAccessor.USER_HEADER, Principal.class);
        String authedSender = principal.getName();
        chatMessage.setSender(authedSender);
        String recipient = chatMessage.getRecipient();

        System.out.println("authedSender:"+authedSender);
        System.out.println("recipient:"+recipient);
        if (!authedSender.equals(recipient)) {
            template.convertAndSendToUser(recipient, "/queue/messages", chatMessage);
        }
//        template.convertAndSendToUser(principal.getName(),"/queue/messages",chatMessage);
    }
}
