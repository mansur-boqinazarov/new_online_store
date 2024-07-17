package uz.pdp.online_store.dao.order;

import uz.pdp.online_store.dao.base.BaseDAO;
import uz.pdp.online_store.entity.order.Orders;
import uz.pdp.online_store.entity.user.Users;
import uz.pdp.online_store.enums.OrderStatus;

import java.util.ArrayList;
import java.util.List;


public class OrderDAO extends BaseDAO<Orders, String> {
    public Orders findByUser(Users user) {
        List<Orders> orders = findAll();
        for (Orders order : orders) {
            if (order.getUser().getId().equals(user.getId()) &&
                    order.getOrderStatus().equals(OrderStatus.NOT_ORDERED)) {
                        return order;
            }
        }
        return null;
    }
}