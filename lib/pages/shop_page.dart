

import 'package:flutter/material.dart';

import 'package:csci410_project/components/coffee_tile.dart';
import 'package:csci410_project/models/coffee_shop.dart';
import 'package:provider/provider.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import '../models/coffe.dart';

class ShopPage extends StatefulWidget {
  final bool isLoading;

  ShopPage({Key? key, required this.isLoading}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
  }

  void addToCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).addItemToCart(coffee);

    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text("Successfully added to cart"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
        builder: (context, value, child) => SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(children: [
                const Text(
                  "How would you like your coffee?",
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
                        itemCount: value.coffeeShop.length,
                        itemBuilder: (context, index) {
                          Coffee eachCoffee = value.coffeeShop[index];

                          return CoffeeTile(
                            coffee: eachCoffee,
                            icon: const Icon(Icons.add),
                            onPressed: () => addToCart(eachCoffee),
                          );
                        },
                      )),
              ]),
            )));
  }
}
