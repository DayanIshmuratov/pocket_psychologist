import 'package:appwrite/appwrite.dart';

class AppWriteProvider {
  Client client = Client()
      .setEndpoint('http://192.168.1.109:17181/v1')
      .setProject('641e94ff0df16b5a4814')
      .setSelfSigned();
}