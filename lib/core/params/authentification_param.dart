import 'package:equatable/equatable.dart';

class AuthenticationParams extends Equatable {
  final String phone;
  final String? password;

  final String? code;
  final String? fcmToken;

  const AuthenticationParams(
      {required this.phone, this.password, this.code, this.fcmToken});

  @override
  List<Object?> get props => [phone, password, code];
}
