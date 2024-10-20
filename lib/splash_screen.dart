import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_1/dashbord.dart';
import 'package:flutter_task1/Task_1/hello_profile.dart';
import 'package:flutter_task1/Task_3/user_dashbord.dart';
import 'package:flutter_task1/home.dart';
import 'package:flutter_task1/homeNew.dart';
import 'package:flutter_task1/login.dart';
import 'package:flutter_task1/practise.dart';
import 'package:flutter_task1/sharedpref.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // if (SessionManager().sharedPreferences.getBool("isLoggedIn") != null &&
    //     SessionManager().sharedPreferences.getBool("isLoggedIn") == true) {
    //   _navigateToHome();
    // }else{
    //   _navigateToReg();
    // }
    _navigateToReg();

  }

  _navigateToHome() async {
    await Future.delayed(
        const Duration(milliseconds: 3000), () {}); // Delay for 3 seconds
    Navigator.pushReplacement(
      context,
      // MaterialPageRoute(builder: (context) => const HomePage()),
      // MaterialPageRoute(builder: (context) => const Dashbord()),
      MaterialPageRoute(builder: (context) => const Homenew()) ,
    );
  }
  _navigateToReg() async {
    await Future.delayed(
        const Duration(milliseconds: 3000), () {}); // Delay for 3 seconds
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      // MaterialPageRoute(builder: (context) => const Dashbord()) ,
      // MaterialPageRoute(builder: (context) => const Homenew()) ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/welcome.jpg', width: 300, height: 300),
            // Your image here
            SizedBox(height: 20),
            CircularProgressIndicator(),
            // Loading indicator
          ],
        ),
      ),
    );
  }
}
