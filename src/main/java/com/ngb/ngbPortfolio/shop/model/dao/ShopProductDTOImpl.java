package com.ngb.ngbPortfolio.shop.model.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ngb.ngbPortfolio.product.model.dto.ProductDTO;
import com.ngb.ngbPortfolio.shop.model.dto.CartDTO;

@Repository
public class ShopProductDTOImpl implements ShopProductDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<ProductDTO> getSelectAll() {
		return sqlSession.selectList("shop.getSelectAll");
	}
	
	@Override
	public List<ProductDTO> getSelectAllCate(ProductDTO paramDto) {
		return sqlSession.selectList("shop.getSelectAllCate", paramDto);
	}
	
	@Override
	public List<ProductDTO> getSelectAllSearch(ProductDTO paramDto) {
		if(paramDto.getCategoryCode() == 0) {
			return sqlSession.selectList("shop.getSelectAllSearch2", paramDto);
		} else {
			return sqlSession.selectList("shop.getSelectAllSearch", paramDto);
		}
	}
	
	@Override
	public List<ProductDTO> getSearchVendorName(ProductDTO paramDto) {
		return sqlSession.selectList("shop.getSearchVendorName", paramDto);
	}
	
	@Override
	public int getTotalRecordAll(ProductDTO paramDto) {
		return sqlSession.selectOne("shop.getTotalRecordAll", paramDto);
	}
	
	@Override
	public int getTotalRecordSearch(ProductDTO paramDto) {
		if(paramDto.getCategoryCode() == 0) {
			return sqlSession.selectOne("shop.getTotalRecordSearch2", paramDto);
		} else {
			return sqlSession.selectOne("shop.getTotalRecordSearch", paramDto);
		}
	}
	
	@Override
	public int getTotalRecordVendor(ProductDTO paramDto) {
		return sqlSession.selectOne("shop.getTotalRecordVendor", paramDto);
	}
	
	@Override
	public ProductDTO getSelectOne(ProductDTO paramDto) {
		return sqlSession.selectOne("shop.getSelectOne", paramDto);
	}

	@Override
	public CartDTO getSelectOneCart(CartDTO paramDto) {
		return sqlSession.selectOne("shop.getSelectOneCart", paramDto);
	}
	
	@Override
	public List<CartDTO> getSelectAllCart(CartDTO paramDto) {
		return sqlSession.selectList("shop.getSelectAllCart", paramDto);
	}
	
	@Override
	public int searchCart(CartDTO paramDto) {
		int result = 0;
		if(sqlSession.selectOne("shop.searchCart", paramDto) != null) {
			result = sqlSession.selectOne("shop.searchCart", paramDto);
		}
		return result;
	}
	
	@Override
	public int updateAmount(CartDTO paramDto) {
		return sqlSession.update("shop.updateAmount", paramDto);
	}

	@Override
	public int setCartChuga(CartDTO paramDto) {
		return sqlSession.insert("shop.setCartChuga", paramDto);
	}

	@Override
	public int sujungAmount(CartDTO paramDto) {
		return sqlSession.update("shop.sujungAmount", paramDto);
	}

	@Override
	public int sakjeCartOne(CartDTO paramDto) {
		return sqlSession.delete("shop.sakjeCartOne", paramDto);
	}
	
	@Override
	public int sakjeCartOne2(CartDTO paramDto) {
		return sqlSession.delete("shop.sakjeCartOne2", paramDto);
	}
	
	@Override
	public int sakjeCartChecked(String items) {
		return sqlSession.delete("shop.sakjeCartChecked", items);
	}

	@Override
	public int sakjeMemberCart(int memberCode) {
		return sqlSession.delete("shop.sakjeMemberCart", memberCode);
	}

	@Override
	public int updateBuy(CartDTO paramDto) {
		return sqlSession.update("shop.updateBuy", paramDto);
	}

	@Override
	public List<CartDTO> getSelectAllBought(CartDTO paramDto) {
		return sqlSession.selectList("shop.getSelectAllBought", paramDto);
	}
	
}
