import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task1/login.dart';
import 'package:flutter_task1/router.dart';
import 'package:flutter_task1/sharedpref.dart';

import 'db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final TextEditingController _userNameEditController = TextEditingController();
  final TextEditingController _passwordEditController = TextEditingController();

  String firstname = "", lastname = "";

  void getRegData() async {
    final sharedPreferences = await SessionManager().init();
    String? regData = sharedPreferences.getString("regData");
    var jsonData = jsonDecode(regData!);

    setState(() {
      firstname = jsonData['first_name'];
      lastname = jsonData['last_name'];
    });
  }

  void getDataFromDB() async {
    List<Map<String, dynamic>> res = await MyDataBase().getRegistrationData(
        _userNameEditController.text, _passwordEditController.text);

    if (res.isEmpty) {
    } else {
      setState(() {
        firstname = res[0]['firstName'] as String;
        lastname = res[0]['lastName'] as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getRegData();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home Screen")),
        elevation: 50,
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (c) => AlertDialog(
                          title: const Text('Logout'),
                          content: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [Text("Do you want to logout?")],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No")),
                            TextButton(
                                onPressed: () async {
                                  await logout();
                                },
                                child: const Text("Yes"))
                          ],
                        ),);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          firstname != null && lastname != null
              ? Center(child: Text("WELCOME TO FLUTTER $firstname $lastname"))
              : const Center(child: Text("WELCOME TO FLUTTER")),
        ],
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(color: Colors.grey),
        child: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const Icon(
                    Icons.person,
                    size: 30,
                  )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left:8.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.profile);
                    },
                    child: const Align(
                      alignment: FractionalOffset.centerLeft,
                      child: Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left:8.0),
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: ()async {
                      showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                          title: const Text('Logout'),
                          content: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [Text("Do you want to logout?")],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No")),
                            TextButton(
                                onPressed: () async {
                                  await logout();
                                },
                                child: const Text("Yes"))
                          ],
                        ),);
                    },
                    child: const Align(
                      alignment: FractionalOffset.centerLeft,
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            const Divider(
              height: 0,
            )
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    await SessionManager().sharedPreferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return const Login();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
  }
}
