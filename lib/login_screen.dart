import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tourlism_root_641463010/menu.dart';
import 'package:tourlism_root_641463010/register.dart'; // Import your menu page file

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final url = 'http://localhost/Api_tourlism/checklogin.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Successful response
      final List<dynamic> responseData = json.decode(response.body);

      // Process responseData as needed

      // Navigate to the menu page
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyMenuPage(),
      ));
    } else {
      // Unsuccessful response
      // Display an error message or handle accordingly
      print('Login failed: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เข้าสู่ระบบ',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 254, 123, 1),
      ),
      backgroundColor: const Color.fromARGB(255, 49, 83, 99),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('images/crru.png'),
                width: 400.0,
                height: 400.0,
              ),
              TextFormField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'ชื่อผู้ใช้',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextFormField(
                controller: passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'รหัสผ่าน',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  loginUser(context);
                },
                child: Text('เข้าสู่ระบบ'),
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(300, 50),
                  side: BorderSide(
                    color: Color.fromARGB(255, 254, 123, 1),
                    width: 2.0,
                  ),
                  backgroundColor: Color.fromARGB(255, 254, 123, 1),
                ),
              ),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => RegisterUserForm(),
                  ));
                },
                child: Text(
                  'ลงทะเบียนผู้ใช้ใหม่',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
