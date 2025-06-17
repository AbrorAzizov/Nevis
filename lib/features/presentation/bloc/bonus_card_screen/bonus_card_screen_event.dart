part of 'bonus_card_screen_bloc.dart';

abstract class BonusCardScreenEvent extends Equatable {
  const BonusCardScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadDataEvent extends BonusCardScreenEvent {}
