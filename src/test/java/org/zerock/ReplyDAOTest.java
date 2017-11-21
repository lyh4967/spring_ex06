package org.zerock;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.ReplyVO;
import org.zerock.persistence.ReplyDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ReplyDAOTest {
	
	@Inject 
	ReplyDAO dao;
	
	private static Logger logger=LoggerFactory.getLogger(ReplyDAOTest.class);
	
	/*@Test
	public void testCreate() throws Exception{
		ReplyVO vo=new ReplyVO();
		vo.setBno(1910);
		vo.setReplyer("Honn");
		vo.setReplytext("Good");
		dao.create(vo);
	}*/
	/*@Test
	public void testUpdate() throws Exception{
		ReplyVO vo=new ReplyVO();
		vo.setRno(25);
		vo.setReplyer("Honn");
		vo.setReplytext("Good");
		dao.update(vo);	
	}*/
	/*@Test
	public void testdelete() throws Exception{
		dao.delete(26);
		
	}*/
	@Test
	public void testList() throws Exception{
		List<ReplyVO> list=dao.list(1910);
		for(ReplyVO a:list) {
			logger.info(a.getRno()+":"+a.getReplytext());
		}
	}
	
	

}
