import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task1/db.dart';
import 'package:flutter_task1/home.dart';
import 'package:flutter_task1/router.dart';
import 'package:flutter_task1/sharedpref.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userNameEditController = TextEditingController();
  final TextEditingController _passwordEditController = TextEditingController();

  // final TextEditingController _usernameEditController = TextEditingController();
  // final TextEditingController _passEditController = TextEditingController();

  bool _isSecPass = true;
  late String email, password;

  void getRegData() async {
    final sharedPreferences = await SessionManager().init();
    String? regData = sharedPreferences.getString("regData");
    var jsonData = jsonDecode(regData!);

    // _userNameEditController.text = jsonData['firstName'];
    // _passwordEditController.text = jsonData['password'];

    setState(() {
      email = jsonData['email'];
      password = jsonData['password'];
    });
  }

  Future<bool> getDataFromDB() async {
    List<Map<String, dynamic>> res = await MyDataBase().getRegistrationData(
        _userNameEditController.text, _passwordEditController.text);

    print(res);

    if (res.isEmpty) {
      return false;
    } else {
      await SessionManager()
          .sharedPreferences
          .setString("regData", jsonEncode(res[0]));

      await SessionManager().sharedPreferences.setBool("isLoggedIn", true);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    getRegData();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Login")),
        elevation: 50,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Visibility(
                visible: false,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Login with your credentials",
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _userNameEditController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Username")),
                  // maxLength: 10,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _passwordEditController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _isSecPass
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isSecPass = !_isSecPass;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                      label: const Text("Password")),
                  obscureText: _isSecPass,
                ),
              ),
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
                            "Please enter Username",
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    return;
                  }

                  // if (_userNameEditController.text != email) {
                  //   ScaffoldMessenger.of(context)
                  //     ..clearSnackBars()
                  //     ..showSnackBar(
                  //       const SnackBar(
                  //         content: Text(
                  //           "Please enter correct username",
                  //         ),
                  //         backgroundColor: Colors.red,
                  //         duration: Duration(seconds: 3),
                  //       ),
                  //     );
                  //   return;
                  // }

                  if (_passwordEditController.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(const SnackBar(
                        content: Text(
                          "Please enter Password",
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ));
                    return;
                  }

                  // if (_passwordEditController.text != password) {
                  //   ScaffoldMessenger.of(context)
                  //     ..clearSnackBars()
                  //     ..showSnackBar(const SnackBar(
                  //       content: Text(
                  //         "Please enter correct password",
                  //       ),
                  //       backgroundColor: Colors.red,
                  //       duration: Duration(seconds: 3),
                  //     ));
                  //   return;
                  // }

                  if (await getDataFromDB() == false) {
                    if (mounted) {
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(const SnackBar(
                          content: Text(
                            "Invalid credentials..",
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ));
                    }
                    return;
                  }

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const HomePage(),
                  //   ),
                  // );

                  Navigator.of(context).pushNamed(AppRoutes.home);
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(200),
                    backgroundColor: Colors.amber),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              TextButton(onPressed: (){
                Navigator.pushNamed(context, AppRoutes.reg);
              }, child: Text("Don't have account? Sign Up Here",style: TextStyle(color: Colors.deepPurpleAccent),))
            ],
          ),
        ),
      ),
    );
  }
}
