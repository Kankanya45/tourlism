import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourlism_root_641463010/login_screen.dart';

class RegisterUserForm extends StatefulWidget {
  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void registerUser() async {
    if (!validateForm()) {
      return;
    }

    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String email = emailController.text;
    String password = passwordController.text;

    String apiUrl = 'http://localhost/Api_tourlism/saveregister.php';

    Map<String, dynamic> requestBody = {
      'firstname': firstName,
      'lastname': lastName,
      'phone': phone,
      'email': email,
      'password': password,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        showSuccessDialog(context);
      } else {
        print('Failed to register user');
      }
    } catch (error) {
      print('Error connecting to the server: $error');
    }
  }

  bool validateForm() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      // Show a SnackBar or some other feedback to the user.
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ลงทะเบียนผู้ใช้ใหม่',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 254, 123, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 49, 83, 99),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: firstNameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Firstname',
                labelStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                prefixIcon: Icon(Icons.person, color: Colors.white),
              ),
            ),
            TextFormField(
              controller: lastNameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Lastname',
                labelStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                prefixIcon: Icon(Icons.person, color: Colors.white),
              ),
            ),
            TextFormField(
              controller: phoneController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Telephone',
                labelStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                prefixIcon: Icon(Icons.phone, color: Colors.white),
              ),
            ),
            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                prefixIcon: Icon(Icons.email, color: Colors.white),
              ),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                prefixIcon: Icon(Icons.lock, color: Colors.white),
                suffixIcon: Icon(Icons.visibility, color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: registerUser,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                backgroundColor: Color.fromARGB(255, 254, 123, 1),
              ),
              child: Text(
                'บันทึก',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Successfully'),
        content: Text('Your information has been successfully saved.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
            child: Text('Go to Login Page'),
          ),
        ],
      );
    },
  );
}
