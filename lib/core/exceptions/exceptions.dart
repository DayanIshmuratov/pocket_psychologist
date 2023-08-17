class ServerException implements Exception {
  final String msg;
  ServerException([this.msg = 'Ошибка получения данных с сервера.']);
  String get message => msg;
  // String message() {
  //   return msg;
  // }
}

class NetworkException implements Exception {
  final String msg;
  NetworkException([this.msg = 'Нет соединения']);
  String get message => msg;
}

class LocalException  implements Exception {
  final String msg;
  LocalException([this.msg = 'Ошибка получения данных с локального хранилища.']);
  String get message => msg;
// String message() {
//   return msg;
// }
}