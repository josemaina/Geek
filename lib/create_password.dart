import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreatePassword extends StatefulWidget {
  @override
  _CreatePasswordState createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final TextEditingController staffIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  bool obscureText1 = true;
  bool obscureText2 = true;
  bool passwordsMatch = false;
  bool isLoading = false;

  void checkPasswords() {
    setState(() {
      passwordsMatch = passwordController.text == confirmPasswordController.text;
    });
  }

  void createPassword() async {
    String staffId = staffIdController.text.trim();
    String password = passwordController.text.trim();

    if (staffId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('All fields are required')));
      return;
    }

    if (!passwordsMatch) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await secureStorage.write(key: staffId, value: password);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Password Created Successfully for $staffId'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/signInStaff');
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Could not save password')));
    } finally {
      setState(() {
        isLoading = false;
      });
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
              children: [
                Text(
                  'Please Create Your Password',
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
                  decoration: InputDecoration(labelText: 'Enter Your Staff ID'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Create Your Password',
                    suffixIcon: IconButton(
                      icon: Icon(obscureText1 ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => obscureText1 = !obscureText1),
                    ),
                  ),
                  obscureText: obscureText1,
                  onChanged: (_) => checkPasswords(),
                ),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Your Password',
                    suffixIcon: IconButton(
                      icon: Icon(obscureText2 ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => obscureText2 = !obscureText2),
                    ),
                  ),
                  obscureText: obscureText2,
                  onChanged: (_) => checkPasswords(),
                ),
                SizedBox(height: 10),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: passwordsMatch ? createPassword : null,
                        child: Text('Create Password'),
                      ),
                if (!passwordsMatch && confirmPasswordController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Passwords do not match',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}