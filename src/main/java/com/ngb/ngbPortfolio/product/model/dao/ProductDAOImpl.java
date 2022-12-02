package com.ngb.ngbPortfolio.product.model.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ngb.ngbPortfolio.product.model.dto.ProductDTO;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<ProductDTO> getSelectAll() {
		return sqlSession.selectList("product.getSelectAll");
	}
	
	@Override
	public List<ProductDTO> getSelectAllPage(ProductDTO paramDto) {
		return sqlSession.selectList("product.getSelectAllPage", paramDto);
	}
	
	@Override
	public List<ProductDTO> getSelectAllSearch(ProductDTO paramDto) {
		if(paramDto.getCategoryCode() == 0) {
			return sqlSession.selectList("product.getSelectAllSearch2", paramDto);
		} else {
			return sqlSession.selectList("product.getSelectAllSearch", paramDto);
		}
	}

	@Override
	public ProductDTO getSelectOne(ProductDTO paramDto) {
		return sqlSession.selectOne("product.getSelectOne", paramDto);
	}

	@Override
	public int setInsert(ProductDTO paramDto) {
		return sqlSession.insert("product.setInsert", paramDto);
	}

	@Override
	public int setUpdate(ProductDTO paramDto) {
		return sqlSession.update("product.setUpdate", paramDto);
	}

	@Override
	public int setDelete(ProductDTO paramDto) {
		return sqlSession.delete("product.setDelete", paramDto);
	}

	@Override
	public int getTotalRecord() {
		return sqlSession.selectOne("product.getTotalRecord");
	}
	
	@Override
	public int getTotalRecordSearch(ProductDTO paramDto) {
		if(paramDto.getCategoryCode() == 0) {
			return sqlSession.selectOne("product.getTotalRecordSearch2", paramDto);
		} else {
			return sqlSession.selectOne("product.getTotalRecordSearch", paramDto);
		}
	}

}
