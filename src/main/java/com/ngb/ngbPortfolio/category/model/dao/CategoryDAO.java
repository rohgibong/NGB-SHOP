package com.ngb.ngbPortfolio.category.model.dao;

import java.util.List;

import com.ngb.ngbPortfolio.category.model.dto.CategoryDTO;

public interface CategoryDAO {
	public List<CategoryDTO> getSelectAll();
	public CategoryDTO getSelectOne(CategoryDTO paramDto);
	public int setInsert(CategoryDTO paramDto);
	public int setUpdate(CategoryDTO paramDto);
	public int setDelete(CategoryDTO paramDto);
}
