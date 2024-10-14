import 'package:flutter/material.dart';

import 'package:flutter_task1/Task_3/widgets/index.dart';


class UserBlogsNavigation extends StatefulWidget {
  const UserBlogsNavigation({super.key});

  @override
  State<UserBlogsNavigation> createState() => _UserBlogsNavigation();
}

class _UserBlogsNavigation extends State<UserBlogsNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("User Blog Screen")),
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
              
              const SizedBox(height: 10,),
             

              const SizedBox(height: 10),

              const Text(
                "Your Blogs...",
                style: TextStyle(
                  fontSize: 24.0, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.black, 
                ),
              ),

              const SizedBox(height: 10,),
             Container(
                child:const Wrap(
                  children: [
                    BlogCard(
                      title: "Understanding Flutter Widgets",
                      date: "October 7, 2024",
                      authorName: "Anonymous",
                      blogContent: "Flutter widgets are the building blocks of the Flutter UI framework. In this article, we will explore the basics of widgets and how they form the core of every Flutter application...",
                    ),
                    BlogCard(
                      title: "Understanding Java MVC",
                      date: "October 7, 2024",
                      authorName: "Anonymous",
                      blogContent: "Flutter widgets are the building blocks of the Flutter UI framework. In this article, we will explore the basics of widgets and how they form the core of every Flutter application...",
                    ),
                    BlogCard(
                      title: "Understanding Android XML",
                      date: "October 7, 2024",
                      authorName: "Anonymous",
                      blogContent: "Flutter widgets are the building blocks of the Flutter UI framework. In this article, we will explore the basics of widgets and how they form the core of every Flutter application...",
                    ),
                    BlogCard(
                      title: "Understanding .NET Architeture",
                      date: "October 7, 2024",
                      authorName: "Anonymous",
                      blogContent: "Flutter widgets are the building blocks of the Flutter UI framework. In this article, we will explore the basics of widgets and how they form the core of every Flutter application...",
                    ),

                    // Add more BlogCard widgets here
                  ],
                ),
              )

            ],
          ),
        ));
  }
}
