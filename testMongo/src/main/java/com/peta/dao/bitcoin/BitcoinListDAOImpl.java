package com.peta.dao.bitcoin;

import java.util.List;

import javax.inject.Inject;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.mongodb.WriteConcern;
import com.mongodb.client.MongoClient;
import com.peta.config.BitcoinCollection;
import com.peta.dto.bitcoin.BitcoinDTO;
import com.peta.dto.bitcoin.BitcoinMainDTO;

@Repository
public class BitcoinListDAOImpl extends BitcoinCollection implements BitcoinListDAO {

	


	private MongoTemplate mongoTemp = mongotemp();
	
	
	@Override
	public List<BitcoinDTO> bitcoinList(String coin) throws Exception {
		
		Query query = new Query();
		if(coin != null) {
			query = new Query(
					(new Criteria()).andOperator(new Criteria[] { Criteria.where("coinname").regex(coin, "i")
							})).with(Sort.by(Direction.DESC, "days"));
		}else {
			query = new Query().with(Sort.by(Direction.DESC, "days"));
		}
		
		return mongoTemp.find(query, BitcoinDTO.class);
	}


	@Override
	public List<BitcoinMainDTO> listAll(String sort) throws Exception {
		Query query = new Query();
		
		if(sort == null) {
			query = new Query().with(Sort.by(Direction.DESC, "bidtotal"));
		}else if(sort.equals("eventday")) {
			query = new Query().with(Sort.by(Direction.ASC, sort));
		}
		
		else {
			query = new Query().with(Sort.by(Direction.DESC, sort));
		}
		// TODO Auto-generated method stub
		return mongoTemp.find(query, BitcoinMainDTO.class);
	}
	
	
	
}
