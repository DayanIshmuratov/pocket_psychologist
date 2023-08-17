import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pocket_psychologist/common/widgets/dialogs.dart';
import 'package:pocket_psychologist/main_page/main_page.dart';

import '../../core/server/database.dart';


class GreetPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Greeting.greeting(context);
    return MainPage();
  }

}
class Greeting {
  static greeting(BuildContext context) async {
    if (await InternetConnectionChecker().hasConnection) {
      final db = AppWriteDBProvider.instance.db;
      final result = await db.getDocument(
          documentId: '64779100eeee439b6fb7',
          databaseId: 'other', 
          collectionId: 'launch',
      );
      final greetingData = GreetingData.fromJson(result.data);
      Dialogs.showGreetingDialog(context, greetingData.text, greetingData.gif);
    }

  }
}

class GreetingData extends Equatable{
  final String text;
  final int releaseNumber;
  final String gif;

  GreetingData(this.text, this.releaseNumber, this.gif);
  
  factory GreetingData.fromJson(Map<String, dynamic> json) {
    return GreetingData(json['info_message'], json['release_number'], json['launch_image']);
  }


  @override
  List<Object?> get props => throw UnimplementedError();}