import 'package:flutter/material.dart';
import 'home.dart';
import 'package:easy_localization/easy_localization.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('signup'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration:  InputDecoration(labelText:'name'.tr()),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter your name";
                  if (value[0] != value[0].toUpperCase()) {
                    return "First letter must be uppercase";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration:  InputDecoration(labelText: 'email'.tr()),
                validator: (value) {
                  if (!value!.contains("@")) return "Invalid email";
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration:  InputDecoration(labelText: 'password'.tr()),
                validator: (value) {
                  if (value!.length < 6) return "At least 6 characters";
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Confirm Password"),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Home()),
                    );
                  }
                },
                child:  Text('signup'.tr()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
