import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_7/blog_page.dart';
import 'package:flutter_task1/utilility/card_modal.dart';

class BlogCard extends StatelessWidget {
  final String title;
  final String date;
  final String authorName;
  final String blogContent;

  const BlogCard({
    Key? key,
    required this.title,
    required this.date,
    required this.authorName,
    required this.blogContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
         child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "By $authorName",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              blogContent,
              maxLines: 2, 
              overflow: TextOverflow.ellipsis, 
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showCardModal(context, blogContent, title, date, authorName, (){});
                },
                child:const Text(
                  "Read More",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                  ),
                ),

              ),
            ),

             Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                     Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BlogPage(blogTitle:title,blogContent:blogContent,blogDate:date,blogUser:authorName)) ,
                      );
                },
                child:const Text(
                  "Read on next page",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                  ),
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
