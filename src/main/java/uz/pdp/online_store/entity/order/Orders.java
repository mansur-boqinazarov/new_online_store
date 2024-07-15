package uz.pdp.online_store.entity.order;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import uz.pdp.online_store.entity.auditable.Auditable;
import uz.pdp.online_store.entity.user.Users;
import uz.pdp.online_store.enums.OrderStatus;

import java.util.List;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@SuperBuilder(toBuilder = true)
public class Orders extends Auditable {
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "order")
    private List<OrderItem> orderItems;
    @ManyToOne(cascade = CascadeType.ALL)
    private Users user;
    private Integer totalPrice;
    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "varchar(255) default 'NOT_ORDERED'")
    private OrderStatus orderStatus;
}