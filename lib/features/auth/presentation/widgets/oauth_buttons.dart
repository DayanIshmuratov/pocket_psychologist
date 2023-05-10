import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/common/widgets/snackbars.dart';
import 'package:pocket_psychologist/features/auth/presentation/state/auth_cubit.dart';
import 'package:pocket_psychologist/features/auth/presentation/state/auth_utils.dart' as utils;
import '../../../../core/exceptions/exceptions.dart';

class OauthButtons extends StatelessWidget {
  final AuthCubit authCubit;
  OauthButtons({required this.authCubit});
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AppTitle(value: "ИЛИ"),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () async {
                  try {
                    await authCubit.googleAuth(context);
                    if (authCubit.state is AuthSigned) {
                      Navigator.pop(context);
                      SnackBars.showSnackBar(
                          context,
                          'Вы успешно вошли в аккаунт',
                          Theme.of(context).primaryColor);
                    }
                  } on NetworkException catch (e) {
                    SnackBars.showSnackBar(context, e.message, Colors.red);
                  } on AppwriteException catch (e) {
                    SnackBars.showSnackBar(context, utils.errorTypeToString(e?.type ?? 'Неожиданная ошибка.'), Colors.red);
                  }
                },
                child:
                    oauthButton('assets/images/small_images/icons/google.png'),
              ),
              GestureDetector(
                onTap: () {
                  authCubit.vkAuth();
                },
              child: oauthButton('assets/images/small_images/icons/vk.png')),
            ],
          ),
        ],
      ),
    );
  }
}

Widget oauthButton(String imagePath) {
  return Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black, width: 2),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Image.asset(imagePath, filterQuality: FilterQuality.low,)),
    ),
  );
}