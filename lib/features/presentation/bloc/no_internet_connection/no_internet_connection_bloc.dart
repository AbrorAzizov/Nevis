import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/loyalty_card_entity.dart';
import 'package:nevis/features/domain/usecases/loyalty_card/get_qr_code.dart';

part 'no_internet_connection_event.dart';
part 'no_internet_connection_state.dart';

class NoInternetConnectionBloc
    extends Bloc<NoInternetConnectionEvent, NoInternetConnectionState> {
  final GetQRCodeUC getQRCodeUC;

  NoInternetConnectionBloc({required this.getQRCodeUC})
      : super(NoInternetConnectionState()) {
    on<LoadDataEvent>(_onLoadData);
  }

  void _onLoadData(
      LoadDataEvent event, Emitter<NoInternetConnectionState> emit) async {
    LoyaltyCardQREntity? loyalCard;

    final data = await Future.wait(
      [getQRCodeUC()],
    );

    data.forEachIndexed(
      (index, element) {
        element.fold(
          (_) {},
          (result) => switch (index) {
            0 => loyalCard = result,
            _ => {},
          },
        );
      },
    );

    emit(state.copyWith(loyalCard: loyalCard));
  }
}
