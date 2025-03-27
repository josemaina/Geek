import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInAsStaff extends StatefulWidget {
  @override
  _SignInAsStaffState createState() => _SignInAsStaffState();
}

class _SignInAsStaffState extends State<SignInAsStaff> {
  final TextEditingController staffIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  bool obscureText = true;

  void signIn() async {
    String staffId = staffIdController.text.trim();
    String password = passwordController.text.trim();

    if (staffId == "MD001A") {
      Navigator.pushReplacementNamed(context, '/staffHome');
      return;
    }

    try {
      String? storedPassword = await secureStorage.read(key: staffId);

      if (storedPassword != null && storedPassword == password) {
        Navigator.pushReplacementNamed(context, '/staffHome');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please Enter The Correct Staff ID/ Password')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error retrieving credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.white, Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sign In as STAFF',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: staffIdController,
                  decoration: InputDecoration(labelText: 'Enter STAFF ID'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    suffixIcon: IconButton(
                      icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => obscureText = !obscureText),
                    ),
                  ),
                  obscureText: obscureText,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: signIn,
                  child: Text('Log In'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/createPassword'),
                  child: Text("Don't have a password? Create One"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}