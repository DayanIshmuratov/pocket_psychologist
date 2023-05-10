import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/common/widgets/dialogs.dart';
import 'package:pocket_psychologist/features/auth/presentation/state/auth_cubit.dart';
import 'package:pocket_psychologist/features/profile/widget/profile_listtile.dart';

import '../../auth/domain/entity/userData.dart';
import '../widget/edit_listtile.dart';

class EditProfilePage extends StatefulWidget {
  final UserData userData;

  EditProfilePage({required this.userData});
  State<EditProfilePage> createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        title:  AppText(value: 'Редактирование профиля'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () async {
              await Dialogs.showNameChangeDialog(context, widget.userData.name, authCubit);
              setState(() {});
            },
              child: EditListTile(title: widget.userData.name, subtitle: 'Нажмите, чтобы изменить имя',)),
          Divider(color: Theme.of(context).primaryColor,),
          EditListTile(title: widget.userData.email, subtitle: 'Нажмите, чтобы изменить почту',),
          Divider(color: Theme.of(context).primaryColor,),
          EditListTile(title: 'Смена пароля', subtitle: 'Нажмите, чтобы изменить пароль',),
          Divider(color: Theme.of(context).primaryColor,),
        ],
      )
    );
  }
}