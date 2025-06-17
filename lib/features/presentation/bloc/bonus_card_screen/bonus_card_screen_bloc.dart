import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/entities/loyalty_card_entity.dart';
import 'package:nevis/features/domain/usecases/loyalty_card/get_qr_code.dart';

part 'bonus_card_screen_event.dart';
part 'bonus_card_screen_state.dart';

class BonusCardScreenBloc
    extends Bloc<BonusCardScreenEvent, BonusCardScreenState> {
  final GetQRCodeUC getQRCodeUC;

  BonusCardScreenBloc({required this.getQRCodeUC})
      : super(BonusCardScreenState()) {
    on<LoadDataEvent>(_onLoadData);
  }

  void _onLoadData(
      LoadDataEvent event, Emitter<BonusCardScreenState> emit) async {
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

    emit(state.copyWith(loyalCard: loyalCard, isLoading: false));
  }
}
