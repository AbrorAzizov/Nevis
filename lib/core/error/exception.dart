abstract class ApiException implements Exception {
  final String? message;

  ApiException({this.message});

  ApiException copyWith({String? message});

  @override
  String toString() => '${runtimeType.toString()}: $message';
}

class ServerException extends ApiException {
  ServerException([String? message])
      : super(message: message ?? 'Ошибка сервера');

  @override
  ServerException copyWith({String? message}) {
    return ServerException(message);
  }
}

class CacheException extends ApiException {
  CacheException([String? message]) : super(message: message ?? 'Ошибка кеша');

  @override
  CacheException copyWith({String? message}) {
    return CacheException(message);
  }
}

class SendingCodeTooOftenException extends ApiException {
  SendingCodeTooOftenException([String? message])
      : super(message: message ?? 'Слишком частая отправка кода');

  @override
  SendingCodeTooOftenException copyWith({String? message}) {
    return SendingCodeTooOftenException(message);
  }
}

class ConfirmationCodeWrongException extends ApiException {
  ConfirmationCodeWrongException([String? message])
      : super(message: message ?? 'Неверный код подтверждения');

  @override
  ConfirmationCodeWrongException copyWith({String? message}) {
    return ConfirmationCodeWrongException(message);
  }
}

class PhoneDontFoundException extends ApiException {
  PhoneDontFoundException([String? message])
      : super(message: message ?? 'Телефон не найден');

  @override
  PhoneDontFoundException copyWith({String? message}) {
    return PhoneDontFoundException(message);
  }
}

class PhoneAlreadyTakenException extends ApiException {
  PhoneAlreadyTakenException([String? message])
      : super(message: message ?? 'Телефон уже занят');

  @override
  PhoneAlreadyTakenException copyWith({String? message}) {
    return PhoneAlreadyTakenException(message);
  }
}

class UncorrectedPasswordException extends ApiException {
  UncorrectedPasswordException([String? message])
      : super(message: message ?? 'Некорректный пароль');

  @override
  UncorrectedPasswordException copyWith({String? message}) {
    return UncorrectedPasswordException(message);
  }
}

class PasswordMatchesPreviousOneException extends ApiException {
  PasswordMatchesPreviousOneException([String? message])
      : super(message: message ?? 'Пароль совпадает с предыдущим');

  @override
  PasswordMatchesPreviousOneException copyWith({String? message}) {
    return PasswordMatchesPreviousOneException(message);
  }
}

class SessionExpiredException extends ApiException {
  SessionExpiredException([String? message])
      : super(message: message ?? 'Сессия истекла');

  @override
  SessionExpiredException copyWith({String? message}) {
    return SessionExpiredException(message);
  }
}

class InvalidFormatException extends ApiException {
  InvalidFormatException([String? message])
      : super(message: message ?? 'Неверный формат');

  @override
  InvalidFormatException copyWith({String? message}) {
    return InvalidFormatException(message);
  }
}

class AccountDontExistsException extends ApiException {
  AccountDontExistsException([String? message])
      : super(message: message ?? 'Аккаунт не существует');

  @override
  AccountDontExistsException copyWith({String? message}) {
    return AccountDontExistsException(message);
  }
}

class AcceptPersonalDataException extends ApiException {
  AcceptPersonalDataException([String? message])
      : super(
            message:
                message ?? 'Необходимо принять соглашение на обработку данных');

  @override
  AcceptPersonalDataException copyWith({String? message}) {
    return AcceptPersonalDataException(message);
  }
}

class TooManyRequestsException extends ApiException {
  TooManyRequestsException([String? message])
      : super(message: message ?? 'Слишком много запросов');

  @override
  TooManyRequestsException copyWith({String? message}) {
    return TooManyRequestsException(message);
  }
}

class EmptyOrdersException extends ApiException {
  EmptyOrdersException([String? message])
      : super(message: message ?? 'Список заказов пуст');

  @override
  EmptyOrdersException copyWith({String? message}) {
    return EmptyOrdersException(message);
  }
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String? message])
      : super(message: message ?? 'Пользователь не авторизирован');

  @override
  UnauthorizedException copyWith({String? message}) {
    return UnauthorizedException(message);
  }
}

class NoFavoritePharmaciesException extends ApiException {
  NoFavoritePharmaciesException([String? message])
      : super(message: message ?? 'Список любимых аптек пуст не авторизирован');

  @override
  NoFavoritePharmaciesException copyWith({String? message}) {
    return NoFavoritePharmaciesException(message);
  }
}

class MaxProductQuantityExceededException extends ApiException {
  MaxProductQuantityExceededException([String? message])
      : super(message: message ?? 'Превышено максимальное количество упаковок');

  @override
  MaxProductQuantityExceededException copyWith({String? message}) {
    return MaxProductQuantityExceededException(message);
  }
}
