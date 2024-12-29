import 'package:flutter/material.dart'; // Importing Flutter material package for UI elements.
import 'package:firebase_auth/firebase_auth.dart'; // Importing Firebase Authentication package.
import 'package:my_pocket_wallet/screens/home_page.dart'; // Importing home page screen.
import 'package:my_pocket_wallet/screens/signgin.dart'; // Importing sign-in screen.
import 'package:my_pocket_wallet/screens/forgotpassword.dart'; // Importing forgot password screen.

// LoginPage widget for the login screen.
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final FirebaseAuth _auth =
      FirebaseAuth.instance; // FirebaseAuth instance for authentication.
  final _formKey = GlobalKey<
      FormState>(); // Global key for the form state to manage form validation.

  // TextEditingController to control email and password input fields.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500, // Setting the app bar color.
        title: const Center(
          child: Text(
            'Login', // Setting the app bar title.
            style: TextStyle(
                fontWeight: FontWeight.bold), // Styling the app bar title.
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adding padding around the body.
        child: Form(
          key: _formKey, // Associating the form key with the form.
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Centering the column contents vertically.
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Stretching the column contents horizontally.
            children: [
              TextFormField(
                controller:
                    emailController, // Linking the email controller to the text field.
                decoration: const InputDecoration(
                  labelText: 'Email', // Setting the label text.
                  border: OutlineInputBorder(), // Adding an outline border.
                ),
                validator: (value) {
                  // Validator function to check if the input is valid.
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email'; // Error message if the field is empty.
                  }
                  return null; // No error message if the field is valid.
                },
              ),
              const SizedBox(height: 20), // Adding space between input fields.
              TextFormField(
                controller:
                    passwordController, // Linking the password controller to the text field.
                obscureText: true, // Hiding the password input.
                decoration: const InputDecoration(
                  labelText: 'Password', // Setting the label text.
                  border: OutlineInputBorder(), // Adding an outline border.
                ),
                validator: (value) {
                  // Validator function to check if the input is valid.
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password'; // Error message if the field is empty.
                  }
                  return null; // No error message if the field is valid.
                },
              ),
              const SizedBox(
                  height: 20), // Adding space between input fields and button.
              ElevatedButton(
                onPressed: () async {
                  // Asynchronous function to handle login.
                  if (_formKey.currentState!.validate()) {
                    // Checking if the form is valid.
                    try {
                      // Attempting to sign in with email and password.
                      await _auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      // Navigating to the home page if login is successful.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } catch (e) {
                      // Displaying an error message if login fails.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to login: $e')),
                      );
                    }
                  }
                },
                child: const Text('Login'), // Setting the button text.
              ),
              const SizedBox(
                  height: 10), // Adding space between button and text.
              TextButton(
                onPressed: () {
                  // Function to navigate to the sign-up page.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text(
                    'Don’t have an account? Sign Up'), // Setting the button text.
              ),
              TextButton(
                onPressed: () {
                  // Function to navigate to the forgot password page.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()),
                  );
                },
                child:
                    const Text('Forgot Password?'), // Setting the button text.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
