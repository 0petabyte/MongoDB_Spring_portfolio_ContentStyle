package com.peta.dao.message;

import com.mongodb.client.ClientSession;

public interface PointDAO {
	public void updatePoint(ClientSession session,String uid,int point) throws Exception;
}
