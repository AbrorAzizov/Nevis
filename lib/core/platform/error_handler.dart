import 'dart:developer' as developer;

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
    try {
      return Right(await fun());
    } on UnauthorizedException catch (e) {
      developer.log('UnauthorizedException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(UnauthorizedFailure(e.message));
    } on TooManyRequestsException catch (e) {
      developer.log('TooManyRequestsException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(TooManyRequestsFailure(message: e.message));
    } on ServerException catch (e) {
      developer.log('ServerException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(ServerFailure(message: e.message));
    } on SendingCodeTooOftenException catch (e) {
      developer.log('SendingCodeTooOftenException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(SendingCodeTooOftenFailure(message: e.message));
    } on ConfirmationCodeWrongException catch (e) {
      developer.log('ConfirmationCodeWrongException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(ConfirmationCodeWrongFailure(message: e.message));
    } on PhoneDontFoundException catch (e) {
      developer.log('PhoneDontFoundException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(PhoneDontFoundFailure(message: e.message));
    } on PhoneAlreadyTakenException catch (e) {
      developer.log('PhoneAlreadyTakenException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(PhoneAlreadyTakenFailure(message: e.message));
    } on UncorrectedPasswordException catch (e) {
      developer.log('UncorrectedPasswordException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(UncorrectedPasswordFailure(message: e.message));
    } on PasswordMatchesPreviousOneException catch (e) {
      developer.log('PasswordMatchesPreviousOneException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(PasswordMatchesPreviousOneFailure(message: e.message));
    } on InvalidFormatException catch (e) {
      developer.log('InvalidFormatException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(InvalidFormatFailure(message: e.message));
    } on AccountDontExistsException catch (e) {
      developer.log('AccountDontExistsException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(AccountDontExistsFailure(message: e.message));
    } on AcceptPersonalDataException catch (e) {
      developer.log('AcceptPersonalDataException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(AcceptPersonalDataFailure(message: e.message));
    } on MaxProductQuantityExceededException catch (e) {
      developer.log('MaxProductQuantityExceededException message: ${e.message}',
          name: 'ErrorHandler');
      return Left(MaxQuantityExceededFailure(message: e.message));
    } catch (e) {
      developer.log('Unknown exception: $e', name: 'ErrorHandler');
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
