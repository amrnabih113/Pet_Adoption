import 'dart:convert';

import 'package:Pet_Gardin/database.dart';
import 'package:Pet_Gardin/global.dart';
import 'package:Pet_Gardin/login.dart';
import 'package:flutter/material.dart';
import 'package:Pet_Gardin/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getsessionid();
  }

  void getsessionid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginsession = prefs.getInt("sessionid");
    });
  }

  void get_users() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var json_users = prefs.getString("users");
      users = jsonDecode(json_users!);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loginsession == null || loginsession == -1
          ? const Login()
          : const Homepage(),
      routes: {
        "homepage": (context) => const Homepage(),
        "login": (context) => const Login(),
      },
    );
  }
}
