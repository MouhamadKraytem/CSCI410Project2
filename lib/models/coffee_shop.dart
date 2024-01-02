import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:csci410_project/models/coffe.dart';
import '../LoginPage.dart';
class CoffeeShop extends ChangeNotifier {
  List<Coffee> get coffeeShop => shop;

  List<Coffee> get userCart => cart;
  void addItemToCart(Coffee coffee) async {
    cart.add(coffee);
    notifyListeners();

    String username = await pref.getString('id');
    print(coffee.id);
    print("====");
    print(username);
    try {
      post(
        Uri.parse(
            'https://mobileprojecttt.000webhostapp.com/add_item_to_cart.php'),
        body: {
          'coffee_id': coffee.id,
          'user_id': username,
        },
      );
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  void removeItemFromCart(Coffee coffee) async {
    cart.remove(coffee);
    notifyListeners();

    String username = await pref.getString('id');
    print(coffee.id);
    print("====");
    print(username);
    try {
      post(
        Uri.parse(
            'https://mobileprojecttt.000webhostapp.com/delete_item_from_cart.php'),
        body: {
          'coffee_id': coffee.id,
          'user_id': username,
        },
      );
      // print(res);
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }
}

List<Coffee> shop = [];

List<Coffee> cart = [];
