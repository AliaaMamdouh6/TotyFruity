import 'package:flutter/material.dart';
import 'home.dart';
import 'package:easy_localization/easy_localization.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('login'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
            
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
                decoration:  InputDecoration(labelText:'password'.tr()),
                validator: (value) {
                  if (value!.length < 6) return "At least 6 characters";
                  return null;
                },
              ),
            
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('forgot_password'.tr()),
                          content: Text('forgot_password_message'.tr()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('ok'.tr()),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('forgot_password'.tr(), style: const TextStyle(color: Colors.deepOrange)),
                ),
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
                child:  Text('login'.tr()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
