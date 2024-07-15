package uz.pdp.online_store.service.order;

import uz.pdp.online_store.dao.order.OrderDAO;
import uz.pdp.online_store.entity.order.OrderItem;
import uz.pdp.online_store.entity.order.Orders;
import uz.pdp.online_store.entity.user.Users;
import uz.pdp.online_store.enums.OrderStatus;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class OrderService {
    public OrderDAO dao = new OrderDAO();

    public Orders createOrder(Users user) {
        Orders order = Orders.builder()
                .user(user)
                .orderItems(new ArrayList<>())
                .totalPrice(0)
                .orderStatus(OrderStatus.NOT_ORDERED)
                .build();
        dao.save(order);
        return order;
    }


    public Integer totalBalance(String orderID) {
        Integer totalPrice = findOrder(orderID).getTotalPrice();
        List<OrderItem> allOrderItemByOrderID = new OrderItemService().getAllOrderItemByOrderID(orderID);
        for (OrderItem orderItem : allOrderItemByOrderID) {
            Integer productPrice = orderItem.getProduct().getProductPrice();
            totalPrice += productPrice * orderItem.getQuantity();
        }
        if (totalPrice != null) {
            findOrder(orderID).setTotalPrice(totalPrice);
            return totalPrice;
        } else return 0;
    }

    public Orders findOrder(String orderID) {
        return dao.findById(orderID);
    }

    public Optional<Orders> findOrderByUser(Users user) {
        Orders orders = dao.findByUser(user);
        if (orders != null && !orders.getOrderStatus().equals(OrderStatus.ORDERED)) {
            return Optional.of(orders);
        } else {
            return Optional.of(createOrder(user));
        }
    }

    public void orderedProduct(Users user){
        Optional<Orders> orderByUser = findOrderByUser(user);
        if (orderByUser.isPresent()) {
            Orders orders = orderByUser.get();
        dao.deleteById(orders.getId());
            /*
            orders.setOrderStatus(OrderStatus.ORDERED);
            dao.update(orders);
*/
        }
    }

    public List<String> historyOrdered(Users user){
        List<Orders> orders = dao.findAll();
        List<String> orderIDs = new ArrayList<>();
        for (Orders order : orders) {
            if (order.getOrderStatus().equals(OrderStatus.ORDERED)){
                orderIDs.add(order.getId());
            }
        }
        return orderIDs;
    }

}