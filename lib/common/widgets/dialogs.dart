import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/widgets/snackbars.dart';
import 'package:sqflite/sqflite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:pocket_psychologist/features/auth/presentation/state/auth_utils.dart';
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
          Row(children: [
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
    return showDialog(
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
}