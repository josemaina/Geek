import 'package:flutter/material.dart';
import 'home_page.dart';
import 'sign_in_page.dart';
import 'welcome_screen.dart';
import 'sign_in_as_staff.dart';
import 'create_password.dart'; 
import 'staff_home.dart'; 

void main() {
  runApp(MedTrackApp());
}

class MedTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set WelcomeScreen as the first screen
      routes: {
        '/': (context) => WelcomeScreen(),
        '/signIn': (context) => SignInPage(),
        '/home': (context) => HomePage(),
        '/signInStaff': (context) => SignInAsStaff(),
      '/createPassword': (context) => CreatePassword(),
      '/staffHome': (context) => StaffHome(),
      },
    );
  }
}
