import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  final String blogTitle;
  final String blogContent;
  final String blogDate;
  final String blogUser;
  
  const BlogPage({super.key,required this.blogContent,required this.blogDate,required this.blogUser,required this.blogTitle});

  @override
  State<BlogPage> createState() => _BlogPage();
}

class _BlogPage extends State<BlogPage> {
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Blog Screen")),
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
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
           
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:Column(
                children: [
                 Text(
                  widget.blogTitle
                 ),
                  const SizedBox(height: 20),
                  Text(
                    widget.blogContent
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.blogDate
                  ),
                  const SizedBox(height: 20),
                  
                ],
              ),
            ),
            const SizedBox(height: 20),
            Divider(),
            
            const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
