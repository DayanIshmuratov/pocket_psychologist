import 'package:appwrite/appwrite.dart';
import '../../../../core/logger/logger.dart';
import '../data_models/question_model.dart';

abstract class SurveyRemoteDataSource {
  saveData(QuestionModel model);
}

class SurveyRemoteDataSourceImpl implements  SurveyRemoteDataSource{
  final Client client;
  late Databases database;
  SurveyRemoteDataSourceImpl({required this.client}) {
    database = Databases(client);
  }

  @override
  saveData(QuestionModel model) async {
    Account account = Account(client);
    final user = await account.get();

    try {
      final document = await database.createDocument(
        databaseId: ID.custom('users_answers'),
        collectionId: ID.custom(user.$id),
        documentId: ID.unique(),
        data: model.toMap(),
      );
      logger.info(document.toMap());
    } on AppwriteException catch (e) {
      logger.info(e.message);
    }
  }
}