import 'package:chat_app_2/services/auth/auth_service.dart';
import 'package:chat_app_2/pages/home_page.dart';
import 'package:chat_app_2/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/components/my_button.dart';
import '/components/my_textfield.dart';
import '/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.person_add_alt_rounded,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                'Create an account for yourself!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 40),

              // sign in button
              MyButton(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    UserCredential? credential = await AuthService().createUserWithEmailAndPassword(
                            emailController.text,
                            passwordController.text);
                    if (credential != null) {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                    else {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: Center(
                            child: Text(
                              'Passwords do not match or user already exists',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }
                        // .then((value) => Navigator.of(context)
                        //         .pushReplacement(MaterialPageRoute(
                        //       builder: (context) => const LoginPage(),
                        //     )));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Center(
                          child: Text(
                            'Passwords do not match',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    ),
                    child: const Text(
                      'Login now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
