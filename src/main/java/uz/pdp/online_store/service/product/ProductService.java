package uz.pdp.online_store.service.product;

import uz.pdp.online_store.dao.product.ProductDAO;
import uz.pdp.online_store.entity.product.Category;
import uz.pdp.online_store.entity.product.Product;
import uz.pdp.online_store.enums.Measurement;
import uz.pdp.online_store.service.shop.ShopService;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


public class ProductService {
    ProductDAO dao = new ProductDAO();

    //delete product by id method
    public void deleteProduct(String productId) {
        dao.deleteById(productId);
    }

    public void createProduct(String productName, String productDescription, int productPrice, int productQuantity, Measurement measurement, String pictureID, String categoryID, String shopID) {
        Product product = Product.builder().productName(productName).productDescription(productDescription).productPrice(productPrice).productQuantity(productQuantity).measurement(measurement).picture(new PictureService().getPicture(pictureID)).category(new CategoryService().getCategory(categoryID)).shop(new ShopService().getShopById(shopID))
                .build();
        dao.save(product);
    }

    public List<Product> getAllProducts() {
        return dao.findAll();
    }

    public List<Product> getAllProductByShop(String shopID) {
        List<Product> productList = getAllProducts();
        return productList.stream()
                .filter(product -> product.getShop().getId().equals(shopID))
                .toList();
    }
    public List<Product> getAllProductByCategory(String categoryID) {
        List<Product> productList = getAllProducts();
        return productList.stream()
                .filter(product -> product.getCategory().getId().equals(categoryID))
                .toList();
    }
    public Product getProduct(String productID) {
        return dao.findById(productID);
    }

    public List<Product> randomProduct(){
        List<Product> productList = getAllProducts();
        Collections.shuffle(productList);
        return productList.stream()
                .limit(Math.min((productList.size()), 16))
                .toList();
    }

    public List<Product> randomProduct2(){
        List<Product> productList = getAllProducts();
        Collections.shuffle(productList);
        return productList.stream()
                .limit(Math.min((productList.size()), 6))
                .toList();
    }

    public Product findById(String productId) {
        return dao.findById(productId);
    }
    public List<Product> getListByCategory(String categoryID) {
        List<Product> productList = getAllProducts();
            List<Product> list = dao.findAll();
                for (Product prod : list) {
                    if (prod.getCategory().getId().equals(categoryID)) {
                        productList.add(prod);
                    }
                }
            return productList;
    }
    public List<Product> searchingProduct(String searchingName){
        return findSimilarProducts(searchingName, getAllProducts(), 0.8);
    }

    private static List<Product> findSimilarProducts(String word, List<Product> products, double threshold) {
        List<Product> result = new ArrayList<>();
        for (Product product : products) {
            if (jaroWinklerSimilarity(word, product.getProductName()) >= threshold) {
                result.add(product);
            }
        }
        return result;
    }

    private static double jaroWinklerSimilarity(String s1, String s2) {
        if (s1.equals(s2)) return 1.0;

        int[] mtp = matches(s1, s2);
        float m = mtp[0];
        if (m == 0) return 0.0f;
        float j = ((m / s1.length() + m / s2.length() + (m - mtp[1]) / m)) / 3;
        float jw = j < 0.7f ? j : j + Math.min(0.1f, 1.0f / mtp[3]) * mtp[2] * (1 - j);
        return jw;
    }

    private static int[] matches(String s1, String s2) {
        String max, min;
        if (s1.length() > s2.length()) {
            max = s1;
            min = s2;
        } else {
            max = s2;
            min = s1;
        }

        int range = Math.max(max.length() / 2 - 1, 0);
        int[] matchIndexes = new int[min.length()];
        for (int i = 0; i < matchIndexes.length; i++) {
            matchIndexes[i] = -1;
        }
        boolean[] matchFlags = new boolean[max.length()];
        int matches = 0;

        for (int i = 0; i < min.length(); i++) {
            char c1 = min.charAt(i);
            for (int j = Math.max(i - range, 0), end = Math.min(i + range + 1, max.length()); j < end; j++) {
                if (!matchFlags[j] && c1 == max.charAt(j)) {
                    matchIndexes[i] = j;
                    matchFlags[j] = true;
                    matches++;
                    break;
                }
            }
        }

        char[] ms1 = new char[matches];
        char[] ms2 = new char[matches];
        for (int i = 0, si = 0; i < min.length(); i++) {
            if (matchIndexes[i] != -1) {
                ms1[si] = min.charAt(i);
                si++;
            }
        }
        for (int i = 0, si = 0; i < max.length(); i++) {
            if (matchFlags[i]) {
                ms2[si] = max.charAt(i);
                si++;
            }
        }

        int transpositions = 0;
        for (int i = 0; i < ms1.length; i++) {
            if (ms1[i] != ms2[i]) {
                transpositions++;
            }
        }

        int prefix = 0;
        for (int i = 0; i < Math.min(4, min.length()); i++) {
            if (s1.charAt(i) == s2.charAt(i)) {
                prefix++;
            } else {
                break;
            }
        }

        return new int[]{matches, transpositions / 2, prefix, max.length()};
    }









}