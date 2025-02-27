import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/features/domain/usecases/auth/logout.dart';

part 'profile_screen_event.dart';
part 'profile_screen_state.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  final LogoutUC logoutUC;
  ProfileScreenBloc({required this.logoutUC}) : super(ProfileScreenState()) {
    on<LogoutEvent>(_onLogout); // выход из профиля
  }

  // выход из профиля
  void _onLogout(LogoutEvent event, Emitter<ProfileScreenState> emit) async {
    logoutUC();

    emit(NavigateLoginState());
  }
}
