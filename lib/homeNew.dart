import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task1/login.dart';
import 'package:flutter_task1/router.dart';
import 'package:flutter_task1/sharedpref.dart';
import 'package:intl/intl.dart';

import 'Task_3/user_dashbord.dart';
import 'Task_3/widgets/action_buttons.dart';
import 'db.dart';

class Homenew extends StatefulWidget {
  const Homenew({super.key});

  @override
  State<Homenew> createState() => _HomeNewState();
}

class _HomeNewState extends State<Homenew> {
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


    String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

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
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await logout();
                      },
                      child: const Text("Yes"),
                    )
                  ],
                ),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Updated greeting with current date
            firstname != null && lastname != null
                ? Center(
              child: Text(
                "Welcome Priyanka\nToday's date is $currentDate: $firstname $lastname",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
                : const Center(
              child: Text(
                "Welcome Priyanka",
                style: TextStyle(fontSize: 18),
              ),
            ),

            SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ActionButtons(
                      text: "Task 3",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UserDashbord()),
                        );
                      },
                      backgroundColor: Colors.purple,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 10),
                    ActionButtons(
                      text: "Write New Blog",
                      onPressed: () {},
                      backgroundColor: Colors.purple,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 10),
                    ActionButtons(
                      text: "Manage Activity",
                      onPressed: () {},
                      backgroundColor: Colors.purple,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 10),
                    ActionButtons(
                      text: "Deactivate Account",
                      onPressed: () {},
                      backgroundColor: Colors.purple,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
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
