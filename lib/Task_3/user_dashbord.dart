import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_1/widgets/cutome_card.dart';
import 'package:flutter_task1/Task_1/widgets/dash_table.dart';
import 'package:flutter_task1/Task_3/widgets/index.dart';


class UserDashbord extends StatefulWidget {
  const UserDashbord({super.key});

  @override
  State<UserDashbord> createState() => _UserDashbord();
}

class _UserDashbord extends State<UserDashbord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("User Dashboard Screen")),
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
                            Text("Name : John Doe"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Age : 25 Years"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
             
              Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2, 
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 5,
        children: [
          ActionButtons(
            text: "Update Profile",
            onPressed: () {},
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
          ),
          ActionButtons(
            text: "Write New Blog",
            onPressed: () {},
            backgroundColor: Colors.green,
            textColor: Colors.white,
          ),
          ActionButtons(
            text: "Manage Activity",
            onPressed: () {},
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
          ),
          ActionButtons(
            text: "Deactivate Account",
            onPressed: () {},
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
          ),
        ],
      ),
    ),
  ),
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
                      authorName: "John Doe",
                      blogContent: "Flutter widgets are the building blocks of the Flutter UI framework. In this article, we will explore the basics of widgets and how they form the core of every Flutter application...",
                    ),
                    BlogCard(
                      title: "Understanding Java MVC",
                      date: "October 7, 2024",
                      authorName: "John Doe",
                      blogContent: "Flutter widgets are the building blocks of the Flutter UI framework. In this article, we will explore the basics of widgets and how they form the core of every Flutter application...",
                    ),
                    BlogCard(
                      title: "Understanding Android XML",
                      date: "October 7, 2024",
                      authorName: "John Doe",
                      blogContent: "Flutter widgets are the building blocks of the Flutter UI framework. In this article, we will explore the basics of widgets and how they form the core of every Flutter application...",
                    ),
                    BlogCard(
                      title: "Understanding .NET Architeture",
                      date: "October 7, 2024",
                      authorName: "John Doe",
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
