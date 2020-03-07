package com.peta.service.img;

import java.util.List;

import org.springframework.stereotype.Service;

import com.peta.dto.SearchCriteria;
import com.peta.dto.img.ImgDTO;


@Service
public interface ImgService {
	public List<ImgDTO> listSearchCriteria(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	public void register(ImgDTO img) throws Exception;
	
	public ImgDTO read(String id) throws Exception;
	
	public void remove(String id) throws Exception;
	
	public void modify(ImgDTO img) throws Exception;
}
