package com.peta.dao.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.bson.Document;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.mongodb.WriteConcern;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.peta.dto.BoardDTO;
import com.peta.dto.user.LoginDTO;
import com.peta.dto.user.UserDTO;
import com.peta.dto.user.UserUnameDTO;

@Repository
public class UserDAOImpl implements UserDAO {
	
	@Inject
	private MongoTemplate mongoTemplate;
	
	@Inject
	private MongoDatabase db;


	@Override
	public UserDTO login(LoginDTO dto) throws Exception {
		Query query = new Query();
		
		query = new Query((new Criteria()).
				andOperator(new Criteria[] { Criteria.where("uid").is(dto.getUid()),
						Criteria.where("upw").is(dto.getUpw())}));
		
		return mongoTemplate.findOne(query, UserDTO.class);

	}

	@Override
	public void keepLogin(String uid, String sessionId, Date next) {
		
		Query query = new Query();
		System.out.println(uid);
		System.out.println(sessionId);
		System.out.println(next);
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("uid").is(uid) }));
		Update update = new Update();
		update.set("sessionkey", sessionId);
		update.set("sessionLimit", next);
		mongoTemplate.updateFirst(query, update, UserDTO.class);
		// TODO Auto-generated method stub
		
	}

	@Override
	public UserDTO checkUserWithSessionKey(String value) {
		Date nowTime = new Date();
		String sessionKey = value;
		BasicQuery query = new BasicQuery("{ sessionkey : '" + sessionKey + "'}");
		UserDTO userDTO = mongoTemplate.findOne(query, UserDTO.class);
		Date dbTime =  userDTO.getSessionLimit();
		
		//시간 비교 after before 를 통해 return  
		if (dbTime.after(nowTime)) {
			return userDTO;
		}

		return null;

	}
	
	@Override
	public List<UserUnameDTO> searchid() {
		
		Query query = new Query().with(Sort.by(Direction.DESC, "_id"));
	
		return mongoTemplate.find(query, UserUnameDTO.class,"tb1_user");

		
	}

	@Override
	public boolean joinId(String id) throws Exception {
		Query query = new Query();
		query = new Query((new Criteria()).
				andOperator(new Criteria[] { Criteria.where("uid").is(id)
						}));
		try {
		UserDTO user = mongoTemplate.findOne(query, UserDTO.class);
		System.out.println(user.getUname());
		return false;
		}catch (Exception e) {
			return true;
			// TODO: handle exception
		}

	}

	@Override
	public boolean joinUname(String uname) throws Exception {
		Query query = new Query();
		query = new Query((new Criteria()).
				andOperator(new Criteria[] { Criteria.where("uname").is(uname)
						}));
		try {
		UserDTO user = mongoTemplate.findOne(query, UserDTO.class);
		System.out.println(user.getId());
		return false;
		}catch (Exception e) {
			e.printStackTrace();
			return true;
			// TODO: handle exception
		}
	}

	@Override
	public void joinUser(UserDTO user) throws Exception {
		// TODO Auto-generated method stub
		mongoTemplate.insert(user);
	}
	
	
	
	
	
}
