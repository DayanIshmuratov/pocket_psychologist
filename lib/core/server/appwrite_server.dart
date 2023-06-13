import 'dart:async';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:pocket_psychologist/constants/appwrite_constants/appwrite_constants.dart' as constants;

import '../logger/logger.dart';

class AppWriteServerProvider {

  static AppWriteServerProvider instance = AppWriteServerProvider._internal();

  late Client client;
  factory AppWriteServerProvider() {
    return instance;
  }

  AppWriteServerProvider._internal() {
    client = Client()
        .setEndpoint(constants.appwriteEndpoint)
        .setProject(constants.appwriteProjectId)
        .setKey(constants.appwriteServerKey);

  }

  Future<void> createCollection(String id) async {
    final db = Databases(client);
    await db.createCollection(
      databaseId: constants.appwriteUsersAnswersDatabaseId,
      collectionId: id,
      name: id,
      permissions: [
        Permission.read(Role.user(id)),
        Permission.update(Role.user(id)),
        Permission.create(Role.user(id)),
        Permission.write(Role.user(id)),
        Permission.delete(Role.user(id)),
      ],
    );

    await db.createIntegerAttribute(
        databaseId: constants.appwriteUsersAnswersDatabaseId,
        collectionId: id,
        key: 'question_id',
        xrequired: true);

    await db.createIntegerAttribute(
        databaseId: constants.appwriteUsersAnswersDatabaseId,
        collectionId: id,
        key: 'question_answer_id',
        xrequired: true);
    await isAttributesCreated(db, id);
    }

  Future<void> isAttributesCreated(Databases db, String id) async {
    bool isReady = false;
    while (!isReady) {
      Collection collection = await db.getCollection(
        databaseId: constants.appwriteUsersAnswersDatabaseId,
        collectionId: id,
      );
      await Future.delayed( const Duration(seconds: 2)).then((_) {
          logger.info(collection.attributes);
          logger.info("Ждем создание атрибутов");
          logger.info(isReady);
      if (collection.attributes.length == 2) {
      if (collection.attributes[0]['status'] == 'available' && collection.attributes[1]['status'] == 'available')  {
          isReady = true;
        }
      }
      });
    }
  }

  Future<void> deleteCollection(String id) async {
    final db = Databases(client);
    await db.deleteCollection(
        databaseId: constants.appwriteUsersAnswersDatabaseId,
        collectionId: id);
    await waitForDeletionCompletion(db, id);
  }

  Future<void> waitForDeletionCompletion(Databases db, String id) async {
    bool deletionCompleted = false;
    while (!deletionCompleted) {
      logger.info('Ждем удаления коллекции');
      try {
       await db.getCollection(databaseId: constants.appwriteUsersAnswersDatabaseId,
           collectionId: id);
      } on AppwriteException {
        deletionCompleted = true;
      }

      if (deletionCompleted) {
        // Deletion completed, exit the loop and return
        break;
      }

      // Wait for a short duration before checking again
      await Future.delayed(Duration(seconds: 1));
    }
  }
}