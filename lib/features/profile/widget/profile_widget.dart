import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/profile/widget/profile_card.dart';
import 'package:pocket_psychologist/features/profile/widget/profile_listtile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/app_colors/app_theme.dart';
import '../../auth/presentation/state/auth_cubit.dart';

class ProfileWidgets extends StatefulWidget {
  const ProfileWidgets({super.key});

  @override
  State<ProfileWidgets> createState() => _ProfileWidgetsState();
}

class _ProfileWidgetsState extends State<ProfileWidgets> {
  static const double spaceHeight = 16.0;

  @override
  build(BuildContext context)  {
    Color color = Theme.of(context).primaryColor;
    AuthCubit authCubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: color,
        ),
      ),
      body: BlocBuilder<AuthCubit, AuthState> (
          builder: (context, state) {
            if(state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is AuthSigned)
                      ProfileCard(name: state.userData.name),
                    if (state is AuthUnSigned)
                      ProfileCard(name: 'Гость',),
                    // if (state is AuthUnSigned)
                    // const SizedBox(
                    //     height: spaceHeight
                    // ),
                    if (state is AuthUnSigned)
                      InkWell(
                        onTap: () async {
                          await Navigator.pushNamed(context, 'sign_in_page');
                          setState(() {});
                        },
                        child: const ProfileListTile(title: 'Войти в аккаунт', icon: Icons.person_outline,),
                      ),
                    if (state is AuthSigned)
                      InkWell(onTap: () async {
                        await Navigator.pushNamed(context, 'edit_profile_page', arguments: authCubit);
                      }, child: const ProfileListTile(title: 'Редактировать', icon: Icons.person)),
                    Divider(color: color),
                    InkWell(
                      onTap: () {
                        _changingThemeDialog(context);
                      },
                      child: const ProfileListTile(title: 'Сменить тему',icon: Icons.palette_outlined),
                    ),
                    Divider(color: color),
                    InkWell(
                      onTap: () {
                        _aboutUsDialog(context);
                      },
                      child: const ProfileListTile(title: 'О нас', icon: Icons.people_alt_outlined),
                    ),
                    Divider(color: color),
                    InkWell(
                      onTap: () async {
                        String url = "https://forms.gle/R4121QDby9hEfaLB9";
                        final Uri uri = Uri.parse(url);
                        if (!await launchUrl(uri)) {
                        throw 'Could not launch $uri';
                        } else {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: const ProfileListTile(title: 'Бета-тест', icon: Icons.engineering_outlined),
                    ),
                    if (authCubit.state is AuthSigned)
                      Column(children: [
                        Divider(color: color),
                        InkWell(
                          onTap: () async {
                            await authCubit.logOut();
                            setState(() {});
                          },
                          child: const ProfileListTile(
                            title: 'Выйти из аккаунта', icon: Icons.logout,
                          ),
                        ),
                      ],
                      ),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}

Future<void> _aboutUsDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Center(
            child: AppTitle(value: "О нас"),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const AppText(
                      value: 'Приложение создано Даяном Ишмуратовым, при поддержке Руфы Байгужиной. Любые вопросы, пожелания - пишите!', textAlign: TextAlign.justify),
                  IconButton(
                      onPressed: () {
                        launchTelegram();
                      },
                      icon: const Icon(
                        Icons.telegram,
                        color: Colors.blue,
                        size: 40,
                      ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
      );
}

Future<void> _changingThemeDialog(BuildContext context) {
  final appTheme = context.read<AppTheme>();
  const double sizeOfCircle = 40;
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Center(
            child: AppTitle(value: "Выберите нужный цвет"),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      appTheme.changeToPurple();
                    },
                    child: Container(
                      height: sizeOfCircle,
                      width: sizeOfCircle,
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                      child: appTheme.state is PurpleAppThemeState
                          ? const Icon(Icons.done, color: Colors.white)
                          : const SizedBox.shrink(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      appTheme.changeToGreen();
                    },
                    child: Container(
                      height: sizeOfCircle,
                      width: sizeOfCircle,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: appTheme.state is GreenAppThemeState
                          ? const Icon(Icons.done, color: Colors.white)
                          : const SizedBox.shrink(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      appTheme.changeToRed();
                    },
                    child: Container(
                      height: sizeOfCircle,
                      width: sizeOfCircle,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: appTheme.state is RedAppThemeState
                          ? const Icon(Icons.done, color: Colors.white)
                          : const SizedBox.shrink(),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     appTheme.changeToBlack();
                  //   },
                  //   child: Container(
                  //     height: sizeOfCircle,
                  //     width: sizeOfCircle,
                  //     decoration: BoxDecoration(
                  //       color: Colors.black38,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: appTheme.state is BlackAppThemeState
                  //         ? Icon(Icons.done, color: Colors.white)
                  //         : SizedBox.shrink(),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        );
      });
}

void launchTelegram() async {
  String url = "https://t.me/idsids2";
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw 'Could not launch $uri';
  } else {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
