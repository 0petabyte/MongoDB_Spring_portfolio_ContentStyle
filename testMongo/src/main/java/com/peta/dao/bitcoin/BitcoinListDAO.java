package com.peta.dao.bitcoin;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.peta.dto.bitcoin.BitcoinDTO;
import com.peta.dto.bitcoin.BitcoinMainDTO;


public interface BitcoinListDAO {
	public List<BitcoinDTO> bitcoinList(String coin)throws Exception;
	
	public List<BitcoinMainDTO> listAll(String sort) throws Exception;
	
}
