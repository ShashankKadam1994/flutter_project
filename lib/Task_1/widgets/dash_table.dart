import 'package:flutter/material.dart';

class DashTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(),
        columnWidths: const{
          0:  FixedColumnWidth(150), // Width for the first column
          1: FixedColumnWidth(100), // Width for the second column
        },
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.grey[300]),
            children:const [
               Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
               Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('Age', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const TableRow(
            children: [
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('Rohit'),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('28'),
              ),
            ],
          ),
          const TableRow(
            children: [
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('Ritesh'),
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('22'),
              ),
            ],
          ),
          // Add more TableRow as needed
        ],
      ),
    );
  }
}
