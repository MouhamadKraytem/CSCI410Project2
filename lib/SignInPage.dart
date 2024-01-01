import 'package:csci410_project/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey();
  NewUser()async{
    var url = "https://mobileprojecttt.000webhostapp.com/add_client.php";

    var res = await http.post(Uri.parse(url) , body: {
        'username': _name.text,
        'password' : _pass.text
    });

    if(res.statusCode ==200){
      var red = convert.json.decode(res.body);
      if(red == "Username already exists"){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Username aready exists")));
      }else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign In Succeesed")));
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
          return LoginPage();
        }));
      }
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
        title: Text("Sign Page"),
        centerTitle: true,
      ),
      body: Center(

        child: Form(

          key: _form,
          child: Column(
            children: [
              SizedBox(height: 10,),
              SizedBox(

                child: TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter User Name",
                      prefixIcon: Icon(Icons.person)
                  ),
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return "Field Null";
                    }
                    return null;
                  },
                ),
                width: 200,
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: TextFormField(
                  obscuringCharacter:  '*',
                  obscureText: true,
                  controller: _pass,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.lock),

                  ),
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return "Field Null";
                    }
                  },
                ),
                width: 200,
              ),
              SizedBox(height: 10,),
              SizedBox(
                child: TextFormField(
                  obscuringCharacter:  '*',
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Confirm Password",
                      prefixIcon: Icon(Icons.lock)
                  ),
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return "Field Null";
                    }else if(value != _pass.text ){
                      return "Password Not Match";
                    }
                  },
                ),
                width: 200,
              ),
              SizedBox(height: 10,),
              SizedBox(child: ElevatedButton(
                onPressed: (){
                  if(_form.currentState!.validate()){
                    //add to data base
                    NewUser();

                  }
                },child:Text("Sign In") ,

              )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Already Have an account ? "),
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                      return LoginPage();
                    }));
                  }, child: Text("LogIn "))
                ],
              ),

            ],
          ),
        ),
      ),
    );;
  }
}