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
      return Left(UnauthorizedFailure(e.message));
    } on TooManyRequestsException catch (e) {
      return Left(TooManyRequestsFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on SendingCodeTooOftenException catch (e) {
      return Left(SendingCodeTooOftenFailure(message: e.message));
    } on ConfirmationCodeWrongException catch (e) {
      return Left(ConfirmationCodeWrongFailure(message: e.message));
    } on PhoneDontFoundException catch (e) {
      return Left(PhoneDontFoundFailure(message: e.message));
    } on PhoneAlreadyTakenException catch (e) {
      return Left(PhoneAlreadyTakenFailure(message: e.message));
    } on UncorrectedPasswordException catch (e) {
      return Left(UncorrectedPasswordFailure(message: e.message));
    } on PasswordMatchesPreviousOneException catch (e) {
      return Left(PasswordMatchesPreviousOneFailure(message: e.message));
    } on InvalidFormatException catch (e) {
      return Left(InvalidFormatFailure(message: e.message));
    } on AccountDontExistsException catch (e) {
      return Left(AccountDontExistsFailure(message: e.message));
    } on AcceptPersonalDataException catch (e) {
      return Left(AcceptPersonalDataFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
