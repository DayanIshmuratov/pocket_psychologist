import 'package:appwrite/appwrite.dart';
import 'package:pocket_psychologist/constants/appwrite_constants/appwrite_constants.dart' as appwriteConstants;

class AppWriteProvider {

  static final AppWriteProvider instance = AppWriteProvider._internal();
  late final Client client;

  factory AppWriteProvider() {
    return instance;
  }

  AppWriteProvider._internal() {
    client = Client()
        .setEndpoint(appwriteConstants.appwriteEndpoint)
        .setProject(appwriteConstants.appwriteProjectId);
  }

}