import 'package:flutter/material.dart';

class PetContainer extends StatelessWidget {
  const PetContainer({
    super.key,
    required this.animal,
    required this.imageurl,
    required this.selected,
    required this.onSelected,
  });

  final String animal;
  final String imageurl;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: selected ? const Color(0xff52796f) : Colors.white,
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
                child: MaterialButton(
                  onPressed: onSelected,
                  height: 80,
                  minWidth: 80,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    imageurl,
                    color: selected
                        ? Colors.white
                        : const Color.fromARGB(255, 42, 44, 45),
                    height: 60,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                animal,
                style: const TextStyle(
                    color: Color.fromARGB(255, 66, 72, 74), fontSize: 15),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
