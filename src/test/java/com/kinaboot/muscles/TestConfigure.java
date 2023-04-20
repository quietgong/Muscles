package com.kinaboot.muscles;

import com.kinaboot.muscles.dao.OrderDao;
import com.kinaboot.muscles.dao.ReviewDao;
import com.kinaboot.muscles.dao.UserDao;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.PageHandler;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.*;
import org.junit.runner.RunWith;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
        "file:src/main/webapp/WEB-INF/spring/root-context.xml",
        "file:src/main/webapp/WEB-INF/spring/aop-context.xml",
        "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class TestConfigure {

}
