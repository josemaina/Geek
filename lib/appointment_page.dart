import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final List<String> doctors = [
    "Nrs Mike Kung'u", "Nrs Faith Mwanzia", "Nrs Joe Maina",
    "Nrs Chris Ngatia", "Nrs Nimo Ngatia", "Nrs John Okoth",
    "Nrs Owang Sino"
  ];
  String? selectedDoctor;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);
  String? userPhoneNumber;

  @override
  void initState() {
    super.initState();
    _loadUserPhoneNumber();
  }

  Future<void> _loadUserPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userPhoneNumber = prefs.getString('phone');
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      helpText: "Select Appointment Time",
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null &&
        (picked.hour >= 9 && picked.hour < 17)) { // Ensure time is within range
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _submitAppointment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Appointment Booked"),
        content: Text(
          "You shall receive your appointment reminder via SMS to the phone number."
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ),
            child: Text("Return to Home Page"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Appointment")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade100, Colors.lightBlue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Doctor:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedDoctor,
                hint: Text("Choose a doctor"),
                items: doctors.map((String doctor) {
                  return DropdownMenuItem<String>(
                    value: doctor,
                    child: Text(doctor),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDoctor = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              Text("Select Date:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Text("${selectedDate.toLocal()}".split(' ')[0]),
              ),
              SizedBox(height: 20),
              Text("Select Time:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text("${selectedTime.format(context)}"),
              ),
              SizedBox(height: 20),
              Divider(),
              Text("Appointment Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Doctor: ${selectedDoctor ?? "Not selected"}", style: TextStyle(fontSize: 16)),
              Text("Date: ${selectedDate.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 16)),
              Text("Time: ${selectedTime.format(context)}", style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: selectedDoctor != null ? _submitAppointment : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text("Submit Appointment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
