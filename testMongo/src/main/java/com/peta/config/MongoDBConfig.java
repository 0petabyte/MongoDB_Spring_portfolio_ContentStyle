package com.peta.config;

import org.bson.Document;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.MongoTemplate;

import com.mongodb.ConnectionString;
import com.mongodb.MongoClientSettings;
import com.mongodb.WriteConcern;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

@Configuration
public class MongoDBConfig {

	public @Bean MongoClient mongoClient() {
		//final String combineUrl = "mongodb://id:pass@localhost:26016/?authSource=admin";
		final String combineUrl = "mongodb://id:pass@localhost:26016/?authSource=admin";
		ConnectionString connString = new ConnectionString(combineUrl);
		MongoClientSettings settings = MongoClientSettings.builder().applyConnectionString(connString).retryWrites(true)
				.build();
		MongoClient mongoClient = MongoClients.create(settings);
//		MongoDatabase db = mongoClient.getDatabase("search");
//		MongoCollection<Document> document = db.getCollection("test");

		return mongoClient;
	}

	public @Bean MongoDatabase get2Collection() {
		MongoClient mongoClient = mongoClient();
		MongoDatabase db = mongoClient.getDatabase("search");
//		MongoCollection<Document> target = db.getCollection("test")
//				.withWriteConcern(WriteConcern.MAJORITY);
		
		return db;
		
	}
	
	@Bean
	public MongoTemplate mongoTemplate2() throws Exception {
		MongoTemplate mongoTemplate = new MongoTemplate(mongoClient(), "search");
		mongoTemplate.setWriteConcern(WriteConcern.ACKNOWLEDGED);
		return mongoTemplate;
	}
	

	
//	@Bean
//	public MongoTemplate mongoTemplate2() throws Exception {
//		return new MongoTemplate(mongoClient(), "search");
//	}

}