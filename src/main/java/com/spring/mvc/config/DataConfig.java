package com.spring.mvc.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

/**
 * Created by apple6268 on 16. 3. 23.
 */

@Configuration
@MapperScan("com.spring.mvc.**.mapper")
public class DataConfig {
    @Bean(name="dataSource")
    public DataSource dataSource() {
//        SimpleDriverDataSource dataSource = new SimpleDriverDataSource();
//        dataSource.setDriverClass(oracle.jdbc.driver.OracleDriver.class);
//        dataSource.setUrl("jdbc:oracle:thin:@//bananablue.iptime.org:1521/orcl");
//        dataSource.setUsername("apple6268");
//        dataSource.setPassword("rave6268");


//        return dataSource;

        DriverManagerDataSource driverManagerDataSource = new DriverManagerDataSource();
        driverManagerDataSource.setDriverClassName( "net.sf.log4jdbc.sql.jdbcapi.DriverSpy" );
        driverManagerDataSource.setUrl( "jdbc:log4jdbc:oracle:thin:@//bananablue.iptime.org:1521/orcl" );
        driverManagerDataSource.setUsername( "c##apple6268" );
        driverManagerDataSource.setPassword( "rave6268" );


        return driverManagerDataSource;
    }



    @Bean
    public DataSourceTransactionManager transactionManager()
    {
        return new DataSourceTransactionManager(dataSource());
    }

    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource());
        return sessionFactory.getObject();
    }

/*    @Bean
    public UsersMapper usersMapper() throws Exception {
        SqlSessionTemplate sessionTemplate = new SqlSessionTemplate(sqlSessionFactory());
        return sessionTemplate.getMapper(UsersMapper.class);
    }*/
}

