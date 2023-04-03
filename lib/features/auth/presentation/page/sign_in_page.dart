import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/common/validators/validators.dart';
import 'package:pocket_psychologist/core/server/account.dart';
import 'package:pocket_psychologist/features/auth/presentation/state/auth_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _key = GlobalKey<FormState>();
  final space = 16.0;
  bool isSignUp = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _secondPasswordController = TextEditingController();

  void _toogle() {
    isSignUp = !isSignUp;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTitle(value: isSignUp ? 'Регистрация' : 'Вход'),
                RichText(
                  text: TextSpan(
                      text: isSignUp ? 'Уже есть аккаунт? ' : 'Нет аккаунта? ',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black, fontFamily: 'Nunito'),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () {
                            _toogle();
                          },
                          text: isSignUp ? 'Войдите.' : "Создайте.",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Theme.of(context).primaryColor, fontFamily: 'Nunito'),
                        ),
                      ]),
                ),
                if (isSignUp)
                  SizedBox(height: space,),
                if (isSignUp)
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Имя',
                    ),
                    validator: (value) {
                      return Validators.validateName(name: value as String);
                    },
                  ),
                SizedBox(height: space,),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Почта',
                  ),
                  validator: (value) {
                    return Validators.validateEmail(email: value as String);
                  },
                ),
                SizedBox(height: space,),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Пароль',
                  ),
                  validator: (value) {
                    return Validators.validatePassword(password: value as String);
                  },
                ),
                if (isSignUp)
                  SizedBox(height: space,),
                if (isSignUp)
                  TextFormField(
                    controller: _secondPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Пароль',
                    ),
                    validator: (value) {
                     return Validators.validateSecondPassword(first: _passwordController.text, second: value as String);
                    },
                  ),
                SizedBox(height: space,),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(MediaQuery.of(context).size.width * 0.7),
                      ),
                      onPressed: () {
                        _submit();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppSubtitle(value: isSignUp ? "Зарегистрироваться" : "Войти"),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_key.currentState!.validate()) {
      if (!isSignUp) {
        AccountProvider().signIn(_emailController.text, _passwordController.text);
      } else {
        AccountProvider().signUp(_emailController.text, _passwordController.text, _nameController.text);
      }
    }
  }

}
