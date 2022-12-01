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

}
