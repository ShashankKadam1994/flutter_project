
import 'dart:core';

class RegistrationModel {
  late final String title;
  late final String fname;
  late final String mname;
  late final String lname;
  late final String mnumber;
  late final String email;
  late final String password;
  late final String gender;
  late final String dob;
  late final int age;

  RegistrationModel({
    required this.title,
    required this.fname,
    required this.mname,
    required this.lname,
    required this.mnumber,
    required this.email,
    required this.password,
    required this.gender,
    required this.dob,
    required this.age,

  });

  // RegistrationModel.fromMap(Map<String, dynamic> result)

  Map<String, Object> toMap() {
    return {
      'title': title,
      'first_name': fname,
      'middle_name': mname,
      'last_name': lname,
      'mobile_number': mnumber,
      'email_id': email,
      'password': password,
      'gender': gender,
      'dob_birth': dob,
      'age': age,
    };
  }
}

