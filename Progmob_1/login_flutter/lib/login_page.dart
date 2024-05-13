import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/signup_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() {
    final token = myStorage.read('token');
    if (token != null) {
      // Jika pengguna sudah login, arahkan ke halaman login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

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
                const Icon(
                  Icons.location_on_sharp,
                  size: 100,
                  color: Colors.white,
                ),
                const Text(
                  "HALLO MIKE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 60),
                _buildInputField(emailController, "Email address"),
                const SizedBox(height: 20),
                _buildInputField(passwordController, "Password",
                    isPassword: true),
                const SizedBox(height: 20),
                _buildRememberForgot(),
                const SizedBox(height: 20),
                _buildLoginButton(),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: _buildGreyText("Sign Up"),
                ),
                const SizedBox(height: 20),
                _buildOtherLogin(),
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

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberUser,
              onChanged: (value) {
                setState(() {
                  rememberUser = value!;
                });
              },
            ),
            _buildGreyText("Remember me"),
          ],
        ),
        TextButton(
          onPressed: () {
            // Tambahkan logika untuk lupa password
          },
          child: _buildGreyText("I forgot my password"),
        )
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        goLogin(
          context,
          emailController,
          passwordController,
          dio,
          myStorage,
          apiUrl,
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("LOGIN"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Login with"),
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

void goLogin(BuildContext context, emailController, passwordController, dio,
    myStorage, apiUrl) async {
  try {
    final response = await dio.post('$apiUrl/login', data: {
      'email': emailController.text,
      'password': passwordController.text,
    });
    print(response.data);
    myStorage.write('token', response.data['data']['token']);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
  } on DioException catch (e) {
    print('Error : ${e.response?.statusCode} - ${e.response?.data}');
  }
}
