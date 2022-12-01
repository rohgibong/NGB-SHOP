package com.ngb.ngbPortfolio.product.model.dao;

import java.util.List;

import com.ngb.ngbPortfolio.product.model.dto.ProductDTO;

public interface ProductDAO {
	public List<ProductDTO> getSelectAll();
	public List<ProductDTO> getSelectAllPage(ProductDTO paramDto);
	public List<ProductDTO> getSelectAllSearch(ProductDTO paramDto);
	public ProductDTO getSelectOne(ProductDTO paramDto);
	public int setInsert(ProductDTO paramDto);
	public int setUpdate(ProductDTO paramDto);
	public int setDelete(ProductDTO paramDto);
	public int getTotalRecord();
	public int getTotalRecordSearch(ProductDTO paramDto);
}
