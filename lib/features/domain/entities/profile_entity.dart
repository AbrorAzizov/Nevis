import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? userId;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? birthday;
  final String? emailAddress;
  final dynamic statusNotifications;
  final dynamic acceptPolicy;
  final String? oldPassword;
  final String? newPassword;
  final String? newPasswordConfirm;

  const ProfileEntity({
    this.userId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthday,
    this.emailAddress,
    this.statusNotifications,
    this.acceptPolicy,
    this.oldPassword,
    this.newPassword,
    this.newPasswordConfirm,
  });

  ProfileEntity copyWith({
    String? userId,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? gender,
    String? birthday,
    String? emailAddress,
    dynamic statusNotifications,
    dynamic acceptPolicy,
    String? oldPassword,
    String? newPassword,
    String? newPasswordConfirm,
  }) =>
      ProfileEntity(
        userId: userId ?? this.userId,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        emailAddress: emailAddress ?? this.emailAddress,
        statusNotifications: statusNotifications ?? this.statusNotifications,
        acceptPolicy: acceptPolicy ?? this.acceptPolicy,
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword,
        newPasswordConfirm: newPasswordConfirm ?? this.newPasswordConfirm,
      );

  @override
  List<Object?> get props => [
        userId,
        phoneNumber,
        firstName,
        lastName,
        gender,
        birthday,
        emailAddress,
        statusNotifications,
        acceptPolicy,
        oldPassword,
        newPassword,
        newPasswordConfirm,
      ];
}
