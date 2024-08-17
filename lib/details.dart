import 'package:Pet_Gardin/database.dart';
import 'package:Pet_Gardin/global.dart';
import 'package:Pet_Gardin/photo.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  Details({super.key, required this.seleccted_animal, required this.filterd});
  int seleccted_animal;
  bool filterd;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool favourite = false;

  @override
  void initState() {
    print(widget.seleccted_animal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final animal;
    widget.filterd
        ? animal = SelectedAnimals[widget.seleccted_animal]
        : animal = animals[widget.seleccted_animal];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: animal["gender"] == "male"
            ? const Color.fromARGB(255, 151, 194, 198)
            : const Color(0xffa56d4c),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 380,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      color: animal["gender"] == "male"
                          ? const Color.fromARGB(255, 151, 194, 198)
                          : const Color(0xffa56d4c),
                    ),
                    Image.asset(animal["imageurl"])
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.only(
                        top: 70, bottom: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Photo(
                                        imageurl: SelectedAnimals[
                                                    widget.seleccted_animal]
                                                ["owner"]["image"] ??
                                            "assets/images/userphoto.jpeg"),
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  animal["owner"]["image"],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                                child: ListTile(
                              title: Text(
                                animal["owner"]["username"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              subtitle: Text(
                                animal["owner"]["email"],
                                style: const TextStyle(),
                              ),
                            ))
                          ],
                        ),
                        Text(
                          animal["description"],
                          style: const TextStyle(fontSize: 15),
                        )
                      ],
                    )),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(30),
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(animal["name"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                    animal["gender"] == "male"
                        ? const Icon(
                            Icons.male,
                            size: 30,
                          )
                        : const Icon(
                            Icons.female,
                            size: 30,
                          )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      animal["speices"],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      animal["age"],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      color: Color(0xff52796f),
                      size: 15,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      animal["address"],
                      style: const TextStyle(
                          fontSize: 15, color: Color.fromARGB(255, 66, 72, 74)),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(30),
        height: 130,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Color(0xffbfc9ca)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
                onPressed: () {
                  setState(() {
                    favourite = !favourite;
                  });
                },
                color: const Color(0xff52796f),
                minWidth: 35,
                height: 50,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: favourite
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: MaterialButton(
                    onPressed: () {},
                    color: const Color(0xff52796f),
                    height: 50,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: const Text("Adoption",
                        style: TextStyle(color: Colors.white))))
          ],
        ),
      ),
    );
  }
}
