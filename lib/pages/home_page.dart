import 'package:csci410_project/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:csci410_project/components/bottom_nav_bar.dart';
import 'package:csci410_project/const.dart';
import 'dart:convert';
import 'package:csci410_project/models/coffee_shop.dart';
import '../models/coffe.dart';
import 'cart_page.dart';
import 'shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isLoading = true;

  bool isCartLoading = true;
  String idss ="";


  void getPref()async{
     idss = await pref.getString("id");
  }

  void initState() {
    super.initState();
    loadCoffees();
    loadCartItems();
    getPref();
  }

  void loadCoffees() async {
    String url =
        "https://mobileprojecttt.000webhostapp.com/get_all_coffees.php";

    var response = await get(Uri.parse(url)).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      setState(() {
        String res = response.body;

        shop.clear();

        for (var row in jsonDecode(res)) {
          var s = Coffee(row['coffee_id'], row['coffee_name'],
              row['coffee_price'], row['coffee_image']);

          shop.add(s);
        }

        isLoading = false;
      });
    }
  }

  void loadCartItems() async {
    String url = "https://mobileprojecttt.000webhostapp.com/get_cart_items.php";

    var response = await get(Uri.parse(url)).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      setState(() {
        String res = response.body;

        shop.clear();

        for (var row in jsonDecode(res)) {
          var s = Coffee(row['coffee_id'], row['coffee_name'],
              row['coffee_price'], row['coffee_image']);

          cart.add(s);
        }

        isCartLoading = false;
      });
    }
  }

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Hello $idss"),
        actions: [
          ElevatedButton(onPressed: (){
            pref.remove('id');
            Navigator.of(context).push(MaterialPageRoute(builder: (builder){
              return LoginPage();
            }));
          }, child: Icon(Icons.logout)),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _selectedIndex == 0
          ? ShopPage(isLoading: isLoading)
          : CartPage(isLoading: isCartLoading),
    );
  }
}
