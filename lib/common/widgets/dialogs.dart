import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/widgets/snackbars.dart';
import 'package:sqflite/sqflite.dart';
import 'package:appwrite/models.dart' as models;
import '../../core/exceptions/exceptions.dart';
import '../../features/auth/domain/entity/userData.dart';
import '../../features/auth/presentation/state/auth_cubit.dart';
import '../components/text.dart';
import '../validators/validators.dart';
import 'package:pocket_psychologist/features/auth/presentation/state/auth_utils.dart' as utils;

class Dialogs {
  static showDataConfirmationDialog(BuildContext context,
      Future<void> Function(models.DocumentList remoteAnswers, Database localdb) loadToDB,
      Future<void> Function(List<Map<String, Object?>> localAnswers, UserData user, Databases remotedb, bool delete) loadToServer,
      models.DocumentList remoteAnswers, Database localdb, List<Map<String, Object?>> localAnswers,
      UserData userData, Databases remotedb, bool delete,
      ) {
    return showDialog(
      barrierDismissible: false,
        context: context, builder: (context) {
      return SimpleDialog(
        title: AppText(value: 'На вашем аккаунте обнаружены результаты раннее пройденных тестов. Хотите их загрузить?'),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ElevatedButton(onPressed: () {
              loadToDB(remoteAnswers, localdb);
              Navigator.pop(context);
            }, child: AppText(value: "Да")),
            ElevatedButton(onPressed: () {
              loadToServer(localAnswers, userData, remotedb, true);
              Navigator.pop(context);
            }, child: AppText(value: "Нет")),
          ],)
        ],
      );
    }
    );
  }
  static showNameChangeDialog(BuildContext context, String name, AuthCubit authCubit) {
    final key = GlobalKey<FormState>();
    return showDialog<String>(
        context: context,
        builder: (context) {
          TextEditingController nameController = TextEditingController(text: name);
          return SimpleDialog(
            title: const AppSubtitle(value: 'Введите новое имя'),
            children: [
              Form(
                key: key,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          return Validators.validateName(
                              name: nameController.text);
                        },
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              try {
                                await authCubit.updateName(nameController.text);
                                Navigator.pop(context, nameController.text);
                              }  on NetworkException catch (e) {
                                SnackBars.showSnackBar(context, e.message, Colors.red);
                              } on AppwriteException catch (e) {
                                SnackBars.showSnackBar(context, utils.errorTypeToString(e?.type ?? 'Неожиданная ошибка. Сообщите разработчику'), Colors.red);
                              }
                            }
                          },
                          child: const AppText(value: 'Потвердить'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
     );
  }

  static showPasswordChangeDialog(BuildContext context, AuthCubit authCubit) {
    final key = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          final oldPasswordController = TextEditingController();
          final newPasswordController = TextEditingController();
          final newPasswordConfirmController = TextEditingController();
          return StatefulBuilder(
            builder: (context, setState) {
              bool isHidden = true;
              return SimpleDialog(
                title: AppSubtitle(value: 'Смена пароля'),
                children: [
                  Form(
                    key: key,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                           const Text(
                              'Старый пароль',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextFormField(
                              obscureText: isHidden,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: () {
                                  setState(() {
                                    isHidden = !isHidden;
                                  });
                                }, icon: isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                                hintText: 'Введите ваш старый пароль',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(16),
                              ),
                              controller: oldPasswordController,
                              validator: (value) {
                                return Validators.validatePassword(
                                    password: value as String);
                              },
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Новый пароль',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextFormField(
                              obscureText: isHidden,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: () {
                                  setState(() {
                                    isHidden = !isHidden;
                                  });
                                }, icon: isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                                hintText: 'Введите ваш новый пароль',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(16),
                              ),
                              controller: newPasswordController,
                              validator: (value) {
                                return Validators.validatePassword(
                                    password: value as String);
                              },
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Подтвердите новый пароль',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextFormField(
                              obscureText: isHidden,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: () {
                                  setState(() {
                                    isHidden = !isHidden;
                                  });
                                }, icon: isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                                hintText: 'Подтвердите ваш новый пароль',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(16),
                              ),
                              controller: newPasswordConfirmController,
                              validator: (value) {
                                return Validators.validateSecondPassword(first: newPasswordController.text,
                                    second: value as String);
                              },
                            ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (key.currentState!.validate()) {
                                  try {
                                    await authCubit.updatePassword(oldPasswordController.text, newPasswordController.text);
                                    Navigator.pop(context);
                                  }  on NetworkException catch (e) {
                                    SnackBars.showSnackBar(context, e.message, Colors.red);
                                  } on AppwriteException catch (e) {
                                    SnackBars.showSnackBar(context, utils.errorTypeToString(e?.type ?? 'Неожиданная ошибка. Сообщите разработчику'), Colors.red);
                                  }
                                }
                              },
                              child: const AppText(value: 'Потвердить'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          );
        }
    );
  }

  static showEmailChangeDialog(BuildContext context,String email, AuthCubit authCubit) {
    final key = GlobalKey<FormState>();
    bool isHidden = true;
    return showDialog(
        context: context,
        builder: (context) {
          final emailController = TextEditingController();
          final passwordController = TextEditingController();
          return StatefulBuilder(
            builder: (context, setState) {
              return SimpleDialog(
                title: AppSubtitle(value: 'Смена почты'),
                children: [
                  Form(
                    key: key,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                           const Text(
                              'Новая почта',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Введите новую почту',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(16),
                              ),
                              controller: emailController,
                              validator: (value) {
                                return Validators.validateEmail(
                                    email: value as String);
                              },
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Пароль',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextFormField(
                              obscureText: isHidden,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: () {
                                  setState(() {
                                    isHidden = !isHidden;
                                  });
                                }, icon: isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                                hintText: 'Введите ваш пароль',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(16),
                              ),
                              controller: passwordController,
                              validator: (value) {
                                return Validators.validatePassword(
                                    password: value as String);
                              },
                            ),
                            SizedBox(height: 16),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (key.currentState!.validate()) {
                                  try {
                                    await authCubit.updateEmail(emailController.text, passwordController.text);
                                    Navigator.pop(context);
                                  }  on NetworkException catch (e) {
                                    SnackBars.showSnackBar(context, e.message, Colors.red);
                                  } on AppwriteException catch (e) {
                                    SnackBars.showSnackBar(context, utils.errorTypeToString(e?.type ?? 'Неожиданная ошибка. Сообщите разработчику'), Colors.red);
                                  }
                                }
                              },
                              child: const AppText(value: 'Потвердить'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          );
        }
    );
  }

  static showGreetingDialog(BuildContext context, String? text, String? gif) {
    return showDialog(
        // barrierDismissible: false,
        context: context, builder: (context) {
      return SimpleDialog(
        // title: AppText(value: 'На вашем аккаунте обнаружены результаты раннее пройденных тестов. Хотите их загрузить?'),
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AppSubtitle(value: text ?? '', textAlign: TextAlign.justify,),
                  Image.network(gif ?? ''),
                ],
              ),
            ),
          )
        ],
      );
    }
    );
  }
}