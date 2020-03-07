package com.peta.service.message;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mongodb.client.ClientSession;
import com.mongodb.client.MongoClient;
import com.peta.dao.message.MessageDAO;
import com.peta.dao.message.PointDAO;
import com.peta.dto.SearchCriteria;
import com.peta.dto.message.MessageDTO;



@Service
public class MessageServiceImpl implements MessageService{
	@Inject
	private MessageDAO messageDAO;

	@Autowired
	private MongoClient mongoClient;
  
	@Inject
	private PointDAO pointDAO;
	
	@Override
	public void addMessage(MessageDTO dto) throws Exception {
		// TODO Auto-generated method stub
		try (ClientSession session = mongoClient.startSession()) {

			session.startTransaction();

			try {

				messageDAO.create(session,dto);
				System.out.println("¾îµð´Ï");
				pointDAO.updatePoint(session,dto.getSender(), 10);

				session.commitTransaction();

			} catch (Exception e) {
				e.printStackTrace();
				session.abortTransaction();
			}
			session.close();

		}


		
	}

	@Override
	public MessageDTO readMessage(String uid, String id) throws Exception {
		// TODO Auto-generated method stub
		try (ClientSession session = mongoClient.startSession()) {

			session.startTransaction();

			try {

				HashMap<String, String> map=  messageDAO.updateState(session,uid,id);
				String targetId = map.get("targetid");
				
				if (map.get("fistopen").equals("true")) {
					pointDAO.updatePoint(session,targetId, 5);
					session.commitTransaction();
				}

			} catch (Exception e) {
				e.printStackTrace();
				session.abortTransaction();
			}
			session.close();
			MessageDTO tes = messageDAO.readMessage(id);
			System.out.println(tes);
			return tes;

		}
		
		
		
		

	}
	
	@Override
	public List<MessageDTO> readMessageList(SearchCriteria cri,String uid) throws Exception{
		return messageDAO.readMessageList(cri,uid);
	}
	
	@Override
	public int readMessageCount(SearchCriteria cri,String uid) throws Exception{
		return messageDAO.readMessageCount(cri, uid);
	}
	
}
