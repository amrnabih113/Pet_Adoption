import 'package:Pet_Gardin/database.dart';
import 'package:Pet_Gardin/global.dart';
import 'package:Pet_Gardin/photo.dart';
import 'package:Pet_Gardin/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: ListView(children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Photo(
                          imageurl: users[loginsession!]["image"] ??
                              "assets/images/userphoto.jpeg"),
                    )),
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
              ),
              Expanded(
                  child: ListTile(
                title: Text(
                  users[loginsession!]["username"],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                subtitle: Text(
                  users[loginsession!]["email"],
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ))
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.pets),
            title: const Text(
              "Adoption",
            ),
            iconColor: Colors.white,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.account_balance),
            title: const Text(
              "Donation",
            ),
            iconColor: Colors.white,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          ListTile(
            onTap: () {
              scaffoldkey1.currentState!.closeDrawer();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "UNDER BUILDING",
                  style: TextStyle(
                      color: Color(0xffcad2c5),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                showCloseIcon: true,
                duration: Duration(seconds: 2),
                backgroundColor: Color(0xff52796f),
              ));
            },
            leading: const Icon(Icons.add),
            title: const Text(
              "Add Pet",
            ),
            iconColor: Colors.white,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.favorite),
            title: const Text(
              "Favourate",
            ),
            iconColor: Colors.white,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.mail),
            title: const Text(
              "Masseges",
            ),
            iconColor: Colors.white,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            leading: const Icon(Icons.person),
            title: const Text(
              "profile",
            ),
            iconColor: Colors.white,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(
            height: 170,
          ),
          ListTile(
            onTap: () {
              scaffoldkey1.currentState!.closeDrawer();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 1),
                content: Text("UNDER BUILDING",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffcad2c5))),
                backgroundColor: Color(0xff52796f),
              ));
            },
            leading: const Icon(Icons.settings),
            title: const Text(
              "Settings",
            ),
            iconColor: Colors.white,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          ListTile(
            onTap: () {
              scaffoldkey1.currentState!.closeDrawer();
              scaffoldkey1.currentState!.showBottomSheet(
                (context) {
                  return Container(
                    height: 120,
                    color: const Color(0xff52796f),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Text(
                              "Logging Out",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFCBA4)),
                            ),
                            Text(
                              "Are you sure ?",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffcad2c5)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        MaterialButton(
                            onPressed: () async {
                              loginsession = null;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setInt("sessionid", -1);
                              Navigator.of(context)
                                  .pushReplacementNamed("login");
                            },
                            color: const Color(0xFFFFCBA4),
                            minWidth: 30,
                            height: 40,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text("Ok",
                                style: TextStyle(color: Color(0xff52796f)))),
                        const SizedBox(
                          width: 30,
                        ),
                        MaterialButton(
                            onPressed: () {
                              Navigator.pop(scaffoldkey1.currentState!.context);
                            },
                            color: const Color(0xFFFFCBA4),
                            minWidth: 30,
                            height: 40,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text("cancel",
                                style: TextStyle(color: Color(0xff52796f))))
                      ],
                    ),
                  );
                },
              );
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text(
              "Log out",
            ),
            iconColor: Colors.white,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ]));
  }
}
