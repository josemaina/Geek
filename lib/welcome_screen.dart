import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.white, Colors.lightBlue.shade100], // Gradient as per your request
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to MedTrack',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/signIn'), // No changes to Patient login
                child: Text('Log In as Patient'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/signInStaff'), // Correctly navigates to Staff authentication page
                child: Text('Log In as Staff'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
