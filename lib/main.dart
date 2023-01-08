import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api_login/second.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center ,
                            children: [
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(labelText: "Email", 
                                border: OutlineInputBorder(),
                                suffix: Icon(Icons.login)),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: passController,
                                decoration: InputDecoration(labelText: "Password", 
                                border: OutlineInputBorder(),
                                suffix: Icon(Icons.password)),
                              ),
                              SizedBox(
                                height: 45,
                              ),
                              OutlinedButton.icon(                                
                                onPressed: () {
                                  login();
                                }, 
                                icon: Icon(
                                  Icons.login,
                                  size: 18,
                                  ),
                                  label: Text("Login")),
                            ],
                       ))),
                    ),
                  );
                }
                //Code for login 
                Future<void> login() async{
                  if (passController.text.isNotEmpty && emailController.text.isNotEmpty){
                    var response = await http.post(Uri.parse("https://reqres.in/api/login"),
                    body: ({
                      'email': emailController.text,
                      'password': passController.text
                    }));
                    if (response.statusCode ==200){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Second()));
                    } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
                    }
                  }else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Blank field is not allowed")));
                  }                  
                }
            }