package com.peta.dao.main;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.peta.dto.BoardDTO;
import com.peta.dto.board.BoardListDTO;

@Repository
public class MainDAOImpl implements MainDAO{
	
	@Inject
	MongoTemplate mongoTemplate;

	@Override
	public List<BoardDTO> mainlist() throws Exception {
		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("boardOrder").gte(1).lte(10) })).with(Sort.by(Direction.ASC, "boardOrder"));
		List<BoardListDTO> boardList = (List<BoardListDTO>) mongoTemplate.find(query, BoardListDTO.class);
		Query query2 = new Query();
		List<BoardDTO> test = new ArrayList<BoardDTO>();
		for (int i=0;i<10;i++) {
			query2 = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("board").regex(boardList.get(i).getBoardUrl(), "i") })).with(Sort.by(Direction.DESC, "_id")).limit(8);
			test.addAll(mongoTemplate.find(query2, BoardDTO.class));
		}
		return test;


	}

	@Override
	public List<BoardListDTO> mainBoardList() throws Exception {
		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("boardOrder").gte(1).lte(10) })).with(Sort.by(Direction.ASC, "boardOrder"));
		List<BoardListDTO> boardList = (List<BoardListDTO>) mongoTemplate.find(query, BoardListDTO.class);
		return boardList;
	}

	@Override
	public List<BoardDTO> piclist() throws Exception {
		Query query = new Query();
		query = new Query((new Criteria()).andOperator(new Criteria[] { Criteria.where("files.0").exists(true) })).with(Sort.by(Direction.DESC, "_id")).limit(20);;
		List<BoardDTO> test = mongoTemplate.find(query, BoardDTO.class);
		List<BoardDTO> test2 = new ArrayList<BoardDTO>();
		for (int i=0;i<20;i++) {
			String [] fileName = test.get(i).getFiles();
			String originFileName = fileName[0];
			String [] orginFile = originFileName.split("\\.");
			if(orginFile[1].equals("jpg") ||orginFile[1].equals("png") || orginFile[1].equals("jpeg")) {
				test2.add(test.get(i));
			}else {
				continue;
			}
		}

		return test2;
	}
	
	

	
}
