import 'package:chat_app_2/components/my_button.dart';
import 'package:chat_app_2/components/my_textfield.dart';
import 'package:chat_app_2/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_2/services/auth/auth_service.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  bool emailSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.password_outlined,
                  size: 100,
                ),
                const SizedBox(height: 50),

                Column(
                  children: [
                    Text(
                      'Forgot your password ???',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'We got you covered',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        ),
                        child: Text(
                          'I remembered my password',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                MyButton(
                  text: 'Reset Password',
                  onTap: forgotPassword,
                ),
                const SizedBox(height: 30),
                emailSent
                    ? const Text("Check your inbox for further instructions")
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  forgotPassword() async {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Center(
            child: Text('An email is on it\'s way'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );

    try {
      await AuthService().sendPasswordResetEmail(emailController.text);
      setState(() {
        emailSent = true;
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(e.toString() + ' Please try again'),
            ),
          );
        },
      );
    }
  }
}
