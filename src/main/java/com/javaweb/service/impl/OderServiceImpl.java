package com.javaweb.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaweb.dto.*;
import com.javaweb.entity.*;
import com.javaweb.service.*;
import com.javaweb.repository.*;
@Service
public class OderServiceImpl implements IOrderService{
	@Autowired
	IGeocodingService geocodingService;
	@Autowired
	IStoreService storeService;
	@Autowired
	IUserService userService;
	@Autowired
	IPaymentService paymentService;
	@Autowired
	ITransactionService transactionService;
	@Autowired
	ICarrierService carrierService;
	@Autowired
	IStoreProductService storeProductService;
	@Autowired
	ICartService cartService;
	@Autowired
	ICartItemService cartItemService;
	@Autowired
	IAddressService addressService;
	@Autowired
	IProductService productService;

	@Autowired
	IOrderItemService orderItemService;
	@Autowired
	IOrderRepository orderRepository;

	public StoreEntity findNearestStore(UserEntity user, List<StoreEntity> stores,Long userAddressId) {
		//
		AddressEntity userAddress = addressService.findByIdNotOptional(userAddressId);
		
		GeocodingResultDTO userAddressGeocoding = geocodingService.getCoordinates(userAddress.getAddress());
		
		StoreEntity nearestStore = null;
        double shortestDistance = Double.MAX_VALUE;

        // Duyệt qua danh sách tất cả các store và tính khoảng cách với user
        for (StoreEntity store : stores) {
        	GeocodingResultDTO storeAddressGeocoding = geocodingService.getCoordinates(store.getAddress());
            double distance = geocodingService.calculateDistance(Double.parseDouble(userAddressGeocoding.getLat()), 
            		Double.parseDouble(userAddressGeocoding.getLon()), Double.parseDouble(storeAddressGeocoding.getLat()),Double.parseDouble( storeAddressGeocoding.getLon()));

            // Kiểm tra xem store này có khoảng cách gần hơn store hiện tại không
            if (distance < shortestDistance) {
                nearestStore = store;
                shortestDistance = distance;
            }
        }

        return nearestStore;
    }
	//Tạo đơn hàng cho store gần nhất
	@Override
	public Boolean createOrderForStore(UserEntity user,Long userAddressId) {
        //lấy địa chỉ của khách hàng
        AddressEntity userAddress = addressService.findByIdNotOptional(userAddressId);

        // Tìm store gần nhất
		List<StoreEntity> stores = storeService.findAll();
        StoreEntity nearestStore = findNearestStore(user, stores, userAddressId);

        // Tạo đơn hàng cho store gần nhất
        OrderEntity order = new OrderEntity();
        if (nearestStore != null) {
            order.setStoreId(nearestStore.getId()); // Gán store gần nhất vào đơn hàng
            order.setUser(user);
            order.setAddress(userAddress.getAddress());
            orderRepository.save(order);
            return true;
            // Tiến hành các bước tạo đơn hàng khác (ví dụ: lưu vào cơ sở dữ liệu)
        }

        return false;
    }
	//Trương hợp đặt hàng khi user đang trong giỏ hàng
	//nhóm các cartItem theo các store, tìm các store có đủ quantity của cartItem
	public Map<Long, List<CartProductDTO>> groupCartItemsByStore(Long userId,AddressEntity userAddress) {
	    List<CartProductDTO> cartItems = cartService.findCartItemsByUser(userId);
	    Map<Long, List<CartProductDTO>> storeCartMap = new HashMap<>();

	    for (CartProductDTO item : cartItems) {
	        List<StoreEntity> stores = storeProductService.findStoresByProductIdAndQuantity(
	            item.getId(),
	            item.getQuantity()
	        );

	        if (!stores.isEmpty()) {
	    		//
	    		GeocodingResultDTO userAddressGeocoding = geocodingService.getCoordinates(userAddress.getAddress());
	    		
	    		StoreEntity nearestStore = null;
	            double shortestDistance = Double.MAX_VALUE;
	        	// Duyệt qua danh sách tất cả các store và tính khoảng cách với user
	            for (StoreEntity store : stores) {
	            	GeocodingResultDTO storeAddressGeocoding = geocodingService.getCoordinates(store.getAddress());
	                double distance = geocodingService.calculateDistance(Double.parseDouble(userAddressGeocoding.getLat()), 
	                		Double.parseDouble(userAddressGeocoding.getLon()), Double.parseDouble(storeAddressGeocoding.getLat()),Double.parseDouble( storeAddressGeocoding.getLon()));

	                // Kiểm tra xem store này có khoảng cách gần hơn store hiện tại không
	                if (distance < shortestDistance) {
	                	nearestStore = store;
	                    shortestDistance = distance;
	                }
	            }
	            //Long storeId = stores.get(0).getId(); // Chọn store đầu tiên (ưu tiên store có sản phẩm)
	            //Chọn store gần nhất và có sản phẩm
	            Long storeId = nearestStore.getId(); 
	            storeCartMap.computeIfAbsent(storeId, k -> new ArrayList<>()).add(item);
	        } else {
	            throw new RuntimeException("No store has enough quantity for product: " + item.getId());
	        }
	    }

	    return storeCartMap;
	}
	//Trương hợp đặt hàng khi user đang trong giỏ hàng
	//Tạo các order sau khi nhóm các cartItem theo stores
	@Override
	public void createOrders(Long userId,Long carrierId,Long address,String method) {
		//biến lưu tổng tiền(amount_from_user)
		Long totalAmount = 0L;
		//lấy địa chỉ của khách hàng
        AddressEntity userAddress = addressService.findByIdNotOptional(address);
		//user
		UserEntity user = userService.findByIdNotOptional(userId);
		//danh sách store:list product
	    Map<Long, List<CartProductDTO>> storeCartMap = groupCartItemsByStore(userId,userAddress);
	    //Số lượng store
	    int count = storeCartMap.size();
	    //lấy carrier
	    CarrierEntity carrier = carrierService.findById(carrierId).get();
	    //Tổng tiền ship sau khi cộng thêm 50000 phí thêm
	    Long shippingFee = (carrier.getPrice() + 50000)/count;
	    for (Map.Entry<Long, List<CartProductDTO>> entry : storeCartMap.entrySet()) {
	        Long storeId = entry.getKey();
	        List<CartProductDTO> items = entry.getValue();

	        // Tạo Order
	        OrderEntity order = new OrderEntity();
	        order.setUser(user);
	        order.setStoreId(storeId);
	        order.setAddress(userAddress.getAddress());
	      //lưu order
	        orderRepository.save(order);
	        //reset biến
	        totalAmount = 0L;
	        // Tạo OrderItem
	        for (CartProductDTO item : items) {
	        	totalAmount += item.getPrice() * item.getQuantity();
	        	//tìm product theo id
	        	ProductEntity product = productService.findByIdProductID(item.getId());
	        	//tạo order item ứng với mỗi cart item
	            OrderItemEntity orderItem = new OrderItemEntity();
	            orderItem.setOrder(order);
	            orderItem.setProduct(product);
	            orderItem.setCount(Integer.parseInt(item.getQuantity().toString()));
	            orderItemService.save(orderItem);

	            // Thay đổi số lượng trong kho (quantity, sold)
	            storeProductService.updateQuantityAfterUserPlaceOrderItem(storeId, item.getId(), item.getQuantity());
	        }
	        totalAmount +=shippingFee;
	        //tiền phải thu từ user
	        order.setAmountFromUser(Double.parseDouble(totalAmount.toString()));
	        //tiền cho carrier
	        order.setAmountToGD(Double.parseDouble(carrier.getPrice().toString()));
	        //tiền cho store
	        Long amountToStore = totalAmount- carrier.getPrice();
	        order.setAmountToStore(Double.parseDouble(amountToStore.toString()));
	        order.setStatus("chờ vận chuyển");
	        //lưu order
	        orderRepository.save(order);
	        //Lưu transaction
	        TransactionEntity transaction = new TransactionEntity();
	        transaction.setAmount(Double.parseDouble(totalAmount.toString()));
	        //đang lưu đối với trả bằng tiền mặt
	        transaction.setIsPaid(false);
	        transaction.setOrder(order);
	        //lấy payment
	        PaymentEntity payment = paymentService.findPaymentEntityByUserAndMethod(user, method);
	        transaction.setPayment(payment);
	        transactionService.save(transaction);
	    }
	    //Tìm cart của user
	    CartEntity cart = cartService.findCartByUser(user);
	    //Xóa tất cả cartItem trong giỏ hàng sau khi user đặt hàng xong
	    cartItemService.deleteAllByCart(cart);
	}


}
