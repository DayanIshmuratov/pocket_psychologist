import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/common/widgets/snackbars.dart';
import '../../../../common/validators/validators.dart';
import '../../../../core/logger/logger.dart';
import '../state/auth_cubit.dart';

class PasswordRecoveryPage extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  String email;
  AuthCubit authCubit;
  PasswordRecoveryPage({required this.authCubit,required this.email, super.key});

  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController(text: email);
    return Scaffold(
      appBar: AppBar(
        title: const AppTitle(value: 'Восстановление пароля'),
        centerTitle: true,
      ),
      body: Form(
        key: _key,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Почта',
              ),
              validator: (value) {
                return Validators.validateEmail(email: value as String);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  try {
                    await authCubit.passwordRecovery(emailController.text);
                    Navigator.pop(context);
                    SnackBars.showSnackBar(context, 'Запрос отправлен на почту', Theme.of(context).primaryColor);
                  } on AppwriteException catch (e, s) {
                    logger.severe(e, s);
                    // SnackBars.showSnackBar(context, e.type ?? 'Неожиданная ошибка', Colors.red);
                  }
                }
              },
              child: const AppSubtitle(value: 'Восстановить'),
            ),
          ],
        ),
      ),
    );
  }
}
