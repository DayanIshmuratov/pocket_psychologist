import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/profile/widget/profile_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/server/account.dart';
import '../../../core/server/appwrite.dart';

class ProfileWidgets extends StatefulWidget {
  State<ProfileWidgets> createState() => _ProfileWidgetsState();
}

class _ProfileWidgetsState extends State<ProfileWidgets> {
  static const double spaceHeight = 16.0;

  @override
  build(BuildContext context) {
    Account account = Account(AppWriteProvider().client);
    return Scaffold(
      body: FutureBuilder(
          future: account.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      // mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/images/no_image.jpg'),
                        ),
                        SizedBox(
                          child:
                              Center(child: AppTitle(value: snapshot.data?.name ?? "Гость")),
                          width: MediaQuery.of(context).size.width-112,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: spaceHeight,
                    ),
                    if (snapshot.data == null)
                      InkWell(
                        onTap: () async {
                          await Navigator.pushNamed(context, 'sign_in_page');
                          setState(() {});
                        },
                        child: ProfileCard(text: 'Войти в аккаунт'),
                      ),
                    if (snapshot.data != null)
                      ProfileCard(text: 'Редактировать'),
                    SizedBox(
                      height: spaceHeight / 3,
                    ),
                    InkWell(
                      onTap: () {
                        _aboutUsDialog(context);
                      },
                      child: ProfileCard(text: 'О нас'),
                    ),
                    SizedBox(
                      height: spaceHeight / 3,
                    ),
                    InkWell(
                        onTap: () async {
                          await AccountProvider().logOut();
                          setState(() {});
                        },
                        child: ProfileCard(
                          text: 'Выйти из аккаунта',
                        ))
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
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
                      )),
                ],
              ),
            ),
          ],
        );
      });
}

void launchTelegram() async{
  String url =
      "https://t.me/idsids2";
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw 'Could not launch $uri';
  } else {
    await launchUrl(uri,
        mode: LaunchMode.externalApplication);
  }
}