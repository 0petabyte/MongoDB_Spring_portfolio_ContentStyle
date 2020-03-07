package com.peta.dao.message;

import javax.inject.Inject;

import org.bson.Document;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.mongodb.WriteConcern;
import com.mongodb.client.ClientSession;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.peta.dto.user.UserDTO;

@Repository
public class PointDAOImpl implements PointDAO {

	@Inject
	private MongoTemplate mongoTemplate;

	@Inject
	private MongoDatabase db;

	@Override
	public void updatePoint(ClientSession session, String uid, int point) throws Exception {

		// MongoClient Ver
		MongoCollection<Document> target = db.getCollection("tb1_user").withWriteConcern(WriteConcern.MAJORITY);

		Document find = new Document("uid", uid);
		Document increase = new Document("point", point);
		Document update = new Document("$inc", increase);
		//Integer.parseInt("abcd"); //에러생성 트랜잭션 테스트
		target.findOneAndUpdate(session, find, update);
		
		// MongoTemplate Ver
//	    Query query = new Query();    
//	    query = new Query((new Criteria()).andOperator(new Criteria[] {
//	            Criteria.where("uid").is(uid)
//	          }));
//	    BasicQuery query1 = new BasicQuery("{ uid : '"+uid+"'}");
//	    UserDTO userTest1 = mongoTemplate.findOne(query1, UserDTO.class);
//	    int uPoint = userTest1.getpoint();
//	    int changPoint = uPoint + point;
//        Update update = new Update();
//        update.set("point", changPoint);
//        mongoTemplate.updateFirst(query, update, UserDTO.class);

	}

}
