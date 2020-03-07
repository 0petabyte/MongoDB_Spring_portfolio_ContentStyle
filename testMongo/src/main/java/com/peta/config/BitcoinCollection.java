package com.peta.config;

import javax.inject.Inject;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.MongoTemplate;

import com.mongodb.ConnectionString;
import com.mongodb.MongoClientSettings;
import com.mongodb.WriteConcern;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;


public class BitcoinCollection {
	
	
	public MongoClient mongoClient() {
		//final String combineUrl = "mongodb://id:pass@localhost:26016/?authSource=admin";
		final String combineUrl = "mongodb://id:pass@localhost:27057/?authSource=admin";
		ConnectionString connString = new ConnectionString(combineUrl);
		MongoClientSettings settings = MongoClientSettings.builder().applyConnectionString(connString).retryWrites(true)
				.build();
		MongoClient mongoClient = MongoClients.create(settings);
//		MongoDatabase db = mongoClient.getDatabase("search");
//		MongoCollection<Document> document = db.getCollection("test");

		return mongoClient;
	}
	
	
	public MongoTemplate mongotemp(){

		MongoTemplate mongoTemplate = new MongoTemplate(mongoClient(), "bitcoin");
		mongoTemplate.setWriteConcern(WriteConcern.ACKNOWLEDGED);
		return mongoTemplate;
	}







}
