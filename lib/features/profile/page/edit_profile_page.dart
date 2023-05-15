import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/common/widgets/dialogs.dart';
import 'package:pocket_psychologist/common/widgets/snackbars.dart';
import 'package:pocket_psychologist/features/auth/presentation/state/auth_cubit.dart';
import 'package:pocket_psychologist/features/profile/widget/profile_listtile.dart';

import '../../auth/domain/entity/userData.dart';
import '../widget/edit_listtile.dart';

class EditProfilePage extends StatefulWidget {
  State<EditProfilePage> createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final authCubit = context.read<AuthCubit>();
    final authCubitState = authCubit.state;
    late UserData userData;
    if (authCubitState is AuthSigned) {
      userData = authCubitState.userData;
    } else {
      Navigator.pop(context);
      SnackBars.showSnackBar(context, 'Неожиданная ошибка, перезайдите на аккаунт', Colors.red);
    }

    return Scaffold(
      appBar: AppBar(
        title:  AppText(value: 'Редактирование профиля'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () async {
              await Dialogs.showNameChangeDialog(context, userData.name, authCubit);
              await authCubit.refresh();
              setState(() {});
            },
              child: EditListTile(title: userData.name, subtitle: 'Нажмите, чтобы изменить имя',)),
          Divider(color: color),
          InkWell(
            onTap: () async {
              await Dialogs.showEmailChangeDialog(context, userData.email, authCubit);
              await authCubit.refresh();
              setState(() {});
            },
              child: EditListTile(title: userData.email, subtitle: 'Нажмите, чтобы изменить почту',)),
          Divider(color: color),
          InkWell(
            onTap: () async {
              await Dialogs.showPasswordChangeDialog(context, authCubit);
              await authCubit.refresh();
              setState(() {});
            },
              child: EditListTile(title: 'Смена пароля', subtitle: 'Нажмите, чтобы изменить пароль',)),
          Divider(color: color),
        ],
      )
    );
  }
}