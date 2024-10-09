import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_5/dynamic_list.dart';
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
  String formatDate(DateTime date) {
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    final day = DateFormat('d').format(date);
    final month = DateFormat('MMMM').format(date);
    final year = DateFormat('y').format(date);
    final suffix = daySuffix(int.parse(day));

    return '$day$suffix of $month $year';
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
    DateTime dateCurr=DateTime.now();
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.9;
    double buttonHeight = 55;
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
             SizedBox(height: 20),
            Divider(),
            firstname != null && lastname != null
                ? Center(
              child: Text(
                "Welcome Priyanka\nToday's date is ${formatDate(dateCurr)}: $firstname $lastname",
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
             SizedBox(height: 20),
            Divider(),
           
            SizedBox(height: 20),

            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child:ActionButtons(
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
                     ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child:ActionButtons(
                        text: "Write New Blog",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DynamicList()),
                          );
                        },
                        backgroundColor: Colors.purple,
                        textColor: Colors.white,
                      ),
                     ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child:ActionButtons(
                        text: "Manage Activity",
                        onPressed: () {},
                        backgroundColor: Colors.purple,
                        textColor: Colors.white,
                      ),
                     ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child:ActionButtons(
                        text: "Deactivate Account",
                        onPressed: () {},
                        backgroundColor: Colors.purple,
                        textColor: Colors.white,
                      ),
                    )
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
