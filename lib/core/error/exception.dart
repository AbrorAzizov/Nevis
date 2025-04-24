abstract class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  ApiException copyWith({String? message});

  @override
  String toString() => '${runtimeType.toString()}: $message';
}

class ServerException extends ApiException {
  ServerException([super.message = 'Ошибка сервера']);

  @override
  ServerException copyWith({String? message}) {
    return ServerException(message ?? this.message);
  }
}

class CacheException extends ApiException {
  CacheException([super.message = 'Ошибка кеша']);

  @override
  CacheException copyWith({String? message}) {
    return CacheException(message ?? this.message);
  }
}

class SendingCodeTooOftenException extends ApiException {
  SendingCodeTooOftenException(
      [super.message = 'Слишком частая отправка кода']);

  @override
  SendingCodeTooOftenException copyWith({String? message}) {
    return SendingCodeTooOftenException(message ?? this.message);
  }
}

class ConfirmationCodeWrongException extends ApiException {
  ConfirmationCodeWrongException(
      [super.message = 'Неверный код подтверждения']);

  @override
  ConfirmationCodeWrongException copyWith({String? message}) {
    return ConfirmationCodeWrongException(message ?? this.message);
  }
}

class PhoneDontFoundException extends ApiException {
  PhoneDontFoundException([super.message = 'Телефон не найден']);

  @override
  PhoneDontFoundException copyWith({String? message}) {
    return PhoneDontFoundException(message ?? this.message);
  }
}

class PhoneAlreadyTakenException extends ApiException {
  PhoneAlreadyTakenException([super.message = 'Телефон уже занят']);

  @override
  PhoneAlreadyTakenException copyWith({String? message}) {
    return PhoneAlreadyTakenException(message ?? this.message);
  }
}

class UncorrectedPasswordException extends ApiException {
  UncorrectedPasswordException([super.message = 'Некорректный пароль']);

  @override
  UncorrectedPasswordException copyWith({String? message}) {
    return UncorrectedPasswordException(message ?? this.message);
  }
}

class PasswordMatchesPreviousOneException extends ApiException {
  PasswordMatchesPreviousOneException(
      [super.message = 'Пароль совпадает с предыдущим']);

  @override
  PasswordMatchesPreviousOneException copyWith({String? message}) {
    return PasswordMatchesPreviousOneException(message ?? this.message);
  }
}

class SessionExpiredException extends ApiException {
  SessionExpiredException([super.message = 'Сессия истекла']);

  @override
  SessionExpiredException copyWith({String? message}) {
    return SessionExpiredException(message ?? this.message);
  }
}

class InvalidFormatException extends ApiException {
  InvalidFormatException([super.message = 'Неверный формат']);

  @override
  InvalidFormatException copyWith({String? message}) {
    return InvalidFormatException(message ?? this.message);
  }
}

class AccountDontExistsException extends ApiException {
  AccountDontExistsException([super.message = 'Аккаунт не существует']);

  @override
  AccountDontExistsException copyWith({String? message}) {
    return AccountDontExistsException(message ?? this.message);
  }
}

class AcceptPersonalDataException extends ApiException {
  AcceptPersonalDataException(
      [super.message = 'Необходимо принять соглашение на обработку данных']);

  @override
  AcceptPersonalDataException copyWith({String? message}) {
    return AcceptPersonalDataException(message ?? this.message);
  }
}

class TooManyRequestsException extends ApiException {
  TooManyRequestsException([super.message = 'Слишком много запросов']);

  @override
  TooManyRequestsException copyWith({String? message}) {
    return TooManyRequestsException(message ?? this.message);
  }
}
