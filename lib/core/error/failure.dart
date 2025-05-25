import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object?> get props => [message];

  Failure copyWith({String? message});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});

  @override
  ServerFailure copyWith({String? message}) =>
      ServerFailure(message: message ?? this.message);
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});

  @override
  CacheFailure copyWith({String? message}) =>
      CacheFailure(message: message ?? this.message);
}

class InternetConnectionFailure extends Failure {
  const InternetConnectionFailure({super.message});

  @override
  InternetConnectionFailure copyWith({String? message}) =>
      InternetConnectionFailure(message: message ?? this.message);
}

class LocationFailure extends Failure {
  const LocationFailure({super.message});

  @override
  LocationFailure copyWith({String? message}) =>
      LocationFailure(message: message ?? this.message);
}

class SendingCodeTooOftenFailure extends Failure {
  const SendingCodeTooOftenFailure({super.message});

  @override
  SendingCodeTooOftenFailure copyWith({String? message}) =>
      SendingCodeTooOftenFailure(message: message ?? this.message);
}

class ConfirmationCodeWrongFailure extends Failure {
  const ConfirmationCodeWrongFailure({super.message});

  @override
  ConfirmationCodeWrongFailure copyWith({String? message}) =>
      ConfirmationCodeWrongFailure(message: message ?? this.message);
}

class PhoneDontFoundFailure extends Failure {
  const PhoneDontFoundFailure({super.message});

  @override
  PhoneDontFoundFailure copyWith({String? message}) =>
      PhoneDontFoundFailure(message: message ?? this.message);
}

class PhoneAlreadyTakenFailure extends Failure {
  const PhoneAlreadyTakenFailure({super.message});

  @override
  PhoneAlreadyTakenFailure copyWith({String? message}) =>
      PhoneAlreadyTakenFailure(message: message ?? this.message);
}

class UncorrectedPasswordFailure extends Failure {
  const UncorrectedPasswordFailure({super.message});

  @override
  UncorrectedPasswordFailure copyWith({String? message}) =>
      UncorrectedPasswordFailure(message: message ?? this.message);
}

class PasswordMatchesPreviousOneFailure extends Failure {
  const PasswordMatchesPreviousOneFailure({super.message});

  @override
  PasswordMatchesPreviousOneFailure copyWith({String? message}) =>
      PasswordMatchesPreviousOneFailure(message: message ?? this.message);
}

class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure({super.message});

  @override
  SessionExpiredFailure copyWith({String? message}) =>
      SessionExpiredFailure(message: message ?? this.message);
}

class InvalidFormatFailure extends Failure {
  const InvalidFormatFailure({super.message});

  @override
  InvalidFormatFailure copyWith({String? message}) =>
      InvalidFormatFailure(message: message ?? this.message);
}

class AccountDontExistsFailure extends Failure {
  const AccountDontExistsFailure({super.message});

  @override
  AccountDontExistsFailure copyWith({String? message}) =>
      AccountDontExistsFailure(message: message ?? this.message);
}

class AcceptPersonalDataFailure extends Failure {
  const AcceptPersonalDataFailure({super.message});

  @override
  AcceptPersonalDataFailure copyWith({String? message}) =>
      AcceptPersonalDataFailure(message: message ?? this.message);
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure({super.message});

  @override
  TooManyRequestsFailure copyWith({String? message}) =>
      TooManyRequestsFailure(message: message ?? this.message);
}

class EmptyOrdersFailure extends Failure {
  const EmptyOrdersFailure([String? message]) : super(message: message);

  @override
  Failure copyWith({String? message}) =>
      EmptyOrdersFailure(message ?? this.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(String? message) : super(message: message);

  @override
  Failure copyWith({String? message}) =>
      UnauthorizedFailure(message ?? this.message);
}
