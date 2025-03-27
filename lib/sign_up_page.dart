import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_in_page.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _agreedToTOS = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launcher.launchUrl(uri, mode: launcher.LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _signUp(BuildContext context) async {
    if (_formKey.currentState!.validate() && _agreedToTOS) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up Successful')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade100, Colors.lightBlue.shade200], // Full light-blue shade
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextField(controller: fullNameController, decoration: InputDecoration(labelText: 'Full Name')),
                TextField(controller: idController, decoration: InputDecoration(labelText: 'ID Number')),
                TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
                TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone Number')),
                TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Create Password'), obscureText: true),
                TextField(controller: confirmPasswordController, decoration: InputDecoration(labelText: 'Confirm Password'), obscureText: true),
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToTOS,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreedToTOS = value!;
                        });
                      },
                    ),
                    Flexible(
                      child: Wrap(
                        children: [
                          Text("I agree to MedTrack's "),
                          GestureDetector(
                            onTap: () => _launchURL('https://example.com/privacy'),
                            child: Text('Privacy Policy', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                          ),
                          Text(' and '),
                          GestureDetector(
                            onTap: () => _launchURL('https://example.com/terms'),
                            child: Text('Terms of Service', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _agreedToTOS ? () => _signUp(context) : null,
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
