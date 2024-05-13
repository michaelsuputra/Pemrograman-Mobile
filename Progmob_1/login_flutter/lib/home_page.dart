import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/add_user.dart';
import 'package:my_app/list_user.dart';
import 'package:my_app/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 60,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome back, Mike!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'How are you?',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              // tombol login
              onPressed: () {
                goUser(dio, apiUrl, myStorage);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'View Profile',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              // tombol list user
              onPressed: () {
                // Balik ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListUser(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'List User',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              // tombol list user
              onPressed: () {
                // Balik ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUser(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'Tambah User',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              // tombol logout
              onPressed: () {
                goLogout(context, dio, apiUrl, myStorage);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Fungsi login
void goUser(dio, apiUrl, myStorage) async {
  try {
    final response = await dio.get(
      '$apiUrl/user',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);
  } on DioException catch (e) {
    print('Error : ${e.response?.statusCode} - ${e.response?.data}');
  }
}

// Fungsi logout
void goLogout(context, dio, apiUrl, myStorage) async {
  try {
    final response = await dio.get(
      '$apiUrl/logout',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);

    // Balik ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  } on DioException catch (e) {
    print('Error : ${e.response?.statusCode} - ${e.response?.data}');
  }
}
