import 'package:dart_appwrite/dart_appwrite.dart';

class AppWriteServerProvider {
  Client client = Client()
      .setEndpoint('http://192.168.0.12:17181/v1') // Your API Endpoint
      .setProject('641e94ff0df16b5a4814')                // Your project ID
      .setKey('86d2306895f508813b57b312fdb32bc4823930907fbc2bde9bdde684fbd358aed0c966f56f9417adb3b2a3787ce8a805041e61d9289143b6f57724954fb42f0297ffe9cd0639da29d37ff70b4475d41b8bfbd919c2213f2ff1522dba7f38833a9455f776090da8a4dbd36f491bc61f9403856b7984b2612bd7812763a7c9e76a');
}