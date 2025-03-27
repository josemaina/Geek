import 'package:flutter/material.dart';
import 'appointment_page.dart';
import 'medical_history_page.dart';
import 'healthy_tips_page.dart';
import 'payment_history_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade100, Colors.lightBlue.shade200], // Light-blue gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('mT', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.purple.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Hello There. What Would You Like To Explore Today',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),

              // Bigger Buttons
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentPage()),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40), // Bigger button
                  textStyle: TextStyle(fontSize: 18), // Larger font
                ),
                child: Text('Book Your Appointment'),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HealthyTipsPage()),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Read A Healthy Tip'),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentHistoryPage()),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('View Your Payment History'),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicalHistoryPage()),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('View Your Medical History'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
