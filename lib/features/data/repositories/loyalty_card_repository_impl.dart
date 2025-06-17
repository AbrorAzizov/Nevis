import 'package:dartz/dartz.dart';
import 'package:nevis/core/error/failure.dart';
import 'package:nevis/core/platform/error_handler.dart';
import 'package:nevis/core/platform/network_info.dart';
import 'package:nevis/features/data/datasources/loyalty_card_local_source.dart';
import 'package:nevis/features/data/datasources/loyalty_card_remote_source.dart';
import 'package:nevis/features/data/models/loyalty_card_qr_model.dart';
import 'package:nevis/features/data/models/loyalty_card_register_model.dart';
import 'package:nevis/features/domain/entities/loyalty_card_entity.dart';
import 'package:nevis/features/domain/repositories/loyalty_card_repository.dart';

class LoyaltyCardRepositoryImpl implements LoyaltyCardRepository {
  final LoyaltyCardRemoteDataSource remoteDataSource;
  final LoyaltyCardLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  LoyaltyCardRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.errorHandler,
  });

  @override
  Future<Either<Failure, void>> registerCard(
          LoyaltyCardRegisterModel model) async =>
      await errorHandler.handle(
        () async => await remoteDataSource.registerCard(model),
      );

  @override
  Future<Either<Failure, LoyaltyCardQREntity?>> getQRCode() async {
    final isConnected = await networkInfo.isConnected;
    final Future<LoyaltyCardQRModel?> fun;

    if (isConnected) {
      fun = remoteDataSource.getQRCode();
    } else {
      fun = localDataSource.getQRCode();
    }

    return await errorHandler.handle(
      () async {
        final qrModel = await fun;
        return qrModel;
      },
    );
  }

  @override
  Future<Either<Failure, LoyaltyCardEntity?>> getCardInfo() async =>
      await errorHandler.handle(
        () async {
          final cardInfo = await remoteDataSource.getCardInfo();
          return cardInfo;
        },
      );
}
