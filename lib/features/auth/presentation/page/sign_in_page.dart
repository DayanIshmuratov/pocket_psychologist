import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/common/validators/validators.dart';
import 'package:pocket_psychologist/core/exceptions/exceptions.dart';
import 'package:pocket_psychologist/core/server/account.dart';
import 'package:pocket_psychologist/core/server/appwrite_server.dart';
import 'package:pocket_psychologist/features/auth/presentation/state/auth_cubit.dart';

import '../../../../common/widgets/snackbars.dart';
import '../../../../core/logger/logger.dart';
import '../../../../utilities/utilities.dart' as utils;

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _key = GlobalKey<FormState>();
  final space = 16.0;
  bool isSignUp = false;
  bool isHidden = true;
  final _nameController = TextEditingController(text: 'Dayan');
  final _emailController =
      TextEditingController(text: 'ishmuratovdayan11@gmail.com');
  final _passwordController = TextEditingController(text: '123123123');
  final _secondPasswordController = TextEditingController(text: '123123123');

  void _toogle() {
    isSignUp = !isSignUp;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _authCubit = context.read<AuthCubit>();
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
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Nunito'),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _toogle();
                            },
                          text: isSignUp ? 'Войдите.' : "Создайте.",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'Nunito'),
                        ),
                      ]),
                ),
                if (isSignUp)
                  SizedBox(
                    height: space,
                  ),
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
                SizedBox(
                  height: space,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Почта',
                  ),
                  validator: (value) {
                    return Validators.validateEmail(email: value as String);
                  },
                ),
                SizedBox(
                  height: space,
                ),
                TextFormField(
                  obscureText: isHidden,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {
                      isHidden = !isHidden;
                      setState(() {});
                    }, icon: isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                    hintText: 'Пароль',
                  ),
                  validator: (value) {
                    return Validators.validatePassword(
                        password: value as String);
                  },
                ),
                if (isSignUp)
                  SizedBox(
                    height: space,
                  ),
                if (isSignUp)
                  TextFormField(
                    obscureText: isHidden,
                    controller: _secondPasswordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: () {
                        isHidden = !isHidden;
                        setState(() {});
                      }, icon: isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                      hintText: 'Пароль',
                    ),
                    validator: (value) {
                      return Validators.validateSecondPassword(
                          first: _passwordController.text,
                          second: value as String);
                    },
                  ),
                SizedBox(
                  height: space,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(
                          MediaQuery.of(context).size.width * 0.7),
                    ),
                    onPressed: () {
                      _submit(_authCubit);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppSubtitle(
                          value: isSignUp ? "Зарегистрироваться" : "Войти"),
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

  void _submit(AuthCubit authCubit) async {
    if (_key.currentState!.validate()) {
      if (!isSignUp) {
        try {
          await authCubit.signInWithEmail(_emailController.text, _passwordController.text);
        } on NetworkException catch (e) {
          SnackBars.showSnackBar(context, e.message, Colors.red);
        } catch (e) {
          SnackBars.showSnackBar(context, e.toString(), Colors.red);
        }
        finally {
          SnackBars.showSnackBar(context, 'Вы успешно вошли в аккаунт', Theme.of(context).primaryColor);
        }
        utils.checkAnswersSignIn(context);
        // logger.info('USERID - ${user.$id}');
        Navigator.pop(context);
      } else {
        await authCubit.signUpWithEmail(_nameController.text, _emailController.text, _passwordController.text);
        utils.checkAnswersSignUp();
        Navigator.pop(context);
        SnackBars.showSnackBar(context, 'Вы успешно создали аккаунт', Theme.of(context).primaryColor);
      }
    }
  }
}