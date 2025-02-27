import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'about_us_screen_event.dart';
part 'about_us_screen_state.dart';

class AboutUsScreenBloc extends Bloc<AboutUsScreenEvent, AboutUsScreenState> {
  AboutUsScreenBloc() : super(AboutUsScreenInitial());
}
