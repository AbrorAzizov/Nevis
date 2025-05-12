import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nevis/core/shared_preferences_keys.dart';
import 'package:nevis/features/domain/usecases/auth/logout.dart';
import 'package:nevis/features/presentation/bloc/profile_screen/profile_screen_state.dart';
import 'package:nevis/locator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_screen_event.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  final LogoutUC logoutUC;

  ProfileScreenBloc({required this.logoutUC})
      : super(ProfileInitial(canQuit: _getCanQuitFromPrefs())) {
    on<LogoutEvent>((event, emit) async {
      await logoutUC();
      emit(SuccessfullyQuitedFromProfileState());
    });
  }

  static bool _getCanQuitFromPrefs() {
    final token =
        sl<SharedPreferences>().getString(SharedPreferencesKeys.accessToken);
    return token?.isNotEmpty ?? false;
  }
}
