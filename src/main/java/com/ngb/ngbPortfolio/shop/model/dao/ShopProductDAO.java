
package com.ngb.ngbPortfolio.shop.model.dao;
import java.util.List;

import com.ngb.ngbPortfolio.product.model.dto.ProductDTO;
import com.ngb.ngbPortfolio.shop.model.dto.CartDTO;

public interface ShopProductDAO {
	public List<ProductDTO> getSelectAll();
	public List<ProductDTO> getSelectAllCate(ProductDTO paramDto);
	public List<ProductDTO> getSelectAllSearch(ProductDTO paramDto);
	public List<ProductDTO> getSearchVendorName(ProductDTO paramDto);
	public int getTotalRecordAll(ProductDTO paramDto);
	public int getTotalRecordSearch(ProductDTO paramDto);
	public int getTotalRecordVendor(ProductDTO paramDto);
	public ProductDTO getSelectOne(ProductDTO paramDto);
	public CartDTO getSelectOneCart(CartDTO paramDto);
	public List<CartDTO> getSelectAllCart(CartDTO paramDto);
	public int searchCart(CartDTO paramDto);
	public int updateAmount(CartDTO paramDto);
	public int setCartChuga(CartDTO paramDto);
	public int sujungAmount(CartDTO paramDto);
	public int sakjeCartOne(CartDTO paramDto);
	public int sakjeCartOne2(CartDTO paramDto);
	public int sakjeCartChecked(String items);
	public int sakjeMemberCart(int memberCode);
	public int updateBuy(CartDTO paramDto);
	public List<CartDTO> getSelectAllBought(CartDTO paramDto);
}
