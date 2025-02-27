part of 'info_about_order_screen_bloc.dart';

abstract class InfoAboutOrderScreenEvent extends Equatable {
  const InfoAboutOrderScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends InfoAboutOrderScreenEvent {}
