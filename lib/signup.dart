import 'package:Pet_Gardin/global.dart';
import 'package:Pet_Gardin/login.dart';
import 'package:flutter/material.dart';
import 'package:Pet_Gardin/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool showPassword = false;
  final Map<String, String> _inputData = {};

  @override
  void dispose() {
    _focusNode.dispose();
    save_users();
    super.dispose();
  }

  void save_users() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json_users = jsonEncode(users);
    prefs.setString('users', json_users);
  }

  void _showErrorDialog(String massagetitle, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff52796c),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Text(massagetitle),
          titleTextStyle: const TextStyle(
              color: Color(0xFFFFCBA4),
              fontSize: 30,
              fontWeight: FontWeight.bold),
          content: Text(message),
          contentTextStyle: const TextStyle(
            color: Color(0xffcad2c5),
            fontSize: 15,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (massagetitle == "Signed up") {
                  Navigator.of(context).pushReplacementNamed("login");
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFFFFCBA4)),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _checkUser() {
    for (int i = 0; i < users.length; i++) {
      if (_inputData['email'] == users[i]["email"]) {
        return false;
      }
    }

    users.add(
      {
        "username": _inputData['username'],
        "email": _inputData['email'],
        "password": _inputData['password'],
        "image": null,
        "phone": null,
      },
    );
    loginsession = users.length - 1;

    return true;
  }

  void _saveInput() {
    setState(() {
      _inputData['email'] = _emailController.text;
      _inputData['password'] = _passwordController.text;
      _inputData['username'] = _nameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFCBA4),
                        fontSize: 50,
                      )),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xffcad2c5)),
                    cursorColor: const Color(0xFFFFCBA4),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        iconColor: Color(0xFFFFCBA4),
                        hintText: "Username",
                        labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFCBA4)),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffcad2c5)),
                        contentPadding: EdgeInsets.all(5),
                        focusColor: Color(0xFFFFCBA4),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffcad2c5), width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFCBA4),
                            width: 2,
                          ),
                        )),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xffcad2c5)),
                    cursorColor: const Color(0xFFFFCBA4),
                    decoration: const InputDecoration(
                        icon: Icon(Icons.mail),
                        iconColor: Color(0xFFFFCBA4),
                        hintText: "E-MAIL",
                        labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFCBA4)),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffcad2c5)),
                        contentPadding: EdgeInsets.all(5),
                        focusColor: Color(0xFFFFCBA4),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffcad2c5), width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFCBA4),
                            width: 2,
                          ),
                        )),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    obscureText: !showPassword,
                    controller: _passwordController,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xffcad2c5)),
                    cursorColor: const Color(0xFFFFCBA4),
                    decoration: InputDecoration(
                        suffixIconColor: const Color(0xFFFFCBA4),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: showPassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.remove_red_eye)),
                        icon: const Icon(Icons.password_rounded),
                        iconColor: const Color(0xFFFFCBA4),
                        hintText: "PASSWORD",
                        labelStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFCBA4)),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffcad2c5)),
                        contentPadding: const EdgeInsets.all(5),
                        focusColor: const Color(0xFFFFCBA4),
                        border: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffcad2c5), width: 2),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFCBA4),
                            width: 2,
                          ),
                        )),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                      onPressed: () {
                        _saveInput();
                        _checkUser()
                            ? _showErrorDialog(
                                "Signed up", "Thank you for signing up")
                            : _showErrorDialog(
                                "Error", "This email already exists");
                      },
                      color: const Color(0xFFFFCBA4),
                      minWidth: double.infinity,
                      height: 40,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text("Sign Up",
                          style: TextStyle(color: Color(0xff52796f)))),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Aleady Have An Email? ',
                        style: TextStyle(color: Color(0xFFBFC9CA)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(color: Color(0xFFFFCBA4)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xff52796f),
    );
  }
}
