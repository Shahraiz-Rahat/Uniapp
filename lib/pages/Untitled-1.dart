import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:info_mobile_application/pages/nav_bar.dart';

import '../firebase_auth_implementation/firebase_auth_services.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  final FirebaseAuthServices _auth = FirebaseAuthServices();
  // Editing Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordObscured = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Function to handle the signup
  // void _handleSignIn() {
  //   if (_formkey.currentState!.validate()) {
  //     // Simulate successful sign-up

  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title:
  //               const Text("Email or Password is incorrect. Please try again!"),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the dialog
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => const LoginPage()),
  //                 );
  //               },
  //               child: const Text("OK"),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      final enteredEmail = emailController.text;
      final enteredPassword = passwordController.text;

      // Replace the following condition with your hardcoded credentials
      if (enteredEmail == 'your_default_email@example.com' &&
          enteredPassword == 'your_default_password') {
        // Navigate to the home screen or any other screen upon successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
      } else {
        // Display an error message for invalid credentials
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                  "Email or Password is incorrect. Please try again!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  // Function to handle "Forgot Password" button
  void _handleForgotPassword() async {
    // Implement your logic for handling forgot password here
    // Show a dialog to collect the user's email
    final emailResetController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Forgot Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Enter your email to reset your password:"),
              TextField(
                controller: emailResetController,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = emailResetController.text.trim();
                if (email.isNotEmpty) {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);
                    Navigator.of(context).pop(); // Close the dialog
                    // Show a success message or navigate to a success page
                    // You can add a dialog or a Snackbar to inform the user.
                    // Example:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Password reset email sent. Check your inbox!",
                        ),
                      ),
                    );
                  } catch (error) {
                    print("Error sending password reset email: $error");
                    // Handle the error and inform the user.
                    // You can show an error dialog or a Snackbar.
                    // Example:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Failed to send password reset email. Please try again.",
                        ),
                      ),
                    );
                  }
                }
              },
              child: const Text("Reset Password"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Email Address field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        labelText: "Email Address",
        hintText: 'hello@example.com',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    // Password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: passwordObscured,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        labelText: "Password",
        hintText: '••••••••••••••',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              passwordObscured = !passwordObscured;
            });
          },
          icon: Icon(
            passwordObscured ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );

    // Login Button
    double displayWidth = MediaQuery.of(context).size.width;
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      color: const Color.fromARGB(255, 7, 57, 97),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
          horizontal: displayWidth * .05,
          vertical: displayWidth * .04,
        ),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: _signin,
        child: const Text(
          "Log In",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

    // Forgot Password button
    final forgotPasswordButton = TextButton(
      onPressed: _handleForgotPassword,
      child: const Text(
        "Forgot Password?",
        style: TextStyle(
          color: Color.fromARGB(255, 7, 57, 97),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Login_In.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      width: 400,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF191919),
                          fontSize: 40,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 400,
                      height: 40,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Welcome to the ',
                              style: TextStyle(
                                color: Color(0xFF555555),
                                fontSize: 24,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 2,
                              ),
                            ),
                            TextSpan(
                              text: ' CUI Assist',
                              style: TextStyle(
                                color: Color(0xFF555555),
                                fontSize: 24,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    emailField,
                    const SizedBox(height: 35),
                    passwordField,
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: forgotPasswordButton,
                    ),
                    const SizedBox(height: 25),
                    loginButton,
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: const Text(
                            " Sign Up",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 57, 97),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signin() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavBar()),
      );
    } else {
      _handleSignIn();
    }
  }
}
