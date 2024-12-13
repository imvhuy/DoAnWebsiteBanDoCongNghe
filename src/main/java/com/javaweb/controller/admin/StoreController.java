package com.javaweb.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.javaweb.dto.GalleryDTO;
import com.javaweb.entity.*;
import com.javaweb.service.ICommissionService;
import com.javaweb.service.IGalleryService;
import com.javaweb.service.IProductService;
import com.javaweb.service.IStoreLevelService;
import com.javaweb.service.IStoreProductService;
import com.javaweb.service.IStoreService;

@Controller("StoreOfAdmin")
@RequestMapping(value = "/admin/stores")
public class StoreController {

	@Autowired
	private IStoreService storeService;
	@Autowired
	private IStoreLevelService storeLevelService;

	@Autowired
	private IStoreProductService storeProductService;
	@Autowired

	private IProductService productService;
	@Autowired
	private ICommissionService commissionService;
	@Autowired
	private IGalleryService galleryServiceImpl;

	// Hiển thị danh sách cửa hàng với phân trang và tìm kiếm theo tên cửa hàng
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@GetMapping // Cập nhật đường dẫn cho phù hợp với base URL
	public String list(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "5") int size,
			@RequestParam(value = "storeName", required = false) String storeName, ModelMap model) {

		// Đảm bảo page bắt đầu từ 1
		page = Math.max(page, 1); // Đảm bảo page không nhỏ hơn 1

		Pageable pageable = PageRequest.of(page - 1, size); // PageRequest bắt đầu từ 0
		Page<StoreEntity> storePage;

		// Kiểm tra nếu có tham số storeName, tìm kiếm theo tên cửa hàng
		if (storeName != null && !storeName.trim().isEmpty()) {
			storePage = storeService.findByStoreName(storeName, pageable);
			model.addAttribute("storeName", storeName); // Truyền giá trị tìm kiếm vào model
		} else {
			storePage = storeService.findAll(pageable); // Lấy tất cả cửa hàng nếu không có tìm kiếm
		}

		// Thêm các thông tin phân trang và dữ liệu vào model
		model.addAttribute("storePage", storePage);
		model.addAttribute("stores", storePage.getContent()); // Danh sách cửa hàng
		model.addAttribute("totalPages", storePage.getTotalPages()); // Tổng số trang
		model.addAttribute("totalElements", storePage.getTotalElements()); // Tổng số phần tử
		model.addAttribute("currentPage", page); // Trang hiện tại
		model.addAttribute("size", size); // Số lượng phần tử trên mỗi trang

		return "admin/stores/store-list"; // Trả về view hiển thị danh sách cửa hàng
	}

	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@GetMapping("edit/{id}")
	public ModelAndView editStore(@PathVariable("id") Long storeId, ModelMap model) {
		// Tìm cửa hàng theo ID
		StoreEntity storeEntity = storeService.findById(storeId)
				.orElseThrow(() -> new RuntimeException("Store not found"));

		// Lấy điểm của cửa hàng
		int storePoints = storeEntity.getPoint(); // Điều chỉnh theo trường thực tế của StoreEntity

		// Tìm cấp độ của cửa hàng từ bảng storelevel
		StoreLevelEntity storeLevel = storeLevelService.findByMinPoint(storePoints);

		// Thêm cửa hàng và cấp độ vào model
		model.addAttribute("store", storeEntity);
		model.addAttribute("storeLevel", storeLevel); // Lưu tên cấp độ vào model
		model.addAttribute("editMode", true); // Đánh dấu chế độ chỉnh sửa

		return new ModelAndView("admin/stores/addOrEdit", model); // Trả về View cho trang chỉnh sửa cửa hàng
	}

	@GetMapping("delete/{id}")
	public ModelAndView delete(@PathVariable("id") Long id, RedirectAttributes model) {
		Optional<StoreEntity> optionalStore = storeService.findById(id);

		if (optionalStore.isEmpty()) {
			return new ModelAndView("redirect:/admin/stores");
		}
		storeService.deleteById(id); // Xóa voucher
		commissionService.deleteById(optionalStore.get().getCommission().getId());
		return new ModelAndView("redirect:/admin/stores"); // Quay lại danh sách promotion
	}

	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(@ModelAttribute("store") StoreEntity storeEntity, RedirectAttributes model) {
		try {
			// Kiểm tra xem cửa hàng có ID (cập nhật) hay không
			if (storeEntity.getId() != null) {
				// Tìm cửa hàng theo ID
				StoreEntity existingStore = storeService.findById(storeEntity.getId())
						.orElseThrow(() -> new RuntimeException("Store not found"));

				// Cập nhật chỉ trường isActive
				existingStore.setIsActive(storeEntity.getIsActive());

				// Lưu lại cửa hàng đã cập nhật
				storeService.save(existingStore);

			}
		} catch (Exception e) {
			// Thêm thông báo lỗi
			model.addFlashAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
		}

		// Chuyển hướng về trang danh sách cửa hàng
		return new ModelAndView("redirect:/admin/stores");

	}

