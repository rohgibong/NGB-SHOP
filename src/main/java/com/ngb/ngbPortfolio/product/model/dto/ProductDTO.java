package com.ngb.ngbPortfolio.product.model.dto;

import java.sql.Date;

public class ProductDTO {
	private int productCode;
	private String productName;
	private String productDetailName;
	private int productPrice;
	private String productDescription;
	private String vendorName;
	private String attachInfo;
	private Date regiDate;
	private String useable;
	private int categoryCode;
	private int deliveryPeriod;
	private int deliveryPrice;
	private String deliveryArea;
	private Date arrivalDate;
	
	private String searchGubun;
	private String searchData;
	private int startRecord;
	private int lastRecord;
	
	public int getProductCode() {
		return productCode;
	}
	public void setProductCode(int productCode) {
		this.productCode = productCode;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductDetailName() {
		return productDetailName;
	}
	public void setProductDetailName(String productDetailName) {
		this.productDetailName = productDetailName;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public String getProductDescription() {
		return productDescription;
	}
	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	public String getVendorName() {
		return vendorName;
	}
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}
	public String getAttachInfo() {
		return attachInfo;
	}
	public void setAttachInfo(String attachInfo) {
		this.attachInfo = attachInfo;
	}
	public Date getRegiDate() {
		return regiDate;
	}
	public void setRegiDate(Date regiDate) {
		this.regiDate = regiDate;
	}
	public String getUseable() {
		return useable;
	}
	public void setUseable(String useable) {
		this.useable = useable;
	}
	public int getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}
	public int getDeliveryPeriod() {
		return deliveryPeriod;
	}
	public void setDeliveryPeriod(int deliveryPeriod) {
		this.deliveryPeriod = deliveryPeriod;
	}
	public int getDeliveryPrice() {
		return deliveryPrice;
	}
	public void setDeliveryPrice(int deliveryPrice) {
		this.deliveryPrice = deliveryPrice;
	}
	public String getDeliveryArea() {
		return deliveryArea;
	}
	public void setDeliveryArea(String deliveryArea) {
		this.deliveryArea = deliveryArea;
	}
	public Date getArrivalDate() {
		return arrivalDate;
	}
	public void setArrivalDate(Date arrivalDate) {
		this.arrivalDate = arrivalDate;
	}
	public String getSearchGubun() {
		return searchGubun;
	}
	public void setSearchGubun(String searchGubun) {
		this.searchGubun = searchGubun;
	}
	public String getSearchData() {
		return searchData;
	}
	public void setSearchData(String searchData) {
		this.searchData = searchData;
	}
	public int getStartRecord() {
		return startRecord;
	}
	public void setStartRecord(int startRecord) {
		this.startRecord = startRecord;
	}
	public int getLastRecord() {
		return lastRecord;
	}
	public void setLastRecord(int lastRecord) {
		this.lastRecord = lastRecord;
	}
	
}
