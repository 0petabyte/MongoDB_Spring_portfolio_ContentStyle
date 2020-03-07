package com.peta.dao.board;

import java.util.List;

import javax.inject.Inject;


import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.peta.dto.ReplyDTO;
import com.peta.dto.board.BoardListDTO;

@Repository
public class BoardListDAOImpl implements BoardListDAO{

	@Inject
	private MongoTemplate mongoTemplate;

	
	@Override
	public List<BoardListDTO> boardlist() throws Exception {
		
		Query query = new Query().with(Sort.by(Direction.ASC, "boardOrder"));
		return mongoTemplate.find(query, BoardListDTO.class);
	}


	@Override
	public void boardCreate(BoardListDTO dto) throws Exception {
		mongoTemplate.insert(dto);
	}


	@Override
	public void boardRemove(String id) throws Exception {
		Query query = new Query();

		query = new Query((new Criteria()).andOperator(new Criteria[] {

				Criteria.where("_id").is(id) }));
		mongoTemplate.remove(query,BoardListDTO.class);
		// TODO Auto-generated method stub
		
	}


	@Override
	public void boardUpate(BoardListDTO dto) throws Exception {
		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("_id").is(dto.getId()) }));
		Update update = new Update();
		update.set("boardName", dto.getBoardName());
		update.set("boardUrl", dto.getBoardUrl());
		update.set("boardOrder", dto.getBoardOrder());
		mongoTemplate.updateFirst(query, update, BoardListDTO.class);
		// TODO Auto-generated method stub
		
	}
	
	

	
	
}
