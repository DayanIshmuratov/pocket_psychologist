import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/constants/app_colors/app_theme.dart';
import 'package:pocket_psychologist/features/auth/presentation/page/sign_in_page.dart';

import '../../../common/components/text.dart';
import '../../auth/presentation/state/auth_cubit.dart';
import '../widget/app_theme_switcher.dart';
import '../widget/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileWidgets(),
      );
  }
}
