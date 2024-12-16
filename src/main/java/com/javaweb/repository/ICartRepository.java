package com.javaweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import com.javaweb.entity.CartEntity;
import com.javaweb.dto.*;
import com.javaweb.entity.UserEntity;



@Repository
public interface ICartRepository extends JpaRepository<CartEntity, Long>{
    @Query("SELECT new com.javaweb.dto.CartProductDTO(ci .id,p.id, p.name, p.price, g.image,ci.quantity,p.promotionalPrice) " + 
    		"FROM CartItemEntity ci " +
    		"JOIN ci.cart  c "+
    		"JOIN ProductEntity p on p.id = ci.productId " +
    		"JOIN GalleryEntity g on p = g.productEntity "+
    		"WHERE c.user.id = :id  AND g.type = 'front' ")
    List<CartProductDTO> findCartItemsByUser(@Param("id") Long id);
    
    CartEntity findCartEntityByUser(UserEntity user);
}
