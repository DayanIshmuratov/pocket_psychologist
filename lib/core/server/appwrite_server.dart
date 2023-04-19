import 'dart:async';

import 'package:dart_appwrite/dart_appwrite.dart';
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
    while (true) {
      final collection = await db.getCollection(
        databaseId: constants.appwriteUsersAnswersDatabaseId,
        collectionId: id,
      );
      if (collection.attributes.length == 2) {
        final first = collection.attributes[0]['status'];
        final second = collection.attributes[1]['status'];
        if (first == 'available' && second == 'available')  {
          logger.info(collection.attributes);
          break;
        }
      }
      Timer(Duration(milliseconds: 1000), () {
        logger.info("Ждем создание атрибутов");
      });
    }
  }

  Future<void> deleteCollection(String id) async {
    final db = Databases(client);
    await db.deleteCollection(
        databaseId: constants.appwriteUsersAnswersDatabaseId,
        collectionId: id);
  }
}