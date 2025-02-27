import 'package:equatable/equatable.dart';

class AuthenticationParams extends Equatable {
  final String phone;
  final String? password;
  final String? fbid;
  final String? code;

  const AuthenticationParams(
      {required this.phone, this.password, this.fbid, this.code});

  @override
  List<Object?> get props => [phone, password, fbid, code];
}
