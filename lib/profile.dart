import 'dart:convert';
import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task1/sharedpref.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getRegData());
  }

  void getRegData() async {
    final sharedPreferences = await SessionManager().init();
    String? regData = sharedPreferences.getString("regData");
    var jsonData = jsonDecode(regData!);

    print(jsonData);
    // _userNameEditController.text = jsonData['firstName'];
    // _passwordEditController.text = jsonData['password'];
//{id: 1, title: DISHANK, first_name: DISHANK, middle_name: D, last_name: KADAM, mobile_number: 9730484894, email_id: dk.dishank123@gmail.com, password: 12345689, gender: M, dob_birth: 01/10/1992, age: 32}
    setState(() {
      _userNameEditController.text = jsonData['first_name'];
      _userNameMiddle.text = jsonData['middle_name'];
      _userNameLast.text = jsonData['last_name'];
      _userMobileNumber.text = jsonData['mobile_number'];
      _userEmailId.text = jsonData['email_id'];
      _dobController.text = jsonData['dob_birth'];
      _ageController.text = jsonData['age'];
      _selectedValue=jsonData['gender'];
      dropdownValue=jsonData['title'];
    });
  }

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
        title: Text("Profile"),
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
                    onChanged:null,
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
                  readOnly: true,
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
                  readOnly: true,
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
                  readOnly: true,
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
                  readOnly: true,
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
                    readOnly: true,
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
                            onChanged:null
                            ,
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
                            onChanged: null
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

              const SizedBox(
                height: 20,
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     if (_userNameEditController.text.isEmpty) {
              //       ScaffoldMessenger.of(context)
              //         ..clearSnackBars()
              //         ..showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //               "Please enter first name",
              //             ),
              //             backgroundColor: Colors.red,
              //             duration: Duration(seconds: 3),
              //           ),
              //         );
              //       return;
              //     }
              //     if (_userNameMiddle.text.isEmpty) {
              //       ScaffoldMessenger.of(context)
              //         ..clearSnackBars()
              //         ..showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //               "Please enter middle name",
              //             ),
              //             backgroundColor: Colors.red,
              //             duration: Duration(seconds: 3),
              //           ),
              //         );
              //       return;
              //     }
              //     if (_userNameLast.text.isEmpty) {
              //       ScaffoldMessenger.of(context)
              //         ..clearSnackBars()
              //         ..showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //               "Please enter last name",
              //             ),
              //             backgroundColor: Colors.red,
              //             duration: Duration(seconds: 3),
              //           ),
              //         );
              //       return;
              //     }
              //
              //     if (_userMobileNumber.text.isEmpty) {
              //       ScaffoldMessenger.of(context)
              //         ..clearSnackBars()
              //         ..showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //               "Please enter mobile number",
              //             ),
              //             backgroundColor: Colors.red,
              //             duration: Duration(seconds: 3),
              //           ),
              //         );
              //       return;
              //     }
              //     if (_userEmailId.text.isEmpty) {
              //       ScaffoldMessenger.of(context)
              //         ..clearSnackBars()
              //         ..showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //               "Please enter email Id",
              //             ),
              //             backgroundColor: Colors.red,
              //             duration: Duration(seconds: 3),
              //           ),
              //         );
              //       return;
              //     }
              //
              //     if (_userPassword.text.isEmpty) {
              //       ScaffoldMessenger.of(context)
              //         ..clearSnackBars()
              //         ..showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //               "Please enter password",
              //             ),
              //             backgroundColor: Colors.red,
              //             duration: Duration(seconds: 3),
              //           ),
              //         );
              //       return;
              //     }
              //
              //     if (!(_userPassword.text.length == 8)) {
              //       ScaffoldMessenger.of(context)
              //         ..clearSnackBars()
              //         ..showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //               "Please enter valid password",
              //             ),
              //             backgroundColor: Colors.red,
              //             duration: Duration(seconds: 3),
              //           ),
              //         );
              //       return;
              //     }
              //
              //     if (_dobController.text.isEmpty) {
              //       ScaffoldMessenger.of(context)
              //         ..clearSnackBars()
              //         ..showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //               "Please select date",
              //             ),
              //             backgroundColor: Colors.red,
              //             duration: Duration(seconds: 3),
              //           ),
              //         );
              //       return;
              //     }
              //     var regDetails = RegistrationModel(
              //         title: dropdownValue,
              //         fname: _userNameEditController.text,
              //         mname: _userNameMiddle.text,
              //         lname: _userNameLast.text,
              //         mnumber: _userMobileNumber.text,
              //         email: _userEmailId.text,
              //         password: _userPassword.text,
              //         gender:_selectedValue.toString(),
              //         dob: _dobController.text,
              //         age: int.parse(
              //             _ageController.text.replaceAll(" Year", "")));
              //
              //     await MyDataBase().initializedDB();
              //     var res =
              //     await MyDataBase().insertRegistrationDetails(regDetails);
              //     if (res != 0) {
              //       if (mounted) {
              //         ScaffoldMessenger.of(context)
              //           ..clearSnackBars()
              //           ..showSnackBar(
              //             const SnackBar(
              //               content: Text(
              //                 "Registration data stored successfully!!",
              //               ),
              //               backgroundColor: Colors.green,
              //               duration: Duration(seconds: 3),
              //             ),
              //           );
              //       }
              //
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) => const Login(),
              //         ),
              //       );
              //     } else {
              //       if (mounted) {
              //         ScaffoldMessenger.of(context)
              //           ..clearSnackBars()
              //           ..showSnackBar(
              //             const SnackBar(
              //               content: Text(
              //                 "Unable to save registration details!",
              //               ),
              //               backgroundColor: Colors.red,
              //               duration: Duration(seconds: 3),
              //             ),
              //           );
              //       }
              //     }
              //   },
              //   style: ElevatedButton.styleFrom(
              //       fixedSize: const Size.fromWidth(200),
              //       backgroundColor: Colors.red),
              //   child: const Text(
              //     "Submit",
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
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
