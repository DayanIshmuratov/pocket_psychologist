import 'package:appwrite/appwrite.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pocket_psychologist/core/logger/logger.dart';
import 'package:pocket_psychologist/core/server/account.dart';

import '../../../../core/db/database.dart';
import '../../../../core/server/database.dart';
import '../../../auth/presentation/state/auth_utils.dart';
import 'package:pocket_psychologist/constants/appwrite_constants/appwrite_constants.dart' as constants;


Future<void> loadToServer() async {
  if (await InternetConnectionChecker().hasConnection) {
    try {
      final user = await AccountProvider.get().account.get();
      final localdb = await DBProvider.db.database;
      final remotedb = AppWriteDBProvider().db;
      final localAnswers = await loadFromLocalDB(localdb);
      await appWriteServerProvider.deleteCollection(user.$id);
      await appWriteServerProvider.createCollection(user.$id);
      for (var mapRead in localAnswers) {
        Map<String, dynamic> map = Map<String, dynamic>.from(mapRead);
        await remotedb.createDocument(
          databaseId: ID.custom(constants.appwriteUsersAnswersDatabaseId),
          collectionId: ID.custom(user.$id),
          documentId: ID.unique(),
          data: map,
        );
      }
    } catch (e, s) {
      logger.info('ОШИБКА загрузки на сервер у action_utils');
      logger.severe(e, s);
    }
  }
}