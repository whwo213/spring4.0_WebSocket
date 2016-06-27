package com.spring.mvc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

/**
 * Created by apple6268 on 16. 3. 22.
 */
/* <mvc:annotation-driven /> */
@EnableWebMvc


/*
<context:component-scan base-package="com.intercast">
  <context:include-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
  <context:exclude-filter type="annotation" expression="org.springframework.stereotype.Service"/>
  <context:exclude-filter type="annotation" expression="org.springframework.stereotype.Repository"/>
 </context:component-scan>
*/
@ComponentScan(basePackages="com.spring.*")
@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resource/**").addResourceLocations("/resources/").setCachePeriod(31556926);
    }
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {

        super.addViewControllers(registry);
//        registry.addViewController("/login").setViewName("login");
    }

    @Bean
    public MultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxInMemorySize(1000000000);
        resolver.setMaxUploadSize(2100000000);
        return resolver;
    }

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }



    /**
     * Tiles 설정파일
     *
     * <bean id="titlesConfigurer"
     *  class="org.springframework.web.servlet.view.tiles2.TilesConfigurer">
     *  <property name="definitions">
     *   <list>
     *    <value>/WEB-INF/config/tiles-defs.xml</value>
     *   </list>
     *  </property>
     * </bean>
     */
    @Bean
    public TilesConfigurer tilesConfigurer() {
        TilesConfigurer configure = new TilesConfigurer();
        configure.setDefinitions("/WEB-INF/config/tiles-defs.xml");;
        return configure;
    }



    /**
     * <bean class="org.springframework.web.servlet.view.UrlBasedViewResolver">
     *  <property name="viewClass" value="org.springframework.web.servlet.view.tiles2.TilesView"></property>
     *  <property name="order" value="1"></property>
     * </bean>
     */
    @Bean
    public UrlBasedViewResolver urlBasedViewResolver() {
        UrlBasedViewResolver resolver = new UrlBasedViewResolver();
        resolver.setViewClass(TilesView.class);
        resolver.setOrder(1);
        return resolver;
    }

    @Bean
    public InternalResourceViewResolver getInternalResourceViewResolver(){
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/page/");
        resolver.setSuffix(".jsp");
        resolver.setOrder(2);
        return resolver;
    }


}
