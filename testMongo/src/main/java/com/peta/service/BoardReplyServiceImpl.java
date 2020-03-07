package com.peta.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mongodb.client.ClientSession;
import com.mongodb.client.MongoClient;
import com.peta.dao.BoardDAO;
import com.peta.dao.BoardReplyDAO;
import com.peta.dto.Criteria;
import com.peta.dto.ReplyDTO;

@Service
public class BoardReplyServiceImpl implements BoardReplyService {

	@Inject
	private BoardReplyDAO dao;

	@Inject
	private BoardDAO boardDAO;

	@Autowired
	private MongoClient mongoClient;

	@Override
	public List<ReplyDTO> list(String rno, Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.list(rno, cri);
	}

	@Override
	public void create(ReplyDTO dto) throws Exception {
		try (ClientSession session = mongoClient.startSession()) {

			session.startTransaction();

			try {

				dao.create(session, dto);

				boardDAO.updateReplyCnt(session, dto.getRno(), 1);

				session.commitTransaction();

			} catch (Exception e) {
				e.printStackTrace();
				session.abortTransaction();
			}
			session.close();

		}

	}

	@Override
	public void update(ReplyDTO dto) throws Exception {
		dao.update(dto);
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(String id) throws Exception {

		try (ClientSession session = mongoClient.startSession()) {

			session.startTransaction();

			try {

				String rno = boardDAO.getRno(id);
				dao.delete(session, id);
				boardDAO.updateReplyCnt(session, rno, -1);

				session.commitTransaction();

			} catch (Exception e) {
				e.printStackTrace();
				session.abortTransaction();
			}
			session.close();

		}

		// TODO Auto-generated method stub

	}

	@Override
	public int count(String rno) throws Exception {
		return dao.count(rno);
	}

}
