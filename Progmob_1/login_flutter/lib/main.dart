import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/login_page.dart';
import 'package:my_app/signup_page.dart';
import 'package:my_app/home_page.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
