package com.peta.dao.message;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.bson.Document;
import org.bson.types.ObjectId;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.mongodb.BasicDBObject;
import com.mongodb.WriteConcern;
import com.mongodb.client.ClientSession;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.FindOneAndUpdateOptions;
import com.peta.dto.BoardDTO;
import com.peta.dto.SearchCriteria;
import com.peta.dto.message.MessageDTO;

@Repository
public class MessageDAOImpl implements MessageDAO {

	@Inject
	private MongoTemplate mongoTemplate;

	@Inject
	private MongoDatabase db;

	@Override
	public void create(ClientSession session, MessageDTO dto) throws Exception {
		// TODO Auto-generated method stub
		Date time = new Date();
		
		//Mongo Client Ver
		MongoCollection<Document> target =
				db.getCollection("tb1_message").withWriteConcern(WriteConcern.MAJORITY);
		MongoCollection<Document> target2 =
				db.getCollection("tb1_user");
		String uname = (String) target2.find(new Document("uid",dto.getSender())).first().get("uname");
		System.out.println(dto.getTargetid());
		String targetname = (String) target2.find(new Document("uid",dto.getTargetid())).first().get("uname");
		System.out.println(targetname);
		Document contents = new Document();
		contents.put("targetid",dto.getTargetid());
		contents.put("sender",dto.getSender());
		contents.put("message",dto.getMessage());
		contents.put("senderName",uname);
		contents.put("targetName",targetname);
		contents.put("senddate",time);
		System.out.println(contents);
		target.insertOne(session,contents);
		
		//MongoTemplate 
//		Date time = new Date();
//		dto.setSenddate(time);
//		mongoTemplate.insert(dto);
	}

	@Override
	public MessageDTO readMessage(String id) throws Exception {
		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("_id").is(id) }));
		MessageDTO voList = mongoTemplate.findOne(query, MessageDTO.class);
		return voList;
	}

	@Override
	public HashMap<String, String> updateState(ClientSession session,String uid,String id) throws Exception {
		
		Date time = new Date();
		
		//MongoClient Ver
		MongoCollection<Document> target = 
				db.getCollection("tb1_message").withWriteConcern(WriteConcern.MAJORITY);
		HashMap<String, String> map = new HashMap<String, String>();
//	    BasicDBObject andQuery = new BasicDBObject();
//	    List<Document> obj = new ArrayList<Document>();
//	    obj.add(new Document("_id", new ObjectId(id)));
//	    obj.add(new Document("targetid", uid));
//	    andQuery.put("$and", obj);
//	    System.out.println(andQuery);
	    Document find = new Document("_id", new ObjectId(id));
		Document increase = new Document("opendate", time);
		Document update = new Document("$set", increase);
		Document test = target.find(find).first();
		System.out.println(test);
		String firstOpen;
		Date testdate = (Date) test.get("opendate");
		String targetid = (String) test.get("targetid");

		if(testdate == null && targetid.equals(uid)) {
			target.findOneAndUpdate(session, find, update);
			firstOpen = "true";
		}else {
			firstOpen = "false";
		}
		map.put("fistopen",firstOpen);
		map.put("targetid",targetid);
		
		return map;

		
		//MongoTemplate Ver
//		Query query = new Query();
//		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("_id").is(id) }));
//		Update update = new Update();
//		Date time = new Date();
//		update.set("opendate", time);
//		mongoTemplate.updateFirst(query, update, MessageDTO.class);

	}
	
	public List<MessageDTO> readMessageList(SearchCriteria cri,String uid) throws Exception{
//		MongoCollection<Document> target = 
//				db.getCollection("tb1_message");
//		Document find = new Document("targetid", uid);
//		System.out.println("여긴왔지");
//		FindIterable<Document> test = target.find(find);
//		System.out.println(test.first());
//		System.out.println(uid);
//		return null;
		
		String searchType = cri.getSearchType();
		
		int page = cri.getPage() - 1;
		int size = cri.getPerPageNum();
		Query query = new Query();
		

		
		
		if(searchType.equals("t")) {
			query = new Query((new Criteria()).andOperator(new Criteria[] 
					{ Criteria.where("targetid").regex(uid, "i") })).with(Sort.by(Direction.DESC, "_id"))
					.with(PageRequest.of(page, size));
		}
		
		else if(searchType.equals("s")) {
			query = new Query((new Criteria()).andOperator(new Criteria[] 
					{ Criteria.where("sender").regex(uid, "i") })).with(Sort.by(Direction.DESC, "_id"))
					.with(PageRequest.of(page, size));
		}
		
		return mongoTemplate.find(query, MessageDTO.class);
		
	}
	
	public int readMessageCount(SearchCriteria cri,String uid) throws Exception{
		

		Query query = new Query();
		String searchType = cri.getSearchType();
		
		if(searchType.equals("t")) {
			query = new Query((new Criteria()).andOperator(new Criteria[] 
					{ Criteria.where("targetid").regex(uid, "i") })).with(Sort.by(Direction.DESC, "_id"))
					;
		}
		
		else if(searchType.equals("s")) {
			query = new Query((new Criteria()).andOperator(new Criteria[] 
					{ Criteria.where("sender").regex(uid, "i") })).with(Sort.by(Direction.DESC, "_id"))
					;
		}
		
		return (int) mongoTemplate.count(query, MessageDTO.class);
		
	}

}
