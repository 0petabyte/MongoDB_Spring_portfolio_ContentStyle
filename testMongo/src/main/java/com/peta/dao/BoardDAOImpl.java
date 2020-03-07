package com.peta.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.jws.Oneway;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.WriteConcernResolver;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.WriteConcern;
import com.mongodb.client.ClientSession;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.peta.dto.BoardDTO;
import com.peta.dto.ReplyDTO;
import com.peta.dto.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private MongoTemplate mongoTemplate;
	

	@Inject
	private MongoDatabase db;

	
	// list
	// 게시판 리스트
	public List<BoardDTO> list() {

		int page = 0;
		int size = 10;

		Query query = new Query().with(Sort.by(Direction.DESC, "_id")).with(PageRequest.of(page, size));

	
		// mongoTempleate.find(조건, 돌려받을 클래스 , 컬렉션)
		return mongoTemplate.find(query, BoardDTO.class);
	}

	// create
	public void create(ClientSession session,BoardDTO board) throws Exception {
//		MongoCollection<Document> target =
//				db.getCollection("board").withWriteConcern(WriteConcern.MAJORITY);
//		Date time = new Date();
//		Document contents = new Document();
//		contents.put("title",board.getTitle());
//		contents.put("content",board.getContent());
//		contents.put("dateTime",time);
//		contents.put("writer",board.getWriter());
//		contents.put("viewcnt",board.getViewcnt());
//		contents.put("replycnt",board.getReplycnt());
//		
//		ArrayList< DBObject > array = new ArrayList< DBObject >();
//		
//		String[] dbo;
//		dbo =board.getFiles();
//		contents.put("files",dbo);
//		//contents.put(milestones);
//		System.out.println("test1");
//		target.insertOne(session,contents);
//		System.out.println("test2");
		
//		MongoTemplate mongo = mongoTemplate;
//		WriteConcern wc = resolveWriteConcern(writeConcern);
//		mongomongo.setWriteConcern(WriteConcern.MAJORITY);
//		mongoTemplate.setWriteConcern(WriteConcern.MAJORITY);

		//mongotemplate Ver
		Date time = new Date();
		//모든게시판에서 글을 쓸경우 자동으로 자유게시판 으로 하게끔 설정.
		if (board.getBoardName() == "") {
			board.setBoardName("자유게시판");
		}
		board.setBoard(board.getBoard().replace(",", ""));
		board.setDateTime(time);
//		System.out.println("session"+session);
//		WriteConcernResolver.resolve(null);
//		mongoTemplate.insert(board);
		
		mongoTemplate.withSession(()->session)
		.execute(action -> 
		{ 
			return action.insert(board);
		  });
		 
	}

	// read
	public BoardDTO read(String id) throws Exception {
		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("_id").is(id) }));
		BoardDTO voList = mongoTemplate.findOne(query, BoardDTO.class);
		return voList;
	}

	// delete
	public void remove(String id) throws Exception {
		Query query = new Query();

		query = new Query((new Criteria()).andOperator(new Criteria[] {

				Criteria.where("id").is(id) }));
		this.mongoTemplate.remove(query, BoardDTO.class);
	}

	// modify
	public void modify(BoardDTO board) throws Exception {
		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("_id").is(board.getId()) }));
		Update update = new Update();
		update.set("content", board.getContent());
		update.set("title", board.getTitle());
		update.set("files", board.getFiles());
		mongoTemplate.updateFirst(query, update, BoardDTO.class);
	}

	public List<BoardDTO> listCriteria(com.peta.dto.Criteria cri) throws Exception {

		int page = cri.getPage();
		int size = cri.getPerPageNum();
		Query query = new Query().with(Sort.by(Direction.DESC, "_id")).with(PageRequest.of(page, size));

		// mongoTempleate.find(조건, 돌려받을 클래스 , 컬렉션)
		return mongoTemplate.find(query, BoardDTO.class);

	}

	public List<BoardDTO> listSearch(SearchCriteria cri) throws Exception {
		String board = cri.getBoard();
		int page = cri.getPage() - 1;
		int size = cri.getPerPageNum();
		String keyword = cri.getKeyword();
		String searchType = cri.getSearchType();
		System.out.println(searchType);
		System.out.println(board);
		Query query = new Query();
		if (searchType == null && board == null) {

			query = new Query().with(Sort.by(Direction.DESC, "_id")).with(PageRequest.of(page, size));

		}
		
		else if (keyword != null && searchType != null && board == "") {
			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { 
							Criteria.where("title").regex(keyword, "i")}))
							.with(Sort.by(Direction.DESC, "_id")).with(PageRequest.of(page, size));
		}
		
		
		else if(searchType == null && board != null && keyword == null) {
			System.out.println("보드진입");
			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { 
							Criteria.where("board").regex(board, "i")}))
							.with(Sort.by(Direction.DESC, "_id")).with(PageRequest.of(page, size));
		}
		else if(searchType != null && board != null && keyword == null) {
			System.out.println("보드진입");
			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { 
							Criteria.where("board").regex(board, "i")}))
							.with(Sort.by(Direction.DESC, "_id")).with(PageRequest.of(page, size));
		}

		else if (searchType.equals("t") && keyword != null) {

			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { Criteria.where("title").regex(keyword, "i"),
							Criteria.where("board").regex(board, "i")}))
							.with(Sort.by(Direction.DESC, "_id")).with(PageRequest.of(page, size));

		} else if (searchType.equals("c") && keyword != null) {

			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { Criteria.where("content").regex(keyword, "i"),
							Criteria.where("board").regex(board, "i") }))
							.with(Sort.by(Direction.DESC, "_id")).with(PageRequest.of(page, size));
		} else if (searchType.equals("tc") && keyword != null) {

			query = new Query(
					(new Criteria()).orOperator(new Criteria[] {
							(new Criteria()).andOperator(Criteria.where("board").regex(board,"i"),Criteria.where("title").regex(keyword, "i")),
							(new Criteria()).andOperator(Criteria.where("board").regex(board,"i")),Criteria.where("content").regex(keyword, "i")
		
					})).with(Sort.by(Direction.DESC, "_id"))
							.with(PageRequest.of(page, size));
		} else {

			System.out.println("else");
			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { 
							Criteria.where("board").regex(board, "i")}))
							.with(Sort.by(Direction.DESC, "_id")).with(PageRequest.of(page, size));
		}

		// int pageCount = (int) mongoTemplate.count(query, BoardDTO.class);
		// mongoTempleate.find(조건, 돌려받을 클래스 , 컬렉션)
		return mongoTemplate.find(query, BoardDTO.class);
	}

	public int listSearchCount(SearchCriteria cri) throws Exception {
		Query query = new Query();
		String board = cri.getBoard();
		String keyword = cri.getKeyword();
		String searchType = cri.getSearchType();
		if (searchType == null && board == null) {

			query = new Query().with(Sort.by(Direction.DESC, "_id"));

		}
		
		else if (keyword != null && searchType != null && board == "") {
			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { 
							Criteria.where("title").regex(keyword, "i")}))
							.with(Sort.by(Direction.DESC, "_id"));
		}
		
		
		else if(searchType == null && board != null && keyword == null) {
			System.out.println("보드진입");
			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { 
							Criteria.where("board").regex(board, "i")}))
							.with(Sort.by(Direction.DESC, "_id"));
		}
		else if(searchType != null && board != null && keyword == null) {
			System.out.println("보드진입");
			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { 
							Criteria.where("board").regex(board, "i")}))
							.with(Sort.by(Direction.DESC, "_id"));
		}

		else if (searchType.equals("t") && keyword != null) {

			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { Criteria.where("title").regex(keyword, "i"),
							Criteria.where("board").regex(board, "i")}))
							.with(Sort.by(Direction.DESC, "_id"));

		} else if (searchType.equals("c") && keyword != null) {

			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { Criteria.where("content").regex(keyword, "i"),
							Criteria.where("board").regex(board, "i") }))
							.with(Sort.by(Direction.DESC, "_id"));
		} else if (searchType.equals("tc") && keyword != null) {

			query = new Query(
					(new Criteria()).orOperator(new Criteria[] {
							(new Criteria()).andOperator(Criteria.where("board").regex(board,"i"),Criteria.where("title").regex(keyword, "i")),
							(new Criteria()).andOperator(Criteria.where("board").regex(board,"i")),Criteria.where("content").regex(keyword, "i")
		
					})).with(Sort.by(Direction.DESC, "_id"))
							;
		} else {

			System.out.println("else");
			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { 
							Criteria.where("board").regex(board, "i")}))
							.with(Sort.by(Direction.DESC, "_id"));
		}

		// mongoTempleate.find(조건, 돌려받을 클래스 , 컬렉션)
		return (int) mongoTemplate.count(query, BoardDTO.class);
	}

	public void updateReplyCnt(ClientSession session, String rno, int amount) throws Exception {
		MongoCollection<Document> target = 
				db.getCollection("board").withWriteConcern(WriteConcern.MAJORITY);

		// Integer.parseInt("abcd"); //에러생성 트랜잭션 테스트
		
		// MongoClient Ver
		Document find = new Document("_id", new ObjectId(rno));
		Document increase = new Document("replycnt", amount);
		Document update = new Document("$inc", increase);
		
		target.findOneAndUpdate(session, find, update);


//		System.out.println(cursor.first().get("replycnt"));


		// MongoTemplate Ver
//		Query query = new Query();
//		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("_id").is(rno) }));
//		BasicQuery query1 = new BasicQuery("{ _id : '" + rno + "'}");
//		BoardDTO userTest1 = mongoTemplate.findOne(query1, BoardDTO.class);
//		int uPoint = userTest1.getReplycnt();
//		int changPoint = uPoint + amount;
//		Update update = new Update();
//		update.set("replycnt", changPoint);
//		mongoTemplate.updateFirst(query, update, BoardDTO.class);
	}

	public String getRno(String id) throws Exception {
		BasicQuery query1 = new BasicQuery("{ _id : '" + id + "'}");
		ReplyDTO userTest1 = mongoTemplate.findOne(query1, ReplyDTO.class);
		String uRno = userTest1.getRno();
		return uRno;

	}

	public void updateViewCnt(String id) throws Exception {
		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("_id").is(id) }));
		BasicQuery query1 = new BasicQuery("{ _id : '" + id + "'}");
		BoardDTO userTest1 = mongoTemplate.findOne(query1, BoardDTO.class);
		int uPoint = userTest1.getViewcnt();
		int changPoint = uPoint + 1;
		Update update = new Update();
		update.set("viewcnt", changPoint);
		mongoTemplate.updateFirst(query, update, BoardDTO.class);
	}

	/*
	 * public void addAttach(String fullName) throws Exception { BasicQuery
	 * basicQuery = new BasicQuery(new BasicDBObject());
	 * basicQuery.setSortObject(new BasicDBObject("$natural", -1)); BoardDTO testBno
	 * = mongoTemplate.findOne(basicQuery, BoardDTO.class); String uploadBno =
	 * testBno.getId(); Date time = new Date(); UploadDTO upload = new UploadDTO();
	 * upload.setBno(uploadBno); upload.setFullname(fullName);
	 * upload.setRegdate(time); mongoTemplate.insert(upload);
	 * 
	 * }
	 */

	public void deleteAttach(String id) throws Exception {
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(id));
		Update update = new Update();
		update.unset("files[0]");

		// run update operation
		mongoTemplate.updateMulti(query, update, BoardDTO.class);

	}

}