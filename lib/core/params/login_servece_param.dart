import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';

class LoginServiceParam extends Equatable {
  final String serviceToken;
  final LoginServiceType loginServiceType;
  final String fcmToken;

  const LoginServiceParam(
      {required this.serviceToken,
      required this.loginServiceType,
      required this.fcmToken});

  @override
  List<Object?> get props => [serviceToken, loginServiceType];
}
