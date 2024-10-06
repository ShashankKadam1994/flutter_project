import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task1/login.dart';
import 'package:flutter_task1/router.dart';
import 'package:flutter_task1/sharedpref.dart';

import '../db.dart';

class HelloProfile extends StatefulWidget {
  const HelloProfile({super.key});

  @override
  State<HelloProfile> createState() => _HelloProfile();
}

class _HelloProfile extends State<HelloProfile> {
  @override
  Widget build(BuildContext context) {
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First set of text widgets
            SizedBox(
              child: Column(
                children: [

                  Text(
                    "Hello World!",
                    style: TextStyle(color: Colors.red,
                    fontStyle:FontStyle.normal ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Space between the two sets of widgets

            // Align the second SizedBox differently
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Hello World!",
                      style: TextStyle(
                          fontSize: 24,
                          // Font size
                          fontWeight: FontWeight.bold,
                          // Bold
                          fontStyle: FontStyle.italic,
                          // Italic
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          letterSpacing: 2.0),
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
}
