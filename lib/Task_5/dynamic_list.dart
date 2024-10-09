import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_1/widgets/cutome_card.dart';
import 'package:flutter_task1/Task_1/widgets/dash_table.dart';
import 'package:flutter_task1/Task_3/widgets/index.dart';
import 'package:flutter_task1/Task_5/models/blog_model.dart';
import 'package:flutter_task1/Task_5/widgets/content_fild.dart';
import 'package:flutter_task1/Task_5/widgets/date_field.dart';
import 'package:flutter_task1/Task_5/widgets/title_field.dart';

class DynamicList extends StatefulWidget {
  const DynamicList({super.key});

  @override
  State<DynamicList> createState() => _DynamicList();
}

class _DynamicList extends State<DynamicList> {
  late String _blogTitle='';
  late String _blogContent='';
  late DateTime _date;
  int id=1;
  List<BlogModel> blogs = [];
  DateTime? _selectedDate = DateTime.now();

  void _handleDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _submitForm() {
    if (_blogTitle.isNotEmpty && _blogContent.isNotEmpty && _selectedDate != null) {
      final newBlog = BlogModel(
        id:id,
        title: _blogTitle,
        date: _selectedDate!.toLocal().toString().split(' ')[0], 
        userInfo: "Anonymous",
        blogContent: _blogContent,
      );

      // Add the new blog to the list and refresh the UI
      setState(() {
        blogs.add(newBlog);
        id++;
      });
    } else {
      print('Form is incomplete');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Add Blog Screen")),
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
                  TitleField(onSaved: (value) => _blogTitle = value),
                  const SizedBox(height: 20),
                  ContentFild(onSaved: (value) => _blogContent = value), 
                  const SizedBox(height: 20),
                  DateField(
                    onDateSelected: _handleDateSelected,
                    initialDate: _selectedDate ?? DateTime.now(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF313256),
                      foregroundColor: Colors.white,
                      fixedSize: Size(buttonWidth, 50),
                    ),
                    onPressed: _submitForm,
                    child: const Text('Submit Blog'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Divider(),
            const SizedBox(height: 20),
             const Text(
              "Your Blogs...",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Wrap(
                children: blogs.map((blog) {
                  return BlogCard(
                    title: blog.title,
                    date: blog.date,
                    authorName: blog.userInfo,
                    blogContent: blog.blogContent,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
