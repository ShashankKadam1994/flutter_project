import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_5/dynamic_list.dart';
import 'package:flutter_task1/Task_7/user_blogs_navigation.dart';
import 'package:flutter_task1/Task_9/fetch_user_data.dart';
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
                        text: "User Profile(Task 3)",
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
                        text: "Write New Blog(Task 5)",
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
                        text: "Routing and Nevigation",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const UserBlogsNavigation()),
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
                        text: "Fetch Movie Data",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FetchUserData()),
                          );
                        },
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
