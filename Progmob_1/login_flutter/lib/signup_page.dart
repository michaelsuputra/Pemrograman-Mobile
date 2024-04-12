// ignore_for_file: unused_import

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: myColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildInputField(nameController, "Name"),
                SizedBox(height: 20),
                _buildInputField(emailController, "Email address"),
                SizedBox(height: 20),
                _buildInputField(passwordController, "Password",
                    isPassword: true),
                SizedBox(height: 40),
                _buildSignUpButton(),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: _buildGreyText("Back to Login"),
                ),
                SizedBox(height: 20),
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
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(color: Colors.white),
      obscureText: isPassword,
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        String name = nameController.text;
        String email = emailController.text;
        String password = passwordController.text;

        if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
          // Data user berhasil didaftarkan, navigasi ke halaman home
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Sign Up Failed'),
              content: Text('Please fill in all the fields.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Text("SIGN UP"),
    );
  }

  Widget _buildOtherSignUp() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Sign Up with"),
          SizedBox(height: 10),
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
