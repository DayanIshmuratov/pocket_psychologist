import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: _nameController,
          ),
          TextFormField(
            controller: _emailController,
          ),
          TextFormField(
            controller: _passwordController,
          ),
          ElevatedButton(onPressed: () {}, child: AppSubtitle(value: "Регистрация")),
        ],
      ),
    );
  }
}
