import 'package:equatable/equatable.dart';
import 'package:nevis/constants/enums.dart';

class LoginServiceParam extends Equatable {
  final String serviceToken;
  final LoginServiceType loginServiceType;

  const LoginServiceParam(
      {required this.serviceToken, required this.loginServiceType});

  @override
  List<Object?> get props => [serviceToken, loginServiceType];
}
