import 'package:flutter/material.dart';

class Dummyscreen1 extends StatelessWidget {
  const Dummyscreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            width: 100,
            color: Colors.red,
            child: Text("testiiiiiiiii"),
          ),
        ],
      ),
    );
  }
}
