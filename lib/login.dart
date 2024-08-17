import 'package:Pet_Gardin/global.dart';
import 'package:Pet_Gardin/signup.dart';
import 'package:flutter/material.dart';

import 'package:Pet_Gardin/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showPassword = false;
  final Map<String, String> _inputData = {};

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  Future<bool> _checkUser() async {
    for (int i = 0; i < users.length; i++) {
      if (_inputData['email'] == users[i]["email"] &&
          _inputData['password'] == users[i]["password"]) {
        loginsession = i;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt("sessionid", loginsession!);
        return true;
      }
    }
    return false;
  }

  void _showErrorDialog(String message1, String message2) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff52796c),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Text(message1),
          titleTextStyle: const TextStyle(
              color: Color(0xFFFFCBA4),
              fontSize: 30,
              fontWeight: FontWeight.bold),
          content: Text(message2),
          contentTextStyle: const TextStyle(
            color: Color(0xffcad2c5),
            fontSize: 15,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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

  void _saveInput() {
    setState(() {
      _inputData['email'] = _emailController.text;
      _inputData['password'] = _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: SingleChildScrollView(
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
                    Image.asset(
                      "assets/images/logo.png",
                      color: const Color(0xFFFFCBA4),
                      height: 220,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffcad2c5)),
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
                          fontWeight: FontWeight.bold,
                          color: Color(0xffcad2c5)),
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
                    const Text(
                      "Forget Password?",
                      style: TextStyle(color: Color(0xffcad2c5)),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                        onPressed: () async {
                          _saveInput();

                          await _checkUser()
                              ? Navigator.of(context)
                                  .pushReplacementNamed("homepage")
                              : _showErrorDialog(
                                  "Erorr", "Wrong Email or Password");
                        },
                        color: const Color(0xFFFFCBA4),
                        minWidth: double.infinity,
                        height: 40,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text("Log In",
                            style: TextStyle(color: Color(0xff52796f)))),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Not a member? ',
                          style: TextStyle(color: Color(0xFFBFC9CA)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()),
                            );
                          },
                          child: const Text(
                            'Join now',
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
      ),
      backgroundColor: const Color(0xff52796f),
    );
  }
}
