package com.peta.dto.bitcoin;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Days_Sum_All")
public class BitcoinMainDTO {
	private String id;
	private String coinname;
	private long askqty;
	private long asktotal;
	private long bidqty;
	private long bidtotal;
	private String exchange;
	private double rate_7day;
	private double rate_14day;
	private long total_7day;
	private long total_14day;
	private long volume;
	private String url;
	private String title;
	private int eventday;
	private long total_30day;
	private double rate_30day;
	
	
	
	
	public long getTotal_30day() {
		return total_30day;
	}
	public void setTotal_30day(long total_30day) {
		this.total_30day = total_30day;
	}
	public double getRate_30day() {
		return rate_30day;
	}
	public void setRate_30day(double rate_30day) {
		this.rate_30day = rate_30day;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public int getEventday() {
		return eventday;
	}
	public void setEventday(int eventday) {
		this.eventday = eventday;
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
	public long getAskqty() {
		return askqty;
	}
	public void setAskqty(long askqty) {
		this.askqty = askqty;
	}
	public long getAsktotal() {
		return asktotal;
	}
	public void setAsktotal(long asktotal) {
		this.asktotal = asktotal;
	}
	public long getBidqty() {
		return bidqty;
	}
	public void setBidqty(long bidqty) {
		this.bidqty = bidqty;
	}
	public long getBidtotal() {
		return bidtotal;
	}
	public void setBidtotal(long bidtotal) {
		this.bidtotal = bidtotal;
	}
	public String getExchange() {
		return exchange;
	}
	public void setExchange(String exchange) {
		this.exchange = exchange;
	}


	public double getRate_7day() {
		return rate_7day;
	}
	public void setRate_7day(double rate_7day) {
		this.rate_7day = rate_7day;
	}
	public double getRate_14day() {
		return rate_14day;
	}
	public void setRate_14day(double rate_14day) {
		this.rate_14day = rate_14day;
	}
	public long getTotal_7day() {
		return total_7day;
	}
	public void setTotal_7day(long total_7day) {
		this.total_7day = total_7day;
	}
	public long getTotal_14day() {
		return total_14day;
	}
	public void setTotal_14day(long total_14day) {
		this.total_14day = total_14day;
	}
	public long getVolume() {
		return volume;
	}
	public void setVolume(long volume) {
		this.volume = volume;
	}
	
	
	
}
