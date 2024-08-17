import 'package:Pet_Gardin/database.dart';
import 'package:Pet_Gardin/details.dart';
import 'package:Pet_Gardin/global.dart';
import 'package:flutter/material.dart';

class CastomSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: const Color(0xff52796f),
        iconTheme: const IconThemeData(color: Color(0xFFFFCBA4)),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hoverColor: Color(0xffcad2c5),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFFCBA4), width: 2),
        ),
        hintStyle: TextStyle(color: Color(0xffcad2c5)),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Color(0xffcad2c5)),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.cancel),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        color: const Color(0xff52796f),
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            return Card(
              color: const Color(0xff52796f),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                seleccted_animal: index,
                                filterd: false,
                              )));
                },
                title: Text(
                  animals[index]["name"],
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xffcad2c5)),
                ),
              ),
            );
          },
          itemCount: animals.length,
        ),
      );
    } else {
      SelectedAnimals =
          animals.where((element) => element["name"].contains(query)).toList();

      return Container(
        color: const Color(0xff52796f),
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            return Card(
              color: const Color(0xff52796f),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                seleccted_animal: index,
                                filterd: true,
                              )));
                },
                title: Text(
                  SelectedAnimals[index]["name"] ?? "",
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xffcad2c5)),
                ),
              ),
            );
          },
          itemCount: SelectedAnimals.length,
        ),
      );
    }
  }
}
