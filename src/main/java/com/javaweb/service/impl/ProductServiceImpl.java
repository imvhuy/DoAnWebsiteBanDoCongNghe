package com.javaweb.service.impl;

import com.javaweb.dto.ProductDTO;
import com.javaweb.dto.ProductDetailDTO;
import com.javaweb.entity.GalleryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.SubcategoryValueEntity;
import com.javaweb.repository.IGalleryRepository;
import com.javaweb.repository.IProductRepository;
import com.javaweb.repository.ISubcategoryValueRepository;
import com.javaweb.service.IProductService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ProductServiceImpl implements IProductService {
    @Autowired
    private IProductRepository productRepository;
    @Autowired
    private IGalleryRepository galleryRepository;
    @Autowired
    private ISubcategoryValueRepository subcategoryValueRepository;


    @Override
    public List<ProductDetailDTO> findLatestProductInThisMonth(Date date) {
        return productRepository.findLatestProductInThisMonth(date);
    }

    @Override
    public List<ProductDetailDTO> findTopSellingProducts(Pageable pageable) {
        return productRepository.findTopSellingProducts(pageable);
    }

    @Override
    public List<ProductDetailDTO> findTopTotalRatingProducts(Pageable pageable) {
        return productRepository.findTopTotalRatingProducts(pageable);
    }

    public List<GalleryEntity> getGalleryByProductId(Long productId) {
        return galleryRepository.findByProductEntityId(productId);  // Tìm tất cả ảnh của sản phẩm
    }

    @Override
    public List<ProductEntity> findAllByCategoryEntity_IdAndIsActive(Long categoryId, Boolean isActive) {
        return productRepository.findAllByCategoryEntity_IdAndIsActive(categoryId, isActive);
    }

    @Override
    public Page<ProductEntity> searchProducts(Map<String, String> params, Pageable page) {
        List<SubcategoryValueEntity> subcategoryValueEntities = new ArrayList<>();
        params.forEach((key, value) -> {
            if (value != null && !value.isEmpty()) {
                SubcategoryValueEntity tmp = subcategoryValueRepository.findBySlug(value);
                subcategoryValueEntities.add(tmp);
            }
        });
        Page<ProductEntity> result = productRepository.findBySubCategoryValues(subcategoryValueEntities, page);
        return result;
    }

    @Override
    public Page<ProductEntity> filterProductsByCategoryAndValue(Long id, Map<String, String> params, Pageable page) {
        Set<ProductEntity> result = new HashSet<>();
        List<Set<ProductEntity>> productSets = new ArrayList<>();

        // Biến lưu trữ khoảng giá
        Long minPrice = null;
        Long maxPrice = null;
        String available = "";
        // Duyệt qua tất cả các parameter
        for (Map.Entry<String, String> entry : params.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();

            if (value != null && !value.isEmpty()) {
                switch (key) {
                    case "minPrice":
                        minPrice = Long.parseLong(value);
                        break;
                    case "maxPrice":
                        maxPrice = Long.parseLong(value);
                        break;
                    case "availability":
                        available = value;
                    default:
                        // Tìm SubcategoryValueEntity dựa trên giá trị của parameter
                        SubcategoryValueEntity tmp = subcategoryValueRepository.findBySlug(value);
                        if (tmp != null) {
                            productSets.add(new HashSet<>(tmp.getProducts()));
                        }
                        break;
                }
            }
        }

        // Nếu có ít nhất một danh sách sản phẩm, lấy giao giữa các danh sách
        if (!productSets.isEmpty()) {
            result.addAll(productSets.get(0));
            for (int i = 1; i < productSets.size(); i++) {
                result.retainAll(productSets.get(i));
            }
        } else {
            productSets.add(new HashSet<>(productRepository.findAll()));
            result.addAll(productSets.get(0));
        }

        // Lọc sản phẩm theo khoảng giá nếu có
        if (minPrice != null || maxPrice != null) {
            Long finalMinPrice = minPrice;
            Long finalMaxPrice = maxPrice;
            result.removeIf(product -> {
                Long price = product.getPrice();
                return (finalMinPrice != null && price < finalMinPrice) || (finalMaxPrice != null && price > finalMaxPrice);
            });
        }
        if (available.contains("san-hang")) {
            result.removeIf(ProductEntity::getIsSelling);
        } else {
            result.removeIf(ProductEntity -> !ProductEntity.getIsSelling());
        }

        // Chuyển Set sang List
        List<ProductEntity> resultList = new ArrayList<>(result);

        // Tính toán thông tin phân trang
        int start = (int) page.getOffset();
        int end = Math.min(start + page.getPageSize(), resultList.size());

        // Kiểm tra nếu không có sản phẩm trong trang yêu cầu
        if (start > resultList.size()) {
            return new PageImpl<>(Collections.emptyList(), page, resultList.size());
        }

        // Tạo Page từ danh sách đã phân trang
        return new PageImpl<>(resultList.subList(start, end), page, resultList.size());
    }

    @Override
    public long findMinMaxPriceByCategory(Long categoryId) {
        return productRepository.findMinMaxPriceByCategory(categoryId);
    }

    @Override
    public Page<ProductEntity> findByNameContainingIgnoreCase(String name, Pageable pageable) {
        return productRepository.findByNameContainingIgnoreCase(name, pageable);
    }

    @Override
    public List<ProductEntity> findByNameContainingIgnoreCase(String query) {
        return productRepository.findByNameContainingIgnoreCase(query);
    }

    @Override
    public void delete(ProductEntity entity) {
        productRepository.delete(entity);
    }

    @Override
    public Page<ProductEntity> findByCategoryEntity_IdAndIsActive(Long categoryId, boolean IsActive, Pageable pageable) {
        return productRepository.findByCategoryEntity_IdAndIsActive(categoryId, IsActive, pageable);
    }

    @Override
    public void deleteById(Long id) {
        productRepository.deleteById(id);
    }

    @Override
    public long count() {
        return productRepository.count();
    }

    @Override
    public List<ProductEntity> findAll() {
        return productRepository.findAll();
    }

    @Override
    public ProductEntity getProductById(Long id) {
        Optional<ProductEntity> product = productRepository.findById(id);
        return product.orElseThrow(() -> new RuntimeException("Product not found"));
    }

    @Override
    public <S extends ProductEntity> S save(S entity) {
        if (entity.getId() == null) {
            // Thêm mới
            return productRepository.save(entity);
        } else {
            // Cập nhật
            Optional<ProductEntity> existingProduct = findById(entity.getId());
            if (existingProduct.isPresent()) {
                ProductEntity existing = existingProduct.get();

                // Cập nhật tất cả các trường
                existing.setName(entity.getName());
                existing.setDescription(entity.getDescription());
                existing.setPrice(entity.getPrice());
                existing.setColor(entity.getColor());
                existing.setConfiguration(entity.getConfiguration());
                existing.setPromotionalPrice(entity.getPromotionalPrice());
                existing.setIsActive(entity.getIsActive());
                existing.setIsSelling(entity.getIsSelling());
                existing.setVideo(entity.getVideo());
                existing.setCategoryEntity(entity.getCategoryEntity());

                // Lưu xuống database
                return (S) productRepository.save(existing);
            }
        }
        return productRepository.save(entity);
    }

    @Override
    public Optional<ProductEntity> findById(Long id) {
        return productRepository.findById(id);
    }

    @Override
    public List<ProductEntity> findByNameContaining(String Name) {
        return productRepository.findByNameContaining(Name);
    }

    @Override
    public Page<ProductEntity> findByNameContaining(String Name, Pageable pageable) {
        return productRepository.findByNameContaining(Name, pageable);
    }

    @Override
    public Page<ProductEntity> findAll(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    @Override
    public List<ProductEntity> findAll(Sort sort) {
        return productRepository.findAll(sort);
    }

    @Override
    public List<ProductEntity> findAllById(Iterable<Long> id) {
        return productRepository.findAllById(id);
    }

    @Override
    public void deleteAll() {
        productRepository.deleteAll();
    }

    @Override
    public ProductDTO convertToDTO(ProductEntity entity) {
        ProductDTO model = new ProductDTO();
        BeanUtils.copyProperties(entity, model);

        // Map gallery images
        Map<String, String> gallery = new HashMap<>();
        if (entity.getGalleryEntities() != null) {
            for (GalleryEntity galleryEntity : entity.getGalleryEntities()) {
                gallery.put(galleryEntity.getType(), galleryEntity.getImage());
            }
        }
        model.setGallery(gallery);

        return model;
    }


    @Override
    public Long countTotalAvailableQuantityOfProduct(Long id) {
        return productRepository.countTotalAvailableQuantityOfProduct(id);
    }


    @Override
    public ProductEntity findByIdProductID(Long productId) {
        return productRepository.findById(productId).orElse(null);
    }
    
    //tìm những product có cừng categoryName
    @Override
	public List<ProductDetailDTO> findRelatedProductsByProduct(Long id){
    	String categoryName = productRepository.getProductCategory(id);
    	return productRepository.findRelatedProductsByProduct(categoryName);
    }
}

