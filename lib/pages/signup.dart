import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/helper/helper.dart';
import 'package:groceryapp/pages/home.dart';
import 'package:groceryapp/pages/login.dart';
import 'package:groceryapp/pages/welcome_page.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  
  TextEditingController usercontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  void signUp()async{
   if(passwordcontroller.text != confirmpasswordcontroller.text ){
    displayMessage("Password don't match !!", context);
   }
   try{
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    // Try to create a new user
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailcontroller.text,
      password: passwordcontroller.text,
    );
     await saveUser(userCredential);
    // Dismiss the loading dialog
    Navigator.pop(context);
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Registered Successfully",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );

    // Navigate to the Home page after successful signup
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );

   }on FirebaseAuthException catch(e){
     Navigator.pop(context);
    displayMessage("An unexpected error occurred", context);
   }
  }
  Future <void> saveUser(UserCredential userCredential)async{
    await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.email).set({
       "username":usercontroller.text,
       "email":userCredential.user!.email,
       "phone":phonecontroller.text
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 39, 37, 37),
      body: SingleChildScrollView(
        child: Container(
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
                    Navigator.push(
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
                child: Text("Go ahead and set up", style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text("your account", style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 20.0),
                child: Text("Sign-up to enjoy the best managing experience ", style: TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w300)),
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
                    
                    // Username
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: usercontroller,
                        cursorHeight: 25,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person, color: Colors.green, size: 30),
                          hintText: "Username",
                          hintStyle: TextStyle(fontSize: 24.0, color: const Color.fromARGB(255, 148, 146, 146)),
                        ),
                        style: TextStyle(fontSize: 28.0),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    // Email
                    Container(
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
                    SizedBox(height: 30.0,),
                      // phone number
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: phonecontroller,
                        cursorHeight: 25,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.phone, color: Colors.green, size: 30),
                          hintText: "Phone number",
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
                    // Confirm Password
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: confirmpasswordcontroller,
                        obscureText: true,
                        cursorHeight: 25,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.password, color: Colors.green, size: 30),
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(fontSize: 24.0, color: const Color.fromARGB(255, 148, 146, 146)),
                        ),
                        style: TextStyle(fontSize: 28.0),
                      ),
                    ),
                   
                    SizedBox(height: 30.0),
                    // Sign Up Button
                    GestureDetector(
                      onTap: signUp,
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
                            "Sign Up",
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
                        Text("Already have an account ? ",style: TextStyle(fontSize: 24.0),),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          },
                          child: Text("Login",style: TextStyle(fontSize: 24.0,color: Colors.green),))
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
