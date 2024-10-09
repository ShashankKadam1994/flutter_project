import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TitleField extends StatelessWidget {
  final void Function(String) onSaved;

  const TitleField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Blog Title Here',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:const BorderSide(
            color: Colors.grey, 
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:const BorderSide(
            color: Colors.blue, 
            width: 2.0, 
          ),
        ),
          suffixIcon: IconButton(
          icon:const Icon(
           Icons.text_fields,
           color: Colors.grey,
          ),
          onPressed: () {
            
          },
        ),
      ),
    
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the blog title field.';
        }
        return null;
      },
      onChanged: (value) {
        onSaved(value);
      },
      onSaved: (String? value) {
        print(value);
        onSaved(value!);
      },
    );
  }
}
