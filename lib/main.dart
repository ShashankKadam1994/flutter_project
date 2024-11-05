import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task1/router.dart';
import 'package:flutter_task1/sharedpref.dart';
import 'package:flutter_task1/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: kIsWeb
        ? FirebaseOptions(
            apiKey: "AIzaSyCOgw4Xl0fIexyl4F7rElqTb0f_H0T9efQ",
            authDomain: "fluttertask-7d4f6.firebaseapp.com",
            projectId: "fluttertask-7d4f6",
            storageBucket: "fluttertask-7d4f6.appspot.com",
            messagingSenderId: "855938418989",
            appId: "1:855938418989:web:29b74bf630758679fdeba4",
          )
        : null, // For Android/iOS, Firebase will use google-services.json
  );
  
  // await MyDataBase().initializedDB();
  await SessionManager().init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
