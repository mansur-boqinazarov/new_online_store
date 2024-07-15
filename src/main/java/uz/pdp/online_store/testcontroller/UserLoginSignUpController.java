package uz.pdp.online_store.testcontroller;


import uz.pdp.online_store.service.user.UserService;

public class UserLoginSignUpController {
    public static void main(String[] args) {
        String fullname = "To'lqin Ruzimbayev";
        String email = "ruzimbayev.tulkin@mail.ru";
        String password = "12345";
        String phoneNumber = "123456789";
        signup(fullname, email, password, phoneNumber);
    }
    private static void signup(String fullname, String email, String password, String phoneNumber){
        UserService userService = new UserService();
        userService.signUp(fullname, email, password, phoneNumber);
    }
    private static void login(){

    }
}