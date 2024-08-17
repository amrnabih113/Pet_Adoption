import 'package:flutter/material.dart';

class Animalinfo extends StatelessWidget {
  Animalinfo({
    super.key,
    required this.imageurl,
    required this.name,
    required this.type,
    required this.gender,
    required this.speices,
    required this.age,
    required this.distance,
  });

  final String imageurl;
  final String name;
  final String type;
  final String gender;
  final String speices;
  final String age;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: gender == "male"
                        ? const Color.fromARGB(255, 151, 194, 198)
                        : const Color(0xffa56d4c),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  height: 190,
                ),
                Container(
                  height: 150,
                  width: 120,
                  child: Image.asset(
                    imageurl,
                    fit: BoxFit.fitHeight,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            height: 160,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    gender == "male"
                        ? const Icon(Icons.male)
                        : const Icon(Icons.female)
                  ],
                ),
                Text(
                  speices,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  age,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      color: Color(0xff52796f),
                      size: 15,
                    ),
                    Text(
                      distance,
                      style: const TextStyle(
                          fontSize: 12, color: Color.fromARGB(255, 66, 72, 74)),
                    ),
                  ],
                )
              ],
            ),
          )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
