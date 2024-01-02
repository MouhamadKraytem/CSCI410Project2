import 'package:csci410_project/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import './pages/home_page.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

EncryptedSharedPreferences pref = EncryptedSharedPreferences();

class _LoginPageState extends State<LoginPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey();

  Login() async {
    var url = "https://mobileprojecttt.000webhostapp.com/login.php";
    var res = await http.post(Uri.parse(url),
        body: {'username': _name.text, 'password': _pass.text});

    if (res.statusCode == 200) {
      var red = convert.jsonDecode(res.body);
      print(red);
      if (red['status'] == "success") {
        await pref.setString("id", red['userId']); // Use await here
        await pref.setString("name", red['name']);
        print(await pref.getString("id")); // Use await here

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("login")));
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
          return HomePage();
        }));
      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalide Username or passowrd")));
      }
    }else{
      print("connection error");
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _form,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter User Name"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Field Null";
                    }
                    return null;
                  },
                ),
                width: 200,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: TextFormField(
                  obscuringCharacter:  '*',
                  obscureText: true,
                  controller: _pass,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Enter Password"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Field Null";
                    }
                  },
                ),
                width: 200,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  child: ElevatedButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    Login();
                  }
                },
                child: Text("Login"),
              )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (builder) {
                      return SignInPage();
                    }));
                  },
                  child: Text("Sign In ?"))
            ],
          ),
        ),
      ),
    );
  }
}
