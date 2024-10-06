import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task1/db.dart';
import 'package:flutter_task1/login.dart';
import 'package:flutter_task1/registration.dart';
import 'package:flutter_task1/router.dart';
import 'package:flutter_task1/sharedpref.dart';
import 'package:intl/intl.dart';
import 'package:form_validator/form_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sqflite/sqflite.dart';

// import 'package:dependency_validator/';

enum SingingCharacter { lafayette, jefferson }

class practise extends StatefulWidget {
  const practise({super.key});

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  State<practise> createState() => _PractiseState();
}

class _PractiseState extends State<practise> {
  final _formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address.';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter valid an email address';
    }
    return null;
  }

  final TextEditingController _userNameEditController = TextEditingController();
  final TextEditingController _userNameMiddle = TextEditingController();
  final TextEditingController _userNameLast = TextEditingController();
  final TextEditingController _userMobileNumber = TextEditingController();
  final TextEditingController _userEmailId = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String dropdownValue = "Mr.", _selectedValue = "Male";
  // int _selectedValue = 1;

//   getDatabasesPath() {
//
//     // Avoid errors caused by flutter upgrade.
// // Importing 'package:flutter/widgets.dart' is required.
//     WidgetsFlutterBinding.ensureInitialized();
// // Open the database and store the reference.
//     final database = openDatabase(
//       // Set the path to the database. Note: Using the `join` function from the
//       // `path` package is best practice to ensure the path is correctly
//       // constructed for each platform.
//         join(await getDatabasesPath(), 'doggie_database.db'),
//     );
//   }

  Future<bool> storeData() async {
    Map<String, dynamic> jsonData = {
      "title": dropdownValue,
      "firstName": _userNameEditController.text,
      "middleName": _userNameMiddle.text,
      "lastName": _userNameLast.text,
      "mobile": _userMobileNumber.text,
      "email": _userEmailId.text,
      "password": _userPassword.text,
      "dob": _dobController.text,
      "age": _ageController.text
    };

    final sharedPreferences = await SessionManager().init();
    return await sharedPreferences.setString("regData", jsonEncode(jsonData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Registration")),
        elevation: 50,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: .5),
                    borderRadius: BorderRadius.circular(5)),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    // icon: const Icon(Icons.menu),
                    style: const TextStyle(color: Colors.black),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Mr.',
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Mr.'),
                            )),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Mrs.',
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Mrs.'),
                            )),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Ms.',
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Ms.'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _userNameEditController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[A-Z]"))
                  ],
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                        "First Name",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _userNameMiddle,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[A-Z]"))
                  ],
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Middle Name")),
                  obscureText: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _userNameLast,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[A-Z]"))
                  ],
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Last Name")),
                  obscureText: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _userMobileNumber,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'^[0-5]')),
                    FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                  ],
                  keyboardType: TextInputType.phone,

                  // textCapitalization: TextCapitalization.characters,

                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      counterText: "",
                      label: Text("Mobile Number")),
                  obscureText: false,
                  maxLength: 10,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Form(
                  key: _formKey,
                  child: TextField(
                    controller: _userEmailId,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp((r'[a-zA-Z0-9@._+-]')))
                    ],
                    keyboardType: TextInputType.emailAddress,
                    // textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text("Email ID")),

                    obscureText: false,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _userPassword,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(
                  //       RegExp((r'[a-zA-Z0-9@._+-]')))
                  // ],

                  keyboardType: TextInputType.text,

                  // textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                      label: Text("Password")),
                  obscureText: false,
                  maxLength: 8,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Gender"),
              ),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: .5),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(.5),
                          child: RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'Male',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: 'Male',
                            groupValue: _selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedValue = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0.5),
                          child: RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'Female',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: 'Female',
                            groupValue: _selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedValue = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _dobController,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(
                  //       RegExp((r'[a-zA-Z0-9@._+-]')))
                  // ],

                  readOnly: true,
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2050),
                    );

                    print(date);
                    _dobController.text =
                        DateFormat("dd/MM/yyyy").format(date!);

                    var age = DateTime.now().difference(date).inDays / 365;

                    print(age);
                    NumberFormat nm = NumberFormat("##");

                    _ageController.text = nm.format(age) + " " + "Year";
                  },
                  keyboardType: TextInputType.text,
                  // textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Date Of Birth")),
                  obscureText: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _ageController,

                  readOnly: true,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.deny(RegExp(r'^[0-5]')),
                  //   FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                  // ],
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Age")),
                  obscureText: false,
                ),
              ),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, AppRoutes.login);
              }, child: Text("Already have account? Sign In")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_userNameEditController.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter first name",
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    return;
                  }
                  if (_userNameMiddle.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter middle name",
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    return;
                  }
                  if (_userNameLast.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter last name",
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    return;
                  }

                  if (_userMobileNumber.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter mobile number",
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    return;
                  }
                  if (_userEmailId.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter email Id",
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    return;
                  }

                  if (_userPassword.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter password",
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    return;
                  }

                  if (!(_userPassword.text.length == 8)) {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter valid password",
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    return;
                  }

                  if (_dobController.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please select date",
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    return;
                  }
                  var regDetails = RegistrationModel(
                      title: dropdownValue,
                      fname: _userNameEditController.text,
                      mname: _userNameMiddle.text,
                      lname: _userNameLast.text,
                      mnumber: _userMobileNumber.text,
                      email: _userEmailId.text,
                      password: _userPassword.text,
                      gender:_selectedValue,
                      dob: _dobController.text,
                      age: int.parse(
                          _ageController.text.replaceAll(" Year", "")));

                  await MyDataBase().initializedDB();
                  var res =
                      await MyDataBase().insertRegistrationDetails(regDetails);
                  if (res != 0) {
                    if (mounted) {
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Registration data stored successfully!!",
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 3),
                          ),
                        );
                    }

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Unable to save registration details!",
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ),
                        );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(200),
                    backgroundColor: Colors.red),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                    height: 100,
                    width: 200,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
