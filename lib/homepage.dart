import 'package:Pet_Gardin/Animalinfo.dart';
import 'package:Pet_Gardin/PetContainer.dart';
import 'package:Pet_Gardin/database.dart';
import 'package:Pet_Gardin/details.dart';
import 'package:Pet_Gardin/drawer.dart';
import 'package:Pet_Gardin/global.dart';
import 'package:Pet_Gardin/photo.dart';
import 'package:Pet_Gardin/searchdelgate.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FocusNode _focusNode = FocusNode();
  String? selectedAnimal = "ALL";
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    scaffoldkey1 = scaffoldkey;
    SelectedAnimals = animals;
    print(loginsession);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Location",
                  style:
                      TextStyle(fontSize: 16, color: const Color(0xff52796f)),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Color(0xff52796f),
                    ),
                    Text(
                      "Mansoura,",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    Text(
                      " Egypt",
                      style: TextStyle(
                          color: Color.fromARGB(255, 66, 72, 74), fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Photo(
                      imageurl: users[loginsession!]["image"] ??
                          "assets/images/userphoto.jpeg"),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  users[loginsession!]["image"] ??
                      "assets/images/userphoto.jpeg",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      drawer: const Drawer(
        backgroundColor: Color(0xff52796f),
        child: drawer(),
      ),
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Color(0xffe9eef1),
          ),
          child: Column(
            children: [
              const SizedBox(height: 25),
              TextField(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  showSearch(context: context, delegate: CastomSearch());
                },
                focusNode: _focusNode,
                minLines: 1,
                maxLines: 1,
                cursorColor: const Color.fromARGB(255, 66, 72, 74),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(2),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.filter_list_outlined),
                  border: OutlineInputBorder(
                    gapPadding: 2,
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 2,
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 170, 179, 182),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "search pet to adopt",
                  hintStyle: const TextStyle(color: Color(0xffbfc9ca)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 115,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, i) {
                    return PetContainer(
                      animal: categories[i]["animal"],
                      imageurl: categories[i]["imageurl"],
                      selected: selectedAnimal == categories[i]["animal"],
                      onSelected: () {
                        setState(() {
                          SelectedAnimals = [];
                          selectedAnimal = categories[i]["animal"];
                          selectedAnimal == "ALL"
                              ? SelectedAnimals = animals
                              : SelectedAnimals.addAll(animals.where(
                                  (element) =>
                                      element["type"] == selectedAnimal));
                        });
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: SelectedAnimals.isEmpty
                    ? const Center(
                        child: Text("No Animals",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFBFC9CA),
                            )),
                      )
                    : ListView.builder(
                        itemCount: SelectedAnimals.length,
                        itemBuilder: (context, int i) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Details(
                                          seleccted_animal: i,
                                          filterd: true,
                                        )),
                              );
                            },
                            child: Animalinfo(
                              imageurl: SelectedAnimals[i]["imageurl"],
                              name: SelectedAnimals[i]["name"],
                              distance: SelectedAnimals[i]["distance"],
                              gender: SelectedAnimals[i]["gender"],
                              speices: SelectedAnimals[i]["speices"],
                              age: SelectedAnimals[i]["age"],
                              type: SelectedAnimals[i]["type"],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
