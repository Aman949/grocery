import 'package:flutter/material.dart';

class Veg extends StatefulWidget {
  const Veg({super.key});

  @override
  State<Veg> createState() => _VegState();
}

class _VegState extends State<Veg> {
  // List of data to be displayed in each grid item
  final List<Map<String, dynamic>> gridItems = [
    {'text': 'Carrot','price':"\$30"},
    {'text': 'Onion','price':"\$20"},
    {'text': 'Tomato', 'price':"\$30"},
    {'text': 'Lemon','price':"\$10" },
    {'text': 'Carrot','price':"\$50"},
    {'text': 'Onion', 'price':"\$40"},
    {'text': 'Lemon', 'price':"\$20"},
    {'text': 'Tomato','price':"\$10"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Vegetables',style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600
        ),)),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 10, // Horizontal space between grid items
        mainAxisSpacing: 20, // Vertical space between grid items
        padding: EdgeInsets.all(10.0),
        children: List.generate(gridItems.length, (index) {
          final item = gridItems[index];

          return Container(
            decoration: BoxDecoration(
              boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
              color: Colors.white, 
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(40),bottomLeft: Radius.circular(20),topLeft: Radius.circular(20),topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 120,
                width: 200,
                decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 248, 243), 
              borderRadius: BorderRadius.circular(20) ),
              child: Image.asset("assets/images/veg.png"),
              ),
              SizedBox(height: 10,),
              Text(item['text'],style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700
              ),),
              
            ],)
          );
        }),
      ),
    );
  }
}
