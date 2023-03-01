package com.kinaboot.muscles.domain;

import junit.framework.TestCase;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class PageHandlerTest{
    @Test
    public void totalPageTest(){
        SearchCondition sc = new SearchCondition();
        PageHandler ph = new PageHandler(140, sc);
        ph.print();
        System.out.println("ph = " + ph);
        assert (ph.getTotalPage()==14);
    }
}