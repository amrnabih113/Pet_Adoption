import 'package:Pet_Gardin/database.dart';
import 'package:Pet_Gardin/global.dart';
import 'package:Pet_Gardin/photo.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool edit = false;
  final GlobalKey<ScaffoldState> scaffoldkey2 = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  bool showPassword = false;
  String? user_image;

  // Controllers to manage text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load user data
    _loadUserProfile();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loadUserProfile() {
    if (loginsession != null) {
      final user = users[loginsession!];
      if (user != null) {
        _emailController.text = user["email"] ?? "";
        _usernameController.text = user["username"] ?? "";
        _phoneController.text = user["phone"] ?? "";
        _passwordController.text = user["password"] ?? "";
        user_image = user["image"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey2,
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text("Edit Profile"),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff52796f),
            fontSize: 25),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xff52796f),
          iconSize: 25,
        ),
        centerTitle: true,
        actions: [
          !edit
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      edit = true;
                    });
                  },
                  icon: const Icon(Icons.edit),
                  color: const Color(0xff52796f),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      edit = false;
                    });
                    // You can add code here to save the updated data.
                  },
                  icon: const Icon(Icons.check),
                  color: const Color(0xff52796f),
                )
        ],
      ),
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
                decoration: const BoxDecoration(
                    color: Color(0xff52796f),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                padding: const EdgeInsets.all(20),
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Photo(
                                        imageurl: user_image ??
                                            "assets/images/userphoto.jpeg")));
                          },
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: const Color(0xff52796f), width: 4),
                            ),
                            child: CircleAvatar(
                                radius: 100,
                                backgroundImage: user_image != null
                                    ? AssetImage(user_image!)
                                    : const AssetImage(
                                        "assets/images/userphoto.jpeg")),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            scaffoldkey2.currentState!
                                .showBottomSheet((context) => Container());
                          },
                          icon: const Icon(Icons.add_circle),
                          iconSize: 35,
                          color: const Color(0xff52796f),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _usernameController,
                      enabled: edit,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffcad2c5)),
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
                      enabled: edit,
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
                      controller: _phoneController,
                      enabled: edit,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffcad2c5)),
                      cursorColor: const Color(0xFFFFCBA4),
                      decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          iconColor: Color(0xFFFFCBA4),
                          hintText: "Phone",
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
                      controller: _passwordController,
                      enabled: edit,
                      obscureText: !showPassword,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
