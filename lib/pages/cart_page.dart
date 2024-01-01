import 'package:flutter/material.dart';
import 'package:csci410_project/components/coffee_tile.dart';
import 'package:csci410_project/models/coffee_shop.dart';
import 'package:provider/provider.dart';

import '../models/coffe.dart';

class CartPage extends StatefulWidget {
  final bool isLoading;
  const CartPage({super.key, required this.isLoading});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeFromCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).removeItemFromCart(coffee);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
        builder: (context, value, child) => SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(children: [
                const Text(
                  "Your Cart",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 25,
                ),
                widget.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: value.userCart.length,
                            itemBuilder: (context, index) {
                              Coffee eachCoffee = value.userCart[index];
                              return CoffeeTile(
                                coffee: eachCoffee,
                                onPressed: () => removeFromCart(eachCoffee),
                                icon: const Icon(Icons.delete),
                              );
                            }),
                      ),
                Container(
                  padding: const EdgeInsets.all(25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Text(
                      "Pay Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ]),
            )));
  }
}
