import 'package:flutter/material.dart';
import 'package:flutter_task1/Task_15/widgets/signin.dart';
import '../../services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your email';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Enter a valid email';
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your password';
                  if (value.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await AuthService().signUpWithEmailPassword(
                        _emailController.text,
                        _passwordController.text,
                      );
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sign-up successful!')),

                      );
                      // Navigate to another page, such as the sign-in page
                      // Navigator.pushReplacementNamed(context, '/signin');

                      Navigator.pushReplacement(
                        context,
                        // MaterialPageRoute(builder: (context) => const Login()),
                        // MaterialPageRoute(builder: (context) => const Dashbord()) ,
                        MaterialPageRoute(builder: (context) => const SignIn()) ,
                      );

                    } catch (e) {
                      // Show error message if sign-up fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sign-up failed: $e')),
                      );
                    }
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
