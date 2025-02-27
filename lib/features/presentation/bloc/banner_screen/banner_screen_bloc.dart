import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banner_screen_event.dart';
part 'banner_screen_state.dart';

class BannerScreenBloc extends Bloc<BannerScreenEvent, BannerScreenState> {
  BannerScreenBloc() : super(BannerScreenInitial());
}
