package com.spring.mvc.config;

import com.spring.mvc.user.srevice.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import javax.sql.DataSource;

/**
 * Created by apple6268 on 16. 3. 23.
 */

@Configuration
@EnableWebSecurity
@ComponentScan(basePackages = {"com.spring.*"})
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private DataSource dataSource;


    @Autowired
    private UserService userService;


    static final Logger LOGGER = LoggerFactory.getLogger(SecurityConfig.class);


    @Autowired
    public void configAuthentication(AuthenticationManagerBuilder auth) throws Exception{

        auth.jdbcAuthentication().dataSource(dataSource)
                .usersByUsernameQuery(
                        "select email,password,enable from users where email=? AND enable = 1")
                .authoritiesByUsernameQuery(
                        "select email, role from user_roles where email=?");
//        auth.inMemoryAuthentication().withUser("test@a").password("123456").roles("USER");

    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http
                .authorizeRequests()
                .antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
                .antMatchers("/index/**").hasAnyAuthority("ROLE_ADMIN","ROLE_USER")
                .antMatchers("/vacation/**").hasAnyAuthority("ROLE_ADMIN","ROLE_USER")
                .antMatchers("/user/**").hasAnyAuthority("ROLE_ADMIN","ROLE_USER")
                .antMatchers("/file/**").hasAnyAuthority("ROLE_ADMIN","ROLE_USER")
                .antMatchers("/resources/upload/**").hasAnyAuthority("ROLE_ADMIN","ROLE_USER")
                .antMatchers("/login/**").anonymous()
                .and()
                .formLogin()
                .defaultSuccessUrl("/index")
                .loginPage("/login")
                .loginProcessingUrl("/j_spring_security_check")
                .failureUrl("/login?error")
                .usernameParameter("username").passwordParameter("password")

                .and()
                .logout()
                .logoutUrl("/j_spring_security_logout")
                .deleteCookies("remove")
                .logoutSuccessUrl("/login?logout")
                .and()
                .exceptionHandling().accessDeniedPage("/403")
                .and()
                .rememberMe()
//                .key("KEY")
                .tokenValiditySeconds(3200*12)
                .and()
                .csrf().disable();
//                .key("")
//                .csrf();



    }




}
