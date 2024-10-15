import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/helper/helper.dart';
import 'package:groceryapp/pages/forgotpassword.dart';
import 'package:groceryapp/pages/home.dart';
import 'package:groceryapp/pages/signup.dart';
import 'package:groceryapp/pages/welcome_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  void login()async{
    try{
      showDialog(context: context, builder: (context)=>
        Center(child: CircularProgressIndicator(),)
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    } on FirebaseAuthException catch(e){
      displayMessage("An unexpected error occurred", context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 39, 37, 37),
      body: SingleChildScrollView(
        child: Container(
          // Add constraints to the main container
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08, left: 20.0),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(120),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 35),
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text("Welcome back !", style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text("Please login to your account", style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 20.0),
                child: Text("Sign-in to enjoy the best managing experience ", style: TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w300)),
              ),
              SizedBox(height: 40.0),
              // Textfields container
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    // Email
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.08),
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: emailcontroller,
                        cursorHeight: 25,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.email, color: Colors.green, size: 30),
                          hintText: "Email",
                          hintStyle: TextStyle(fontSize: 24.0, color: const Color.fromARGB(255, 148, 146, 146)),
                        ),
                        style: TextStyle(fontSize: 28.0),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    // Password
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: passwordcontroller,
                        obscureText: true,
                        cursorHeight: 25,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.password, color: Colors.green, size: 30),
                          hintText: "Password",
                          hintStyle: TextStyle(fontSize: 24.0, color: const Color.fromARGB(255, 148, 146, 146)),
                        ),
                        style: TextStyle(fontSize: 28.0),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Forgotpassword()));
                            },
                            child: Text("Forgot Password?", style: TextStyle(fontSize: 22.0)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    // Sign Up Button
                    GestureDetector(
                      onTap: login,
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.2,
                        constraints: BoxConstraints(maxWidth: 400),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ? ",style: TextStyle(fontSize: 24.0),),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                          },
                          child: Text("Register Here",style: TextStyle(fontSize: 24.0,color: Colors.green),))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}