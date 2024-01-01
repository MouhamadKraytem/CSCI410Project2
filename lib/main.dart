import 'package:csci410_project/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LoginPage.dart';
import './pages/home_page.dart';
import 'models/coffee_shop.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoffeeShop(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  Future<Widget> getPage() async {
    String id = await pref.getString("id");
    if (id == null || id.isEmpty) {
      // return AdminPage();

      return LoginPage();
    } else {
      return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return 
    MaterialApp(
      title: "csci410 priject",
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getPage(),
        builder: (BuildContext context, AsyncSnapshot<Widget> w) {
          return w.data!;
        },
      ),

    );
  }
}
