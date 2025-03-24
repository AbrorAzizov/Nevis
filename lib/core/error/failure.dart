import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class InternetConnectionFailure extends Failure {}

class LocationFailure extends Failure {}

class SendingCodeTooOftenFailure extends Failure {}

class ConfirmationCodeWrongFailure extends Failure {}

class PhoneDontFoundFailure extends Failure {}

class PhoneAlreadyTakenFailure extends Failure {}

class UncorrectedPasswordFailure extends Failure {}

class PasswordMatchesPreviousOneFailure extends Failure {}

class SessionExpiredFailure extends Failure {}

class InvalidFormatFailure extends Failure {}

class AccountDontExistsFailure extends Failure {}

class AcceptPersonalDataFailure extends Failure {}

class TooManyRequestsFailure extends Failure {}
