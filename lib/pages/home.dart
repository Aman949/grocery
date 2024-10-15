import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/pages/products/dairy.dart';
import 'package:groceryapp/pages/products/fruits.dart';
import 'package:groceryapp/pages/products/snacks.dart';
import 'package:groceryapp/pages/products/veg.dart';
import 'package:groceryapp/pages/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? username;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.email) // Using email as document id
            .get();

        if (userDoc.exists) {
          setState(() {
            username = userDoc['username'];
          });
        } else {
          print("User document does not exist.");
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.06,
                              left: 30.0),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 35, 224, 92),
                              borderRadius: BorderRadius.circular(120)),
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 55),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username ?? "Profile",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              "Check out groceries.....",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 7.0),
                            child: Icon(Icons.search,size: 30,),
                          ),
                          hintText: "Search....",
                          hintStyle: TextStyle(
                            fontSize: 24,
                            color: Colors.black38
                          ),
                          contentPadding: EdgeInsets.only(top: 14)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.green,
                    const Color.fromARGB(255, 150, 240, 153),
                  ]),
                  borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text("Get 40% discount\n on your first order \n from app.",style: TextStyle(
                              fontSize: 25,fontWeight: FontWeight.w700,color: Colors.white
                             ),),
                             SizedBox(height: 15,),
                             Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        
                    const Color.fromARGB(255, 150, 240, 153),
                    Colors.green,
                  ]),
                              ),
                              child: Center(child: Text("Shop Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20),)),
                             )

                        ],),
                        Image.asset("assets/images/veg.png",height: 130,width: 130,)
                  ],),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Categories items
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Fruits()));
                    },
                    child: CategoryTile(title: 'Fruits', path: "assets/images/fruit.png")),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Veg()));
                    },
                    child: CategoryTile(title: 'Vegetables', path: "assets/images/veg.png")),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dairy()));
                    },
                    child: CategoryTile(title: 'Dairy', path: "assets/images/dairy.png")),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Snacks()));
                    },
                    child: CategoryTile(title: 'Snacks', path: "assets/images/snacks.png")),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text("Popular",style: TextStyle(
                    fontSize: 30,fontWeight: FontWeight.w800
                  ),),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 223, 248, 243),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/orange.png",height: 120,width: 120,),
                      Text("Oranges",style: TextStyle(
                        fontSize: 30,fontWeight: FontWeight.w700
                      ),)
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 223, 248, 243),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/guava.png",height: 120,width: 120,),
                      Text("Guava",style: TextStyle(
                        fontSize: 30,fontWeight: FontWeight.w700
                      ),)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Custom widget for category tile
class CategoryTile extends StatelessWidget {
  final String title;
  final String path;

  const CategoryTile({Key? key, required this.title, required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: 100, // Set width for category tiles
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120),color: Colors.grey[400]
            ),
            child: Image.asset(path,height: 50,width: 50,)), // Icon above title
          SizedBox(height: 8), // Space between icon and title
          Text(
            title,
            textAlign: TextAlign.center, // Center the text
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold, // Bold title text
            ),
          ),
        ],
      ),
    );
  }
}
