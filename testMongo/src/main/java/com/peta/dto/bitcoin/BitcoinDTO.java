package com.peta.dto.bitcoin;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Days_Sum_book")
public class BitcoinDTO {
	private String id;
	private String coinname;
	private int days;
	private long bid_total_24;
	private long ask_total_24;
	private long bidqtyToday;
	private long askqtyToday;
	private String exchange;
	private long askbidvolumeToday;
	private long sum_total_24;
	private double torate;
	private double volume;
	private long closeprice;
	
	
	
	
	public double getTorate() {
		return torate;
	}
	public void setTorate(double torate) {
		this.torate = torate;
	}
	public double getVolume() {
		return volume;
	}
	public void setVolume(double volume) {
		this.volume = volume;
	}
	public long getCloseprice() {
		return closeprice;
	}
	public void setCloseprice(long closeprice) {
		this.closeprice = closeprice;
	}
	public long getAskbidvolumeToday() {
		return askbidvolumeToday;
	}
	public void setAskbidvolumeToday(long askbidvolumeToday) {
		this.askbidvolumeToday = askbidvolumeToday;
	}
	public long getSum_total_24() {
		return sum_total_24;
	}
	public void setSum_total_24(long sum_total_24) {
		this.sum_total_24 = sum_total_24;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCoinname() {
		return coinname;
	}
	public void setCoinname(String coinname) {
		this.coinname = coinname;
	}
	public int getDays() {
		return days;
	}
	public void setDays(int days) {
		this.days = days;
	}
	public long getBid_total_24() {
		return bid_total_24;
	}
	public void setBid_total_24(long bid_total_24) {
		this.bid_total_24 = bid_total_24;
	}
	public long getAsk_total_24() {
		return ask_total_24;
	}
	public void setAsk_total_24(long ask_total_24) {
		this.ask_total_24 = ask_total_24;
	}
	public long getBidqtyToday() {
		return bidqtyToday;
	}
	public void setBidqtyToday(long bidqtyToday) {
		this.bidqtyToday = bidqtyToday;
	}
	public long getAskqtyToday() {
		return askqtyToday;
	}
	public void setAskqtyToday(long askqtyToday) {
		this.askqtyToday = askqtyToday;
	}
	public String getExchange() {
		return exchange;
	}
	public void setExchange(String exchange) {
		this.exchange = exchange;
	}
	
	
	
}
