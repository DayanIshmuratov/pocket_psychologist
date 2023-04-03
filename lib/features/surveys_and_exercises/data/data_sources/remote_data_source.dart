import 'package:appwrite/appwrite.dart';
import 'package:pocket_psychologist/features/surveys_and_exercises/domain/entities/question_entity.dart';

import '../data_models/question_model.dart';

abstract class SurveyRemoteDataSource {
  saveData(QuestionModel model);
}

class SurveyRemoteDataSourceImpl implements  SurveyRemoteDataSource{
  final Client client;
  SurveyRemoteDataSourceImpl({required this.client});

  @override
  saveData(QuestionModel model) async {
    final database = Databases(client);
    Account account = Account(client);
    final user = await account.get();

    try {
      final document = await database.createDocument(
        databaseId: ID.custom('default'),
        collectionId: ID.custom('user_answers'),
        documentId: ID.unique(),
        data: addingId(model, user.$id),
        // permissions: [
        //   Permission.read(Role.any()),
        //   Permission.write(Role.any()),
        //   Permission.update(Role.any()),
        //   Permission.create(Role.users()),
        // ],
      );
      print(document.toMap());
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  Map<String, dynamic> addingId(QuestionModel model, String userId) {
    final map = model.toMap();
    map.addAll({'user_id' : userId});
    return map;
  }
}