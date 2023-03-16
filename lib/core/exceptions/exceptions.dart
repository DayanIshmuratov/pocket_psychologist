class ServerException implements Exception {
  final String msg;
  ServerException([this.msg = 'Ошибка получения данных с сервера. Обратитесь к разработчику']);
  String get message => msg;
  // String message() {
  //   return msg;
  // }
}

class CacheException  implements Exception {
  final String msg;
  CacheException([this.msg = 'Ошибка получения данных с локального хранилища. Обратитесь к разработчику']);
  String get message => msg;
// String message() {
//   return msg;
// }
}