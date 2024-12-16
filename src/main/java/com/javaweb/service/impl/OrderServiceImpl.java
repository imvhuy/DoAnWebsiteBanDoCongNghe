package com.javaweb.service.impl;

import com.javaweb.dto.*;
import com.javaweb.entity.*;
import com.javaweb.repository.IOrderRepository;
import com.javaweb.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class OrderServiceImpl implements IOrderService{
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
	IPromotionService promotionService;
	@Autowired
	IPromotionCustomerService promotionCustomerService;
	@Autowired
	IOrderItemService orderItemService;
	@Autowired
	IOrderRepository orderRepository;
    @Autowired
    private INotificationService notificationServiceImpl;
    @Autowired
    IDeliveryService deliveryService;
    @Autowired
    IShipperCarrierService shipperCarrierService;

    public StoreEntity findNearestStore(UserEntity user, List<StoreEntity> stores, Long userAddressId) {
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

    public UserEntity findNearestShipper( List<UserEntity> shippers, String orderAddress) {
        //
       // AddressEntity orderAddress = addressService.findByIdNotOptional(orderAddressId);

        GeocodingResultDTO orderAddressGeocoding = geocodingService.getCoordinates(orderAddress);

        UserEntity nearestShipper = null;
        double shortestDistance = Double.MAX_VALUE;
        System.out.println(shippers.size() + "so luong");
        // Duyệt qua danh sách tất cả các shipper và tính khoảng cách với user
        for (UserEntity shipper : shippers) {
            System.out.println(shipper.getAddressEntities() + " danh sách");
            System.out.println(shipper.getId() + "ngocthao");
            System.out.println(userService.getAddressOfShipper(shipper.getId()) + "address");
            GeocodingResultDTO shipperAddressGeocoding = geocodingService.getCoordinates(userService.getAddressOfShipper(shipper.getId()));
            double distance = geocodingService.calculateDistance(Double.parseDouble(orderAddressGeocoding.getLat()),
                    Double.parseDouble(orderAddressGeocoding.getLon()), Double.parseDouble(shipperAddressGeocoding.getLat()),Double.parseDouble( shipperAddressGeocoding.getLon()));

            // Kiểm tra xem store này có khoảng cách gần hơn store hiện tại không
            if (distance < shortestDistance) {
                nearestShipper = shipper;
                shortestDistance = distance;
            }
        }

        return nearestShipper;
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
	public void createOrders(Long userId,Long carrierId,Long address,String method,Long voucherId) {
		//lấy voucher
		VoucherEntity voucher = promotionService.findById(voucherId).orElse(null);
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
	        if(voucher != null)
	        {
	        	 totalAmount = totalAmount - (totalAmount* voucher.getDiscount()/100 );
	        	 promotionService.updateQuantity(voucherId, voucher.getQuantity() -1);
	        	 VoucherCustomerEntity voucherCustomer = new VoucherCustomerEntity();
	        	 voucherCustomer.setUser(user);
	        	 voucherCustomer.setVoucher(voucher);
	        	 voucherCustomer.setStatus("đã áp dụng");
	        	 promotionCustomerService.save(voucherCustomer);
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
            //lưu shipper gần nhất
            List<UserEntity> shippers = shipperCarrierService.getListOfShipperByCarrierId(carrierId);
            UserEntity shipper = findNearestShipper(shippers,order.getAddress());
            ShipperCarrierEntity shipperCarrier = new ShipperCarrierEntity();
            System.out.println("gia tri shipper id" + shipper.getId());
            shipperCarrier.setUser(shipper);
            shipperCarrier.setCarrier(carrier);
            shipperCarrier.setOrderId(order.getId());
            shipperCarrierService.save(shipperCarrier);
	        //Lưu transaction
	        TransactionEntity transaction = new TransactionEntity();
	        transaction.setAmount(Double.parseDouble(totalAmount.toString()));
	        //đang lưu đối với trả bằng tiền mặt
	        transaction.setIsPaid(false);
	        transaction.setOrder(order);
            // lưu delivery
            DeliveryEntity delivery = new DeliveryEntity();
            delivery.setPrice(Double.parseDouble(carrier.getPrice().toString()));

            // Thiết lập thông tin carrier và order cho delivery
            delivery.setCarrier(carrier);  // Gán carrier vào delivery
            delivery.setOrder(order);      // Gán order vào delivery
            delivery.setDeliveryName("Shipping for Order #" + order.getId()); // Ví dụ tên giao hàng
            delivery.setDescription("Delivery for order #" + order.getId()); // Mô tả giao hàng
            deliveryService.save(delivery);  // Lưu delivery vào cơ sở dữ liệu

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
    @Override
    public OrderEntity createOrder(OrderEntity order) {
        // Thêm logic tạo đơn hàng
        OrderEntity savedOrder = orderRepository.save(order);

        // Gửi thông báo
        notificationServiceImpl.createNotification(
                "A new order has been placed: " + order.getAddress(),
                savedOrder.getUser().getId()
        );

        return savedOrder;
    }
    @Override
    public List<OrderEntity> getAllOrders() {
        return orderRepository.findAll();
    }

    // Lọc đơn hàng theo trạng thái
    @Override
    public List<OrderEntity> getOrdersByStatus(String status) {
        return orderRepository.findByStatus(status);
    }

    @Override
    public List<OrderEntity> findAll() {
        return orderRepository.findAll();
    }

    @Override
    public Page<OrderEntity> findAll(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findAll(pageable);
    }

    @Override
    public Page<OrderEntity> findByStatus(String status, Pageable pageable) {
        return orderRepository.findByStatus(status, pageable);
    }

    @Override
    public Page<OrderEntity> findByCarrierId(Long carrierId, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findByCarrierId(carrierId, pageable);
    }

    // Lấy đơn hàng theo carrierId và trạng thái
    @Override
    public Page<OrderEntity> findByCarrierIdAndStatus(Long shipperId, String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findByCarrierIdAndStatusWithDelivery(shipperId, status, pageable);
    }

    @Override
    public void updateStatus(Long orderId, String newStatus) {
        // Tìm đơn hàng dựa trên ID
        OrderEntity order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng với ID: " + orderId));

        // Cập nhật trạng thái mới
        order.setStatus(newStatus);

        // Lưu thay đổi vào cơ sở dữ liệu
        orderRepository.save(order);
    }

    @Override
    public List<OrderStatisticsDTO> getOrderStatistics(Long carrierId) {
        List<Object[]> rawStatistics = orderRepository.countOrdersByStatus(carrierId);
        List<OrderStatisticsDTO> statistics = new ArrayList<>();
        for (Object[] raw : rawStatistics) {
            OrderStatisticsDTO dto = new OrderStatisticsDTO();
            dto.setStatus((String) raw[0]);
            dto.setTotalOrders((Long) raw[1]);
            statistics.add(dto);
        }
        return statistics;
    }

    @Override
    public Double getTotalAmount(Long carrierId) {
        return orderRepository.calculateTotalAmount(carrierId);
    }
    @Override
    public List<OrderStatisticsDTO> getStatisticsByStatus(Long carrierId) {
        List<Object[]> results = orderRepository.countOrdersAndTotalMoneyByStatus(carrierId);
        List<OrderStatisticsDTO> statistics = new ArrayList<>();

        for (Object[] row : results) {
            OrderStatisticsDTO dto = new OrderStatisticsDTO();
            dto.setStatus((String) row[0]);
            dto.setTotalOrders((Long) row[1]);
            dto.setTotalMoney((Double) row[2]);

            statistics.add(dto);
        }

        return statistics;
    }

    @Override
    public Page<OrderEntity> findByCarrierIdAndStatuses(Long shipperId, List<String> statuses, int page, int size) {
        // Tạo Pageable object từ page và size
        Pageable pageable = PageRequest.of(page, size);


        // Gọi repository để lấy dữ liệu
        return orderRepository.findByCarrierIdAndStatuses(shipperId, statuses, pageable);
    }

    @Override
    public Page<OrderEntity> findCompletedOrdersByCarrierId(Long shipperId, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findCompletedOrdersByCarrierId(shipperId, pageable);
    }

    @Override
    public Page<OrderEntity> findByCarrierIdStatusAndSearch(Long shipperId, String status, String search, int page, int size) {
        return orderRepository.findByCarrierIdStatusAndSearch(shipperId, status, search, PageRequest.of(page, size));
    }

    @Override
    public Page<OrderEntity> findByCarrierIdStatusesAndSearch(Long carrierId, List<String> statuses, String search, int page, int size) {
        return orderRepository.findByCarrierIdStatusesAndSearch(carrierId, statuses, search, PageRequest.of(page, size));
    }

    @Override
    public Page<OrderEntity> findByCarrierIdAndSearch(Long shipperId, String search, int page, int size) {
        return orderRepository.findByCarrierIdAndSearch(shipperId, search, PageRequest.of(page, size));
    }


    @Override
    public List<MonthlyRevenueDTO> getMonthlyRevenue(Long shipperId) {
        List<Object[]> results = orderRepository.calculateMonthlyRevenue(shipperId);
        List<MonthlyRevenueDTO> revenues = new ArrayList<>();

        // Kiểm tra nếu results là null hoặc rỗng
        if (results == null || results.isEmpty()) {
            return revenues;  // Trả về danh sách rỗng nếu không có kết quả
        }

        // Duyệt qua các kết quả và xử lý
        for (Object[] result : results) {
            if (result != null && result.length == 3) {
                // Kiểm tra nếu các phần tử trong result không phải null
                Integer month = (result[0] != null) ? (Integer) result[0] : 0;  // Giá trị mặc định là 0 nếu null
                Integer year = (result[1] != null) ? (Integer) result[1] : 0;    // Giá trị mặc định là 0 nếu null
                Double totalRevenue = (result[2] != null) ? (Double) result[2] : 0.0; // Giá trị mặc định là 0 nếu null

                // Thêm vào danh sách doanh thu
                revenues.add(new MonthlyRevenueDTO(month, year, totalRevenue));
            }
        }

        return revenues;
    }

    @Override
    public Long getInProgressOrdersCount(Long shipperId) {
        return orderRepository.countInProgressOrders(shipperId);
    }

    @Override
    public Long getDeliveredOrdersCount(Long shipperId) {
        return orderRepository.countDeliveredOrders(shipperId);
    }

    @Override
    public Long getPendingOrdersCount(Long shipperId) {
        return orderRepository.countPendingOrders(shipperId);
    }

    @Override
    public List<Object[]> findOrdersByCarrierAndStatuses(Long carrierId, List<String> statuses) {
        return orderRepository.findOrdersByCarrierAndStatuses(carrierId, statuses);
    }

    @Override
    public OrderEntity findLatestOrderByCarrierId(Long carrierId) {
        return orderRepository.findLatestOrderByCarrierId(carrierId);
    }

    @Override
	public List <MonthRevenuesDTO> getMonthRevenuesByStoreId(Long storeId, int year){
    	return orderRepository.getMonthRevenuesByStoreId(storeId,year);
    }

    @Override
	public List<Object[]> getTotalMonthlyOrdersByStoreId(Long storeId,int year){
    	return orderRepository.getTotalMonthlyOrdersByStoreId(storeId, year);
    }

    //vũ làm nha a Thao iu
    @Override
    public List<OrderEntity> findOrdersByUsername(String username) {
        return orderRepository.findByUsername(username);
    }

    @Override
    public Page<OrderEntity> findOrdersByUsername(String username, Pageable pageable) {
        return orderRepository.findByUser_Username(username, pageable);
    }

    @Override
    public Optional<OrderEntity> findById(Long orderId) {
        return orderRepository.findById(orderId);
    }

    @Override
    public Page<OrderEntity> getOrdersByIdAndStatus(Long id, String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);

        // Kiểm tra nếu cả ID và status đều có giá trị, tìm kiếm theo cả hai điều kiện
        if (id != null && status != null && !status.isEmpty()) {
            return orderRepository.findByIdAndStatus(id, status, pageable);
        }

        // Kiểm tra nếu chỉ có status, tìm kiếm theo trạng thái
        if (status != null && !status.isEmpty()) {
            return orderRepository.findByStatus(status, pageable);
        }

        // Kiểm tra nếu chỉ có id, tìm kiếm theo ID
        if (id != null) {
            Optional<OrderEntity> orderOptional = orderRepository.findById(id);
            return new PageImpl<>(orderOptional.isPresent() ? List.of(orderOptional.get()) : Collections.emptyList(), pageable, orderOptional.isPresent() ? 1 : 0);
        }

        // Nếu không có id và status, trả về tất cả đơn hàng
        return orderRepository.findAll(pageable);
    }

    @Override
    public Page<OrderEntity> findAll(Pageable pageable) {
        return orderRepository.findAll(pageable);
    }


    @Override
    public Page<OrderEntity> findByIdStatusAndSearch(Long id, String status, String search, Pageable pageable) {
        return orderRepository.findByIdStatusAndSearch(id, status, search, pageable);
    }


    @Override
    public Page<OrderEntity> findByIdAndStatus(Long id, String status, Pageable pageable) {
        return orderRepository.findByIdAndStatus(id, status, pageable);
    }

    @Override
    public Page<OrderEntity> findByStatusAndSearch(String status, String search, Pageable pageable) {
        return orderRepository.findByStatusAndSearch(status, search, pageable);
    }

    @Override
    public Page<OrderEntity> findBySearch(String search, Pageable pageable) {
        return orderRepository.findBySearch(search, pageable);
    }
}
