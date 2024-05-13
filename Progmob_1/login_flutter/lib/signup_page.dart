// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'login_page.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late Color myColor;
  late Size mediaSize;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: myColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(myColor.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInputField(nameController, "Name"),
                const SizedBox(height: 20),
                _buildInputField(emailController, "Email address"),
                const SizedBox(height: 20),
                _buildInputField(passwordController, "Password",
                    isPassword: true),
                const SizedBox(height: 40),
                _buildSignUpButton(),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: _buildGreyText("Back to Login"),
                ),
                const SizedBox(height: 20),
                _buildOtherSignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String labelText,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      obscureText: isPassword,
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        // memanggil fungsi register
        goRegister(
          context,
          dio,
          myStorage,
          apiUrl,
          nameController,
          emailController,
          passwordController,
        );
      },
      child: const Text("SIGN UP"),
    );
  }

  Widget _buildOtherSignUp() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Sign Up with"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/images/google (1).png")),
              Tab(icon: Image.asset("assets/images/apple-logo.png")),
              Tab(icon: Image.asset("assets/images/facebook.png")),
            ],
          ),
        ],
      ),
    );
  }
}

// fungsi register
void goRegister(BuildContext context, dio, myStorage, apiUrl, nameController,
    emailController, passwordController) async {
  try {
    final response = await dio.post('$apiUrl/register', data: {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });
    print(response.data);
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
