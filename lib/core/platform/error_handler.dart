import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/exception.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/platform/network_info.dart';

abstract class ErrorHandler {
  Future<Either<Failure, T>> handle<T>(Future<T> Function() fun);
}

class ErrorHandlerImpl implements ErrorHandler {
  final NetworkInfo networkInfo;

  ErrorHandlerImpl(this.networkInfo);

  @override
  Future<Either<Failure, T>> handle<T>(Future<T> Function() fun) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await fun());
      } on TooManyRequestsException {
        return Left(TooManyRequestsFailure());
      } on ServerException {
        return Left(ServerFailure());
      } on SendingCodeTooOftenException {
        return Left(SendingCodeTooOftenFailure());
      } on ConfirmationCodeWrongException {
        return Left(ConfirmationCodeWrongFailure());
      } on PhoneDontFoundException {
        return Left(PhoneDontFoundFailure());
      } on PhoneAlreadyTakenException {
        return Left(PhoneAlreadyTakenFailure());
      } on UncorrectedPasswordException {
        return Left(UncorrectedPasswordFailure());
      } on PasswordMatchesPreviousOneException {
        return Left(PasswordMatchesPreviousOneFailure());
      } on InvalidFormatException {
        return Left(InvalidFormatFailure());
      } on AccountDontExistsException {
        return Left(AccountDontExistsFailure());
      } on AcceptPersonalDataException {
        return Left(AcceptPersonalDataFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetConnectionFailure());
    }
  }
}
  //final NetworkInfo networkInfo;
//
  //ErrorHandler(this.networkInfo);
//
  //Future<Either<Failure, T>> handle<T>(Future<T> Function() fun) async {
  //  if (await networkInfo.isConnected) {
  //    try {
  //      return Right(await fun());
  //    } on ServerException {
  //      return Left(ServerFailure());
  //    } on SendingCodeTooOftenException {
  //      return Left(SendingCodeTooOftenFailure());
  //    } on ConfirmationCodeWrongException {
  //      return Left(ConfirmationCodeWrongFailure());
  //    } on PhoneDontFoundException {
  //      return Left(PhoneDontFoundFailure());
  //    } on PhoneAlreadyTakenException {
  //      return Left(PhoneAlreadyTakenFailure());
  //    } on UncorrectedPasswordException {
  //      return Left(UncorrectedPasswordFailure());
  //    } catch (e) {
  //      return Left(ServerFailure());
  //    }
  //  } else {
  //    return Left(InternetConnectionFailure());
  //  }
  //}

