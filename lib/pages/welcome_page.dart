import 'package:flutter/material.dart';
import 'package:groceryapp/pages/signup.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.6,
            width: screenWidth,
            child: Image.asset(
              "assets/images/welcomeScreen.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    "Welcome to Smart Grocery",
                    style: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "We make ordering food supplies a",
                      style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "piece of cake. Get ready to manage all",
                      style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "your orders with a few clicks!! ",
                      style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: screenWidth / 1.2,
                    constraints: BoxConstraints(maxWidth: 400),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
