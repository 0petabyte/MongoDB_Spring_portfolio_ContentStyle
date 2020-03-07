package com.peta.config;

import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;

import com.mongodb.WriteConcern;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;

public class MongoDBGET {
	@Autowired
	private MongoClient mongoClient;

	public com.mongodb.client.MongoCollection<Document> getCollection() {

		MongoDatabase db = mongoClient.getDatabase("search");

		com.mongodb.client.MongoCollection<Document> target = db.getCollection("test")
				.withWriteConcern(WriteConcern.MAJORITY);

		return target;

	}
}
