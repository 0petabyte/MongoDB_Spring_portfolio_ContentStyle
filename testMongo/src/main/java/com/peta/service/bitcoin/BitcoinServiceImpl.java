package com.peta.service.bitcoin;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.peta.dao.bitcoin.BitcoinListDAO;
import com.peta.dto.bitcoin.BitcoinDTO;
import com.peta.dto.bitcoin.BitcoinMainDTO;

@Service
public class BitcoinServiceImpl implements BitcoinService{

	@Inject
	private BitcoinListDAO dao;
	
	@Override
	public List<BitcoinDTO> list(String coin) throws Exception {
		
		return dao.bitcoinList(coin);
	}

	@Override
	public List<BitcoinMainDTO> listAll(String sort) throws Exception {
		return dao.listAll(sort);
	}

	
}
