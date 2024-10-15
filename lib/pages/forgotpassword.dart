import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/pages/login.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emailcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String message = '';

  Future<void> sendResetLink() async {
    String email = emailcontroller.text;

    if (email.isEmpty) {
      setState(() {
        message = 'Please enter your email.';
      });
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Email sent Successfully",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
      setState(() {
        message = 'Password reset link sent to $email.';
      });
    } catch (e) {
      setState(() {
        message = 'Error: ${e.toString()}';
      });
    }
  }

   @override
  void dispose() {
    emailcontroller.dispose(); // Dispose the controller to free resources
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  },
                  child: Icon(Icons.arrow_back,size: 40,)),
                SizedBox(width: 50,),
                Center(
                    child: Text(
                  "Reset Your Password",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Email",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 25.0),
              height: 70,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                
                controller: emailcontroller,
                cursorHeight: 25,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 16.0),
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Icon(Icons.email, color: Colors.green, size: 30),
                  ),
                  hintText: "Email",
                  hintStyle: TextStyle(
                      fontSize: 24.0,
                      color: const Color.fromARGB(255, 148, 146, 146)),
                ),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            SizedBox(height: 40.0),
                    // Sign Up Button
                    GestureDetector(
                      onTap: sendResetLink,
                      child: Center(
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
                              "Send reset link",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("We'll send you an email with a link to reset your password.", style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),),
                    )
          ],
        ),
      ),
    );
  }
}
