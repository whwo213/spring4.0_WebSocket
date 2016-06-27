package com.spring.mvc.config.initializer;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by apple6268 on 16. 3. 24.
 */
public class SessionListener implements HttpSessionListener {
    @Override
    public void sessionCreated(HttpSessionEvent event) {
        System.out.println("==== session 생성 ====");
        event.getSession().setMaxInactiveInterval(60*30);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        System.out.println("==== session 종료 ====");
    }
}
