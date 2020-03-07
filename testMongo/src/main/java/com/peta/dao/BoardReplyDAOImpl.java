package com.peta.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.WriteConcern;
import com.mongodb.client.ClientSession;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.peta.dto.BoardDTO;
import com.peta.dto.ReplyDTO;

@Repository
public class BoardReplyDAOImpl implements BoardReplyDAO {

	@Inject
	private MongoTemplate mongoTemplate;

	@Inject
	private MongoDatabase db;

	@Override
	public List<ReplyDTO> list(String rno, com.peta.dto.Criteria cri) throws Exception {
		// TODO Auto-generated method stub

		int page = cri.getPage() - 1;
		int size = cri.getPerPageNum();

		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("rno").regex(rno, "i") }))
				.with(Sort.by(Direction.DESC, "_id")).with(PageRequest.of(page, size));
		;

		return mongoTemplate.find(query, ReplyDTO.class);
	}

	@Override
	public void create(ClientSession session,ReplyDTO dto) throws Exception {
		//System.out.println(dto);
		//String json = new ObjectMapper().writeValueAsString(dto);
		//System.out.println(json);
		//System.out.println(dto);
		Date time = new Date();
		//dto.setRegdate(time);
		//mongoTemplate.insert(dto);
		MongoCollection<Document> target =
				db.getCollection("boardReply").withWriteConcern(WriteConcern.MAJORITY);
		Document contents = new Document();
		contents.put("rno",dto.getRno());
		contents.put("replytext",dto.getReplytext());
		contents.put("replyer",dto.getReplyer());
		contents.put("regdate",time);
		//contents.append("rno", dto.getRno());
		//Document doc = Document.parse(json);
		target.insertOne(session,contents);

		// TODO Auto-generated method stub

	}

	@Override
	public void update(ReplyDTO dto) throws Exception {
		// TODO Auto-generated method stub
		Date time = new Date();
		dto.setRegdate(time);
		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("_id").is(dto.getId()) }));
		Update update = new Update();
		update.set("replytext", dto.getReplytext());
		update.set("updatedate", time);
		mongoTemplate.updateFirst(query, update, ReplyDTO.class);
	}

	@Override
	public void delete(ClientSession session,String id) throws Exception {
		
		//MongoClient Ver
		MongoCollection<Document> target =
				db.getCollection("boardReply").withWriteConcern(WriteConcern.MAJORITY);
		target.deleteOne(session,new Document("_id",new ObjectId(id)));
		
		//MongoTemplate Ver
//		Query query = new Query();
//		query = new Query((new Criteria()).andOperator(new Criteria[] {
//				Criteria.where("id").is(id) }));
//		this.mongoTemplate.remove(query, ReplyDTO.class);

	}

	@Override
	public int count(String rno) throws Exception {

		// System.out.println("count"+rno);
		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("rno").regex(rno, "i") }))
				.with(Sort.by(Direction.DESC, "_id"));

		return (int) mongoTemplate.count(query, ReplyDTO.class);
	}

}
