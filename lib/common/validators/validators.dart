class Validators {
  static String? validateTitle({required String title}){
    if (title.isEmpty){
      return "Название не может быть пустым";
    }
    return null;
  }
  static String? validateMessage({required String text}) {
    if (text.isEmpty){
      return "Сообщение не может быть пустым";
    }
    return null;
  }

  static String? validateName({required String name}) {

    if (name.isEmpty) {
      return 'Имя не может быть пустым';
    }

    return null;
  }

  static String? validateEmail({required String email}) {

    if (email.isEmpty) {
      return 'Заполните данное поле';
    } else if (!email.contains("@")) {
      return 'Введите корректную почту';
    }

    return null;
  }

  static String? validatePassword({required String password}) {

    if (password.isEmpty) {
      return 'Поле не может быть пустым';
    } else if (password.length < 8) {
      return 'Пароль должен иметь как минимум 8 символов';
    }

    return null;
  }

  static String? validateSecondPassword({required String first, required String second}){
    if (first.isEmpty) {
      return 'Поле не может быть пустым';
    } else if (first != second){
      return 'Пароли не совпадают';
    }
    return null;
  }
}