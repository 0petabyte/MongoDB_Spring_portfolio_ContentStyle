package com.peta.service.bitcoin;

import java.util.List;

import org.springframework.stereotype.Service;

import com.peta.dto.bitcoin.BitcoinDTO;
import com.peta.dto.bitcoin.BitcoinMainDTO;

@Service
public interface BitcoinService {
	public List<BitcoinDTO> list(String coin)throws Exception;
	
	public List<BitcoinMainDTO> listAll(String sort)throws Exception;
}
