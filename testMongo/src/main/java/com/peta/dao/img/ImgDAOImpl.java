package com.peta.dao.img;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;


import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;


import com.peta.dto.SearchCriteria;
import com.peta.dto.img.ImgDTO;

@Repository
public class ImgDAOImpl implements ImgDAO{
	
	@Inject
	private MongoTemplate mongoTemplate;
	
	
	
	
	public List<ImgDTO> listSearchCriteria(SearchCriteria cri) throws Exception{
		int page = cri.getPage()-1;
		int size = cri.getPerPageNum();
		String keyword = cri.getKeyword();
		String searchType = cri.getSearchType();
		
		
		Query query = new Query();
		if (searchType == null){
			
			query = new Query().with(Sort.by(Direction.DESC,"_id"));
			
		}
		
		else if (searchType.equals("t")) {
			
			query = new Query((new Criteria()).andOperator(new Criteria[] {
	  		Criteria.where("title").regex(keyword,"i")
				})).with(Sort.by(Direction.DESC, "_id"))
	  		.with(PageRequest.of(page, size));
			
			  }
		else if (searchType.equals("c")) {
			
			query = new Query((new Criteria()).andOperator(new Criteria[] {
	  		Criteria.where("content").regex(keyword,"i")
				})).with(Sort.by(Direction.DESC, "_id"))
	  		.with(PageRequest.of(page, size));
			  }
		else if (searchType.equals("tc")) {
			
			query = new Query((new Criteria()).orOperator(new Criteria[] {
			  		Criteria.where("title").regex(keyword,"i"),
			  		Criteria.where("content").regex(keyword,"i")
				})).with(Sort.by(Direction.DESC, "_id"))
	  		.with(PageRequest.of(page, size));
			  }
		else {

				
				query = new Query().with(Sort.by(Direction.DESC, "_id"))
				   .with(PageRequest.of(page, size));
				
		
		}

	  //int pageCount = (int) mongoTemplate.count(query, BoardDTO.class);
	  //mongoTempleate.find(조건, 돌려받을 클래스 , 컬렉션)
	  return mongoTemplate.find(query, ImgDTO.class);
	}
	
	public int listSearchCount(SearchCriteria cri) throws Exception{
		Query query = new Query();
		String keyword = cri.getKeyword();
		String searchType = cri.getSearchType();
		if (searchType == null){
			
			query = new Query().with(Sort.by(Direction.DESC, "_id"));
		}
		
		else if (searchType.equals("t")) {
			
			query = new Query((new Criteria()).andOperator(new Criteria[] {
	  		Criteria.where("title").regex(keyword,"i")
			})).with(Sort.by(Direction.DESC, "_id"));
			  }
		else if (searchType.equals("c")) {
			
			query = new Query((new Criteria()).andOperator(new Criteria[] {
	  		Criteria.where("content").regex(keyword,"i")
			})).with(Sort.by(Direction.DESC, "_id"));
			  }
		else if (searchType.equals("tc")) {
			
			query = new Query((new Criteria()).orOperator(new Criteria[] {
	  		Criteria.where("title").regex(keyword,"i"),
	  		Criteria.where("content").regex(keyword,"i")
			})).with(Sort.by(Direction.DESC, "_id"));
			  }
		else {

			
			query = new Query().with(Sort.by(Direction.DESC, "_id"));
			
	
	}
	  //mongoTempleate.find(조건, 돌려받을 클래스 , 컬렉션)
	  return (int) mongoTemplate.count(query, ImgDTO.class);
	}
	
	public void register(ImgDTO img) throws Exception{
		Date time = new Date();
		img.setDateTime(time);
		mongoTemplate.insert(img);
		
	}
	
	public ImgDTO read(String id) throws Exception{
	    Query query = new Query();    
	    query = new Query((new Criteria()).andOperator(new Criteria[] {
	            Criteria.where("_id").is(id)
	          }));
	    ImgDTO voList = mongoTemplate.findOne(query, ImgDTO.class);
	    return voList;
	}
	
	public void remove(String id) throws Exception{
	    Query query = new Query();
	    
	    query = new Query((new Criteria()).andOperator(new Criteria[] {
	            
	            Criteria.where("_id").is(id)
	          }));
	    this.mongoTemplate.remove(query, ImgDTO.class);
	}
	
	public void modify(ImgDTO img) throws Exception{
	    Query query = new Query();    
	    query = new Query((new Criteria()).andOperator(new Criteria[] {
	            Criteria.where("_id").is(img.getId())
	          }));
        Update update = new Update();
        update.set("content", img.getContent());
        update.set("title", img.getTitle());
        mongoTemplate.updateFirst(query, update, ImgDTO.class);
	}
}
