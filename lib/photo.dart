import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  const Photo({super.key, required this.imageurl});
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff52796f),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: Image.asset(
              imageurl,
            ),
          ),
        ));
  }
}
