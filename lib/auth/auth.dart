import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/pages/home.dart';
import 'package:groceryapp/pages/welcome_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Handle error state
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong!"));
          }

          // If the user is authenticated, show the Home screen
          if (snapshot.hasData) {
            return Home();
          } 
          
          // If the user is not authenticated, show the Welcome screen
          return WelcomePage();
        },
      ),
    );
  }
}
