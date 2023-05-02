import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/auth/presentation/state/auth_cubit.dart';

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
                  onTap: () {
                    authCubit.googleAuth();
                  },
                  child: oauthButton('assets/images/small_images/icons/google.png')),
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