//@PreAuthorize("hasAuthority('ROLE_ADMIN')")
//	@GetMapping("/checkproduct/{storeId}")
//	public String checkProduct(@PathVariable Long storeId,
//	                           @RequestParam(defaultValue = "1") int page,
//	                           @RequestParam(defaultValue = "5") int size,
//	                           @RequestParam(value = "productName", required = false) String productName,
//	                           Model model) {
//	    // Đảm bảo page bắt đầu từ 1
//	    page = Math.max(page, 1); // Đảm bảo page không nhỏ hơn 1
//	    Pageable pageable = PageRequest.of(page - 1, size); // PageRequest bắt đầu từ 0
//
//	    Page<StoreProductEntity> storeProductPage;
//
//	    // Kiểm tra nếu có tham số productName, tìm kiếm theo tên sản phẩm
//	    if (productName != null && !productName.trim().isEmpty()) {
//	        storeProductPage = storeProductService.findByStoreIdAndProductName(storeId, productName, pageable);
//	        model.addAttribute("productName", productName); // Truyền giá trị tìm kiếm vào model
//	    } else {
//	        storeProductPage = storeProductService.findByStoreId(storeId, pageable); // Lấy tất cả sản phẩm của cửa hàng nếu không có tìm kiếm
//	    }
//
//	    // Lấy thông tin sản phẩm từ StoreProductEntity
//	    List<ProductEntity> products = storeProductService.getProductsByStore(storeId);
//
//	    // Thêm vào model để truyền dữ liệu vào JSP
//	    model.addAttribute("storeId", storeId);
//	    model.addAttribute("products", products);
//	    model.addAttribute("storeProductPage", storeProductPage); // Dữ liệu phân trang
//	    model.addAttribute("totalPages", storeProductPage.getTotalPages()); // Tổng số trang
//	    model.addAttribute("totalElements", storeProductPage.getTotalElements()); // Tổng số phần tử
//	    model.addAttribute("currentPage", page); // Trang hiện tại
//	    model.addAttribute("size", size); // Số lượng phần tử trên mỗi trang
//
//	    return "admin/stores/checkproduct"; // Trả về view tương ứng
//	}

	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@GetMapping("/checkproduct/{storeId}")
	public String checkProduct(@PathVariable Long storeId, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int size, @RequestParam(value = "name", required = false) String name,
			Model model) {
		// Đảm bảo page bắt đầu từ 1
		page = Math.max(page, 1); // Đảm bảo page không nhỏ hơn 1
		Pageable pageable = PageRequest.of(page - 1, size); // PageRequest bắt đầu từ 0

		Page<StoreProductEntity> storeProductPage;

		// Kiểm tra nếu có tham số productName, tìm kiếm theo tên sản phẩm
		if (name != null && !name.trim().isEmpty()) {
			storeProductPage = storeProductService.findByStoreIdAndProductName(storeId, name, pageable);
			model.addAttribute("name", name); // Truyền giá trị tìm kiếm vào model
		} else {
			storeProductPage = storeProductService.findByStoreId(storeId, pageable); // Lấy tất cả sản phẩm của cửa hàng
																						// nếu không có tìm kiếm
		}

		// Lấy danh sách các sản phẩm đã phân trang từ StoreProductEntity
		// Page<ProductEntity> products =
		// storeProductService.findProductsByStoreAndPage(storeId, pageable);
		StoreEntity storeEntity = storeService.findById(storeId)
				.orElseThrow(() -> new RuntimeException("Store not found"));
		// Page <StoreProductEntity> StoreProducts =
		// storeProductService.findByStoreId(storeId, pageable);
		// Thêm vào model để truyền dữ liệu vào JSP
		model.addAttribute("StoreProducts", storeProductPage.getContent());
		model.addAttribute("storeName", storeEntity.getName());
		model.addAttribute("storeId", storeId);
		// model.addAttribute("products", products.getContent()); // Truyền sản phẩm đã
		// phân trang
		model.addAttribute("storeProductPage", storeProductPage); // Dữ liệu phân trang
		model.addAttribute("totalPages", storeProductPage.getTotalPages()); // Tổng số trang
		model.addAttribute("totalElements", storeProductPage.getTotalElements()); // Tổng số phần tử
		model.addAttribute("currentPage", page); // Trang hiện tại
		model.addAttribute("size", size); // Số lượng phần tử trên mỗi trang

		return "admin/stores/checkproduct"; // Trả về view tương ứng
	}

	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@GetMapping("/viewProduct/{storeproductID}")
	public ModelAndView viewProduct(@PathVariable("storeproductID") Long storeproductID, ModelMap model) {
		StoreProductEntity storeProductEntity = storeProductService.findById(storeproductID);

		ProductEntity product = productService.getProductById(storeProductEntity.getProduct().getId());

		// Kiểm tra nếu sản phẩm không tồn tại (Có thể trả về 404 hoặc thông báo lỗi tùy
		// bạn)
		if (product == null) {
			model.addAttribute("error", "Product not found");
			return new ModelAndView("error/404", model); // View lỗi 404
		}

		// Lấy danh sách ảnh từ GalleryEntity dựa trên product ID
		List<GalleryEntity> galleryList = galleryServiceImpl.findByProductId(product.getId());

		// Chuyển đổi từ GalleryEntity thành DTO nếu cần thiết
		List<GalleryDTO> galleryDTOList = galleryList.stream()
				.map(gallery -> new GalleryDTO(gallery.getImage(), gallery.getType())).collect(Collectors.toList());

		// Thêm thông tin sản phẩm vào ModelMap để view có thể sử dụng
		model.addAttribute("product", product);
		model.addAttribute("storeProductEntity", storeProductEntity);
		model.addAttribute("storeID", storeProductEntity.getStore().getId());
		model.addAttribute("galleries", galleryDTOList); // Thêm danh sách ảnh vào model
		// Trả về ModelAndView với tên view "productdetail" và dữ liệu model đã được
		// thêm
		return new ModelAndView("admin/stores/productdetail", model);
	}

	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@GetMapping("/addProduct/{storeId}")
	public String showAddProductForm(@PathVariable("storeId") Long storeId, Model model) {
		// Lấy danh sách sản phẩm từ service
		List<ProductEntity> products = productService.findAll();

		// Truyền danh sách sản phẩm và storeId vào model
		model.addAttribute("storeId", storeId);
		model.addAttribute("products", products); // Danh sách sản phẩm để hiển thị trong dropdown

		// Trả về trang form thêm sản phẩm vào cửa hàng
		return "admin/stores/addProduct";
	}
	
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@GetMapping("/SelectedAddProduct/{storeId}/{productId}")
	public String selectedAddProduct(@PathVariable Long storeId, 
	                                  @PathVariable Long productId, 
	                                  Model model) {
	    // Debug log để kiểm tra giá trị
	    System.out.println("Store ID: " + storeId);
	    System.out.println("Product ID: " + productId);

	    // Lấy danh sách tất cả sản phẩm để hiển thị trong dropdown
	    List<ProductEntity> products = productService.findAll();

	    // Lấy thông tin cửa hàng
	    StoreEntity store = storeService.findById(storeId)
	        .orElseThrow(() -> new RuntimeException("Store not found with ID: " + storeId));

	    // Lấy thông tin sản phẩm được chọn
	    ProductEntity selectedProduct = productService.getProductById(productId);

	    // Truyền dữ liệu vào Model
	    model.addAttribute("store", store); // Cửa hàng hiện tại
	    model.addAttribute("product", selectedProduct); // Sản phẩm được chọn
	    model.addAttribute("products", products); // Danh sách sản phẩm
	    model.addAttribute("selectedProductId", productId); // ID sản phẩm được chọn

	    // Trả về tên file JSP
	    return "admin/stores/addProduct";
	}
	@PreAuthorize("hasAuthority('ROLE_ADMIN')")
	@PostMapping("/addProduct")
	public String addProductToStore(
	    @RequestParam("storeId") Long storeId, 
	    @RequestParam("productSelect") Long productId, 
	    @RequestParam("quantityInput") Integer quantity, 
	    RedirectAttributes redirectAttributes) {

	    // Debug log để kiểm tra giá trị nhận được
	    System.out.println("Store ID: " + storeId);
	    System.out.println("Product ID: " + productId);
	    System.out.println("Quantity: " + quantity);

	    // Lấy thông tin cửa hàng
	    StoreEntity store = storeService.findById(storeId)
	        .orElseThrow(() -> new RuntimeException("Store not found with ID: " + storeId));

	    // Lấy thông tin sản phẩm
	    ProductEntity product = productService.getProductById(productId);

	    // Tạo mới StoreProductEntity
	    StoreProductEntity storeProduct = new StoreProductEntity();
	    storeProduct.setStore(store);
	    storeProduct.setProduct(product);
	    storeProduct.setQuantity(quantity);
	    storeProduct.setSold(0); // Ban đầu số lượng đã bán là 0

	    // Lưu vào database
	    storeProductService.save(storeProduct);

	    // Thêm thông báo hoặc chuyển hướng
	    redirectAttributes.addFlashAttribute("message", "Product added successfully!");
	    return "redirect:/admin/stores/checkproduct/" + storeId;
	}




}
