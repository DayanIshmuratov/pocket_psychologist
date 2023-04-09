import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/common/validators/validators.dart';
import 'package:pocket_psychologist/core/server/account.dart';
import 'package:pocket_psychologist/core/server/appwrite_server.dart';
import 'package:pocket_psychologist/features/auth/presentation/state/auth_cubit.dart';

import '../../../../core/logger/logger.dart';
import '../../../../utilities/utilities.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _key = GlobalKey<FormState>();
  final space = 16.0;
  bool isSignUp = false;
  final _nameController = TextEditingController(text: 'ff');
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
                  controller: _passwordController,
                  decoration: InputDecoration(
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
                    controller: _secondPasswordController,
                    decoration: InputDecoration(
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
                      _submit();
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

  void _submit() async {
    if (_key.currentState!.validate()) {
      if (!isSignUp) {
        await AccountProvider()
            .signIn(_emailController.text, _passwordController.text);
        Utilities().checkAnswersSignIn(context);
      } else {
        final db = Databases(AppWriteServerProvider().client);
        await AccountProvider().signUp(_emailController.text,
            _passwordController.text, _nameController.text);
        final user = await AccountProvider().account.get();
        await db.createCollection(
          databaseId: 'users_answers',
          collectionId: user.$id,
          name: user.$id,
          permissions: [
            Permission.read(Role.user(user.$id)),
            Permission.update(Role.user(user.$id)),
            Permission.create(Role.user(user.$id)),
            Permission.write(Role.user(user.$id)),
            Permission.delete(Role.user(user.$id)),
          ],
        );
        logger.info('USERID - ${user.$id}');
        await db.createIntegerAttribute(
            databaseId: 'users_answers',
            collectionId: user.$id,
            key: 'question_id',
            xrequired: true);
        await db.createIntegerAttribute(
            databaseId: 'users_answers',
            collectionId: user.$id,
            key: 'question_answer_id',
            xrequired: true);
        Utilities().checkAnswersSignUp();
      }
    }
  }
}
