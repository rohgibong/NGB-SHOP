package com.ngb.ngbPortfolio.shop.model.dto;

import java.sql.Date;

public class CartDTO {
	private int cartNo;
	private int memberCode;
	private int productCode;
	private int productAmount;
	private String buyOX;
    private Date regiDate;
	
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public int getMemberCode() {
		return memberCode;
	}
	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}
	public int getProductCode() {
		return productCode;
	}
	public void setProductCode(int productCode) {
		this.productCode = productCode;
	}
	public int getProductAmount() {
		return productAmount;
	}
	public void setProductAmount(int productAmount) {
		this.productAmount = productAmount;
	}
	public String getBuyOX() {
		return buyOX;
	}
	public void setBuyOX(String buyOX) {
		this.buyOX = buyOX;
	}
	public Date getRegiDate() {
		return regiDate;
	}
	public void setRegiDate(Date regiDate) {
		this.regiDate = regiDate;
	}
	
}
