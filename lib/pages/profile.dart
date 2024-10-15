import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/pages/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   String? username;
  String? email;
  String? contact;
  
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }
  Future<void> fetchUserData() async {
    try {
      // Get the currently logged-in user
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Reference to the user's document in Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.email) // Using email as document id
            .get();

        if (userDoc.exists) {
          setState(() {
            username = userDoc['username'];
            email = currentUser.email;
            contact = userDoc['phone'];
             isLoading = false; 
          });
        } else {
          print("User document does not exist.");
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
  void logout()async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          //text and back btn
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06,left: 20.0),
            child: Row(children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,size: 30,)),
              SizedBox(width: MediaQuery.of(context).size.width*0.32,),
              Text("Profile",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),)
            ],
            ),
          ),
          //profile pic and username
          SizedBox(height: 40.0,),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(120)
                ),
                child: Icon(Icons.person,size: 40,)),
                SizedBox(height: 10.0,),
                Text(
                          username ?? 'Guest',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 36.0,
                          ),
                        ),
                Text(
                          email ?? 'guest@gmail.com',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w700,
                            fontSize: 25.0,
                          ),
                        )
            ],),
          ),
          SizedBox(height: 10.0,),
          //icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Column(children: [
                 Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 253, 135, 174),
                  borderRadius: BorderRadius.circular(120)
                ),
                child: Icon(Icons.shopping_bag_outlined,size: 40,)),
                SizedBox(height: 5,),
                Text("Orders",style: TextStyle(
                  fontSize: 24,fontWeight: FontWeight.w600
                ),)
               ],),
                Column(children: [
                 Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 243, 233),
                  borderRadius: BorderRadius.circular(120)
                ),
                child: Icon(Icons.favorite_outline,size: 40,)),
                SizedBox(height: 5,),
                Text("My Favourite",style: TextStyle(
                  fontSize: 24,fontWeight: FontWeight.w600
                ),)
               ],),
                Column(children: [
                 Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 135, 253, 180),
                  borderRadius: BorderRadius.circular(120)
                ),
                child: Icon(Icons.shopping_cart_outlined,size: 40,)),
                SizedBox(height: 5,),
                Text("My Carts",style: TextStyle(
                  fontSize: 24,fontWeight: FontWeight.w600
                ),)
               ],)
          ],
          ),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[400]
            ),
            height: 10,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: 30,),
          // Account info
          Container(
            
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text("My Account",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800
                ),),
              ),
              SizedBox(height: 20,),
              //Profile
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(children: [
                  Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 253, 135, 174),
                  borderRadius: BorderRadius.circular(120)
                ),
                child: Icon(Icons.person_2_outlined,size: 40,)),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Profile",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                  Text("Name,Email & Phone Number",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)
                ],
                )
                ],),
              ),SizedBox(height: 20,),
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[400]
                ),
              ),
              SizedBox(height: 20,),
              //Payments
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(children: [
                  Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 135, 253, 180),
                  borderRadius: BorderRadius.circular(120)
                ),
                child: Icon(Icons.credit_card,size: 40,)),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Payments",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                  Text("Cards for payments",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)
                ],)
                ],),
              ),SizedBox(height: 20,),
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[400]
                ),
              )
            ],),
          ),
              SizedBox(height: 20,),
              //contact
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(children: [
                  Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 243, 233),
                  borderRadius: BorderRadius.circular(120)
                ),
                child: Icon(Icons.phone,size: 40,)),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Contact",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                  Text(contact??"4533XXXXX",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)
                ],)
                ],),
              ),SizedBox(height:60,),
                // logout Button
                    GestureDetector(
                      onTap: logout,
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
                            "Log Out",
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
        ],
        ),
      ),
    );
  }
}