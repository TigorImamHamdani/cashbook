import 'package:flutter/material.dart';
import 'package:manage/db_helper.dart'; 
import 'package:manage/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color:Color(0xFF2E3192),
        
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: TextStyle(
              color: Color(0xFF2E3192), fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Please register with your information"),
        const SizedBox(height: 60),
        _buildGreyText("Email address"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Username"),
        _buildInputField(usernameController),
        const SizedBox(height: 40),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildRegisterButton(),
        const SizedBox(height: 20),
        _buildLoginPageButton(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.abc),
      ),
      obscureText: isPassword,
    );
  }

  void _registerUser() async {
    final username = usernameController.text;
    final password = passwordController.text;
    final email = emailController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      final dbHelper = DatabaseHelper();
      final user = User(username: username,email: email, password: password);
      await dbHelper.insertUser(user);

      // Redirect atau lakukan tindakan lain setelah pendaftaran berhasil
    } else {
      // Tampilkan pesan kesalahan jika ada data yang kosong
    }
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () {
         _registerUser();
         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: Color(0xFF2E3192),
        minimumSize: const Size.fromHeight(60),
        primary: Color(0xFF2E3192),
      ),
      child: const Text("REGISTER"),
    );
  }

  Widget _buildLoginPageButton() {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    },
    style: ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      elevation: 20,
      shadowColor: Color(0xFF2E3192),
      minimumSize: const Size.fromHeight(60),
      primary: Color(0xFF2E3192),
    ),
      child: const Text("LOGIN"),
    );
  }
}