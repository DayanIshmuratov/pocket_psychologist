import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:pocket_psychologist/core/db/database.dart';
import 'package:pocket_psychologist/core/server/database.dart';
import 'package:pocket_psychologist/utilities/utilities.dart' as utils;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/profile/widget/profile_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/app_colors/app_theme.dart';
import '../../../core/logger/logger.dart';
import '../../../core/server/account.dart';
import '../../auth/presentation/state/auth_cubit.dart';

class ProfileWidgets extends StatefulWidget {
  State<ProfileWidgets> createState() => _ProfileWidgetsState();
}

class _ProfileWidgetsState extends State<ProfileWidgets> {
  static const double spaceHeight = 16.0;

  Future<models.Account> getAccount(Account account) async {
    final user = await account.get();
    logger.info(user.prefs.data);
    // final localAnswers = await utils.loadFromLocalDB(await DBProvider.db.database);
    // final remoteAnswers = await utils.loadFromRemoteDB(AppWriteDBProvider().db, user);
    // if (localAnswers.length > remoteAnswers.total) {
    //   utils.loadToServer(localAnswers, user, AppWriteDBProvider().db, true);
    // }
    return user;
  }

  @override
  build(BuildContext context)  {
    final authCubit = context.read<AuthCubit>();
    final account =  AccountProvider.get().account;
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState> (
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                        AssetImage('assets/images/no_image.jpg'),
                      ),
                      if (state is AuthSigned)
                      SizedBox(
                        child: Center(
                            child: AppTitle(
                                value: state.userInfo.name)),
                        width: MediaQuery.of(context).size.width - 112,
                      ),
                      if (state is AuthUnSigned)
                      SizedBox(
                        child: Center(
                            child: AppTitle(
                                value: 'Гость')),
                        width: MediaQuery.of(context).size.width - 112,
                      ),
                    ],
                  ),
                  SizedBox(
                      height: spaceHeight
                  ),
                  if (state is AuthUnSigned)
                    InkWell(
                      onTap: () async {
                        await Navigator.pushNamed(context, 'sign_in_page');
                        setState(() {});
                      },
                      child: ProfileCard(text: 'Войти в аккаунт'),
                    ),
                  if (state is AuthSigned)
                    ProfileCard(text: 'Редактировать'),
                  SizedBox(
                      height: spaceHeight / 3
                  ),
                  InkWell(
                    onTap: () {
                      _changingThemeDialog(context);
                    },
                    child: ProfileCard(text: 'Сменить тему'),
                  ),
                  SizedBox(
                      height: spaceHeight / 3
                  ),
                  InkWell(
                    onTap: () {
                      _aboutUsDialog(context);
                    },
                    child: ProfileCard(text: 'О нас'),
                  ),
                  SizedBox(
                      height: spaceHeight / 3
                  ),
                  InkWell(
                      onTap: () async {
                        await authCubit.logOut();
                        setState(() {});
                      },
                      child: ProfileCard(
                        text: 'Выйти из аккаунта',
                      ),)
                ],
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
          title: Center(
            child: AppTitle(value: "О нас"),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  AppSubtitle(
                      value: 'UX-design, development and release by dayname'),
                  IconButton(
                      onPressed: () {
                        launchTelegram();
                      },
                      icon: Icon(
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
          title: Center(
            child: AppTitle(value: "Выберите нужный цвет"),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(16),
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
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                      child: appTheme.state is PurpleAppThemeState
                          ? Icon(Icons.done, color: Colors.white)
                          : SizedBox.shrink(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      appTheme.changeToGreen();
                    },
                    child: Container(
                      height: sizeOfCircle,
                      width: sizeOfCircle,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: appTheme.state is GreenAppThemeState
                          ? Icon(Icons.done, color: Colors.white)
                          : SizedBox.shrink(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      appTheme.changeToRed();
                    },
                    child: Container(
                      height: sizeOfCircle,
                      width: sizeOfCircle,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: appTheme.state is RedAppThemeState
                          ? Icon(Icons.done, color: Colors.white)
                          : SizedBox.shrink(),
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




//      FutureBuilder(
//           future: getAccount(account),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 40,
//                           backgroundImage:
//                               AssetImage('assets/images/no_image.jpg'),
//                         ),
//                         SizedBox(
//                           child: Center(
//                               child: AppTitle(
//                                   value: snapshot.data?.name ?? "Гость")),
//                           width: MediaQuery.of(context).size.width - 112,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: spaceHeight
//                     ),
//                     if (snapshot.data == null)
//                       InkWell(
//                         onTap: () async {
//                           await Navigator.pushNamed(context, 'sign_in_page');
//                           setState(() {});
//                         },
//                         child: ProfileCard(text: 'Войти в аккаунт'),
//                       ),
//                     if (snapshot.data != null)
//                       ProfileCard(text: 'Редактировать'),
//                     SizedBox(
//                       height: spaceHeight / 3
//                     ),
//                     InkWell(
//                       onTap: () {
//                         _changingThemeDialog(context);
//                       },
//                       child: ProfileCard(text: 'Сменить тему'),
//                     ),
//                     SizedBox(
//                       height: spaceHeight / 3
//                     ),
//                     InkWell(
//                       onTap: () {
//                         _aboutUsDialog(context);
//                       },
//                       child: ProfileCard(text: 'О нас'),
//                     ),
//                     SizedBox(
//                       height: spaceHeight / 3
//                     ),
//                     InkWell(
//                         onTap: () async {
//                           await AccountProvider.get().logOut();
//                           setState(() {});
//                         },
//                         child: ProfileCard(
//                           text: 'Выйти из аккаунта',
//                         ))
//                   ],
//                 ),
//               );
//             }
//             return Center(child: CircularProgressIndicator());
//           })