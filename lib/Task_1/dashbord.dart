import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_1/widgets/cutome_card.dart';
import 'package:flutter_task1/Task_1/widgets/dash_table.dart';
import 'package:flutter_task1/login.dart';
import 'package:flutter_task1/router.dart';
import 'package:flutter_task1/sharedpref.dart';

import '../db.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _Dashbord();
}

class _Dashbord extends State<Dashbord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Dashboard Screen")),
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
                              print("Logout Not Added till Now");
                            },
                            child: const Text("Yes"))
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/person_icon.png',
                        height: 70,
                        width: 70,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name : TestName"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Age : 17 Years"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Checkout the Services...",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CutomeCard(
                        imagePath: 'assets/booking.png',
                        text: 'Go to here',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CutomeCard(
                        imagePath: 'assets/calender.png',
                        text: 'Booking',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Column(
                    children: [
                      CutomeCard(
                        imagePath: 'assets/attendance.jpg',
                        text: 'Check Meetings',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CutomeCard(
                        imagePath: 'assets/result.png',
                        text: 'Check The Result',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CutomeCard(
                        imagePath: 'assets/course.png',
                        text: 'Go to course ',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  DashTable(),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
