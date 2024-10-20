import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_1/dashbord.dart';
import 'package:flutter_task1/Task_1/hello_profile.dart';
import 'package:flutter_task1/Task_3/user_dashbord.dart';
import 'package:flutter_task1/Task_5/dynamic_list.dart';
import 'package:flutter_task1/Task_7/blog_page.dart';
import 'package:flutter_task1/home.dart';
import 'package:flutter_task1/homeNew.dart';
import 'package:flutter_task1/login.dart';
import 'package:flutter_task1/practise.dart';
import 'package:flutter_task1/profile.dart';

class AppRoutes {
  static const String home = "Home";
  static const String login = "login";
  static const String profile = "profile";
  static const String reg = "reg";
  static const String helloWord = "helloWord";
  static const String dashbord = "dashbord";
  static const String userDashboard = "userDashboard";
  static const String dynamicList = "dynamicList";
  static const String homeNew = "homeNew";


  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());//HelloProfile
      case helloWord:
        return MaterialPageRoute(builder: (_) => HelloProfile());
      case login:
        return MaterialPageRoute(builder: (_) => Login());

      case dashbord:
        return MaterialPageRoute(builder: (_) => Dashbord());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case reg:
        return MaterialPageRoute(builder: (_) => practise());
      case dynamicList:
        return MaterialPageRoute(builder: (_) => DynamicList());
      case userDashboard:
        return MaterialPageRoute(builder: (_) => UserDashbord());
      case homeNew:
        return MaterialPageRoute(builder: (_) => Homenew());
      default:
        return null;
    }
  }
}
