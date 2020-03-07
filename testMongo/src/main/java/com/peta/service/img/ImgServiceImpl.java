package com.peta.service.img;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.peta.dao.img.ImgDAO;
import com.peta.dto.SearchCriteria;
import com.peta.dto.img.ImgDTO;


@Service
public class ImgServiceImpl implements ImgService{
	
	@Inject
	private ImgDAO dao;
	
	@Override
	public List<ImgDTO> listSearchCriteria(SearchCriteria cri) throws Exception{
		return dao.listSearchCriteria(cri);
	}
	
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception{
		return dao.listSearchCount(cri);
	}
	
	@Override
	public void register(ImgDTO img) throws Exception{
		dao.register(img);
	}
	
	@Override
	public ImgDTO read(String id) throws Exception{
		return dao.read(id);
	}
	
	@Override
	public void remove(String id) throws Exception{
		dao.remove(id);
	}
	
	public void modify(ImgDTO img) throws Exception{
		dao.modify(img);
	}
}
