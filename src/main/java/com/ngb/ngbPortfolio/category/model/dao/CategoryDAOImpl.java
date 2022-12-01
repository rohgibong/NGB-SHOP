package com.ngb.ngbPortfolio.category.model.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ngb.ngbPortfolio.category.model.dto.CategoryDTO;

@Repository
public class CategoryDAOImpl implements CategoryDAO {
	
	@Inject
	SqlSession sqlSession;

	@Override
	public List<CategoryDTO> getSelectAll() {
		return sqlSession.selectList("category.getSelectAll");
	}

	@Override
	public CategoryDTO getSelectOne(CategoryDTO paramDto) {
		return sqlSession.selectOne("category.getSelectOne", paramDto);
	}

	@Override
	public int setInsert(CategoryDTO paramDto) {
		return sqlSession.insert("category.setInsert", paramDto);
	}

	@Override
	public int setUpdate(CategoryDTO paramDto) {
		return sqlSession.update("category.setUpdate", paramDto);
	}

	@Override
	public int setDelete(CategoryDTO paramDto) {
		return sqlSession.delete("category.setDelete", paramDto);
	}

}
