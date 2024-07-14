package uz.pdp.online_store.service.user;

import jakarta.persistence.NoResultException;
import uz.pdp.online_store.dao.user.AddressDAO;
import uz.pdp.online_store.dao.user.UserDAO;
import uz.pdp.online_store.entity.user.Address;
import uz.pdp.online_store.entity.user.Users;
import uz.pdp.online_store.enums.Role;
import uz.pdp.online_store.enums.Status;
import uz.pdp.online_store.service.base.BaseService;

import java.util.List;

public class UserService implements BaseService{
    private static final UserDAO userDAO = new UserDAO();
    private static final AddressDAO addressDAO = new AddressDAO();

    public Users login(String email, String password){
        return userDAO.login(email, password);
    }

    public Users signUp(String fullName, String email, String password, String phoneNumber){
        Users user = Users
                .builder()
                .fullName(fullName)
                .email(email)
                .password(password)
                .role(Role.USER)
                .status(Status.ACTIVE)
                .phoneNumber(phoneNumber)
                .build();
        return userDAO.save(user);
    }
    public void saveAddress(String city, String street, String apartmentNumber, String user_id){
        addressDAO.save(
                Address.builder()
                        .city(city)
                        .street(street)
                        .apartment(apartmentNumber)
                        .user(getUserById(user_id))
                        .build());
    }

    public Address getAddress(String user_id){
        try {
            return addressDAO.findById(user_id);
        } catch (NoResultException e) {
            return null;
        }
    }

    public Users getUserById(String user_id){
        try{
            return userDAO.findById(user_id);
        }
        catch (NoResultException e){
            return null;
        }
    }

    public void userInActive(String user_id){
        Users user = getUserById(user_id);
        user.setStatus(Status.IN_ACTIVE);
        userDAO.update(user);
    }

    public List<Users> getAllUsers(){
        List<Users> all = userDAO.findAll();
        return all.stream().filter(users -> users.getRole().equals(Role.USER)).toList();
    }

    public List<Users> getALlSellers(){
        List<Users> all = userDAO.findAll();
        return all.stream().filter(users -> users.getRole().equals(Role.SELLER)).toList();
    }

    public void removeUser(String removeUserId) {
        userDAO.deleteById(removeUserId);
    }
}